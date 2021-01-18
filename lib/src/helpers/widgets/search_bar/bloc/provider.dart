import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final searchBar;

	Provider({Key key, Widget child, Function change, String defaultTitle}):
		searchBar = Bloc(change: change, defaultTitle: defaultTitle),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).searchBar;
	}
}
