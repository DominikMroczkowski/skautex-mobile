import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final addCalendar;

	Provider({Key key, Widget child, BuildContext context}) :
		addCalendar = Bloc(context: context),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).addCalendar;
	}
}
