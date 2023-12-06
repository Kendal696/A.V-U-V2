import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class QuestionClient {
  String urlBase;
  QuestionClient({
    this.urlBase = "https://nlp-3vtkcv5acq-rj.a.run.app",
  });

  Future<Map<String, dynamic>> sendQuestion(String question) async {
    if (kDebugMode) {
      print(jsonEncode({"question": question}));
    }
    // ignore: unnecessary_this
    final response = await http.post(Uri.parse("${this.urlBase}/questions"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": question}),
        encoding: utf8);
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      return {"question": question, "result": "Error al realizar la peticion"};
    }
  }
}
