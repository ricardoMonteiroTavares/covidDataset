import 'package:brasil_data/core/models/model.dart';

/// Modelo que representa os parâmetros para o login do usuário
class LoginModel extends InputModel {
  late String email;
  late String password;

  LoginModel({this.email = '', this.password = ''});
}
