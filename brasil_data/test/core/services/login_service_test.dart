import 'package:brasil_data/core/exceptions/user_exceptions.dart';
import 'package:brasil_data/core/models/login_model.dart';
import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/services/impl/login_service.dart';
import 'package:brasil_data/core/util/or.dart';
import 'package:test/test.dart';

void main() {
  group("LoginService", () {
    LoginService service = LoginService();
    LoginModel model =
        LoginModel(email: "admin@brasildata.com", password: "admin1234");
    test("Dados válidos", () async {
      Or<UserModel, String> response = await service.action(model);
      expect(response.type, equals(isA<UserModel>()));

      UserModel val = response.value;
      expect(val.name, equals("Administrador"));
      expect(val.email, equals("admin@brasildata.com"));
    });
    test("E-mail inválido", () async {
      model.email = "abcd";
      Or<UserModel, String> response = await service.action(model);
      expect(response.type, equals(isA<String>()));

      String val = response.value;
      expect(val, equals(InvalidEmailException().toString()));
    });
    model.email = "admin@brasildata.com";
    test("Senha incorreta", () async {
      model.password = "fkgd";
      Or<UserModel, String> response = await service.action(model);
      expect(response.type, equals(isA<String>()));

      String val = response.value;
      expect(val, equals(IncorrectPasswordException().toString()));
    });
  });
}
