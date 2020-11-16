import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Bans extends StatelessWidget {
	final Booking booking;

	Bans({this.booking});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(booking: booking),
			booking: booking
		);
	}
}

