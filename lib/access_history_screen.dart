import 'package:flutter/material.dart';
class AccessHistoryScreen extends StatefulWidget {
  @override
  _AccessHistoryScreenState createState() => _AccessHistoryScreenState();
}

class _AccessHistoryScreenState extends State<AccessHistoryScreen> {
  List<Map<String, dynamic>> histodry = [
    {'user': 'dsfdsfdsfdsfsd', 'time': '10:20', 'status': true},
    {'user': 'ddddssss', 'time': '10:05', 'status': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Access History')),
      body: ListView.builder(
        itemCount: histodry.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(
            histodry[index]['status'] ? Icons.check_circle : Icons.block,
            color: histodry[index]['status'] ? Colors.green : Colors.red,
          ),
          title: Text(histodry[index]['user']),
          subtitle: Text(histodry[index]['time']),
        ),
      ),
    );
  }
}
