import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';
import 'bloc/bloc.dart';

class Delete extends StatelessWidget {
	final Booking booking;

	Delete({@required this.booking});

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
			textColor: Colors.red,
			child: Text('Blokuj'),
			onPressed: () {
				showDialog(
					context: context,
					child: DeleteDialog(
						stream: stream,
						onTrue: deactivate,
						uri: booking.uri
					)
				);
			}
		);
	}
}
