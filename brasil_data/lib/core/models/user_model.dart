import 'package:brasil_data/core/models/model.dart';

class UserModel extends OutputModel {
  late String? email, name;

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json["user"];
    name = json["e-mail"];
  }
}
