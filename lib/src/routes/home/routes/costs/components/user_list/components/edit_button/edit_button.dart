import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/cost.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';

import 'bloc/bloc.dart';

class EditButton extends StatelessWidget {
	final Cost cost;

	EditButton({@required this.cost});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: _View(),
			cost: cost
		);
	}
}

class _View extends StatelessWidget {

	Widget build(BuildContext context) {
		Bloc bloc = Provider.of(context);

		return RaisedButton(
			textColor: Colors.blue,
			child: Text('Edytuj'),
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
									title: Text("Edytowano"),
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
								title: Text("Edytuję"),
								content: CircularIndicator.horizontal(Colors.blue)
							);
						}
					);
				return AlertDialog(
					title: Text("Edytuj"),
					content: _form(bloc),
					actions: [
						FlatButton(
							child: Text('Edytuj'),
							onPressed: !(snapshot.data == true) ?  () {
								bloc.update();
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
					_name(bloc),
					_cost(bloc),
					_date(bloc)
				],
			)
		);
	}

	Widget _name(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.name,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return CircularIndicator.color(Colors.blue);
				return _nameWidget(bloc, snapshot.data);
			},
		);
	}

	Widget _nameWidget(Bloc bloc, String text) {
		return TextFormField(
			initialValue: text,
			decoration: InputDecoration(
				labelText: 'Nazwa',
			),
			onChanged: bloc.changeName,
		);
	}

	Widget _cost(bloc) {
		return StreamBuilder(
			stream: bloc.cost,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return CircularIndicator.color(Colors.blue);
				return _costWidget(bloc, snapshot.data);
			},
		);
	}

	Widget _costWidget(bloc, text) {
		return TextFormField(
			initialValue: text,
			keyboardType: TextInputType.number,
			decoration: InputDecoration(
				labelText: 'Koszt',
			),
			onChanged: bloc.changeCost,
		);
	}

	Widget _date(Bloc bloc) {
		return DateField(change: bloc.changeDate);
	}
}

class DateField extends StatelessWidget{
	final Function change;

	DateField({this.change});

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
