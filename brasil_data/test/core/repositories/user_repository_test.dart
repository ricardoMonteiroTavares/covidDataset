import 'package:brasil_data/core/exceptions/user_exceptions.dart';
import 'package:brasil_data/core/models/login_model.dart';
import 'package:brasil_data/core/repositories/impl/user_repository.dart';
import 'package:test/test.dart';

void main() {
  group("UserRepository", () {
    UserRepository repository = UserRepository();
    LoginModel model =
        LoginModel(email: "admin@brasildata.com", password: "admin1234");
    test("Dados válidos", () async {
      Map<String, dynamic> response = await repository.get(model);
      expect(response["user"], equals("Administrador"));
      expect(response["e-mail"], equals("admin@brasildata.com"));
    });
    test("E-mail inválido", () {
      model.email = "abcd";
      expect(() async => await repository.get(model),
          throwsA(isA<InvalidEmailException>()));
    });
    model.email = "admin@brasildata.com";
    test("Senha incorreta", () {
      model.password = "fkgd";
      expect(() async => await repository.get(model),
          throwsA(isA<IncorrectPasswordException>()));
    });
  });
}
