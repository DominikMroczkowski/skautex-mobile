import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'bloc/bloc.dart';
import 'package:skautex_mobile/src/routes/home/routes/calendar/bloc/bloc.dart' as calendar;

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);
		final calendarBloc = calendar.Provider.of(context);

		return TableCalendar(
			calendarController: bloc.calendarController,
			locale: 'pl_PL',
			events: null,
			initialCalendarFormat: CalendarFormat.month,
			onVisibleDaysChanged: (DateTime start, DateTime end, _) {
				calendarBloc.changeInterval(start, end);
			},
			onDaySelected: (DateTime choosen, _) {
				calendarBloc.changeChoosenDate(choosen);
			},
		);
	}
}
