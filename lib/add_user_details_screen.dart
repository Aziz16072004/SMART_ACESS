import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddUserDetailsScreen extends StatefulWidget {
  final String imagePath;
  const AddUserDetailsScreen({super.key, required this.imagePath});
  @override
  _AddUserDetailsScreenState createState() => _AddUserDetailsScreenState();
}

class _AddUserDetailsScreenState extends State<AddUserDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accessLevelController = TextEditingController();

  // Function to upload the image to your server
  Future<void> _uploadImage(File imageFile) async {
    // Fetch the userId from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? ''; // Default to an empty string if userId is not found

    if (userId.isEmpty) {
      print('No userId found in SharedPreferences');
      return;
    }
    final uri = Uri.parse('${dotenv.env['API_BASE_URL']}/upload'); // Your FastAPI server URL
    final mimeType = lookupMimeType(imageFile.path);

    final request = http.MultipartRequest('POST', uri)
      ..fields['userId'] = userId  // Using the retrieved userId
      ..fields['name'] = _nameController.text
      ..fields['accessLevel'] = _accessLevelController.text
      ..files.add(await http.MultipartFile.fromPath(
        'image', // This must match the parameter name in FastAPI (`UploadFile = File(...)`)
        imageFile.path,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,  // Handle MIME type
      ));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during image upload: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.file(File(widget.imagePath), height: 200),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _accessLevelController,
              decoration: const InputDecoration(labelText: "Access Level"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newUser = {
                  'name': _nameController.text,
                  'accessLevel': _accessLevelController.text,
                  'imagePath': widget.imagePath,
                };

                // Upload the image before saving the user
                await _uploadImage(File(widget.imagePath));

                // Return the new user data to the previous screen
                Navigator.pop(context, newUser);
              },
              child: const Text("Save User"),
            ),
          ],
        ),
      ),
    );
  }
}
