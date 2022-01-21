import 'package:brasil_data/core/validators/form_validator.dart';
import 'package:brasil_data/core/widgets/alert_error_widget.dart';
import 'package:brasil_data/pages/login_page/bloc/login_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = LoginPageBloc();
  final _width = 500.0, _height = 40.0;
  final _space = const SizedBox(
    height: 15,
  );
  @override
  void dispose() {
    _bloc.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          _bloc.signInHandler(context);
        }
      },
      child: StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) => Scaffold(
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Form(
                key: _bloc.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/logo_colored.png",
                        width: 300,
                      ),
                      AlertErrorWidget(
                        msg: _bloc.errorMsg,
                        maxWidth: _width,
                        minHeight: _height,
                      ),
                      _space,
                      Container(
                        constraints: BoxConstraints(maxWidth: _width),
                        child: TextFormField(
                          focusNode: FocusNode(),
                          decoration: const InputDecoration(
                            icon: Icon(Icons.alternate_email),
                            labelText: "E-mail",
                          ),
                          onChanged: _bloc.setEmail,
                          validator: FormValidator.validateEmail,
                        ),
                      ),
                      _space,
                      Container(
                        constraints: BoxConstraints(maxWidth: _width),
                        child: TextFormField(
                          focusNode: FocusNode(),
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
                      ),
                      _space,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(_width, _height),
                        ),
                        child: (_bloc.isLoading)
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                ),
                              )
                            : const Text("Entrar"),
                        onPressed: (_bloc.isLoading)
                            ? null
                            : () => _bloc.signInHandler(context),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
