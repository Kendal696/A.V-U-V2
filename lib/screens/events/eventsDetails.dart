// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class EventDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String? formUrl;

  const EventDetailScreen({super.key, required this.imageUrl, this.formUrl});

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del evento'),
        backgroundColor: const Color(0xFF9E0044),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            height: 600.0,
          ),
          if (widget.formUrl != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _launchInBrowserView(widget.formUrl!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9E0044),
                  shadowColor: Colors.transparent,
                ),
                child: const Text('Abrir Formulario'),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _launchInBrowserView(String formsURL) async {
    Uri url = Uri.parse(formsURL);
    if (await launchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }
}


