import 'package:brasil_data/core/services/impl/local_service.dart';

mixin ClearUser {
  Future<bool> clearUser() async {
    return LocalService().removeAll();
  }
}
