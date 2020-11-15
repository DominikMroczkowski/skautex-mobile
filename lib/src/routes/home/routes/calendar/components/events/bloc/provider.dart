import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final events;

	Provider({Key key, Widget child, BuildContext context, controller}) :
		events = Bloc(controller: controller, context: context),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).events;
	}
}
