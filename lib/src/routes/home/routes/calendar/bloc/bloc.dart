import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/event.dart';

class Bloc extends ItemList<Event> {
	final GlobalKey<NavigatorState> navigator;
	final _startDate = BehaviorSubject<DateTime>();
	final _endDate = BehaviorSubject<DateTime>();
	final _choosenDate = BehaviorSubject<DateTime>();

	get _changeStartDate => _startDate.sink.add;
	get _changeEndDate => _endDate.sink.add;
	get changeChoosenDate => _choosenDate.sink.add;

	final _reloadEvents = BehaviorSubject<bool>();
	reloadEvents() {
		_reloadEvents.sink.add(true);
	}

	Stream get choosenDate => _choosenDate.stream;

	changeInterval(DateTime start, DateTime end) {
		_changeStartDate(start);
		_changeEndDate(end);
		_refetch();
	}

	_refetch() {
		fetch(where: {
			'start_date': _startDate.value.toString(),
			'end_date': _endDate.value.toString(),
		});
	}

	Bloc(BuildContext context, {this.navigator}) {
		otp = context;
		_reloadEvents.listen(
			(i) {
				_refetch();
			}
		);
	}

	dispose() {
		_startDate.close();
		_endDate.close();
	}
}
