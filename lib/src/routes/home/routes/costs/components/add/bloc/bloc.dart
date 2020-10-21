import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/cost.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';

class Bloc extends Add<Cost> {
	final _name = BehaviorSubject<String>();
	final _cost = BehaviorSubject<String>();
	final _date = BehaviorSubject<String>();
	final _file = BehaviorSubject<String>();

	Stream<String> get name => _name.stream;
	Stream<String> get cost => _cost.stream;
	Stream<String> get date => _date.stream;
	Stream<String> get file => _file.stream;

	Stream<bool> get submitValid  => Rx.combineLatest([name, cost, date], (_) { return true;});

	Function(String) get changeName => _name.sink.add;
	Function(String) get changeCost => _cost.sink.add;
	Function(String) get changeDate => _date.sink.add;
	Function(String) get changeFile => _file.sink.add;

	Bloc(BuildContext context) {
		otp = context;
	}

	add() {
		Cost cost = Cost(
			name: _name.value,
			cost: _cost.value,
			date: _date.value,
			file: _file.value,
		);
		addItem(cost);
	}

	dispose() {
		_name.close();
		_cost.close();
		_date.close();
		_file.close();
	}
}
