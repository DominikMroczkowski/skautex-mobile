import 'package:flutter/material.dart';
import 'screens/login.dart' as screens;
import 'screens/auth_code.dart' as screens;
import 'screens/change_password.dart' as screens;
import 'blocs/login/bloc.dart' as login;
import 'blocs/auth_code/bloc.dart' as auth_code;
import 'blocs/session/bloc.dart' as session;

class App extends StatelessWidget {

	Widget build(context) {
		return session.Provider(
			child: login.Provider (
				child: MaterialApp(
					title: 'Skautex',
					onGenerateRoute: routes
				)
			)
		);
	}

	Route routes(RouteSettings settings) {
		if (settings.name == "/login") {
			return MaterialPageRoute(
				builder: (context) {
					return Scaffold(
						body: screens.Login()
					);
				}
			);
		} else if (settings.name == "/auth_code") {
			return MaterialPageRoute(
				builder: (context) {
					return Scaffold(
						body: auth_code.Provider(child: screens.AuthCode())
					);
				}
			);
		} else if (settings.name == "/change_password") {
			return MaterialPageRoute(
				builder: (context) {
					return Scaffold(
						body: screens.ChangePassword()
					);
				}
			);
		}
	}
}
