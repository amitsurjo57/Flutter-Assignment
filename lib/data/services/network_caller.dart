import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/main.dart';
import 'package:greeting_app/screens/Starting%20Body/log_in_screen.dart';
import 'package:greeting_app/ui/controllers/auth_controllers.dart';
import 'package:http/http.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      final Response response = await get(
        uri,
        headers: {'token' : AuthControllers.accessToken!},
      );
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      final Response response = await post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': AuthControllers.accessToken.toString(),
        },
        body: jsonEncode(body),
      );
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);

        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        Navigator.pushAndRemoveUntil(
          MyApp.navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (_) => const LogInScreen(),
          ),
          (_) => false,
        );
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          errorMessage: 'Your are expired!',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void printResponse(String url, Response response) {
    debugPrint(
      'URL: $url\nRESPONSE CODE: ${response.statusCode}\nBODY: ${response.body}\nTOKEN: ${AuthControllers.accessToken}',
    );
  }
}
