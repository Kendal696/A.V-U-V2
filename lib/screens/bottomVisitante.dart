

// ignore_for_file: file_names

import 'package:avu/screens/faq.dart';
import 'package:avu/screens/events.dart';

import 'package:avu/screens/home.dart';
import 'package:avu/screens/settingsVisitante.dart';
import 'package:flutter/material.dart';


class BottomVisitante extends StatelessWidget {
  const BottomVisitante({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomVisitanteScreen(),
    );
  }
}

class BottomVisitanteScreen extends StatefulWidget {
  const BottomVisitanteScreen({super.key});

  @override
  State<BottomVisitanteScreen> createState() =>
      _BottomUserScreenState();
}


class _BottomUserScreenState
    extends State<BottomVisitanteScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar _buildAppBar(int index) {
    switch (index) {
      case 0:
        return AppBar(
          title: const Text('Home'),
          backgroundColor: const Color(0xFF9E0044),
        );
      case 1:
        return AppBar(
          title: const Text('Eventos'),
          backgroundColor: const Color(0xFF9E0044),
        );
      case 2:
        return AppBar(
          title: const Text('FAQS'),
          backgroundColor: const Color(0xFF9E0044),
        );
      case 3:
        return AppBar(
          title: const Text('Settings'),
          backgroundColor: const Color(0xFF9E0044),
        );
      default:
        return AppBar(
          title: const Text('Default'),
          backgroundColor: const Color(0xFF9E0044),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(_selectedIndex), 
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          // Home Screen
          Home(),
          // Eventos
         Events(),
          // FAQS 
          FAQ(),
          // Pantalla de configuracion
          SettingsVisitante(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFF9E0044),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Eventos',
            backgroundColor: Color(0xFF9E0044),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'FAQS',
            backgroundColor: Color(0xFF9E0044),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Color(0xFF9E0044),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
