import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/routes/app_routes.dart';
import 'package:brasil_data/pages/covid_data_page/covid_data_page.dart';
import 'package:brasil_data/pages/login_page/login_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return buildRoute(const LoginPage(), settings: settings);
      case AppRoutes.covidDataPage:
        final arguments = settings.arguments;
        if (arguments == null) {
          return buildRoute(const LoginPage(), settings: settings);
        }
        return buildRoute(CovidDataPage(user: arguments as UserModel),
            settings: settings);

      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Erro 404!',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Parece que a página que você tentou acessar não existe!!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(_, AppRoutes.login),
                    child: const Text("Retornar para a página de Login"))
              ],
            ),
          ),
        ),
      );
    });
  }
}
