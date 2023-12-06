// ignore_for_file: file_names, use_build_context_synchronously, unnecessary_null_comparison, use_rethrow_when_possible, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EventsManagementScreen extends StatelessWidget {
  const EventsManagementScreen({super.key});

  Future<String> _subirImagenAFirebaseStorage(String imagePath) async {
    try {
      final pickedFile = File(imagePath);
      if (pickedFile == null) {
        throw Exception('No se seleccionó ninguna imagen.');
      }

      final storageReference = FirebaseStorage.instance
          .ref()
          .child('imagenes_eventos/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageReference.putFile(pickedFile);

      final downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      throw error;
    }
  }

  void deleteEvent(String documentId) {
    FirebaseFirestore.instance.collection('events').doc(documentId).delete();
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    bool shouldPop = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Exit'),
          content: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    return shouldPop;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _onBackPressed(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manejo de eventos'),
          backgroundColor: const Color(0xFF9E0044),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('events').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final events = snapshot.data!.docs;

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final name = event['nombre'] as String;
                final description = event['descripcion'] as String;
                final date = event['fecha'] as Timestamp;
                final imageUrl = event['imagenUrl'] as String;
                final formUrl = event['formularioUrl'] as String;
                final documentId = event.id;

                return Card(
                  child: ListTile(
                    title: Text(name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(description),
                        Text('Fecha: ${date.toDate().toString()}'),
                        if (imageUrl.isNotEmpty)
                          Image.network(
                            imageUrl,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            openEditDialog(
                              context,
                              documentId,
                              name,
                              description,
                              date,
                              imageUrl,
                              formUrl,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            deleteEvent(documentId);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void openEditDialog(
    BuildContext context,
    String documentId,
    String name,
    String description,
    Timestamp date,
    String imageUrl,
    String formsURL,
  ) {
    String newName = name;
    String newDescription = description;
    DateTime newDate = date.toDate();
    String newImageUrl = imageUrl;
    String newFormsUrl = formsURL;

    final dateController = TextEditingController(text: newDate.toString());
    final imageUrlController = TextEditingController(text: newImageUrl);
    final formsUrlController = TextEditingController(text: newFormsUrl);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: const Text('Editar Evento'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Nuevo Nombre'),
                    onChanged: (value) {
                      newName = value;
                    },
                    controller: TextEditingController(text: name),
                  ),
                  TextField(
                    decoration:
                        const InputDecoration(labelText: 'Nueva descripcion'),
                    onChanged: (value) {
                      newDescription = value;
                    },
                    controller: TextEditingController(text: description),
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Nueva Fecha'),
                    controller: dateController,
                    onTap: () async {
                      final DateTime picked = (await showDatePicker(
                        context: context,
                        initialDate: newDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      ))!;
                      if (picked != null) {
                        dateController.text = picked.toLocal().toString();
                        newDate = picked;
                      }
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: 'Nueva URL de la imagen'),
                    onChanged: (value) {
                      newImageUrl = value;
                    },
                    controller: imageUrlController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: 'Nueva URL del formulario'),
                    onChanged: (value) {
                      newFormsUrl = value;
                    },
                    controller: formsUrlController,
                  ),
                  if (newImageUrl.isNotEmpty)
                    Image.network(
                      newImageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedFile =
                          await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          newImageUrl = pickedFile.path;
                          imageUrlController.text = newImageUrl;
                        });
                      }
                    },
                    child: const Text('Cambiar Imagen'),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    // Sube la nueva imagen si se selecciona una
                    if (newImageUrl != imageUrl) {
                      final imageUrl =
                          await _subirImagenAFirebaseStorage(newImageUrl);
                      newImageUrl = imageUrl;
                    }

                    FirebaseFirestore.instance
                        .collection('events')
                        .doc(documentId)
                        .update({
                      'nombre': newName,
                      'descripcion': newDescription,
                      'fecha': Timestamp.fromDate(newDate),
                      'imagenUrl': newImageUrl,
                      'formularioUrl': newFormsUrl,
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Guardar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
