import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final users;

	Provider({Key key, Widget child, BuildContext context}) :
		users = Bloc(context),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).users;
	}
}
