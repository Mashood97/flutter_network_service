import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpNetworkService {
  static getRequest({var url, var headers}) async {
    try {
      final response = await http.get(url, headers: headers);
      final decodedResponse = json.decode(response.body);
      return decodedResponse;
    } catch (e) {
      throw e;
    }
  }

  static postRequest({var url, var headers, var body}) async {
    try {
      final response = await http.post(url, headers: headers, body: body);
      final decodedResponse = json.decode(response.body);
      return decodedResponse;
    } catch (e) {
      throw e;
    }
  }

  static putRequest({var url, var headers, var body}) async {
    try {
      final response = await http.put(url, headers: headers, body: body);
      final decodedResponse = json.decode(response.body);
      return decodedResponse;
    } catch (e) {
      throw e;
    }
  }

  static deleteRequest({var url, var headers}) async {
    try {
      final response = await http.delete(url, headers: headers);
      final decodedResponse = json.decode(response.body);
      return decodedResponse;
    } catch (e) {
      throw e;
    }
  }

  static patchRequest({var url, var headers, var body}) async {
    try {
      final response = await http.patch(url, headers: headers, body: body);
      final decodedResponse = json.decode(response.body);
      return decodedResponse;
    } catch (e) {
      throw e;
    }
  }
}
