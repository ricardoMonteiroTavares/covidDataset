import 'package:brasil_data/core/exceptions/internet_exceptions.dart';
import 'package:brasil_data/core/models/covid_model.dart';
import 'package:brasil_data/core/repositories/impl/covid_repository.dart';
import 'package:test/test.dart';

void main() {
  group("CovidRepository: ", () {
    CovidModel modelTest = CovidModel(date: "2022-01-16", state: "RJ");
    CovidRepository repository = CovidRepository();
    test("1- Buscando dados corretamente", () async {
      Map<String, dynamic> response = await repository.get(modelTest);
      expect(response["count"], equals(1));
      expect(response["next"], equals(null));
      expect(response["previous"], equals(null));
    });

    test("2- Página inválida", () {
      modelTest.page = 2;
      expect(() async => await repository.get(modelTest),
          throwsA(isA<NotFoundException>()));
    });
    modelTest.page = 1;
    test("3- UF inválido", () {
      modelTest.state = "RP";
      expect(() async => await repository.get(modelTest),
          throwsA(isA<BadRequestException>()));
    });
    modelTest.state = "RJ";
    test("4- Data inválida", () {
      modelTest.date = "RP";
      expect(() async => await repository.get(modelTest),
          throwsA(isA<BadRequestException>()));
    });
    modelTest.date = "2022-01-16";
    test("5- Data válida, porém o último valor está como verdadeiro", () async {
      modelTest.date = "2022-01-15";
      modelTest.isLast = true;
      Map<String, dynamic> response = await repository.get(modelTest);
      expect(response["count"], equals(0));
      expect(response["next"], equals(null));
      expect(response["previous"], equals(null));
    });
  });
}
