import 'dart:convert';

import 'package:brasil_data/core/models/covid_model.dart';
import 'package:brasil_data/core/repositories/interface/repository.dart';
import 'package:http/http.dart' as http;

/// Repositório que busca os dados da Covid-19 no Brasil
class CovidRepository implements Repository<CovidModel> {
  @override
  Future<dynamic> get(CovidModel data) async {
    const String baseUrl =
        "https://api.brasil.io/v1/dataset/covid19/caso/data/";

    String url = baseUrl + data.toString();

    http.Response response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Token 8b34c604f8c467c5950550f6870bde20dc5229fb"
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error: Falha na busca dos dados");
    }
  }
}
