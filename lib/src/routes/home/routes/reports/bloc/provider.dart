import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final reports;

	Provider({Key key, Widget child, BuildContext context, GlobalKey<NavigatorState> navigator}) :
		reports = Bloc(context, navigator: navigator),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).reports;
	}
}
