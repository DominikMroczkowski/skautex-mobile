import 'package:flutter/material.dart';
import 'bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class Provider extends InheritedWidget {
	final tableCalendar;

	Provider({Key key, Widget child, BuildContext context, calendarController}) :
		tableCalendar = Bloc(context, calendarController: calendarController),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).tableCalendar;
	}
}
