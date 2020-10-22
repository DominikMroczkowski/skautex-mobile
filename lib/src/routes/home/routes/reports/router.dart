import 'package:flutter/material.dart';

import 'view.dart';
import 'routes/add_report/add_report.dart';
import 'routes/report/report.dart';

const _route = '/home/report';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
		if (_route + 's' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  View(),
				settings: settings
			);
		else if (_route + 'report' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  Report(),
				settings: settings
			);
		else if (_route + '/addReport' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  AddReport(),
				settings: settings
			);
	}
}
