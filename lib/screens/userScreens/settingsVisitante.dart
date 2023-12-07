// ignore_for_file: file_names, use_build_context_synchronously

import 'package:avu/main.dart';
import 'package:avu/screens/userScreens/sugestions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsVisitante extends StatefulWidget {
  const SettingsVisitante({super.key});

  @override
  State<SettingsVisitante> createState() => _SettingsVisitanteState();
}

class _SettingsVisitanteState extends State<SettingsVisitante> {
  bool temaSwitchValue = false;
  double volumenValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Configuración',
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 0.05,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              // Tema
              Row(
                children: [
                  const SizedBox(
                    width: 261,
                    child: Text(
                      'Tema',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Switch(
                    value: temaSwitchValue,
                    onChanged: (bool newValue) {
                      setState(() {
                        temaSwitchValue = newValue;
                      });
                    },
                  ),
                ],
              ),

              const Text(
                'Ajustar Volumen del Asistente de voz',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              Slider(
                value: volumenValue,
                onChanged: (newValue) {
                  setState(() {
                    volumenValue = newValue;
                  });
                },
                activeColor: const Color(0xFF9E0044),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuggestionsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9E0044),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Sugerir Pregunta Frecuente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0.09,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Cerrar sesión
                    await FirebaseAuth.instance.signOut();

                    // Redirigir a la pantalla de bienvenida
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainApp()),
                      (route) => false, // Elimina todas las rutas existentes
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9E0044),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const SizedBox(
                    width: 189,
                    child: Text(
                      'Cerrar Sesión',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 0.09,
                      ),
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
}
