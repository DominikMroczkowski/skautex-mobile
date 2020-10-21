import 'package:flutter/material.dart';

import 'login.dart';
import 'routes/auth_code/auth_code.dart';
import 'routes/auth_code/bloc/bloc.dart' as auth_code;

const _route = '/login';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
		if (_route == settings.name)
    	return MaterialPageRoute(
				builder: (_) => View(),
				settings: settings
			);
		else if (_route + '/auth_code' == settings.name)
			return MaterialPageRoute(
				builder: (_) => auth_code.Provider(child: AuthCode()),
				settings: settings
			);
	}
}
