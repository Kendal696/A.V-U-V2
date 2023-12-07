// ignore_for_file: library_private_types_in_public_api

import 'package:avu/home/home.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avu/home/widgets/load.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final SpeechToText _speechToText = SpeechToText();
  late AnimationController _favoriteController;
  bool _speechEnabled = false;
  String _lastWords = '';
  bool _isListening = false;
  bool _canType = false;
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _favoriteController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _textController = TextEditingController();
  }

  void _handleButton1Click() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Homee(initialText: "¿Horarios de atencion?"),
      ),
    );
  }

  void _handleButton2Click() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Homee(
            initialText:
                "¿Cuales son las becas disponibles para estudiantes regulares?"),
      ),
    );
  }

  @override
  void dispose() {
    _favoriteController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _favoriteController.repeat();
      _isListening = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _textController.text = _lastWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    const EdgeInsets margin = EdgeInsets.all(10.0);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF9E0044),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: margin,
              width: double.infinity,
              height: 12,
              color: const Color(0xFFEDF0EF),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 35,
              width: 300,
              child: Text(
                'Asistente de Voz',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _textController,
                minLines: 5,
                maxLines: 7,
                enabled: _canType,
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.black, // Color del borde
                      width: 2.0, // Grosor del borde
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.black87,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Homee(initialText: _textController.text),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9E0044),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Preguntar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFCFCFC),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0.10,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              height: 3,
              width: 300,
              child: const Text(
                'Preguntas Frecuentes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 0.05,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _handleButton1Click,
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF9E0044),
                backgroundColor: Colors.white,
                side: const BorderSide(width: 1.50, color: Color(0xFF9E0044)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const SizedBox(
                width: 267,
                height: 32,
                child: Text(
                  '¿Cuales son los horarios de atencion de plataforma?',
                  textAlign: TextAlign.center, // Centra el texto
                  style: TextStyle(
                    color: Color(0xFF9E0044),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 2,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _handleButton2Click,
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF9E0044),
                backgroundColor: Colors.white,
                side: const BorderSide(width: 1.50, color: Color(0xFF9E0044)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const SizedBox(
                width: 250,
                child: Text(
                  '¿Cuales son las becas disponibles?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF9E0044),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.keyboard,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        _canType = true;
                      });
                    },
                    tooltip: 'Enable Typing',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9E0044),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: AnimatedBuilder(
                      animation: _favoriteController,
                      builder: (context, child) {
                        return _isListening
                            ? const Load(
                                type: 3,
                              )
                            : const Icon(
                                Icons.mic_off,
                                color: Colors.white,
                                size: 40,
                              );
                      },
                    ),
                    onPressed: () {
                      if (_speechToText.isNotListening) {
                        _startListening();
                      }
                    },
                    tooltip: 'Listen',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1.50,
                      color: const Color(0xFF9E0044),
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.stop,
                      color: Color(0xFF9E0044),
                      size: 40,
                    ),
                    onPressed: _stopListening,
                    tooltip: 'Stop Listening',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
