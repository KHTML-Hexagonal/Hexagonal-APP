import 'dart:convert';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ServerApi {
  static Future<Map<String, String>> getHeaders() async {
    String accessToken = dotenv.env['ACCESS_TOKEN']!;
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
  }

  static String baseUrl = 'http://52.231.105.228';

  //건물주 등록 API
  static Future<BuildingRegistrationResponse> postOwnerHouse(
      String buildingId, List<http.MultipartFile> images) async {
    Map<String, String> headers = await getHeaders();

    final url = Uri.parse('$baseUrl/api/v1/buildings/$buildingId/register');

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..files.addAll(images);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return BuildingRegistrationResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to register building: ${response.statusCode}');
    }
  }
}
