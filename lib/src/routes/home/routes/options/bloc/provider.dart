import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final options;

	Provider({Key key, Widget child, BuildContext context}) :
		options = Bloc(),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).options;
	}
}
