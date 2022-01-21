import 'package:brasil_data/core/exceptions/failed_exception.dart';
import 'package:brasil_data/core/exceptions/internet_exceptions.dart';
import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/repositories/impl/local_repository.dart';
import 'package:test/test.dart';

void main() {
  group("LocalRepository: ", () {
    LocalRepository repository = LocalRepository();
    repository.removeAll();
    test("1- Buscando dados não existentes", () async {
      expect(() async => await repository.get(),
          throwsA(isA<NotFoundException>()));
    });

    UserModel modelTest = UserModel(email: "abacaxi@a.com", name: "Eterovaldo");
    test("2- Adicionando valores", () async {
      dynamic response = await repository.set(modelTest);
      expect(response, equals(null));
    });
    test("3- Buscando valores válidos", () async {
      UserModel response = await repository.get(modelTest);
      expect(response.email, equals(modelTest.email));
      expect(response.name, equals(modelTest.name));
    });

    test("4- Limapndo valores existentes", () async {
      bool response = await repository.removeAll();
      expect(response, equals(true));
    });

    test("4- Limapndo valores inexistentes", () async {
      bool response = await repository.removeAll();
      expect(response, equals(true));
    });
  });
}
