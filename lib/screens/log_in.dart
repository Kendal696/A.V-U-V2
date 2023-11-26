// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:avu/adminScreens/bottom.dart';
import 'package:avu/screens/bottom.dart';
import 'package:avu/screens/camera.dart';
import 'package:avu/screens/password.dart';
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
      appBar: AppBar(
        title: const Text('Login Screen'),
        backgroundColor: const Color(0xFF9E0044),
      ),
      resizeToAvoidBottomInset: true, 
      body: SingleChildScrollView( 
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 700,
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
                      const SizedBox(
                        width: 210,
                        height: 20,
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
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: passwordController, 
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                          );
                        },
                        child: const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
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
                                  fontSize: 10,
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
ElevatedButton(
  onPressed: () async {
  final enteredEmail = emailController.text;
final enteredPassword = passwordController.text;

try {
  final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: enteredEmail,
    password: enteredPassword,
  );

  final user = userCredential.user;

  if (user != null) {
    if (user.email == 'admin@gmail.com' && enteredPassword == 'admin123456') {
      // Si las credenciales coinciden con el usuario administrador, redirige a la pantalla de administrador
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomAdmin()),
      );
    } else {
      // Si no es el usuario administrador, redirige a la pantalla de usuario normal
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomUser()),
      );
    }
  }
} catch (e) {
  String errorMessage = 'Error durante el inicio de sesión.';
  if (e is FirebaseAuthException) {
    if (e.code == 'user-not-found') {
      errorMessage = 'Usuario no encontrado. Regístrese primero.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Contraseña incorrecta. Inténtelo de nuevo.';
    }
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
    ),
  );
  print('Error during login: $e');
}
},

  


  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF9E0044),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  ),
  child: const Text('Login'),
),


              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9E0044),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Reset Password'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Camera()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9E0044),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Login with Face ID'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



