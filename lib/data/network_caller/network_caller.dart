import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:taskmanager/data/models/network_response.dart';

class NetworkCaller {
  //this is a get operation from api
  // static keyword use korle class er instance  create korte hoina object access korar jonno
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData,
            errorMessage: null);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            responseData: null,
            errorMessage: null);
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  //post operation is here
  static Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      //-------//////////////////////////////////-----------//

      debugPrint(body.toString());
      debugPrint(url.toString());
      //-------//////////////////////////////////-----------//

      Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {'Content-type': 'Application/json '});
      //-------//////////////////////////////////-----------//
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      //-------//////////////////////////////////-----------//

      if (response.statusCode == 200 || response.statusCode == 201) {
        final encodedData = jsonEncode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: encodedData,
            errorMessage: null);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            responseData: null,
            errorMessage: null);
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }
}
