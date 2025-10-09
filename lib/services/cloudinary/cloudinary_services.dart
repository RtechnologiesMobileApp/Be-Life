import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../data/network/base_api_services.dart';
import 'package:crypto/crypto.dart';

class CloudinaryServices {
  final BaseApiService apiService;
  CloudinaryServices({required this.apiService});

  // ====================== CONFIG / HELPERS ======================

  String _env(String key, {String? fallback}) {
    final v = dotenv.env[key];
    return (v == null || v.isEmpty) ? (fallback ?? '') : v;
  }

  // Prefer .env; fall back to literals ONLY if you must.
  ({String cloudName, String apiKey, String apiSecret, String sigAlgo})
  _creds() {
    final cloudName =
    _env('CLOUDINARY_CLOUD_NAME', fallback: 'dciyl2kz3');
    final apiKey =
    _env('CLOUDINARY_API_KEY', fallback: '989216338954452');
    final apiSecret =
    _env('CLOUDINARY_API_SECRET', fallback: 'g8JDUa4IuoIPkvcBxFTpqzubJIU');

    // Signature algorithm: "sha256" OR "sha1" (default sha1, like Cloudinary SDKs)
    final algo = _env('CLOUDINARY_SIGNATURE_ALGORITHM', fallback: 'sha1').toLowerCase();
    final sigAlgo = (algo == 'sha256') ? 'sha256' : 'sha1';

    if (cloudName.isEmpty || apiKey.isEmpty || apiSecret.isEmpty) {
      throw Exception('Cloudinary credentials missing (cloudName/apiKey/apiSecret).');
    }
    return (cloudName: cloudName, apiKey: apiKey, apiSecret: apiSecret, sigAlgo: sigAlgo);
  }

  // Build Cloudinary signature from signable params only.
  // Exclude: api_key, file, resource_type, cloud_name, signature.
  String _generateSignatureFrom(
      Map<String, String> params,
      String apiSecret, {
        required String algorithm, // 'sha1' | 'sha256'
      }) {
    final signable = Map<String, String>.from(params)
      ..remove('file')
      ..remove('api_key')
      ..remove('resource_type')
      ..remove('cloud_name')
      ..remove('signature');

    final entries = signable.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final toSign = entries.map((e) => '${e.key}=${e.value}').join('&');
    final bytes = utf8.encode(toSign + apiSecret);

    if (algorithm == 'sha256') {
      return sha256.convert(bytes).toString();
    } else {
      return sha1.convert(bytes).toString();
    }
  }

  bool _looksLikeVideo(String pathOrMime) {
    final p = pathOrMime.toLowerCase();
    return p.endsWith('.mp4') ||
        p.endsWith('.mov') ||
        p.endsWith('.m4v') ||
        p.endsWith('.webm') ||
        p.contains('video/');
  }

  MediaType _guessMediaType(String path, {String? mimeHint}) {
    if (mimeHint != null && mimeHint.isNotEmpty) {
      final parts = mimeHint.split('/');
      if (parts.length == 2) return MediaType(parts[0], parts[1]);
    }
    final lower = path.toLowerCase();
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) return MediaType('image', 'jpeg');
    if (lower.endsWith('.png')) return  MediaType('image', 'png');
    if (lower.endsWith('.gif')) return  MediaType('image', 'gif');
    if (lower.endsWith('.webp')) return  MediaType('image', 'webp');
    if (lower.endsWith('.heic') || lower.endsWith('.heif')) return MediaType('image', 'heic');
    if (lower.endsWith('.mp4')) return  MediaType('video', 'mp4');
    if (lower.endsWith('.mov')) return  MediaType('video', 'quicktime');
    if (lower.endsWith('.webm')) return  MediaType('video', 'webm');
    return  MediaType('application', 'octet-stream');
  }

  int _nowSeconds() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  Future<String?> _sendMultipart({
    required Uri url,
    required Map<String, String> fields, // signable params only
    required String apiKey,
    required String apiSecret,
    required String sigAlgo,             // 'sha1' | 'sha256'
    http.MultipartFile? filePart,
  }) async {
    final signature = _generateSignatureFrom(fields, apiSecret, algorithm: sigAlgo);

    final req = http.MultipartRequest('POST', url)
      ..fields.addAll(fields)
      ..fields['api_key'] = apiKey
      ..fields['signature'] = signature;

    if (filePart != null) {
      req.files.add(filePart);
    }

    final res = await req.send();
    final body = String.fromCharCodes(await res.stream.toBytes());
    log('Cloudinary response status: ${res.statusCode}');
    if (res.statusCode == 200) {
      final jsonMap = jsonDecode(body);
      return jsonMap['secure_url'] ?? jsonMap['url'];
    } else {
      log('Cloudinary error body: $body');
      return null;
    }
  }

  // ====================== PUBLIC API ============================

  // If a video reaches here, it will auto-route to uploadVideo().
  Future<String?> uploadFile(XFile file) async {
    try {
      final mimeType = file.mimeType; // may be null on some platforms
      if (_looksLikeVideo(mimeType ?? file.path)) {
        return await uploadVideo(file);
      }

      final creds = _creds();
      final uploadUrl = Uri.parse('https://api.cloudinary.com/v1_1/${creds.cloudName}/image/upload');
      final timestamp = _nowSeconds().toString();

      final stream = http.ByteStream(file.openRead());
      final length = await file.length();
      final contentType = _guessMediaType(file.path, mimeHint: mimeType);

      // SIGNABLE params only. If you add folder/public_id/tags/context, include here.
      final fields = <String, String>{
        'timestamp': timestamp,
      };

      final filePart = http.MultipartFile(
        'file',
        stream,
        length,
        filename: file.path.split('/').last,
        contentType: contentType,
      );

      final url = await _sendMultipart(
        url: uploadUrl,
        fields: fields,
        apiKey: creds.apiKey,
        apiSecret: creds.apiSecret,
        sigAlgo: creds.sigAlgo,
        filePart: filePart,
      );

      if (url != null) log('Image upload successful. URL: $url');
      return url;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<String?> uploadVideo(XFile file) async {
    try {
      final creds = _creds();
      final uploadUrl = Uri.parse('https://api.cloudinary.com/v1_1/${creds.cloudName}/video/upload');
      final timestamp = _nowSeconds().toString();

      final stream = http.ByteStream(file.openRead());
      final length = await file.length();
      final contentType = _guessMediaType(file.path, mimeHint: file.mimeType);

      final fields = <String, String>{
        'timestamp': timestamp,
        // Add signable options here if needed (folder, public_id, eager, etc.)
      };

      final filePart = http.MultipartFile(
        'file',
        stream,
        length,
        filename: file.path.split('/').last,
        contentType: contentType, // e.g., video/mp4
      );

      final url = await _sendMultipart(
        url: uploadUrl,
        fields: fields,
        apiKey: creds.apiKey,
        apiSecret: creds.apiSecret,
        sigAlgo: creds.sigAlgo,
        filePart: filePart,
      );

      if (url != null) log('Video upload successful. URL: $url');
      return url;
    } catch (e) {
      log('Error uploading video: $e');
      return null;
    }
  }

  Future<String?> uploadUint8List(Uint8List data, String filename) async {
    try {
      final creds = _creds();
      final uploadUrl = Uri.parse('https://api.cloudinary.com/v1_1/${creds.cloudName}/image/upload');
      final timestamp = _nowSeconds().toString();

      final fields = <String, String>{
        'timestamp': timestamp,
      };

      final filePart = http.MultipartFile.fromBytes(
        'file',
        data,
        filename: filename,
        contentType: _guessMediaType(filename),
      );

      final url = await _sendMultipart(
        url: uploadUrl,
        fields: fields,
        apiKey: creds.apiKey,
        apiSecret: creds.apiSecret,
        sigAlgo: creds.sigAlgo,
        filePart: filePart,
      );

      if (url != null) log('Upload (bytes) successful. URL: $url');
      return url;
    } catch (e) {
      log('Error uploading Uint8List: $e');
      return null;
    }
  }
}