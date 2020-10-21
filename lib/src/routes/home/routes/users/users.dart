import 'package:flutter/material.dart';

import 'bloc/bloc.dart' as users;
import 'router.dart' as users;

class Users extends StatelessWidget {
	Widget build(context) {
		return users.Provider(
			context: context,
			child: Navigator(
				onGenerateRoute: users.Router.generateRoute,
				initialRoute: '/home/users'
			)
		);
	}
}


