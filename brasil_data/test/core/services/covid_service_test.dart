import 'package:brasil_data/core/exceptions/internet_exceptions.dart';
import 'package:brasil_data/core/models/covid_input_model.dart';
import 'package:brasil_data/core/models/covid_registration_day_model.dart';
import 'package:brasil_data/core/models/covid_response_model.dart';
import 'package:brasil_data/core/services/impl/covid_service.dart';
import 'package:brasil_data/core/util/or.dart';
import 'package:test/test.dart';

void main() {
  group("CovidService: ", () {
    CovidInputModel modelTest =
        CovidInputModel(date: "2022-01-16", state: "RJ");
    CovidService service = CovidService();
    test("1- Buscando dados corretamente", () async {
      Or<CovidResponseModel, String> response = await service.action(modelTest);
      expect(response.type, equals(isA<CovidResponseModel>()));

      CovidResponseModel val = response.value;
      expect(val.count, equals(1));
      expect(val.results.length, equals(1));
      expect(val.next, equals(null));
      expect(val.prev, equals(null));

      CovidRegistrationDayModel reg = val.results[0];
      expect(reg.city, equals("RJ"));
      expect(reg.date, equals("2022-01-16"));
      expect(reg.isLast, equals(false));
      expect(reg.cityIbgeCode, equals(33));
      expect(reg.confirmed, equals(1442517));
      expect(reg.confirmedPer100kInhabitants, equals(8306.46839));
      expect(reg.deaths, equals(69585));
      expect(reg.deathRate, equals(0.0482));
      expect(reg.estimatedPopulation, equals(17366189));
      expect(reg.estimatedPopulation2019, equals(17264943));
      expect(reg.placeType, equals("state"));
    });

    test("2- Página inválida", () async {
      modelTest.page = 2;
      Or<CovidResponseModel, String> response = await service.action(modelTest);
      expect(response.type, equals(isA<String>()));
      String val = response.value;
      expect(val, equals(NotFoundException().toString()));
    });
    modelTest.page = 1;
    test("3- UF inválido", () async {
      modelTest.state = "RP";
      Or<CovidResponseModel, String> response = await service.action(modelTest);
      expect(response.type, equals(isA<String>()));
      String val = response.value;
      expect(val, equals(BadRequestException(["state"]).toString()));
    });
    modelTest.state = "RJ";
    test("4- Data inválida", () async {
      modelTest.date = "RP";
      Or<CovidResponseModel, String> response = await service.action(modelTest);
      expect(response.type, equals(isA<String>()));
      String val = response.value;
      expect(val, equals(BadRequestException(["date"]).toString()));
    });
    modelTest.date = "2022-01-16";
    test("5- Data válida, porém o último valor está como verdadeiro", () async {
      modelTest.date = "2022-01-15";
      modelTest.isLast = true;
      Or<CovidResponseModel, String> response = await service.action(modelTest);
      expect(response.type, equals(isA<CovidResponseModel>()));

      CovidResponseModel val = response.value;
      expect(val.count, equals(0));
      expect(val.results.length, equals(0));
      expect(val.next, equals(null));
      expect(val.prev, equals(null));
    });
  });
}
