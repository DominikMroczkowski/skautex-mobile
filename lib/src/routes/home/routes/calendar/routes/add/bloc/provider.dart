import 'package:flutter/material.dart';
import 'bloc.dart';
import 'update_bloc.dart';
import 'package:skautex_mobile/src/routes/home/routes/calendar/routes/event/bloc/bloc.dart' as event;

class Provider extends InheritedWidget {
	final addCalendar;

	Provider({Key key, Widget child, BuildContext context, event, event.Bloc bloc}) :
		addCalendar = event != null? UpdateBloc(context: context, event: event, eventBloc: bloc) : Bloc(context: context),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).addCalendar;
	}
}
