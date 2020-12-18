import 'package:flutter/material.dart';

import 'routes/home/home.dart';
import 'routes/login/login.dart';

import 'routes/home/bloc/bloc.dart' as home;
import 'routes/login/bloc/bloc.dart' as login;

class Router {

  static Route<dynamic> generateRoute(RouteSettings settings) {
		if ('/' == settings.name || '/login' == settings.name)
    	return MaterialPageRoute(
				builder: (_) => login.Provider(child: Login()),
				settings: settings
			);
		else if  ('/home' == settings.name)
			return MaterialPageRoute(
				builder: (_) => Home(),
				settings: settings
			);
	}
}
