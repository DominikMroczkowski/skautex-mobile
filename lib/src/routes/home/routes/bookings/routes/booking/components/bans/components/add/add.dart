import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Add extends StatelessWidget {
	final Booking booking;

	Add({this.booking});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			booking: booking
		);
	}
}

