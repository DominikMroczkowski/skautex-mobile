import 'package:flutter/material.dart';

import 'bloc/bloc.dart' as session;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'router.dart' as main;

class App extends StatelessWidget {

	Widget build(context) {
		return session.Provider(
			child: MaterialApp(
				title: 'Skautex',
				onGenerateRoute: main.Router.generateRoute,
				locale: Locale('pl', 'PL'),
		     localizationsDelegates: [
   		   	GlobalMaterialLocalizations.delegate,
     	  	GlobalWidgetsLocalizations.delegate
      	 ],
		    supportedLocales: [
   		    const Locale('pl', 'PL'),
      	],
				theme: ThemeData(
    			brightness: Brightness.light,
					primaryColor: Colors.indigo[900],
					backgroundColor: Colors.white
				)
			),
			context: context
		);
	}
}
