import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class DateForm extends StatelessWidget{
	final Booking booking;
	final bloc;

	DateForm({@required this.booking, @required this.bloc});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(
				booking: booking,
				bloc: bloc
			),
			booking: booking
		);
	}

}
