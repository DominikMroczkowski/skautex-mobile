import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/helpers/blocs/add.dart';
import 'package:skautex_mobile/src/models/booking_reservation.dart';
import 'package:skautex_mobile/src/models/booking.dart';

class Bloc extends Add<BookingReservation> {
	final String objectUri;

	final _startDate = BehaviorSubject<String>();
	final _endDate   = BehaviorSubject<String>();

	Stream<String> get startDate => _startDate.stream;
	Stream<String> get endDate   => _endDate.stream;
	Stream<bool> get submitValid  => Rx.combineLatest([startDate, endDate], (_) { return true;});

	Function(String) get changeStartDate => _startDate.sink.add;
	Function(String) get changeEndDate   => _endDate.sink.add;

	Bloc(BuildContext context, Booking booking) :
		objectUri = booking.uri {
		otp = context;
	}

	add() {
		final res = BookingReservation(
			startDate: _startDate.value,
			endDate: _endDate.value,
			objectUri: objectUri
		);
		addItem(res);
	}

	dispose() {
		_endDate.close();
		_startDate.close();
	}
}
