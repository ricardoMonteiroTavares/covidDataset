import 'package:brasil_data/core/models/covid_registration_day_model.dart';
import 'package:brasil_data/core/models/model.dart';

/// Representa os dados vindo do repositório de dados
class CovidResponseModel extends OutputModel {
  late int count;
  late String prev, next;
  late List<CovidRegistrationDayModel> results;

  CovidResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    prev = json['previous'];
    List<Map<String, dynamic>> _results = json['results'];
    results =
        _results.map((e) => CovidRegistrationDayModel.fromJson(e)).toList();
  }
}
