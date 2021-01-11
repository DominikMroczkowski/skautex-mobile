import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';

import 'bloc/bloc.dart';
import 'components/date_form/date_form.dart';

class Book extends StatelessWidget {
	final Booking booking;

	Book({@required this.booking});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: _View(booking: booking),
			booking: booking
		);
	}
}

class _View extends StatelessWidget {
	final booking;

	_View({this.booking});

	Widget build(BuildContext context) {
		Bloc bloc = Provider.of(context);

		return FlatButton(
			textColor: Colors.black,
			child: Text('Rezerwuj'),
			onPressed: () {
				showDialog(
					context: context,
					child: _alert(bloc)
				);
			}
		);
	}

	Widget _alert(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.item,
			builder: (context, snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, snapshot) {
							if (snapshot.hasError)
								return AlertDialog(
									title: Text("Niepowodzenie"),
									content: Text(snapshot.error.toString()),
									actions: [
										FlatButton(
											child: Text('Ok'),
											onPressed:() {
												Navigator.of(context).pop();
											}
										)
									]
								);
							if (snapshot.hasData)
								return AlertDialog(
									title: Text("Zarezerwowano"),
									actions: [
										FlatButton(
											child: Text('Ok'),
											onPressed:() {
												Navigator.of(context).pop();
											}
										)
									]
								);
							return AlertDialog(
								title: Text("Rezerwuję"),
								content: CircularIndicator.horizontal(Colors.blue)
							);
						}
					);
				return AlertDialog(
					title: Text("Rezerwuj"),
					content: DateForm(booking: booking, bloc: bloc),
					actions: [
						StreamBuilder(
							stream: bloc.submitValid,
							builder: (context, snapshot) {
								if (snapshot.hasData)
									return FlatButton(
										child: Text('Rezerwuj'),
										onPressed: () {
											bloc.add();
										}
									);
								return FlatButton(
									child: Text('Rezerwuj'),
									onPressed: null
								);
							}
						),
						FlatButton(
							child: Text('Anuluj'),
							onPressed:() {
								Navigator.of(context).pop();
							}
						)
					]
				);
			},
		);
	}
}
