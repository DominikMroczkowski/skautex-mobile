import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as home;

createTile(booking) {
	return Tile(booking: booking);
}

class Tile extends StatelessWidget {
	final Booking booking;

	Tile({this.booking});

	Widget build(context) {
		return Container(
			child: buildTile(context, booking),
			padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
		);
	}

	Widget buildTile(BuildContext context, Booking cost) {
		final leadingRow = Row(children: [
				Header(text: cost.name),
				Expanded(child: Container()),
				Header(text: cost.name)
		]);
		final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
		return Theme(data: theme, child: Card(
			child: Container(

				child:  ExpansionTile(
					title: leadingRow,
					children: [
						Text2(text: 'Data: ' + cost.name),
						_buttons(context)
					],
				),
				padding: EdgeInsets.all(5.0)
			)
		));
	}

	_buttons(BuildContext context) {
		final bloc = home.Provider.of(context);
		return StreamBuilder(
			stream: bloc.permissions,
			builder: (BuildContext context, AsyncSnapshot<Future<Permissions>> snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, snapshot) {
							return Container(width: 0.0, height: 0.0);
						}
					);
				}
				return Container(width: 0.0, height: 0.0);
			},
		);
	}

}

class Header extends StatelessWidget {
	final String text;

	Header({this.text});

	Widget build(BuildContext context) {
		return Align(
			child: Text(
				text,
				style: TextStyle(
					fontSize: 18,
				)
			),
			alignment: Alignment.topLeft,
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
