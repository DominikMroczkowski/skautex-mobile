import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/booking_reservation.dart';
import 'package:skautex_mobile/src/models/booking.dart';

class Bloc extends ItemList<BookingReservation> {
	final String objectUri;
	final _reservationsDates = BehaviorSubject<List<DateTime>>();

	get reservationsDates => _reservationsDates.stream;

	Bloc(BuildContext context, Booking booking) :
		objectUri = booking.uri {
		otp = context;
		super.fetch(where: {
			'booking_object': objectUri.split('/').last,
			'start_date': DateTime.now().toString()
		});

		itemsWatcher.listen(
			(i) {
				List<DateTime> dates = [];
				i.forEach(
					(i) {
						var start = DateTime.parse(i.startDate);
						final end = DateTime.parse(i.endDate);
						while(!start.isAfter(end)) {
							dates.add(start);
							start = start.add(new Duration(days: 1));
						}
					}
				);
				_reservationsDates.sink.add(dates);
			}
		);
	}

	@override
	dispose() {
		_reservationsDates.close();
		super.dispose();
	}
}
