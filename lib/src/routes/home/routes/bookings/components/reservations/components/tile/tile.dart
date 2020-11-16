import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking_reservation.dart';
import 'components/delete/delete.dart';

class Tile extends StatelessWidget {
	final BookingReservation reservation;

	Tile({this.reservation});

	Widget build(BuildContext context) {
		return Container(child: buildTile(context),
			margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0)
		);
	}

	Widget buildTile(BuildContext context) {
		return  Card(
				child:  ListTile(
					title: Text(reservation.objectName),
					subtitle: Text('Od: ' + reservation.startDate + ' \nDo: ' + reservation.endDate),
					isThreeLine: true,
					dense: true,
					trailing: Delete(reservation: reservation),
				),
				margin: EdgeInsets.zero,
		);
	}
}
