import 'package:avu/adminScreens/addEvents.dart';
import 'package:avu/adminScreens/addFaqs.dart';
import 'package:avu/screens/home.dart';
import 'package:avu/screens/settings.dart';
import 'package:flutter/material.dart';

 // Import the ImageUpload screen

void main() => runApp(const BottomAdminApp());

class BottomAdminApp extends StatelessWidget {
  const BottomAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomAdmin(),
    );
  }
}

class BottomAdmin extends StatefulWidget {
  const BottomAdmin({super.key});

  @override
  State<BottomAdmin> createState() =>
      _BottomAdminState();
}

class _BottomAdminState
    extends State<BottomAdmin> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [    
          Home(),
          EventsManagement(),        
          AddFaqs(), 
          Settings(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor:  Color(0xFF9E0044),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Eventos',
            backgroundColor:  Color(0xFF9E0044),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'FAQs',
            backgroundColor:  Color(0xFF9E0044),
          ),
          BottomNavigationBarItem( 
            icon: Icon(Icons.settings),
            label: 'Configuracion',
            backgroundColor:  Color(0xFF9E0044),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
