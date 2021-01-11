import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';
import 'bloc/bloc.dart';

class Delete extends StatelessWidget {
	final Booking booking;
	final Function update;

	Delete({@required this.booking, @required this.update});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: _View(booking: booking));
	}
}

class _View extends StatelessWidget {
	final Booking booking;

	_View({@required this.booking});

	Widget build(BuildContext context) {
		final Stream stream = Provider.of(context).item;
		final Function deactivate = Provider.of(context).addItem;

		return FlatButton(
			textColor: Colors.black,
			child: Text('Usuń'),
			onPressed: () {
				showDialog(
					context: context,
					child: DeleteDialog(
						ask: 'Czy napewno chcesz usunąć zasób?',
						title: 'Usuwanie',
						whileWorking: 'Usuwanie',
						stream: stream,
						onTrue: deactivate,
						uri: booking.uri
					)
				);
			}
		);
	}
}
