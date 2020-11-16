import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';
import 'package:skautex_mobile/src/models/booking_reservation.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {
	final BookingReservation reservation;

	View({this.reservation});

	Widget build(context) {
		final bloc = Provider.of(context);

		return FlatButton(
			child: Icon(Icons.delete),
			onPressed: () {
				showDialog(
					context: context,
					builder: (context) {
						return DeleteDialog(
							stream: bloc.item,
							uri: reservation.uri,
							onTrue: bloc.addItem,
							title: 'Usuń',
							ask: 'Czy napewno chcesz usunąć rezerwację',
							whileWorking: 'Usuwanie',
						);
					}
				);
			},
			shape: CircleBorder(),
			minWidth: 10.0
 		);
	}

}
