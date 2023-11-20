// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:avu/screens/bottom.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
        backgroundColor: const Color(0xFF9E0044),
      ),
      body: Container(
        color: Colors.grey[200],
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: const ShapeDecoration(
                  color: Color(0xFF9E0044),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(200),
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.7,
                        height: 50,
                        child: const Text(
                          'Registrar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF9E0044),
                            fontSize: 30,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                        ),
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Validar la contraseña
                    if (passwordController.text.length < 6) {
                      // Error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contraseña debe ser más o igual a 6 digitos'),
                        ),
                      );
                      return;
                    }

                    // Crear nuevo usuario
                    final UserCredential userCredential =
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    // Acceder al usuario y obterner su UID
                    final User? user = userCredential.user;
                    final String uid = user?.uid ?? '';

                    // Referencia a la base de datos
                    final FirebaseFirestore firestore = FirebaseFirestore.instance;

                    // Define los datos que se agregaran a la colleccion users  
                    final Map<String, dynamic> userData = {
                      'name': nameController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'created': FieldValue.serverTimestamp(), // Set the creation time
                    };

                    // Agregar el usuario
                    await firestore.collection('users').doc(uid).set(userData);

                    // Si todo bien, lleva al homescreen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const BottomUser()),
                    );
                  } catch (e) {
                    // Errores handle
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error during registration: $e'),
                      ),
                    );
                    print('Error during registration: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9E0044),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
