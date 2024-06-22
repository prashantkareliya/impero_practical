import 'package:flutter/material.dart';

@immutable
class Constants {
  const Constants({required this.endpoint});

  factory Constants.of() {
    if (_instance != null) return _instance!;
    _instance = Constants._prd();
    return _instance!;
  }

  factory Constants._prd() {
    return const Constants(
      ///Base URl
      endpoint: 'http://esptiles.imperoserver.in/api/API/Product/', //  staging server
        //   endpoint: '', // live server
);
  }

  static Constants? _instance;
  final String endpoint;
}

class ResponseStatus {
  static const bool failed = false;
  static const int success = 200;
}

class ApiEndPoint {
  static const String dashBoard = "DashBoard";
  static const String productList = "ProductList";
}