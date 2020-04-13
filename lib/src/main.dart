import 'package:flutter/material.dart';
import 'screens/login.dart' as screens;

class App extends StatelessWidget {
	Widget build(context) {
		return MaterialApp(
			title: 'Skautex',
			home: Scaffold(
				body: screens.Login()
			)
		);
	}
}
