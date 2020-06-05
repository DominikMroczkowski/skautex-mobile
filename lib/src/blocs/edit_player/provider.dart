import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	var editPlayer;

	Provider({Key key, Widget child, BuildContext context})
		: editPlayer = Bloc(context),
		  super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).editPlayer;
	}

}
