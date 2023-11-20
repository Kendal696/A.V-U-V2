// ignore_for_file: file_names, unnecessary_null_comparison, avoid_print, unused_import

import 'package:avu/adminScreens/bottom.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsManagement extends StatefulWidget {
  const EventsManagement({super.key});

  @override
  State<EventsManagement> createState() => _EventsManagementState();
}

class _EventsManagementState extends State<EventsManagement> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
   final TextEditingController imageUrlController = TextEditingController();
   final TextEditingController formsUrlController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ))!;
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  DateTime? combineDateAndTime(DateTime? date, TimeOfDay? time) {
    if (date != null && time != null) {
      return DateTime(date.year, date.month, date.day, time.hour, time.minute);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: const Text('Eventos'),
          backgroundColor: const Color(0xFF9E0044),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 45,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              const Text(
                'Agregar Eventos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 0.05,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Nombre',
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese el nombre del evento ...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Descripción',
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese la decripción del evento...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Fecha',
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                    _selectTime(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: selectedDate == null || selectedTime == null
                        ? const Text(
                            'Selecciona fecha y hora',
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(
                            '${selectedDate!.toLocal()} ${selectedTime!.format(context)}',
                            style: const TextStyle(color: Colors.black),
                          ),
                  ),
                ),
              ),
               const SizedBox(height: 20),
              const Text(
                'URL de la Imagen',
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese el URL de la imagen aqui',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'URL del Formulario',
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: formsUrlController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese el URL del formulario',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final User? user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    return;
                  }
                  String name = nameController.text;
                  String description = descriptionController.text;
                  String imageUrl = imageUrlController.text;
                  String formsURL = formsUrlController.text;
                  DateTime? selectedDateTime = combineDateAndTime(selectedDate, selectedTime);

                  if (selectedDateTime == null) {
                    
                    return;
                  }

                  Timestamp date = Timestamp.fromDate(selectedDateTime);

                  Map<String, dynamic> data = {
                    'name': name,
                    'description': description,
                    'date': date,
                    'imageUrl':imageUrl,
                    'formularioURL': formsURL,

                    'userId': user.uid,
                  };

                  try {
                    await _firestore.collection('events').add(data);
                    print('Success!');
                  } catch (e) {
                    print('Error submitting data to Firestore: $e');
                  }

                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9E0044),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Agregar evento',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9E0044),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EventsManagementScreen()),
                    );
                  },
                  child: const Text('Manejo de Eventos'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventsManagementScreen extends StatelessWidget {
  const EventsManagementScreen({super.key});

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
              final name = event['name'] as String;
              final description = event['description'] as String;
              final date = event['date'] as Timestamp;
              final imageUrl = event['imageUrl'] as String;
              final formUrl= event['formularioUrl'] as String;
              final documentId = event.id;

              return Card(
                child: ListTile(
                  title: Text(name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(description),
                      Text('Fecha: ${date.toDate().toString()}'),
                      //Image.network(imageUrl),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          openEditDialog(context, documentId, name, description, date, imageUrl, formUrl);
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
    ));
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
            onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EventsManagementScreen()),
                    ), 
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () =>Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BottomAdmin()),
                    ),
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );

  return shouldPop;
}


  
void openEditDialog(BuildContext context, String documentId, String name, String description, Timestamp date, String imageUrl, String formsURL) {
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
      return AlertDialog(
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
              decoration: const InputDecoration(labelText: 'Nueva descripcion'),
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
              decoration: const InputDecoration(labelText: 'Nueva URL de la imagen'),
              onChanged: (value) {
                newImageUrl = value;
              },
              controller: imageUrlController,
            ),
             TextField(
              decoration: const InputDecoration(labelText: 'Nueva URL del formulario'),
              onChanged: (value) {
                newFormsUrl = value;
              },
              controller: formsUrlController,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('events').doc(documentId).update({
                'name': newName,
                'description': newDescription,
                'date': Timestamp.fromDate(newDate),
                'imageUrl': newImageUrl,
                'formularioURL': newFormsUrl,
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
      );
    },
  );
}

}
  

  void deleteEvent(String documentId) {
    FirebaseFirestore.instance.collection('events').doc(documentId).delete();
  }

