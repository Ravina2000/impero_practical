import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ravina_impero_practical/src/data/constants/api_constants.dart';

class APIHelper{
  Future<http.Response?>? post(
      {required String path,
        String? host,
        String? scheme,
        Map<String, String>? headers,
        required http.Client httpClient,
        Map<String, dynamic>? params,
        required Map body}) async {
    Uri apiUri = Uri(
        scheme: scheme ?? 'http',
        host: ApiConstants.hostUrl,
        path: path,
        queryParameters: params);

    print(
        '==========================POST REQUEST===================================');
    print('API URI :: $apiUri');

    try {
      final response =
      await http.post(apiUri, headers: headers, body: jsonEncode(body));
      print(
          '==========================POST RESPONSE===================================');
      print('STATUS CODE :: ${response.statusCode}');
      print('HEADERS :: ${jsonEncode(headers)}');
      print('REQUEST :: ${jsonEncode(body)}');
      print('RESPONSE :: ${response.body}');

      return response;
    } catch (e) {
      print(
          '==========================POST ERROR===================================');
      print("API ERROR :: $e");
      return null;
    }
  }
}