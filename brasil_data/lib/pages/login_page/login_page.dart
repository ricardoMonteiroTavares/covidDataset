import 'package:brasil_data/core/validators/form_validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.alternate_email),
              labelText: "E-mail",
            ),
            validator: FormValidator.validateEmail,
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.password),
              labelText: "Senha",
            ),
            validator: FormValidator.validatePassword,
          ),
          ElevatedButton(
            child: const Text("Entrar"),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
