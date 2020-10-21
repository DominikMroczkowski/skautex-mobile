import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/booking_reservation.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class Bloc extends ItemList<BookingReservation> {
	Bloc(BuildContext context) {
		otp = context;
	}
}
