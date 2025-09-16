import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseReference newsRef = FirebaseDatabase.instance.ref('news');

    return Scaffold(
      appBar: AppBar(
        title: const Text('School News 📰'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: newsRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text('No news available'));
          }

          final data =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          final items = data.entries.map((entry) {
            final value = entry.value as Map<dynamic, dynamic>;
            return {
              'title': value['title'] ?? 'No title',
              'description': value['description'] ?? ''
            };
          }).toList();

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, color: Colors.grey),
            itemBuilder: (context, index) {
              final article = items[index];
              return ListTile(
                leading: const Icon(Icons.article_outlined),
                title: Text(article['title']!),
                subtitle: Text(article['description']!),
              );
            },
          );
        },
      ),
    );
  }
}
