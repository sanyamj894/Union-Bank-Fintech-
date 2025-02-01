import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppWriteStorageService {
  final Client _client;
  late final Storage _storage;
  final ImagePicker _picker = ImagePicker();

  AppWriteStorageService()
      : _client = Client()
      .setEndpoint('https://cloud.AppWrite.io/v1') // Replace with your AppWrite endpoint
      .setProject('678dd115000bfb7da92d') // Replace with your AppWrite project ID
  {
    _storage = Storage(_client); // Initialize AppWrite Storage
  }

  Future<void> recordVideo(BuildContext context) async {
    try {
      // Pick a video from the camera
      final XFile? video = await _picker.pickVideo(source: ImageSource.camera);

      if (video != null) {
        // Show a loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Uploading video...')),
        );

        // Upload the video to AppWrite Storage
        String result = await recordFile(video);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    } catch (e) {
      // Handle errors
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


  /// Uploads a video file to AppWrite Storage.
  Future<String> recordFile(XFile video) async {
    try {
      final File videoFile = File(video.path);
      const String bucketId = '678f8d02000439207cfb'; // Replace with your bucket ID
      final String fileId = 'unique()'; // Let AppWrite generate a unique file ID

      // Upload file to AppWrite Storage
      models.File uploadedFile = await _storage.createFile(
        bucketId: bucketId,
        fileId: fileId,
        file: InputFile.fromPath(path: videoFile.path),
      );

      return 'File uploaded successfully: ${uploadedFile.$id}';
    } catch (e) {
      print(e);
      throw Exception('Error uploading video: $e');
    }
  }
}
