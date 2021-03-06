import 'dart:convert';
import 'dart:io';

import 'package:brasil_data/core/exceptions/failed_exception.dart';
import 'package:brasil_data/core/exceptions/internet_exceptions.dart';
import 'package:brasil_data/core/models/covid_input_model.dart';
import 'package:brasil_data/core/repositories/interface/repository.dart';
import 'package:http/http.dart' as http;

/// Repositório que busca os dados da Covid-19 no Brasil
class CovidRepository implements Repository<CovidInputModel> {
  @override
  Future<dynamic> get([CovidInputModel? data]) async {
    if (data == null) {
      throw NullThrownError();
    }
    try {
      const String baseUrl =
          "https://api.brasil.io/v1/dataset/covid19/caso/data/";

      String url = baseUrl + data.toString();

      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Token 8b34c604f8c467c5950550f6870bde20dc5229fb"
      });

      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.body);
        case 400:
          throw BadRequestException(
              Map<String, dynamic>.from(jsonDecode(response.body)).keys);
        case 404:
          throw NotFoundException();
        default:
          throw FailedException();
      }
    } on SocketException catch (_) {
      throw NoInternetException();
    }
  }
}
