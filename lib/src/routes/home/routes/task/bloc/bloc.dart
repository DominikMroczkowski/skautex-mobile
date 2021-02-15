import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/event.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class Bloc extends ItemList<Event> {
	final _reloadEvents = BehaviorSubject<bool>();
	reloadReports() {  _reloadEvents.sink.add(true); }

	_fetch() {
		fetch(
			where: {
				'has_connected_user': false.toString(),
			}
		);
	}

	Bloc(BuildContext context) : super(paging: 5) {
		otp = context;
		_reloadEvents.listen(
			(_) => _fetch()
		);
		_fetch();
	}

	dispose() {
		_reloadEvents.close();
		super.dispose();
	}
}
