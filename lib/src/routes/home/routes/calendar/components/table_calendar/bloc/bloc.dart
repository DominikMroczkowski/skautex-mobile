import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'dart:async';
import 'package:skautex_mobile/src/routes/home/routes/calendar/bloc/bloc.dart' as calendar;
import 'package:table_calendar/table_calendar.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final CalendarController calendarController;
	final Function changeInterval;
	final Function changeChoosenDate;
	final _events = BehaviorSubject<Map<DateTime, List<Event>>>();
	Stream get events => _events.stream;

	final _toMap = StreamTransformer<List<Event>, Map<DateTime, List<Event>>>.fromHandlers(
		handleData: (i, sink) {
			var map = Map<DateTime, List<Event>>();
			i.forEach(
				(i) {
					final startDate = DateTime.tryParse(i.startDate);
					final date = DateTime(startDate.year, startDate.month, startDate.day);
					if (map[date] == null)
						map[date] = [];
					map[date].add(i);
				}
			);
			sink.add(map);
		}
	);

	Bloc(BuildContext context, {this.calendarController}):
		changeInterval = calendar.Provider.of(context).changeInterval,
		changeChoosenDate = calendar.Provider.of(context).changeChoosenDate {
		final now = DateTime.now();
		changeInterval(
			DateTime(now.year, now.month),
			DateTime(now.year, now.month+1, 0)
		);
		calendar.Provider.of(context).itemsWatcher.transform(_toMap).pipe(_events);
	}

	dispose() {
		_events.close();
	}
}
