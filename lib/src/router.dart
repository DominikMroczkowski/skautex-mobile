import 'package:flutter/material.dart';

import 'screens/login/auth_code.dart';
import 'screens/login/login.dart';
import 'screens/login/change_password.dart';

import 'screens/home/home.dart';
import 'screens/home/player.dart';

import 'blocs/auth_code/bloc.dart' as auth_code;
import 'blocs/players/bloc.dart' as player;
import 'blocs/user/bloc.dart' as user;

class Router {
	static RegExp home = new RegExp(r"^/home");

   	static Route<dynamic> generateRoute(RouteSettings settings) {
		if ('/' == settings.name)
    	return MaterialPageRoute(builder: (_) => Login(), 	settings: settings);
    	if ('/auth_code' == settings.name)
    		return MaterialPageRoute(builder: (_) => auth_code.Provider(child: AuthCode()), 	settings: settings);
		if ('/change_password' == settings.name)
    	return MaterialPageRoute(builder: (_) => ChangePassword(),
				settings: settings);
		if (0 < home.allMatches(settings.name).length)
        return MaterialPageRoute(
					builder: (context) {
						return user.Provider(child: _loggedInRoutes(settings.name), context: context);
					},
					settings: settings
				);
    return MaterialPageRoute(
    	builder: (_) => Scaffold(
     		body: Center(
     	 		child: Text('No route defined for ${settings.name}')),
     		),
				settings: settings
			);
  	}

	static Widget _loggedInRoutes(String route) {
		switch (route) {
		case '/home/player':
        		return player.Provider(child: Player());
		default:
			return Home();
		}
	}
}
