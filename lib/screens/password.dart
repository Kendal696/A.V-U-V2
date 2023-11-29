// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      showSnackbar("Llena los campos");
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSnackbar(
          "Se ha enviado un correo electrónico para restablecer la contraseña.");
    } catch (error) {
      showSnackbar(
          "Error al enviar el correo electrónico de restablecimiento de contraseña: $error");
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Olvidé mi contraseña'),
        backgroundColor: const Color(0xFF9E0044),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),
            const SizedBox(
              width: 300,
              height: 50,
              child: Text(
                'Restablecer ',
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
            const SizedBox(
              width: 300,
              height: 50,
              child: Text(
                ' Contraseña',
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
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.093,
                    child: Text(
                      "Ingresa tu correo institucional para enviarte\ninstrucciones para establecer una nueva contraseña",
                      textAlign:
                          TextAlign.center, // Alineación del texto al centro
                      style: TextStyle(
                        fontSize: screenWidth *
                            0.04, // Ajusta el tamaño de la fuente según sea necesario
                        fontFamily: 'Poppins',
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: screenHeight *
                          0.02), // Espacio entre el texto y el TextField
                  SizedBox(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.093,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'example@est.univalle.edu',
                        filled: true,
                        fillColor:
                            const Color(0xFFD9D9D9), // Color hexadecimal aquí
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      style: TextStyle(
                        color: const Color(0xFF000000),
                        fontSize: screenWidth * 0.032,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.001),
            SizedBox(
              width: screenWidth * 0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9E0044),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                ),
                onPressed: resetPassword,
                child: Text(
                  'Enviar mail',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
