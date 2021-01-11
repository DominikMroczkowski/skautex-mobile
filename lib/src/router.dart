import 'package:flutter/material.dart';

import 'routes/home/home.dart';
import 'routes/login/login.dart';
import 'routes/home/router.dart' as home;
import 'routes/login/router.dart' as login;

import 'routes/login/bloc/bloc.dart' as login;

class Router {

  static Route<dynamic> generateRoute(RouteSettings settings) {
		var routes = _mainRoutes(settings);
		routes.addAll(home.routes(settings));
		routes.addAll(login.routes(settings));

		return routes[settings.name];
	}

	static Map<String, MaterialPageRoute> _mainRoutes(RouteSettings settings){
		return {
		'/': MaterialPageRoute(
				builder: (_) => login.Provider(child: Login()),
				settings: settings),
		'/home': MaterialPageRoute(
				builder: (_) => Home(),
				settings: settings
			)
		};
	}
}
