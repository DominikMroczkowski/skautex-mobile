import 'package:flutter/material.dart';

import 'view.dart';
const _route = '/home/calendar';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
		if (_route == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  View(),
				settings: settings
			);
	}
}
