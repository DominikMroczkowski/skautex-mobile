import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'router.dart' as calendar;

class Calendar extends StatelessWidget {
	final GlobalKey<NavigatorState> navigator = GlobalKey();

	Widget build(BuildContext context) {
		return Provider(
			child:  Navigator(
				key: navigator,
				onGenerateRoute: calendar.Router.generateRoute,
				initialRoute: '/home/calendar',
			),
			context: context,
			navigator: navigator
		);
	}
}

