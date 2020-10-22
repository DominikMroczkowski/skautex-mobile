import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'router.dart' as reports;

class Reports extends StatelessWidget {
	Widget build(context) {
		return Provider(
			context: context,
			child: Navigator(
				onGenerateRoute: reports.Router.generateRoute,
				initialRoute: '/home/reports'
			)
		);
	}
}


