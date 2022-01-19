import 'package:brasil_data/core/models/model.dart';

/// Classe que representa os casos e mortes de COVID-19 em um dia
class CovidRegistrationDayModel extends Model {
  late String city, date, placeType, state;
  late num cityIbgeCode,
      confirmed,
      confirmedPer100kInhabitants,
      deathRate,
      deaths,
      estimatedPopulation,
      estimatedPopulation2019,
      orderForPlace;
  late bool isLast;

  CovidRegistrationDayModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    date = json['date'];
    placeType = json['place_type'];
    cityIbgeCode = json['city_ibge_code'];
    confirmed = json['confirmed'];
    confirmedPer100kInhabitants = json['confirmed_per_100k_inhabitants'];
    deaths = json['deaths'];
    deathRate = json['death_rate'];
    estimatedPopulation = json['estimated_population'];
    estimatedPopulation2019 = json['estimated_population_2019'];
    orderForPlace = json['order_for_place'];
    isLast = json['is_last'];
  }
}
