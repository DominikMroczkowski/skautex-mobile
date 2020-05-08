import 'package:flutter/material.dart';

import 'screens/login/auth_code.dart';
import 'screens/login/login.dart';
import 'screens/login/change_password.dart';

import 'screens/home/home.dart';
import 'screens/home/player.dart';

import 'blocs/auth_code/bloc.dart' as auth_code;

class Router {
   	static Route<dynamic> generateRoute(RouteSettings settings) {
  		switch (settings.name) {
      		case '/':
        		return MaterialPageRoute(builder: (_) => Login());
      		case '/auth_code':
        		return MaterialPageRoute(builder: (_) => auth_code.Provider(child: AuthCode()));
		case '/change_password':
        		return MaterialPageRoute(builder: (_) => ChangePassword());
		case '/home':
        		return MaterialPageRoute(builder: (_) => Home());
		case '/player':
        		return MaterialPageRoute(builder: (_) => Player());
      		default:
        		return MaterialPageRoute(
        			builder: (_) => Scaffold(
          				body: Center(
              				child: Text('No route defined for ${settings.name}')),
        			)
			);
    		}
  	}
}
