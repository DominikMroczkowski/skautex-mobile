import 'package:flutter/material.dart';

import 'view.dart';
import 'routes/add_user/add_user.dart';
import 'routes/edit_user/edit_user.dart';
import 'routes/user/user.dart';

const _route = '/home/users';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
		if (_route == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  View(),
				settings: settings
			);
		else if (_route + '/user' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  User(),
				settings: settings
			);
		else if (_route + '/add_user' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  AddUser(),
				settings: settings
			);
		else if (_route + '/edit_user' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  EditUser(),
				settings: settings
			);
	}
}
