import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseReference newsRef = FirebaseDatabase.instance.ref().child(
      'news',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("School News"),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: newsRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading news"));
          }
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text("No news available"));
          }

          final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          final newsItems = data.entries.map((entry) {
            final item = entry.value as Map;
            return {
              "title": item["title"] ?? "",
              "content": item["content"] ?? "",
              "date": item["date"] ?? "",
            };
          }).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: newsItems.length,
            itemBuilder: (context, index) {
              final item = newsItems[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    item["title"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(item["content"]),
                  ),
                  trailing: Text(
                    item["date"],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
