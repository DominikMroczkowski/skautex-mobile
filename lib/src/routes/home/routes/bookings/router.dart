import 'package:flutter/material.dart';

import 'routes/booking/booking.dart';

import 'bookings.dart';
const _route = '/home/bookings';

Map<String, MaterialPageRoute> routes(RouteSettings settings) {
	return {
		_route: MaterialPageRoute(
			builder: (_) =>  Bookings(),
			settings: settings
		),
		_route + '/booking': MaterialPageRoute(
			builder: (_) =>  Booking(booking: settings.arguments),
			settings: settings
		)
	};
}
