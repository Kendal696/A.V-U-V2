// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController questionController = TextEditingController();
    final TextEditingController answerController = TextEditingController();
    final TextEditingController phoneController = TextEditingController(); // Nuevo controlador para el número de teléfono
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggestions'),
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
                'Ayúdanos a Mejorar ',
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
                'Tu pregunta',
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
                    hintText: 'Escribe tu pregunta aquí...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Respuesta Sugerida',
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
                    hintText: 'Si tienes respuestas en mente, compártela aquí...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Número de Teléfono',
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
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Ingresa tu número de teléfono... (opcional)',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tu contribución nos ayuda a mejorar y proporcionar información útil a toda la comunidad universitaria',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final User? user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    return;
                  }

                  String question = questionController.text;
                  String answer = answerController.text;
                  String phoneNumber = phoneController.text;

                  Map<String, dynamic> data = {
                    'question': question,
                    'answer': answer,
                    'phoneNumber': phoneNumber,
                    'userId': user.uid,
                    'sent': FieldValue.serverTimestamp(),
                  };

                  try {
                    await _firestore.collection('faqsSuggestions').add(data);
                    // Mostrar mensaje de éxito y agradecimiento
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('FAQ enviado con éxito. ¡Gracias por tu contribución!'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    // Limpiar los campos del formulario después de enviar
                    questionController.clear();
                    answerController.clear();
                    phoneController.clear();
                  } catch (e) {
                    // Handle errors (e.g., mostrar un mensaje de error)
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
                  'Enviar',
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
}
