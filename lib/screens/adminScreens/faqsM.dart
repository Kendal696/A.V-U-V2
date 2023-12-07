// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FAQsManagementScreen extends StatelessWidget {
  const FAQsManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'FAQs Management',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF9E0044),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('faqs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final faqs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              final faq = faqs[index];
              final question = faq['question'] as String;
              final answer = faq['answer'] as String;
              final documentId = faq.id;

              return Card(
                child: ListTile(
                  title: Text(question),
                  subtitle: Text(answer),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _openEditDialog(
                              context, documentId, question, answer);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteFAQ(documentId);
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

  void _openEditDialog(
      BuildContext context, String documentId, String question, String answer) {
    String newQuestion = question;
    String newAnswer = answer;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit FAQ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'New Question'),
                onChanged: (value) {
                  newQuestion = value;
                },
                controller: TextEditingController(text: question),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'New Answer'),
                onChanged: (value) {
                  newAnswer = value;
                },
                controller: TextEditingController(text: answer),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('faqs')
                    .doc(documentId)
                    .update({
                  'question': newQuestion,
                  'answer': newAnswer,
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteFAQ(String documentId) {
    FirebaseFirestore.instance.collection('faqs').doc(documentId).delete();
  }
}
