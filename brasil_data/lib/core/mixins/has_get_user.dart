import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/services/impl/local_service.dart';
import 'package:brasil_data/core/util/or.dart';

mixin HasAndGetUser {
  Future<bool> hasUser() async {
    Or<UserModel, String> response = await getUser();
    return response.type == UserModel;
  }

  Future<Or<UserModel, String>> getUser() async {
    return await LocalService().action(null);
  }
}
