import 'package:brasil_data/core/models/login_model.dart';
import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/routes/app_routes.dart';
import 'package:brasil_data/core/services/impl/login_service.dart';
import 'package:brasil_data/core/stateMagnement/bloc.dart';
import 'package:brasil_data/core/util/or.dart';
import 'package:flutter/material.dart';

class LoginPageBloc extends Bloc<dynamic> {
  String? _email, _password, errorMsg;
  bool obscureText = true;
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final service = LoginService();

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

  signInHandler(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      sink.add(isLoading);
      LoginModel data = LoginModel(email: _email!, password: _password!);
      Or<UserModel, String> response = await service.action(data);
      if (response.type == UserModel) {
        errorMsg = null;
        sink.add(errorMsg);
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.covidDataPage, (route) => false,
            arguments: response.value);
      } else {
        errorMsg = response.value;
        sink.add(errorMsg);
      }
      isLoading = false;
      sink.add(isLoading);
    }
  }
}
