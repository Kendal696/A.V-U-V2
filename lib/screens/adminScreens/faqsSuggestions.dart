// ignore_for_file: file_names, library_private_types_in_public_api, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FAQsSuggestions extends StatefulWidget {
  const FAQsSuggestions({super.key});

  @override
  _FAQsSuggestionsState createState() => _FAQsSuggestionsState();
}

class _FAQsSuggestionsState extends State<FAQsSuggestions> {
  final CollectionReference faqsSuggestionsCollection =
      FirebaseFirestore.instance.collection('faqsSuggestions');

  final CollectionReference faqsCollection =
      FirebaseFirestore.instance.collection('faqs');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'FAQs Suggestions',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF9E0044),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: faqsSuggestionsCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final faqsSuggestions = snapshot.data!.docs;

          return ListView.builder(
            itemCount: faqsSuggestions.length,
            itemBuilder: (context, index) {
              final faqSuggestion = faqsSuggestions[index];
              final question = faqSuggestion['question'] as String;
              final answer = faqSuggestion['answer'] as String;
              final number = faqSuggestion['phoneNumber'] as String;

              return Card(
                child: ListTile(
                  title: Text(question),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(answer),
                      if (number != null && number.isNotEmpty) Text(number),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          acceptFAQ(faqSuggestion);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteFAQSuggestion(faqSuggestion);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void acceptFAQ(DocumentSnapshot faqSuggestion) {
    final Map<String, dynamic> data =
        faqSuggestion.data() as Map<String, dynamic>;
    faqsCollection.add(data);
    faqSuggestion.reference.delete();
  }

  void deleteFAQSuggestion(DocumentSnapshot faqSuggestion) {
    faqSuggestion.reference.delete();
  }
}
