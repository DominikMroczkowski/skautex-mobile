import 'package:flutter/material.dart';

import 'users.dart';
import 'routes/add_user/add_user.dart';
import 'routes/edit_user/edit_user.dart';
import 'routes/user/user.dart';

const _route = '/home/users';

Map<String, MaterialPageRoute> routes(RouteSettings settings) {
	return {
		_route: MaterialPageRoute(
			builder: (_) =>  Users(),
			settings: settings
		),
		_route + '/user': MaterialPageRoute(
			builder: (_) =>  User(),
			settings: settings
		),
		_route + '/addUser': MaterialPageRoute(
			builder: (_) =>  AddUser(),
			settings: settings
		),
		_route + '/editUser': MaterialPageRoute(
			builder: (_) =>  EditUser(),
			settings: settings
		)
	};
}
