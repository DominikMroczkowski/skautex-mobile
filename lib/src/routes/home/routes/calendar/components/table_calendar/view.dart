import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamBuilder(
			stream: bloc.events,
			builder: (_, snapshot) {
				return _tableCalendar(bloc, snapshot.data);
			}
		);
	}

	_tableCalendar(bloc, events) {
		return TableCalendar(
			calendarController: bloc.calendarController,
			locale: 'pl_PL',
			initialCalendarFormat: CalendarFormat.month,
			onVisibleDaysChanged: (DateTime start, DateTime end, _) {
				bloc.changeInterval(start, end);
			},
			events: events,
			onDaySelected: (DateTime choosen, _, __) {
				bloc.changeChoosenDate(choosen);
			},
		);
	}
}
