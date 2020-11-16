import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/models/booking_blacklist.dart';
import 'package:skautex_mobile/src/helpers/blocs/item.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class Bloc extends Item<Booking> {
	final _reloadBlockings = BehaviorSubject<bool>();
	Function get reloadBlockings => _reloadBlockings.sink.add;
	Stream get blockings => _reloadBlockings.stream;


	Bloc(BuildContext context) {
		otp = context;
	}

	dispose() {
		_reloadBlockings.close();
	}
}
