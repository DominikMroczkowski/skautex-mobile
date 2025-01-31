import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final _added = BehaviorSubject<bool>();

	final _reloadItems = BehaviorSubject<bool>();
	reloadItems() {_reloadItems.sink.add(true);}
	Stream get items => _reloadItems.stream;

	final _reloadReservations = BehaviorSubject<bool>();
	Function get reloadReservations => _reloadReservations.sink.add;
	Stream get reservations => _reloadReservations.stream;

	Bloc();

	dispose() {
		_added.close();
		_reloadItems.close();
		_reloadReservations.close();
	}
}
