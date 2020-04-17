import 'package:flutter/material.dart';
import 'screens/login.dart' as screens;
import 'blocs/login/login.dart' as login_bloc;

class App extends StatelessWidget {
	Widget build(context) {
		return MaterialApp(
			title: 'Skautex',
			home: Scaffold(
				body: login_bloc.Provider(child: screens.Login())
			)
		);
	}
}
