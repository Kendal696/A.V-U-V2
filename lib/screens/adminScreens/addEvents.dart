// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, unnecessary_string_interpolations, use_rethrow_when_possible

import 'dart:io';
import 'package:avu/screens/adminScreens/eventManagement.dart';
import 'package:avu/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EventsManagement extends StatefulWidget {
  const EventsManagement({super.key});

  @override
  State<EventsManagement> createState() => _EventsManagementState();
}

class _EventsManagementState extends State<EventsManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Eventos'),
        backgroundColor: const Color(0xFF9E0044),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EventForm(),
      ),
    );
  }
}

class EventForm extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  File? _selectedImage;
  final TextEditingController _formularioUrlController = TextEditingController();

  final Color _color = const Color(0xFF9E0044);

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _seleccionarHora() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

 Future<String> _subirImagenAFirebaseStorage(File imagen) async {
  try {
    final storageReference = FirebaseStorage.instance
        .ref()
        .child('imagenes_eventos/${DateTime.now().millisecondsSinceEpoch}.jpg');

    await storageReference.putFile(imagen);

    final downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
  } catch (error) {
    throw error;
  }
}

void _agregarEvento() async {
  try {
    DateTime selectedDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    String imageUrl = '';

    if (_selectedImage != null) {
      imageUrl = await _subirImagenAFirebaseStorage(_selectedImage!);
    }

    await FirebaseFirestore.instance.collection('events').add({
      'nombre': _nombreController.text,
      'descripcion': _descripcionController.text,
      'fecha': selectedDateTime,
      'imagenUrl': imageUrl,
      'formularioUrl': _formularioUrlController.text,
    });

    _mostrarMensaje('Evento agregado con éxito');
    _limpiarCampos();
  } catch (error) {
    _mostrarMensaje('Error al agregar el evento: $error');
  }
}

void _limpiarCampos() {
  _nombreController.clear();
  _descripcionController.clear();
  _selectedDate = DateTime.now();
  _selectedTime = TimeOfDay.now();
  _selectedImage == null; 
  _formularioUrlController.clear();
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          TextFormField(
            controller: _descripcionController,
            decoration: const InputDecoration(labelText: 'Descripción'),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  onTap: _seleccionarFecha,
                  decoration: const InputDecoration(labelText: 'Fecha'),
                  controller: TextEditingController(
                    text: "${_selectedDate.toLocal()}".split(' ')[0],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  onTap: _seleccionarHora,
                  decoration: const InputDecoration(labelText: 'Hora'),
                  controller: TextEditingController(
                    text: "${_selectedTime.format(context)}",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _seleccionarImagen,
            style: ElevatedButton.styleFrom(backgroundColor: _color),
            child: const Text('Seleccionar Imagen'),
          ),
          const SizedBox(height: 16.0),
          if (_selectedImage != null)
            Image.file(
              _selectedImage!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            )else(
              const Icon ( Icons.camera)
            ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _formularioUrlController,
            decoration: const InputDecoration(labelText: 'URL del Formulario'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _agregarEvento,
            style: ElevatedButton.styleFrom(backgroundColor: _color),
            child: const Text('Agregar Evento'),
          ),
          ElevatedButton(
            onPressed: _manejoEventos,
            style: ElevatedButton.styleFrom(backgroundColor: _color),
            child: const Text('Manejo de Eventos'),
          ),
        ],
      ),
    );
  }

  void _manejoEventos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EventsManagementScreen(),
      ),
    );
    printCurrentRoutes(context);

  }
}
