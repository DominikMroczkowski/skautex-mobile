import 'package:flutter/material.dart';

import 'home.dart';

import 'routes/players/router.dart' as players;
import 'routes/recommended/recommended.dart';
import 'routes/calendar/router.dart' as calendar;
import 'routes/task/task.dart';
import 'routes/costs/costs.dart';
import 'routes/bookings/router.dart' as bookings;
import 'routes/reports/router.dart' as reports;
import 'routes/test/test.dart';
import 'routes/ranking/ranking.dart';
import 'routes/users/router.dart' as users;
import 'routes/options/options.dart';

const _route = '/home';

Map<String, MaterialPageRoute> routes(RouteSettings settings){
	var routes = {
		_route: MaterialPageRoute(
			builder: (_) =>  Home(),
			settings: settings
		),
		_route + '/recommended': MaterialPageRoute(
			builder: (_) =>  Recommended(),
			settings: settings
		),
		_route + '/task': MaterialPageRoute(
			builder: (_) =>  Task(),
			settings: settings
		),
		_route + '/expenses': MaterialPageRoute(
			builder: (_) =>  Costs(),
			settings: settings
		),
		_route + '/test': MaterialPageRoute(
			builder: (_) =>  Test(),
			settings: settings
		),
		_route + '/rankings': MaterialPageRoute(
			builder: (_) =>  Ranking(),
			settings: settings
		),
		_route + '/options': MaterialPageRoute(
			builder: (_) =>  Options(),
			settings: settings
		)
	};

	routes.addAll(reports.routes(settings));
	routes.addAll(players.routes(settings));
	routes.addAll(users.routes(settings));
	routes.addAll(calendar.routes(settings));
	routes.addAll(bookings.routes(settings));
	return routes;
}
