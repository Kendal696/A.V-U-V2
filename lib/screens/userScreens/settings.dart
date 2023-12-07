import 'package:avu/main.dart';
import 'package:avu/screens/userScreens/cuenta.dart';
import 'package:avu/screens/userScreens/sugestions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notificacionesValue = false; // Valor del checkbox de notificaciones
  bool reconocimientoFacialValue =
      false; // Valor del checkbox de reconocimiento facial
  bool temaSwitchValue = false; // Valor del switch de tema
  double volumenValue = 0.5; // Valor de ajuste de volumen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20.0),
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                'Configuración',
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
              height: 30,
            ),
            // Notificaciones
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 261,
                    child: Text(
                      'Notificaciones',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Checkbox(
                    value: notificacionesValue,
                    onChanged: (bool? newValue) {
                      setState(() {
                        notificacionesValue = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 261,
                    child: Text(
                      'Reconocimiento Facial',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Checkbox(
                    value: reconocimientoFacialValue,
                    onChanged: (bool? newValue) {
                      setState(() {
                        reconocimientoFacialValue = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Tema
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  /*
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
                  SizedBox(
                    width: 15,
                  ),
                  Switch(
                    value: temaSwitchValue,
                    onChanged: (bool newValue) {
                      setState(() {
                        temaSwitchValue = newValue;
                      });
                    },
                  ),*/
                ],
              ),
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

            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuggestionsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 1), // Adjust the padding here
                    backgroundColor: const Color(0xFF9E0044),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
            ),
            const SizedBox(
              height: 60,
            ),
            Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: Container(
                      width: 214,
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 64, vertical: 8),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1.50, color: Color(0xFF9E0044)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              'Cuenta',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF9E0044),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainApp()
                            ),
                      );
                      await FirebaseAuth.instance.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9E0044),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const SizedBox(
                      width: 200,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
