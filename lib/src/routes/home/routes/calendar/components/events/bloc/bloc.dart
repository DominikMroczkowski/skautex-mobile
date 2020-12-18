import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'dart:async';
import 'package:skautex_mobile/src/routes/home/routes/calendar/bloc/bloc.dart' as calendar;
import 'package:scroll_to_index/scroll_to_index.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final AutoScrollController controller;
	final _event = BehaviorSubject<Event>();
	get event => _event.stream;
	get changeEvent => _event.sink.add;

	Bloc({this.controller, context}) {
		final calendarBloc = calendar.Provider.of(context);
		calendarBloc.choosenDate.listen(
			(choosen) {
				calendarBloc.watcher.listen(
					(future) {
						future.then(
							(List<Event> events) {
								controller.scrollToIndex(_getIndex(events, choosen));
							}
						);
					}
				);
			}
		);
	}

	int _getIndex(List<Event> events, DateTime choosen) {
		for (int i = 0; i < events.length; i++) {
			final j = DateTime.tryParse(events[i].startDate);
			if (choosen.isAtSameMomentAs(j) || choosen.isBefore(j))
				return i;

			i++;
		}
		return 0;
	}

	dispose() {
		_event.close();
	}
}
