import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as home;
import './components/block/block.dart';
import './components/book/book.dart';

createCostTile(booking) {
	return CostTile(booking: booking);
}

class CostTile extends StatelessWidget {
	final Booking booking;

	CostTile({this.booking});

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
							if (snapshot.hasData) {
								return _buttons2(context, snapshot.data);
							}
							return Container(width: 0.0, height: 0.0);
						}
					);
				}
				return Container(width: 0.0, height: 0.0);
			},
		);
	}

	_buttons2(BuildContext context, Permissions perms) {
		var toXor = Permissions.toXOR();
		toXor.changePlayer = true;
		final bool canEditPlayer = perms.XOR(toXor);
		toXor = Permissions.toXOR();
		toXor.deletePlayer = true;
		final bool canDeactivatePlayer = perms.XOR(toXor);

		return Container(
			child: Row(
				children: <Widget>[
					canDeactivatePlayer ? Book(booking: booking) : Container(),
					Expanded( child: Container()),
					Container(padding: EdgeInsets.only(left: 10.0)),
					canEditPlayer ? Delete(booking: booking) : Container(),
				],
			),
			height: 50.0
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
