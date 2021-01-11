import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final securityCode;

	Provider({Key key, Widget child, @required BuildContext context }) :
		securityCode = Bloc(context),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).securityCode;
	}
}
