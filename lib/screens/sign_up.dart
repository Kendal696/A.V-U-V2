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
      body: Container(
        color: Colors.grey[350],
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: screenWidth,
                    height: 260,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF9E0044),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: screenWidth * 0.95,
                      margin: const EdgeInsets.only(top: 100),
                      child: Card(
                        margin: const EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
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
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Contraseña',
                                  prefixIcon: Icon(Icons.lock),
                                ),
                              ),
                              const SizedBox(height: 24.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: screenWidth * 0.75,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Validar la contraseña
                      if (passwordController.text.length < 6) {
                        // Error
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Contraseña debe ser más o igual a 6 digitos'),
                          ),
                        );
                        return;
                      }

                      // Crear nuevo usuario
                      final UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      // Acceder al usuario y obterner su UID
                      final User? user = userCredential.user;
                      final String uid = user?.uid ?? '';

                      // Referencia a la base de datos
                      final FirebaseFirestore firestore =
                          FirebaseFirestore.instance;

                      // Define los datos que se agregaran a la colleccion users
                      final Map<String, dynamic> userData = {
                        'name': nameController.text,
                        'email': emailController.text,
                        'password': passwordController.text,
                        'created': FieldValue
                            .serverTimestamp(), // Set the creation time
                      };

                      // Agregar el usuario
                      await firestore
                          .collection('users')
                          .doc(uid)
                          .set(userData);

                      // Si todo bien, lleva al homescreen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const BottomUser()),
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
                    minimumSize: Size(screenWidth * 0.5, 50),
                  ),
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
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
