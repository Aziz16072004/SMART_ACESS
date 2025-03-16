import 'package:flutter/material.dart';

class AccessManagementScreen extends StatelessWidget {
  final List<String> users = ['Admin', 'User1', 'User2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Managefdsfsd Access')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder:
            (context, index) => ListTile(
              title: Text(users[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  /* Add delete logic here */
                },
              ),
            ),
      ),
    );
  }
}
