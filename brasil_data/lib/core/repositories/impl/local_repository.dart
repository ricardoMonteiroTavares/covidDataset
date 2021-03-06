import 'package:brasil_data/core/exceptions/failed_exception.dart';
import 'package:brasil_data/core/exceptions/internet_exceptions.dart';
import 'package:brasil_data/core/mixins/mixin_operators.dart';
import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/repositories/interface/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Classe que realiza a comunicação com o banco de dados local
class LocalRepository
    with RemoveAllOp, SetOP<UserModel>
    implements Repository<UserModel> {
  @override
  Future<UserModel> get([UserModel? data]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name, email, dateTime;
    if ((name = prefs.getString("name")) == null) {
      throw NotFoundException();
    }
    if ((email = prefs.getString("email")) == null) {
      throw NotFoundException();
    }
    if ((dateTime = prefs.getString("dateTime")) == null) {
      throw NotFoundException();
    }

    DateTime now = DateTime.now();
    DateTime actual = DateTime.parse(dateTime!);
    if (now.difference(actual).inHours >= 3) {
      throw NotFoundException();
    }
    prefs.setString("dateTime", now.toString());
    return UserModel(email: email, name: name);
  }

  @override
  Future set(UserModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!(await prefs.setString("name", data.name!))) {
      throw FailedException();
    }
    if (!(await prefs.setString("email", data.email!))) {
      throw FailedException();
    }
    if (!(await prefs.setString("dateTime", DateTime.now().toString()))) {
      throw FailedException();
    }
  }

  @override
  Future<bool> removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.clear();
  }
}
