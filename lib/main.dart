// ignore: unused_import
import 'package:avu/home/home.dart';
import 'package:avu/screens/welcome.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  //Inicializar Firebase en todo el proyecto
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AVU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    
   
      home: const Welcome(),
    );
  }
}

void printCurrentRoutes(BuildContext context) {
  Navigator.of(context).popUntil((route) {
    if (kDebugMode) {
      print("Ruta Actual");
      print(route.settings.name);
    }
    return true;
  });
}
