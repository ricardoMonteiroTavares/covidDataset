import 'package:brasil_data/core/mixins/mixin_operators.dart';
import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/repositories/impl/local_repository.dart';
import 'package:brasil_data/core/services/interface/service.dart';
import 'package:brasil_data/core/util/or.dart';

class LocalService with RemoveAllOp implements Service<UserModel?, UserModel> {
  LocalRepository repository = LocalRepository();
  @override
  Future<Or<UserModel, String>> action(UserModel? data) async {
    if (data == null) {
      try {
        UserModel response = await repository.get();
        return Or<UserModel, String>(response);
      } catch (e) {
        return Or<UserModel, String>(e.toString());
      }
    }

    try {
      repository.set(data);
      return Or<UserModel, String>(data);
    } catch (e) {
      return Or<UserModel, String>(e.toString());
    }
  }

  @override
  Future<bool> removeAll() async {
    return await repository.removeAll();
  }
}
