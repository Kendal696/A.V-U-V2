// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace, use_build_context_synchronously

import 'package:avu/main.dart';
import 'package:avu/screens/userScreens/bottomVisitante.dart';
import 'package:avu/screens/userScreens/log_in.dart';
import 'package:avu/screens/userScreens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
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
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0.06,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.6, // Establecer el ancho del contenedor al 60% del ancho de la pantalla
                  child: Image.asset('assets/logo_blanco.png'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.7, // Establecer el ancho del contenedor al 70% del ancho de la pantalla
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LogIn(),
                        settings: const RouteSettings(name: 'UsuarioHome')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9E0044),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical:
                              12), // Aumentar el tamaño vertical del botón
                    ),
                    child: const Text(
                      'Iniciar Sesión',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18, // Aumentar el tamaño de la letra
                        fontWeight: FontWeight.w700,
                        height: 1.4285714286,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
  width: MediaQuery.of(context).size.width * 0.7,
  child: ElevatedButton(
    onPressed: () async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'visitante@example.com',
          password: 'contraseña',
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomVisitanteScreen(),
          settings: const RouteSettings(name: 'Visitante Home'),),
          
        );
        printCurrentRoutes(context);

      } catch (e) {
        if (kDebugMode) {
          print('Error al iniciar sesión: $e');
        }
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFA7A9AC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
    ),
    child: const Text(
      'Visitante',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1.4285714286,
        color: Color(0xFFFFFFFF),
      ),
    ),
  ),
),

                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text(
                    'No tienes cuenta?, Registrate aquí',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18, // Aumentar el tamaño de la letra
                      fontWeight: FontWeight.w700,
                      height: 1.4285714286,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
