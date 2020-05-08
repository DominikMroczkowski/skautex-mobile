import 'package:flutter/material.dart';

import 'blocs/login/bloc.dart' as login;
import 'blocs/session/bloc.dart' as session;

import 'router.dart';

class App extends StatelessWidget {

	Widget build(context) {
		return session.Provider(
			child: login.Provider (
				child: MaterialApp(
					title: 'Skautex',
					onGenerateRoute: Router.generateRoute
				)
			)
		);
	}
}
