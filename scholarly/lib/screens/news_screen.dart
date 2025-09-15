import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("School News"),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('news')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No news available yet."));
          }

          final articles = snapshot.data!.docs;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final data = articles[index].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.newspaper),
                  title: Text(data['title'] ?? 'No title'),
                  subtitle: Text(data['description'] ?? 'No description'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
