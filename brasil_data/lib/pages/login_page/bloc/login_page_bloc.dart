import 'package:brasil_data/core/models/login_model.dart';
import 'package:brasil_data/core/stateMagnement/bloc.dart';
import 'package:flutter/material.dart';

class LoginPageBloc extends Bloc<dynamic> {
  String? _email, _password;
  bool obscureText = true;

  final formKey = GlobalKey<FormState>();

  Widget get icon => obscureText
      ? const Icon(Icons.remove_red_eye_rounded)
      : const ImageIcon(AssetImage("assets/icons/closed-eye.png"));

  void setEmail(String? newEmail) {
    _email = newEmail;
    sink.add(_email);
  }

  void setPassword(String? newPassword) {
    _password = newPassword;
    sink.add(_password);
  }

  void toggleHandler() {
    obscureText = !obscureText;
    sink.add(obscureText);
  }

  signInHandler() {
    if (formKey.currentState!.validate()) {
      LoginModel data = LoginModel(email: _email!, password: _password!);
      print("Deu certo");
    }
  }
}
