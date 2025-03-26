import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> news;
  const DetailsScreen({super.key, required this.news});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Info"),
        actions: [IconButton(onPressed: () {
          Share.share('${widget.news['title']}\n\n${widget.news['body']}');
        }, icon: Icon(Icons.share))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.news['title'],
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(widget.news['body']),
          ],
        ),
      ),
    );
  }
}
