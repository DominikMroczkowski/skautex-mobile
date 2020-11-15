import 'package:flutter/material.dart';

import 'routes/booking/booking.dart';

import 'view.dart';
const _route = '/home/bookings';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
		if (_route == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  View(),
				settings: settings
			);
		else if (_route + '/booking' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  Booking(booking: settings.arguments),
				settings: settings
			);
	}
}
