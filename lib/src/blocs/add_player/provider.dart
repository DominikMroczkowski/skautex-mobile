import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	var addPlayer;

	Provider({Key key, Widget child, BuildContext context})
		: addPlayer = Bloc(context),
		  super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).addPlayer;
	}

}
