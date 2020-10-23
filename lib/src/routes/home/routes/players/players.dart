import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'router.dart' as players;

class Players extends StatelessWidget {
	Widget build(context) {
		return Provider(
			context: context,
			child: Navigator(
				onGenerateRoute: players.Router.generateRoute,
				initialRoute: '/home/players'
			)
		);
	}
}


