import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final players;

	Provider({Key key, Widget child, BuildContext context}):
		players = Bloc(context),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).players;
	}

}
