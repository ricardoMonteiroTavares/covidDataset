import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/services/impl/local_service.dart';
import 'package:brasil_data/core/util/or.dart';

mixin SetLocalUser {
  Future<Or<UserModel, String>> setLocalUser(UserModel data) async {
    return await LocalService().action(data);
  }
}
