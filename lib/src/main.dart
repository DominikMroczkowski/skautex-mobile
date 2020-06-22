import 'package:flutter/material.dart';

import 'blocs/login/bloc.dart' as login;
import 'blocs/session/bloc.dart' as session;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'router.dart';

class App extends StatelessWidget {

	Widget build(context) {
		return session.Provider(
			child: login.Provider (
				child: MaterialApp(
					title: 'Skautex',
					onGenerateRoute: Router.generateRoute,
					locale: Locale('pl', 'PL'),
		      localizationsDelegates: [
   		     GlobalMaterialLocalizations.delegate,
     		   GlobalWidgetsLocalizations.delegate
      		],
		      supportedLocales: [
   		     const Locale('pl', 'PL'),
      		],
				)
			)
		);
	}
}
