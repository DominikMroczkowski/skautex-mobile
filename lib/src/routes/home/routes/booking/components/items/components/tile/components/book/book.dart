import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';

import 'bloc/bloc.dart';

class Book extends StatelessWidget {
	final Booking booking;

	Book({@required this.booking});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: _View(),
			booking: booking
		);
	}
}

class _View extends StatelessWidget {

	Widget build(BuildContext context) {
		Bloc bloc = Provider.of(context);

		return RaisedButton(
			textColor: Colors.blue,
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
					content: _form(bloc),
					actions: [
						FlatButton(
							child: Text('Rezerwuj'),
							onPressed: !(snapshot.data == true) ?  () {
								bloc.add();
							} : null
						),
						FlatButton(child: Text('Anuluj'), onPressed:() {Navigator.of(context).pop();})
					]
				);
			},
		);
	}

	Widget _form(Bloc bloc) {
		return SingleChildScrollView(
			child: Column(
				children: <Widget>[
					_startDate(bloc),
					_endDate(bloc),
				],
			)
		);
	}


	Widget _startDate(Bloc bloc) {
		return DateField(change: bloc.changeStartDate, name: 'Początek');
	}

	Widget _endDate(Bloc bloc) {
		return DateField(change: bloc.changeEndDate, name: 'Koniec');
	}
}

class DateField extends StatelessWidget{
	final Function change;
	final String name;

	DateField({this.change, String name}):
		name = name ?? 'Data';

	build(BuildContext context) {
		return _date(context);
	}

	Widget _date(BuildContext context) {
		return GestureDetector(
		  onTap: () {
				showDatePicker(
					context: context,
					firstDate: DateTime.utc(1970, 1, 1),
					lastDate: DateTime.now(),
					initialDate: DateTime.now()
				);
			},
  		child: AbsorbPointer(
    		child: _dateField(context)
  		)
		);
	}

	Widget _dateField(context) {
		var controller = TextEditingController(text: DateTime.now().toString());
		return TextField(
			controller: controller,
			onChanged: change,
			decoration: InputDecoration(
				labelText: 'Data',
			),
		);
	}
}
