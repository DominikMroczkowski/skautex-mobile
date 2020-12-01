import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final dateField;

	Provider({Key key, Widget child, Function change, Stream stream}) :
		dateField = Bloc(change: change, stream: stream),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).dateField;
	}
}
