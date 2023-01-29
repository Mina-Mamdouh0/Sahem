import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static Future<dynamic> get({required String url,required Map<String, String> queryParams,}) async {

    http.Response response = await http.get(Uri.parse(url).replace(
      queryParameters: queryParams,
    ),headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('there is a problem with status code ${response.statusCode}');
    }
  }

  static Future<dynamic> post(
      {required String url,
      required dynamic body,}) async {
    http.Response response =
        await http.post(Uri.parse(url), body: body,);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;

    } else {
      throw Exception('there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
}
