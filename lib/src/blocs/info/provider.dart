import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	var info;

	Provider({Key key, Widget child, BuildContext context})
		: info = Bloc(context),
		  super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).info;
	}

}
