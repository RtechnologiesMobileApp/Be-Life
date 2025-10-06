import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../data/network/base_api_services.dart';
import 'package:crypto/crypto.dart';

class CloudinaryServices{
  final BaseApiService apiService;
  CloudinaryServices({required this.apiService});
  
  Future<String?> uploadFile(XFile file) async {
    String? imageUrl;
    try {
      log('Starting Cloudinary upload for file: ${file.path}');
      
      // Get cloud name, API key, and secret from environment
      final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'];
      final apiKey = dotenv.env['CLOUDINARY_API_KEY'];
      final apiSecret = dotenv.env['CLOUDINARY_API_SECRET'];
      
      if (cloudName == null) {
        throw Exception('CLOUDINARY_CLOUD_NAME not found in environment variables');
      }
      if (apiKey == null) {
        throw Exception('CLOUDINARY_API_KEY not found in environment variables');
      }
      if (apiSecret == null) {
        throw Exception('CLOUDINARY_API_SECRET not found in environment variables');
      }
      
      log('Cloud name: $cloudName');
      log('API Key: ${apiKey.substring(0, 5)}...');
      
      var stream = http.ByteStream(file.openRead());
      stream.cast();
      var length = await file.length();
      
      // Use the authenticated upload endpoint
      var uploadUrl = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";
      var timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round().toString();
      
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
        ..fields['api_key'] = apiKey
        ..fields['timestamp'] = timestamp
        ..files.add(http.MultipartFile('file', stream, length,
            filename: file.path.split('/').last));
      
      // Generate signature
      final params = request.fields.entries
          .where((e) => e.key != 'file')
          .map((e) => '${e.key}=${e.value}')
          .toList()
        ..sort();
      final paramString = params.join('&');
      final signature = _generateSignature(paramString, apiSecret);
      request.fields['signature'] = signature;

      log('Uploading to: $uploadUrl');
      var response = await request.send();

      log('Cloudinary response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        imageUrl = jsonMap['secure_url'] ?? jsonMap['url'];
        log('Upload successful. Image URL: $imageUrl');
      } else {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        log("Failed to upload image: ${file.path}");
        log("Response: $responseString");
      }
    } catch (e) {
      log("Error uploading image: $e");
    }
    return imageUrl;
  }
  
  String _generateSignature(String paramString, String apiSecret) {
    // Generate SHA1 hash of paramString + apiSecret
    final bytes = utf8.encode(paramString + apiSecret);
    final digest = sha1.convert(bytes);
    return digest.toString();
  }
  
  Future<String?> uploadUint8List(Uint8List data, String filename) async {
    String? imageUrl;
    try {
      log('Starting Cloudinary upload for Uint8List: $filename');
      
      // Get cloud name, API key, and secret from environment
      final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'];
      final apiKey = dotenv.env['CLOUDINARY_API_KEY'];
      final apiSecret = dotenv.env['CLOUDINARY_API_SECRET'];
      
      if (cloudName == null) {
        throw Exception('CLOUDINARY_CLOUD_NAME not found in environment variables');
      }
      if (apiKey == null) {
        throw Exception('CLOUDINARY_API_KEY not found in environment variables');
      }
      if (apiSecret == null) {
        throw Exception('CLOUDINARY_API_SECRET not found in environment variables');
      }
      
      log('Cloud name: $cloudName');
      log('API Key: ${apiKey.substring(0, 5)}...');
      
      // Use the authenticated upload endpoint
      var uploadUrl = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";
      var timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round().toString();
      
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
        ..fields['api_key'] = apiKey
        ..fields['timestamp'] = timestamp
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          data,
          filename: filename,
          contentType: MediaType('image', 'jpeg'),
        ));
      
      // Generate signature
      final params = request.fields.entries
          .where((e) => e.key != 'file')
          .map((e) => '${e.key}=${e.value}')
          .toList()
        ..sort();
      final paramString = params.join('&');
      final signature = _generateSignature(paramString, apiSecret);
      request.fields['signature'] = signature;

      log('Uploading to: $uploadUrl');
      var response = await request.send();

      log('Cloudinary response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        imageUrl = jsonMap['secure_url'] ?? jsonMap['url'];
        log('Upload successful. Image URL: $imageUrl');
      } else {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        log("Failed to upload Uint8List");
        log("Response: $responseString");
      }
    } catch (e) {
      log("Error uploading Uint8List: $e");
    }
    return imageUrl;
  }
}
