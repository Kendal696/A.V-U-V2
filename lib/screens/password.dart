// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    String email = emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Show a success message or navigate to another screen
      if (kDebugMode) {
        print("Password reset email sent to $email");
      }
    } catch (error) {
      // Handle errors, you might want to show an error message to the user
      if (kDebugMode) {
        print("Error sending password reset email: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
              height: 70,
              child: Text(
                'Restablecer \n Contraseña',
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
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
              child: SizedBox(
                width: screenWidth * 0.7,
                height: screenHeight * 0.093,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'example@est.univalle.edu',
                    filled: true,
                    fillColor: const Color(0xFFD9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  style: TextStyle(
                    color: const Color(0xFF858083),
                    fontSize: screenWidth * 0.032,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9E0044),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: resetPassword,
              child: const Text('Enviar mail'),
            ),
          ],
        ),
      ),
    );
  }
}
