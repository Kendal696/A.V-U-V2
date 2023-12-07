import 'package:flutter/material.dart';
import 'package:avu/api/question_client.dart';
import 'package:avu/models/question.dart';

import 'package:avu/home/widgets/load.dart';

import 'package:voice_to_text/voice_to_text.dart';
import 'package:intl/intl.dart';

class Homee extends StatefulWidget {
  final String initialText;
  const Homee({super.key, this.initialText = ''}); // Valor por defecto agregado
  @override
  State<Homee> createState() => _Homee();
}

class _Homee extends State<Homee> {
  final VoiceToText _speech = VoiceToText();
  List<Widget> chat = [];
  TextEditingController questionController = TextEditingController();
  TextStyle styles = const TextStyle(fontSize: 15);
  @override
  void initState() {
    super.initState();
    questionController = TextEditingController(text: widget.initialText);
    _speech.initSpeech();
    _speech.addListener(() {
      setState(() {
        questionController.text = _speech.speechResult;
      });
    });
    if (widget.initialText.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          handleButton();
        }
      });
    }
  }

  Widget newQuestion(String questionInput) {
    if (questionInput.isEmpty) return const SizedBox();
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8, right: 8),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFBA254A),
                  Color(0xFFBA254A),
                ],
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Text(
              questionInput,
              style: styles,
            ),
          ),
          Text(
            DateFormat.Hm().format(DateTime.now()),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget newResponse(String result) {
    Widget loading = const Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Card(
          color: Color(0xFFCBC7CB),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Load(type: 3),
          ),
        ),
      ),
    );
    if (result.isEmpty) return loading;

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8, left: 8),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFCBC7CB),
                  Color(0xFFCBC7CB),
                ],
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Text(
              result,
              style: styles,
            ),
          ),
          Text(
            DateFormat.Hm().format(DateTime.now()),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void handleButton() {
    if (questionController.text.isNotEmpty) {
      sendQuestion();
    } else {
      _speech.isNotListening ? _speech.startListening() : _speech.stop();
    }
  }

  void sendQuestion() async {
    chat.add(newQuestion(questionController.text));
    chat.add(newResponse(""));
    setState(() {});
    getAnswer();
  }

  void getAnswer() async {
    QuestionClient clinet = QuestionClient();
    final data = await clinet.sendQuestion(questionController.text);
    Question questionAnswer = Question.fromJSON(data);
    chat.removeLast();
    chat.add(newResponse(questionAnswer.result));
    questionController.text = "";
    setState(() {});
  }

  void clearChat() {
    setState(() {
      chat.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Elimina el botón de retroceso
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF9E0044),
        actions: [
          IconButton(
            onPressed: clearChat,
            icon: const Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF4EFF3),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: chat.length,
                itemBuilder: (context, index) {
                  if (chat.isEmpty) return const SizedBox();
                  return chat[index];
                },
              ),
            )),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding:
                  const EdgeInsets.only(right: 5, left: 15, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                        child: TextField(
                      maxLines: null,
                      onChanged: (value) => setState(() {}),
                      controller: questionController,
                      decoration: InputDecoration(
                          hintText: "Ingrese su pregunta",
                          labelStyle: const TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF9e0044), width: 1.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10)),
                    )),
                  ),
                  SizedBox(
                    width: 50,
                    child: TextButton(
                      onPressed: handleButton,
                      child: Container(
                        child: questionController.text.isNotEmpty
                            ? const Icon(
                                Icons.send,
                                color: Color(0xFF9e0044),
                              )
                            : _speech.isNotListening
                                ? const Icon(
                                    Icons.mic_off,
                                    color: Color(0xFF9e0044),
                                  )
                                : const Load(
                                    type: 2,
                                  ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
