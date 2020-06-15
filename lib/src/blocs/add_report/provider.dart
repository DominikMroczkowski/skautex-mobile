import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final addReport;

	Provider({Key key, Widget child, BuildContext context}) :
		addReport = Bloc(context),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).addReport;
	}
}
