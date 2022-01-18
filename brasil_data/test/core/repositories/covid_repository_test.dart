import 'package:brasil_data/core/models/covid_model.dart';
import 'package:brasil_data/core/repositories/impl/covid_repository.dart';
import 'package:test/test.dart';

void main() {
  group("CovidRepository: ", () {
    CovidModel modelTest = CovidModel(date: "2022-01-16", state: "RJ");
    CovidRepository repository = CovidRepository();
    test("Buscando dados corretamente", () async {
      Map<String, dynamic> response = await repository.get(modelTest);
      expect(response["count"], equals(1));
      expect(response["next"], equals(null));
      expect(response["previous"], equals(null));
    });

    test("Página inválida", () async {
      modelTest.page = 2;
      Map<String, dynamic> response = await repository.get(modelTest);
      expect(response["detail"], equals("Página inválida."));
    });
    modelTest.page = 1;
    test("UF inválido", () async {
      modelTest.state = "RP";
      Map<String, dynamic> response = await repository.get(modelTest);
      expect(
          response["state"][0],
          equals(
              "Faça uma escolha válida. RP não é uma das escolhas disponíveis."));
    });
    modelTest.state = "RJ";
    test("Data inválida", () async {
      modelTest.date = "RP";
      Map<String, dynamic> response = await repository.get(modelTest);
      expect(
          response["date"][0],
          equals(
              "Faça uma escolha válida. RP não é uma das escolhas disponíveis."));
    });
    modelTest.date = "2022-01-16";
    test("Data válida, porém o último valor está como verdadeiro", () async {
      modelTest.date = "2022-01-15";
      modelTest.isLast = true;
      Map<String, dynamic> response = await repository.get(modelTest);
      expect(response["count"], equals(0));
      expect(response["next"], equals(null));
      expect(response["previous"], equals(null));
    });
  });
}
