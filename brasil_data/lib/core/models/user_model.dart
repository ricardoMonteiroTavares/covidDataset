import 'package:brasil_data/core/models/model.dart';

class UserModel extends OutputModel {
  late String? email, name;

  UserModel(this.email, this.name);

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["user"];
    email = json["e-mail"];
  }
}
