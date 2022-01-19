import 'package:brasil_data/core/models/login_model.dart';
import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/repositories/impl/user_repository.dart';
import 'package:brasil_data/core/services/interface/service.dart';
import 'package:brasil_data/core/util/or.dart';

class LoginService implements Service<LoginModel, UserModel> {
  UserRepository repository = UserRepository();

  @override
  Future<Or<UserModel, String>> action(LoginModel data) async {
    try {
      Map<String, dynamic> json = await repository.get(data);
      return Or<UserModel, String>(UserModel.fromJson(json));
    } catch (e) {
      return Or<UserModel, String>(e.toString());
    }
  }
}
