import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'router.dart' as bookings;

class Bookings extends StatelessWidget {

	Widget build(BuildContext context) {
		final GlobalKey<NavigatorState> navigator = GlobalKey();

		return Provider(
			child:  Navigator(
				key: navigator,
				onGenerateRoute: bookings.Router.generateRoute,
				initialRoute: '/home/bookings',
			),
			context: context,
			navigator: navigator
		);
	}
}
