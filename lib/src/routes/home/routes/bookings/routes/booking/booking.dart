import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';
import 'package:skautex_mobile/src/models/booking.dart' as models;

class Booking extends StatelessWidget {
	final models.Booking booking;

	Booking({this.booking});

	Widget build(BuildContext context) {
		return Provider(
			child: View(booking: booking),
			context: context
		);
	}
}
