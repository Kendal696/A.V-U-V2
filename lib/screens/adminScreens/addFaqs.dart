// ignore_for_file: file_names, avoid_print

import 'package:avu/screens/adminScreens/faqsM.dart';
import 'package:avu/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFaqs extends StatefulWidget {
  const AddFaqs({super.key});

  @override
  State<AddFaqs> createState() => _AddFaqsState();
}

class _AddFaqsState extends State<AddFaqs> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'FAQs',
          style: TextStyle(color: Colors.white),
        ),
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
                'Agregar FAQs',
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
                'Pregunta',
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
                  controller: questionController,
                  decoration: const InputDecoration(
                    hintText: 'Escriba la pregunta aquí...',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Respuesta ',
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
                  controller: answerController,
                  decoration: const InputDecoration(
                    hintText: 'Escriba la respuesta aquí...',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _agregarEvento();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9E0044),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Añadir',
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FAQsManagementScreen(),
                      settings:
                          const RouteSettings(name: 'FAQsManagementScreen'),
                    ),
                  );
                  printCurrentRoutes(context);
                },
                child: const Text(
                  'FAQs Management',
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _agregarEvento() async {
    try {
      String question = questionController.text;
      String answer = answerController.text;

      Map<String, dynamic> data = {
        'question': question,
        'answer': answer,
      };

      await _firestore.collection('faqs').add(data);

      // Mostrar mensaje de éxito
      _mostrarMensaje('FAQ agregado con éxito');

      // Limpiar los campos después de agregar el FAQ
      _limpiarCampos();
    } catch (error) {
      // Mostrar mensaje de error
      _mostrarMensaje('Error al agregar el FAQ: $error');
    }
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _limpiarCampos() {
    questionController.clear();
    answerController.clear();
  }
}
