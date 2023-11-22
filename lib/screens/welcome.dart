// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:avu/screens/bottomVisitante.dart';
import 'package:avu/screens/log_in.dart';
import 'package:avu/screens/sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  width: 303,
                  child: Text(
                    'Hola, Bienvenido a A.V.U.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0.06,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Image.asset('assets/logo.png'),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogIn()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFCFCFC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.4285714286,
                      color: Color(0xFF9E0044),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9E0044),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Registrarse',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.4285714286,
                      color: Color(0xFFFCFCFC),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: 'visitante@example.com', // Reemplaza con el email del usuario "Visitante"
                        password: 'contraseña', // Reemplaza con la contraseña del usuario "Visitante"
                      );

                      final user = userCredential.user;

                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const BottomVisitante()),
                        );
                      }
                    } catch (e) {
                      // Manejar errores de inicio de sesión
                      String errorMessage = 'Error durante el inicio de sesión.';
                      if (e is FirebaseAuthException) {
                        if (e.code == 'user-not-found') {
                          errorMessage = 'Usuario no encontrado. Regístrate primero.';
                        } else if (e.code == 'wrong-password') {
                          errorMessage = 'Contraseña incorrecta. Inténtalo de nuevo.';
                        }
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                        ),
                      );
                      if (kDebugMode) {
                        print('Error durante el inicio de sesión: $e');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFCFCFC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Visitante',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.4285714286,
                      color: Color(0xFF9E0044),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
