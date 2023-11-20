// ignore_for_file: file_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFaqs extends StatefulWidget {
  const AddFaqs({super.key});

  @override
  State<AddFaqs> createState() => _AddFaqsState();
}

class _AddFaqsState extends State<AddFaqs> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getUserRole(String uid) async {
  
  final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

  if (userDoc.exists) {
    final userData = userDoc.data();
    final userRole = userData?['role']; 
    return userRole;
  } else {
   
    return null;
  }
}


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
          title: const Text('FAQs'),
          backgroundColor: const Color(0xFF9E0044),
        ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 45,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              const Text(
                'Agregar FAQs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 0.05,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Pregunta',
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: questionController,
                  decoration: const InputDecoration(
                    hintText: 'Escriba la pregunta aqui...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Respuesta ',
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: answerController,
                  decoration: const InputDecoration(
                    hintText: 'Escriba la respuesta aqui...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                   final User? user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
          
                    return;
                  }
                  String question = questionController.text;
                  String answer = answerController.text;

                   Map<String, dynamic> data = {
                    'question': question,
                    'answer': answer,
                    'userId': user.uid, 
                  };

                  try {
                    await _firestore.collection('faqs').add(data);
                  } catch (e) {
                   
                    print('Error al subirlo al firestore: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9E0044),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Añadir',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9E0044),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                 
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FAQsManagementScreen()),
                    );
                  },
                  child: const Text('FAQs Management'),
                ),

                
            ],
          ),
        ),
      ),
    );
  }

 
    
}


class FAQsManagementScreen extends StatelessWidget {
  const FAQsManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs Management'),
        backgroundColor:const Color(0xFF9E0044) ,
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
                          openEditDialog(context, documentId, question, answer);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteFAQ(documentId);
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

  void openEditDialog(BuildContext context, String documentId, String question, String answer) {
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
                FirebaseFirestore.instance.collection('faqs').doc(documentId).update({
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

  void deleteFAQ(String documentId) {
    FirebaseFirestore.instance.collection('faqs').doc(documentId).delete();
  }
}

