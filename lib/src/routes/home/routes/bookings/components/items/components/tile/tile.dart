import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/helpers/widgets/header.dart';
import './components/book/book.dart';
import './components/delete/delete.dart';

class ItemTile extends StatelessWidget {
	final Booking booking;

	ItemTile({this.booking});

	Widget build(context) {
		return Container(
			child: buildTile(context, booking),
			margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
		);
	}

	Widget buildTile(BuildContext context, Booking cost) {
		return Card(
			child: InkWell(
				child: ListTile(
					title: Header(text: booking.name),
					dense: true,
					trailing: PopupMenuButton(
						itemBuilder: (BuildContext context) => <PopupMenuEntry>[
							PopupMenuItem(
								child: Delete(booking: booking),
								enabled: false
							),
							PopupMenuItem(
								child: Book(booking: booking),
								enabled: false
							),
						],
					),
				),
				onTap: () {
					//bookings.Provider.of(context).navigator.currentState.pushNamed(
					Navigator.of(context).pushNamed(
						'/home/bookings/booking',
						arguments: booking);
				},
			),
		);
	}
}

class Text2 extends StatelessWidget {
	final String text;

	Text2({this.text});

	Widget build(BuildContext context) {
		return Align(
			child: Text(
				text,
				style: TextStyle(
					fontSize: 12,
				)
			),
			alignment: Alignment.topLeft,
		);
	}
}
