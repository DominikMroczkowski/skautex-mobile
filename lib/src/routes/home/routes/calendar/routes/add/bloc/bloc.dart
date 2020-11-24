import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:skautex_mobile/src/models/event.dart';
import 'package:skautex_mobile/src/models/event_type.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';
import 'package:skautex_mobile/src/models/user.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Add<Event> {
	final name = StreamWrapper<String>();
	final type = StreamWrapper<EventType>();
	final start = StreamWrapper<DateTime>();
	final end = StreamWrapper<DateTime>();
	final color = StreamWrapper<String>();
	final invited = StreamWrapper<List<User>>();
	final _click = BehaviorSubject<Object>();

	addClick() {
		_click.sink.add(Object());
	}

	Stream<Event> get event => Rx.combineLatest(
		[name.stream, type.stream, start.stream, end.stream, color.stream, invited.stream],
		(list) {
			if (list.contains(null))
				return null;
			return Event(
				name: list[0],
				type: list[1],
				startDate: list[2],
				endDate: list[3],
				color: list[4],
			);
		}
	);

	Stream<bool> get submitValid => event.transform(StreamTransformer<Event, bool>.fromHandlers(
	 handleData: (i, sink) {
		if (i == null)
			sink.add(false);
		else
			sink.add(true);
	}));


	Bloc({context}) {
		otp = context;
		_click.stream.listen(
			(_) {
				event.last.then(
					(i) {
						if (event.last == null)
							return;
						else
							addItem(i);
					}
				);
			}
		);
	}
}

class StreamWrapper<T> {
	final _stream = BehaviorSubject<T>();
	Stream get stream => _stream.stream;
	Function(T) get change => _stream.sink.add;
}
