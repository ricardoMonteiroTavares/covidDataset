import 'package:brasil_data/core/exceptions/user_exceptions.dart';
import 'package:brasil_data/core/models/login_model.dart';
import 'package:brasil_data/core/repositories/interface/repository.dart';

/// Repositório que busca os dados dos usuários
class UserRepository implements Repository<LoginModel> {
  @override
  Future get(LoginModel data) async {
    bool emailCompare = data.email == "admin@brasildata.com";
    bool passwordCompare = data.password == "admin1234";

    if (emailCompare && passwordCompare) {
      await Future.delayed(const Duration(seconds: 2));
      return {"user": "Administrador", "e-mail": data.email};
    } else if (!emailCompare) {
      throw InvalidEmailException();
    } else if (!passwordCompare) {
      throw IncorrectPasswordException();
    } else {
      throw Exception("Erro indefinido");
    }
  }
}
