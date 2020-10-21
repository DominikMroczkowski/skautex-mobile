import 'package:flutter/material.dart';

import 'home.dart';

import 'routes/players/players.dart';
import 'routes/recommended/recommended.dart';
import 'routes/calendar/calendar.dart';
import 'routes/task/task.dart';
import 'routes/costs/costs.dart';
import 'routes/booking/booking.dart';
import 'routes/reports/reports.dart';
import 'routes/test/test.dart';
import 'routes/ranking/ranking.dart';
import 'routes/users/users.dart';

const _route = '/home';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
		if (_route == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  View(),
				settings: settings
			);
		else if (_route + '/players' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  Players(),
				settings: settings
			);
		else if (_route + '/recommended' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  Recommended(),
				settings: settings
			);
		else if (_route + '/calendar' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  Calendar(),
				settings: settings
			);
		else if (_route + '/task' == settings.name)
	   	return MaterialPageRoute(
				builder: (_) =>  Task(),
				settings: settings
			);
		else if (_route + '/expenses' == settings.name)
	   	return MaterialPageRoute(
				builder: (_) =>  Costs(),
				settings: settings
			);
		else if (_route + '/booked' == settings.name)
	   	return MaterialPageRoute(
				builder: (_) =>  Booking(),
				settings: settings
			);
		else if (_route + '/reports' == settings.name)
   		return MaterialPageRoute(
				builder: (_) =>  Reports(),
				settings: settings
			);
		else if (_route + '/test' == settings.name)
 	  	return MaterialPageRoute(
				builder: (_) =>  Test(),
				settings: settings
			);
		else if (_route + '/rankings' == settings.name)
	   	return MaterialPageRoute(
				builder: (_) =>  Ranking(),
				settings: settings
			);
		else if (_route + '/users' == settings.name)
	   	return MaterialPageRoute(
				builder: (_) =>  Users(),
				settings: settings
			);


	}
}
