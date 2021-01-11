import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final delete;

	Provider({Key key, Widget child, BuildContext context, Function reloadTemplates}) :
		delete = Bloc(context, reloadTemplates: reloadTemplates),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).delete;
	}
}
