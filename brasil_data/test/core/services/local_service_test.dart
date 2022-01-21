import 'package:brasil_data/core/exceptions/failed_exception.dart';
import 'package:brasil_data/core/exceptions/internet_exceptions.dart';
import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/services/impl/local_service.dart';
import 'package:brasil_data/core/util/or.dart';
import 'package:test/test.dart';

void main() {
  group("LocalService: ", () {
    LocalService service = LocalService();
    service.removeAll();
    test("1- Buscando dados não existentes", () async {
      Or<UserModel, String> response = await service.action(null);
      expect(response.type, equals(String));
      String val = response.value;
      expect(val, equals(NotFoundException().toString()));
    });

    UserModel modelTest = UserModel(email: "abacaxi@a.com", name: "Eterovaldo");
    test("2- Adicionando valores", () async {
      Or<UserModel, String> response = await service.action(modelTest);
      expect(response.type, equals(UserModel));
      UserModel val = response.value;
      expect(val.email, equals(modelTest.email));
      expect(val.name, equals(modelTest.name));
    });
    test("3- Buscando valores válidos", () async {
      Or<UserModel, String> response = await service.action(null);
      expect(response.type, equals(UserModel));
      UserModel val = response.value;
      expect(val.email, equals(modelTest.email));
      expect(val.name, equals(modelTest.name));
    });

    test("4- Limapndo valores existentes", () async {
      bool response = await service.removeAll();

      expect(response, equals(true));
    });

    test("4- Limapndo valores inexistentes", () async {
      bool response = await service.removeAll();

      expect(response, equals(true));
    });
  });
}
