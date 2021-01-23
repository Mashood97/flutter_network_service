import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

import 'http_exception.dart';

class HttpNetworkService {
  static _checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  //it sends a get request using http package with exception handling
  static getRequest({var url, var headers}) async {
    try {
      bool isInternetAvailable = await _checkInternet();
      if (isInternetAvailable) {
        final response = await http.get(url, headers: headers);
        if (response.statusCode == 200 || response.statusCode <= 299) {
          final decodedResponse = json.decode(response.body);
          return decodedResponse;
        } else if (response.statusCode == 300 || response.statusCode <= 399) {
          throw HttpException('Redirection error');
        } else if (response.statusCode == 400 || response.statusCode <= 499) {
          throw HttpException('Bad Request Format');
        } else if (response.statusCode == 500 || response.statusCode <= 599) {
          throw HttpException('Internal Server Error');
        }
      } else {
        throw HttpException('No Internet Found');
      }
    } catch (e) {
      throw e;
    }
  }

  //it sends a post request using http package with exception handling
  static postRequest({
    var url,
    var headers,
    var body,
  }) async {
    try {
      bool isInternetAvailable = await _checkInternet();
      if (isInternetAvailable) {
        final response = await http.post(url, headers: headers, body: body);
        if (response.statusCode == 200 || response.statusCode <= 299) {
          final decodedResponse = json.decode(response.body);
          return decodedResponse;
        } else if (response.statusCode == 300 || response.statusCode <= 399) {
          throw HttpException('Redirection error');
        } else if (response.statusCode == 400 || response.statusCode <= 499) {
          throw HttpException('Bad Request Format');
        } else if (response.statusCode == 500 || response.statusCode <= 599) {
          throw HttpException('Internal Server Error');
        }
      } else {
        throw HttpException('No Internet Found');
      }
    } catch (e) {
      throw e;
    }
  }

  //it sends a put request using http package with exception handling
  static putRequest({var url, var headers, var body}) async {
    try {
      bool isInternetAvailable = await _checkInternet();
      if (isInternetAvailable) {
        final response = await http.put(url, headers: headers, body: body);
        if (response.statusCode == 200 || response.statusCode <= 299) {
          final decodedResponse = json.decode(response.body);
          return decodedResponse;
        } else if (response.statusCode == 300 || response.statusCode <= 399) {
          throw HttpException('Redirection error');
        } else if (response.statusCode == 400 || response.statusCode <= 499) {
          throw HttpException('Bad Request Format');
        } else if (response.statusCode == 500 || response.statusCode <= 599) {
          throw HttpException('Internal Server Error');
        }
      } else {
        throw HttpException('No Internet Found');
      }
    } catch (e) {
      throw e;
    }
  }

  //it sends a delete request using http package with exception handling
  static deleteRequest({var url, var headers}) async {
    try {
      bool isInternetAvailable = await _checkInternet();
      if (isInternetAvailable) {
        final response = await http.delete(url, headers: headers);
        if (response.statusCode == 200 || response.statusCode <= 299) {
          final decodedResponse = json.decode(response.body);
          return decodedResponse;
        } else if (response.statusCode == 300 || response.statusCode <= 399) {
          throw HttpException('Redirection error');
        } else if (response.statusCode == 400 || response.statusCode <= 499) {
          throw HttpException('Bad Request Format');
        } else if (response.statusCode == 500 || response.statusCode <= 599) {
          throw HttpException('Internal Server Error');
        }
      } else {
        throw HttpException('No Internet Found');
      }
    } catch (e) {
      throw e;
    }
  }

  //it sends a patch request using http package with exception handling
  static patchRequest({var url, var headers, var body}) async {
    try {
      bool isInternetAvailable = await _checkInternet();
      if (isInternetAvailable) {
        final response = await http.patch(url, headers: headers, body: body);
        if (response.statusCode == 200 || response.statusCode <= 299) {
          final decodedResponse = json.decode(response.body);
          return decodedResponse;
        } else if (response.statusCode == 300 || response.statusCode <= 399) {
          throw HttpException('Redirection error');
        } else if (response.statusCode == 400 || response.statusCode <= 499) {
          throw HttpException('Bad Request Format');
        } else if (response.statusCode == 500 || response.statusCode <= 599) {
          throw HttpException('Internal Server Error');
        }
      } else {
        throw HttpException('No Internet Found');
      }
    } catch (e) {
      throw e;
    }
  }
}
