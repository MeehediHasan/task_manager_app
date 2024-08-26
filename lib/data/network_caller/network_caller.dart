import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../../ui/controller/auth_controller.dart';
import '../models/network_response.dart';

class NetworkCaller {
  //-------for get request
  static Future<NetworkResponse> getResponse(String url) async {
    try {
      debugPrint(url);
      Response response = await get(
        Uri.parse(url),
        headers: {
          'token': AuthController.accessToken,
        },
      );
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());


      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
          errorMessage: null,
        );
      } //---for failure case 200
      else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: null,
          errorMessage: null,
        );
      }
    } //---for failure case to get data form api
    catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  //-------for post request
  static Future<NetworkResponse> postResponse(String url,
      {Map<String, dynamic>? body}) async {
    try {
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-type': 'Application/json',
          'token': AuthController.accessToken,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
        debugPrint(response.statusCode.toString());
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}
