import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/models/booking_blacklist.dart';
import 'package:skautex_mobile/src/routes/home/routes/bookings/routes/booking/bloc/bloc.dart' as bockingBloc;
import 'package:skautex_mobile/src/models/booking_blacklist.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Delete {
	final BookingBlacklist blacklist;
	Bloc(BuildContext context, {this.blacklist}) {
		otp = context;
		final bookingBloc = bockingBloc.Provider.of(context);
		item.listen(
			(Future i) {
				i.then((_) {bookingBloc.reloadBlockings(true);});
			}
		);
	}
}
