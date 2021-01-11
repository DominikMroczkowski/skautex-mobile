import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final delete;

	Provider({Key key, Widget child, BuildContext context, Event event}) :
		delete = Bloc(context, event: event),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).delete;
	}
}
