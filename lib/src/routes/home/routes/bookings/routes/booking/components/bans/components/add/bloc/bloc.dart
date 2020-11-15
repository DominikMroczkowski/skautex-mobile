import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';
import 'package:skautex_mobile/src/models/booking_blacklist.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/routes/home/routes/bookings/routes/booking/bloc/bloc.dart' as bockingBloc;

import 'provider.dart';
export 'provider.dart';

class Bloc extends Add<BookingBlacklist> {
	final Booking _booking;
	final _user = BehaviorSubject<User>();

	Function(User) get changeUser => _user.sink.add;

	Stream<bool> get submitValid  => Rx.combineLatest([_user.stream], (List<Object> _) { return true;});

	block() {
		final blacklist = BookingBlacklist(
			user: _user.value,
			booking: _booking
		);

		addItem(blacklist);
	}

	Bloc(BuildContext context, {Booking booking}):
		this._booking = booking {
		otp = context;

		final bookingBloc = bockingBloc.Provider.of(context);

		item.listen(
			(Future<BookingBlacklist> i) {
				i.then((_) {bookingBloc.reloadBlockings(true);});
			}
		);
	}

	dispose() {
		_user.close();
	}
}
