import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'router.dart' as reports;

class Reports extends StatelessWidget {
	final _navigator = GlobalKey<NavigatorState>();

	Widget build(context) {
		return Provider(
			context: context,
			child: Navigator(
				key: _navigator,
				onGenerateRoute: reports.Router.generateRoute,
				initialRoute: '/home/reports'
			),
			navigator: _navigator
		);
	}
}


