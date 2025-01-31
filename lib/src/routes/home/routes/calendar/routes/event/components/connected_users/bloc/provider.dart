import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final event;

	Provider({Key key, Widget child, BuildContext context, GlobalKey<NavigatorState> navigator, Event event}) :
		event = Bloc(context, event: event),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).event;
	}
}
