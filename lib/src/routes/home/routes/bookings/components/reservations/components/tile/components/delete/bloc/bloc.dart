import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/routes/home/routes/bookings/bloc/bloc.dart' as bookings;

class Bloc extends Delete {

	Bloc(BuildContext context) {
		otp = context;

		final bookingBloc = bookings.Provider.of(context);

		item.listen(
			(Future i) {
				i.then((_) {bookingBloc.reloadReservations(true);});
			}
		);
	}
}
