import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class TableCalendar extends StatelessWidget {
	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			calendarController: CalendarController(),
		);
	}
}
