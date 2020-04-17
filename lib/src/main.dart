import 'package:flutter/material.dart';
import 'screens/login.dart' as screens;
import 'screens/auth_code.dart' as screens;
import 'blocs/login/login.dart' as login_bloc;
import 'blocs/auth_code/auth_code.dart' as auth_code_bloc;

class App extends StatelessWidget {

	Widget build(context) {
		return MaterialApp(
			title: 'Skautex',
			onGenerateRoute: routes
		);
	}

	Route routes(RouteSettings settings) {
		if (settings.name == "/") {
			return MaterialPageRoute(
				builder: (context) {
					return Scaffold(
						body: login_bloc.Provider(child: screens.Login())
					);
				}
			);
		} else {
			return MaterialPageRoute(
				builder: (context) {
					return Scaffold(
						body: auth_code_bloc.Provider(child: screens.AuthCode())
					);
				}
			);
		}
	}
}
