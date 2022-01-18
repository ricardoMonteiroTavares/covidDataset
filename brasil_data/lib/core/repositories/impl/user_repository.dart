import 'package:brasil_data/core/models/login_model.dart';
import 'package:brasil_data/core/repositories/interface/repository.dart';

/// Repositório que busca os dados dos usuários
class UserRepository implements Repository<LoginModel> {
  @override
  Future get(LoginModel data) async {
    if (data.email == "admin@brasildata.com" && data.password == "admin1234") {
      await Future.delayed(const Duration(seconds: 2));
      return {"user": "Administrador", "e-mail": data.email};
    } else {
      throw Exception("Error: E-mail e/ou senha inválidos");
    }
  }
}
