import 'package:brasil_data/core/validators/form_validator.dart';
import 'package:brasil_data/pages/login_page/bloc/login_page_bloc.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = LoginPageBloc();

  @override
  void dispose() {
    _bloc.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) => Form(
          key: _bloc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.alternate_email),
                  labelText: "E-mail",
                ),
                onChanged: _bloc.setEmail,
                validator: FormValidator.validateEmail,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.password),
                  labelText: "Senha",
                  suffixIcon: IconButton(
                    icon: _bloc.icon,
                    onPressed: _bloc.toggleHandler,
                  ),
                ),
                obscureText: _bloc.obscureText,
                onChanged: _bloc.setPassword,
                validator: FormValidator.validatePassword,
              ),
              ElevatedButton(
                child: const Text("Entrar"),
                onPressed: _bloc.signInHandler,
              )
            ],
          ),
        ),
      ),
    );
  }
}
