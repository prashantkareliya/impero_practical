import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../constants/strings.dart';


class HttpActions {
  String endPoint = Constants.of().endpoint;
  http.Client _client = http.Client();

  Future<dynamic> postMethod(String url,
      {dynamic data, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(headers ?? {});
      print("data ${jsonEncode(data)}");
      print(Uri.parse(endPoint + url));
      http.Response response = await http.post(Uri.parse(endPoint + url),
          body: jsonEncode(data.toString()), headers: headers);
      log(response.body);
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Map<String, String> getSessionData(Map<String, String> headers) {
    headers["content-type"] = "application/x-www-form-urlencoded; charset=utf-8";
    return headers;
  }

  Future<List<ConnectivityResult>> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult;
  }
}
