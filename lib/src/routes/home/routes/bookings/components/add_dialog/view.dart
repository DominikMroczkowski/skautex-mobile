import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'package:skautex_mobile/src/helpers/others/booking_types.dart';
import 'package:skautex_mobile/src/models/booking_type.dart';

import 'bloc/bloc.dart';

class AddView extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);
		return AlertDialog(
			title: Text("Dodaj przedmiot"),
			content: _content(bloc),
			actions: _actions(bloc)
		);
	}

	List<Widget> _actions(bloc) {
		return [
			Cancel(),
			_add(bloc)
		];
	}

	_add(bloc) {
		return StreamBuilder(
			stream: bloc.submitValid,
			builder: (context, snapshot) {
				bool submitValid = false;
				if (snapshot.hasData)
					submitValid = snapshot.data;
				return FlatButton(
					child: Text('Dodaj'),
					onPressed: submitValid ? bloc.add : null
				);
			},
		);
	}

	Widget _content(bloc) {
		return SingleChildScrollView(
			child: Column(
				children: <Widget>[
					_name(bloc),
					_type(bloc),
				],
			)
		);
	}

	Widget _name(bloc) {
		return StreamBuilder(
			stream: bloc.name,
			builder: (context, snapshot) {
				return TextFormField(
					onChanged: bloc.changeName,
					decoration: InputDecoration(
						labelText: 'Nazwa'
					)
				);
			}
		);
	}

	Widget _type(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.types.itemsWatcher,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return CircularIndicator();

				if (snapshot.hasError)
					return Text('Error');

				List<DropdownMenuItem<BookingType>> items = [];
				snapshot.data.forEach((i) {
					items.add(DropdownMenuItem(
						child: Text(getBookingTypeName(i.name)),
						value: i
					));
				});
				return _dropDown(bloc, items);
			}
		);
	}

	Widget _dropDown(Bloc bloc, items) {
		return StreamBuilder(
			stream: bloc.type,
			builder: (context, AsyncSnapshot<BookingType> snapshot) {
				return DropdownButtonFormField<BookingType>(
					items: items,
					onChanged: bloc.changeType,
					value: snapshot.data
				);
			}
		);
	}
}


class Cancel extends StatelessWidget {
	build(BuildContext context) {
		return FlatButton(
			onPressed: () {
				Navigator.of(context).pop();
			},
			child: Text('Anuluj')
		);
	}
}


class View extends StatelessWidget {

	Widget build(BuildContext context) {
		Bloc bloc = Provider.of(context);

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
									title: Text("Dodano"),
									actions: [
										FlatButton(
											child: Text('Ok'),
											onPressed: Navigator.of(context).pop
										)
									]
								);
							return AlertDialog(
								title: Text("Rezerwuję"),
								content: CircularIndicator.horizontal(Colors.blue)
							);
						}
					);
				return AddView();
			},
		);
	}
}
