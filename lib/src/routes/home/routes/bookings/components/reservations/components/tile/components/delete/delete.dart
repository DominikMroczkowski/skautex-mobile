import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking_reservation.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Delete extends StatelessWidget {
	final BookingReservation reservation;

	Delete({this.reservation});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(reservation: reservation),
		);
	}
}
