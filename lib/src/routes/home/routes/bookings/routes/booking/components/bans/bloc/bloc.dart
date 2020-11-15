import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/booking_blacklist.dart';
import 'package:skautex_mobile/src/routes/home/routes/bookings/routes/booking/bloc/bloc.dart' as bockingBloc;

class Bloc extends ItemList<BookingBlacklist>{
	final Booking booking;

	_fetch() {
		super.fetch(where: {'limit': 'none', 'booking_object': booking.uri.split('/').last});
	}

	Bloc(BuildContext context, {this.booking}) {
		otp = context;
		_fetch();
		bockingBloc.Provider.of(context).blockings.listen((i) {
			_fetch();
		});

	}
}
