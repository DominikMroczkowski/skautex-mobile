import 'package:flutter/material.dart';

import 'screens/login/auth_code.dart';
import 'screens/login/login.dart';
import 'screens/login/change_password.dart';

import 'screens/home/home.dart';
import 'screens/home/players.dart';
import 'screens/home/player.dart';
import 'screens/home/add_player.dart';
import 'screens/home/edit_player.dart';
import 'screens/home/users.dart';
import 'screens/home/user.dart';
import 'screens/home/edit_user.dart';
import 'screens/home/add_user.dart';
import 'screens/home/reports.dart';
import 'screens/home/report.dart';
import 'screens/home/add_report.dart';
import 'screens/home/edit_report.dart';

import 'blocs/auth_code/bloc.dart' as auth_code;
import 'blocs/players/bloc.dart' as players;
import 'blocs/player/bloc.dart' as player;
import 'blocs/user/bloc.dart' as user;
import 'blocs/add_player/bloc.dart' as addPlayer;
import 'blocs/edit_player/bloc.dart' as editPlayer;
import 'blocs/info/bloc.dart' as info;
import 'blocs/users/bloc.dart' as users;
import 'blocs/edit_user/bloc.dart' as editUser;
import 'blocs/add_user/bloc.dart' as addUser;
import 'blocs/reports/bloc.dart' as reports;
import 'blocs/add_report/bloc.dart' as addReport;
import 'blocs/report/bloc.dart' as report;

class Router {
		static RegExp home = new RegExp(r"^/home");

   	static Route<dynamic> generateRoute(RouteSettings settings) {
		if ('/' == settings.name)
    	return MaterialPageRoute(
				builder: (_) => Login(),
				settings: settings
			);

    if ('/auth_code' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>
					auth_code.Provider(
					child: AuthCode()
				),
				settings: settings
			);

		if ('/change_password' == settings.name)
    	return MaterialPageRoute(builder: (_) => ChangePassword(),
				settings: settings);

		if (0 < home.allMatches(settings.name).length)
      return MaterialPageRoute(
				builder: (context) {
					return info.Provider(
						child: user.Provider(
							child: _loggedInRoutes(settings.name, context),
							context: context
						),
						context: context
					);
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

	static Widget _loggedInRoutes(String route, BuildContext context) {
		RegExp playerREGEX = new RegExp(r"^/home/player");
		RegExp userREGEX   = new RegExp(r"^/home/user");
		RegExp reportREGEX   = new RegExp(r"^/home/report");

		if (0 < playerREGEX.allMatches(route).length)
			return players.Provider(child: _playersRoutes(route, context), context: context);
		if (0 < userREGEX.allMatches(route).length)
			return _usersRoutes(route, context);
		if (0 < reportREGEX.allMatches(route).length)
			return _reportRoutes(route, context);
		return Home();
	}

	static Widget _playersRoutes(String route, BuildContext context) {
		switch (route) {
			case '/home/players':
	    	return Players();
			case '/home/player/addPlayer':
	    	return addPlayer.Provider(child: AddPlayer(), context: context);
			case '/home/player':
	    	return player.Provider(child: Player(), context: context);
			case '/home/player/editPlayer':
	    	return editPlayer.Provider(child: EditPlayer(), context: context);

			default:
				return Players();
		}
	}

	static Widget _usersRoutes(String route, BuildContext context) {
		switch (route) {
		case '/home/user/addUser':
			return addUser.Provider(child: AddUser(), context: context);
		case '/home/user/editUser':
			return editUser.Provider(child: EditUser(), context: context);
		case '/home/user':
			return user.Provider(child: User(), context: context);
		default:
			return users.Provider(child: Users(), context: context);
		}
	}

	static Widget _reportRoutes(String route, BuildContext context) {
		switch (route) {
		case '/home/report/addReport':
			return addReport.Provider(child: AddReport(), context: context);
		case '/home/report/editReport':
			return EditReport();
		case '/home/report':
			return report.Provider(child: Report(), context: context);
		default:
			return reports.Provider(child: Reports(), context: context);
		}
	}
}
