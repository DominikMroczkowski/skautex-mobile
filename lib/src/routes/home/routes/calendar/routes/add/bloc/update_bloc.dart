import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:skautex_mobile/src/models/event.dart';
import 'package:skautex_mobile/src/models/event_type.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/helpers/blocs/update.dart';

import 'provider.dart';
export 'provider.dart';

import 'types.dart';
import 'users.dart';
import 'connected_user.dart';
import 'validator.dart';

import 'package:skautex_mobile/src/routes/home/routes/calendar/bloc/bloc.dart' as calendar;
import 'package:skautex_mobile/src/routes/home/routes/calendar/routes/event/bloc/bloc.dart' as event;

class UpdateBloc extends Update<Event> with Validate {
	final String uri;
	final _name = BehaviorSubject<String>();
	final event.Bloc eventBloc;
	Stream get name => _name.stream;
	Function(String) get changeName => _name.sink.add;

	final _type = BehaviorSubject<EventType>();
	Stream get type => _type.stream;
	Function(EventType) get changeType => _type.sink.add;

	final _start = BehaviorSubject<DateTime>();
	Stream<DateTime> get start => Rx.combineLatest<DateTime, List<DateTime>>([_start.stream, _end.stream], (i) => [i[0], i[1]]).transform(startIsBefore);
	Function(DateTime) get changeStart => _start.sink.add;

	final _end = BehaviorSubject<DateTime>();
	Stream<DateTime> get end => Rx.combineLatest<DateTime, List<DateTime>>([_start.stream, _end.stream], (i) => [i[0], i[1]]).transform(endIsAfter);
	Function(DateTime) get changeEnd => _end.sink.add;

	final _color = BehaviorSubject<String>();
	Stream get color => _color.stream;
	Function(String) get changeColor => _color.sink.add;

	final _invited = BehaviorSubject<List<User>>();
	Stream get invited => _invited.stream;
	Function(List<User>) get changeInvited => _invited.sink.add;

	final _invitedReady = BehaviorSubject<List<Users>>();
	get invitedReady => Rx.combineLatest<Object, List<User>>([_connectedUsers.itemsWatcher, users], (i) => i[1]);

	final _types;
	final _users;
	final _connectedUsers;

	Stream<List<EventType>> get types => _types.itemsWatcher;
	Stream<List<User>> get users => _users.itemsWatcher;

	send() {
		updateItem(
			Event(
				uri: uri,
				name: _name.value,
				type: _type.value,
				startDate: _start.value.toString(),
				endDate: _end.value.toString(),
				color: _color.value,
				hide: false,
				connectedUsers: _invited.value
			)
		);
	}

	get submitValid => Rx.combineLatest(
		[name, type, start, end, color],
		(list) => true
	);

	UpdateBloc({context, Event event, this.eventBloc}):
		uri = event.uri,
		_types = Types(context: context),
		_users = Users(context: context),
		_connectedUsers = ConnectedUsers(context: context, uri: event.uri) {
		otp = context;
		changeName(event.name);
		changeType(event.type);
		changeStart(DateTime.parse(event.startDate));
		changeEnd(DateTime.parse(event.endDate));
		changeColor(event.color);
		changeInvited(event.connectedUsers);
		_connectedUsers.itemsWatcher.listen(
			(List<User> i) {
				changeInvited(i);
			}
		);
		item.listen((i) {
			i.then((i) {
					calendar.Provider.of(context).reloadEvents();
					eventBloc.changeEvent(i);
			});
		});
	}

	dispose() {
		_name.close();
		_type.close();
		_start.close();
		_end.close();
		_color.close();
		_invited.close();
		_invitedReady.close();
		super.dispose();
	}
}
