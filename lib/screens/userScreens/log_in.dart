// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:avu/screens/adminScreens/bottom.dart';
import 'package:avu/screens/userScreens/bottom.dart';
import 'package:avu/screens/camera.dart';
import 'package:avu/screens/userScreens/password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[350],
      body: Stack(
        alignment: Alignment.topCenter,
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
          SingleChildScrollView(
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100),
                    height: 340,
                    width: screenWidth * 0.95,
                    child: Card(
                      margin: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25), // Aumentado a 30
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 40,
                              width: 300,
                            ),
                            const SizedBox(
                              width: 200,
                              height: 40,
                              child: Text(
                                'Iniciar Sesion',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF9E0044),
                                  fontSize: 30,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  height: 0.05,
                                ),
                              ),
                            ),
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
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPasswordScreen()),
                                );
                              },
                              child: const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '¿Olvidaste tu contraseña?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 0.24,
                                        letterSpacing: 0.15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ',
                                      style: TextStyle(
                                        color: Color(0xFF9E0044),
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 0.24,
                                        letterSpacing: 0.15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Click aquí',
                                      style: TextStyle(
                                        color: Color(0xFF9E0044),
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        height: 0.24,
                                        letterSpacing: 0.15,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: screenWidth * 0.75,
                    child: ElevatedButton(
                      onPressed: () async {
                        final enteredEmail = emailController.text;
                        final enteredPassword = passwordController.text;

                        if (enteredEmail == 'admin@gmail.com' &&
                            enteredPassword == 'admin123456') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const BottomAdmin()),
                          );
                        } else {
                          try {
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: enteredEmail,
                              password: enteredPassword,
                            );

                            final user = userCredential.user;

                            if (user != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomUserScreen()),
                              );
                            }
                          } catch (e) {
                            // Handle login errors
                            String errorMessage = 'Error during login.';
                            if (e is FirebaseAuthException) {
                              if (e.code == 'user-not-found') {
                                errorMessage =
                                    'Usuario no encontrado. Registrese primero.';
                              } else if (e.code == 'wrong-password') {
                                errorMessage =
                                    'Contraseña incorrecta. Intentelo de nuevo.';
                              }
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                              ),
                            );
                            print('Error : $e');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9E0044),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Iniciar Sesion',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: screenWidth * 0.75,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Camera()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9E0044),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Login with Face ID',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
