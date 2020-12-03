import 'package:flutter/material.dart';
import 'bloc.dart';
import 'update_bloc.dart';

class Provider extends InheritedWidget {
	final addCalendar;

	Provider({Key key, Widget child, BuildContext context, event}) :
		addCalendar = event != null? UpdateBloc(context: context, event: event) : Bloc(context: context),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).addCalendar;
	}
}
