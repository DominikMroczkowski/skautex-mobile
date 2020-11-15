import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/routes/home/routes/bookings/bloc/bloc.dart' as booking;

class Bloc extends ItemList<Booking> {
	Bloc(BuildContext context) {
		otp = context;
		super.fetch();
		booking.Provider.of(context).items.listen((i) {
			super.fetch();
		});
	}
}
