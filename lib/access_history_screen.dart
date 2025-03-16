import 'package:flutter/material.dart';

class AccessHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> history = [
    {'user': 'Admin', 'time': '10:00', 'status': true},
    {'user': 'Unknown', 'time': '10:05', 'status': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Access History'),
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(
            history[index]['status'] ? Icons.check_circle : Icons.block,
            color: history[index]['status'] ? Colors.green : Colors.red,
          ),
          title: Text(history[index]['user']),
          subtitle: Text(history[index]['time']),
        ),
      ),
    );
  }
}