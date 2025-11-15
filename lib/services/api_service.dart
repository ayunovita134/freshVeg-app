import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Change this to your local IP when using physical device
  static const String baseUrl = 'http://192.168.11.149:8000/api/predict/';

  static Future<Map<String, dynamic>> predictPotato(String imagePath) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(responseBody);
        return {
          'result': jsonResponse['result'],
          'confidence': jsonResponse['confidence'],
        };
      } else {
        throw Exception('API Error: ${response.statusCode} - $responseBody');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.');
    } on HttpException {
      throw Exception('Unable to connect to the server. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response from server.');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
