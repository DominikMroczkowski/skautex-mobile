import 'package:flutter/material.dart';

import 'login.dart';
import 'routes/auth_code/auth_code.dart';
import 'routes/auth_code/bloc/bloc.dart' as auth_code;

const _route = '/login';

Map<String, MaterialPageRoute> routes(RouteSettings settings){
	return {
		_route: MaterialPageRoute(
			builder: (_) => Login(),
			settings: settings
		),
		_route + '/auth_code': MaterialPageRoute(
			builder: (_) => auth_code.Provider(child: AuthCode()),
			settings: settings
		)
	};
}
