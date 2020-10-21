import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'bloc/bloc.dart' as add;

class AddCost extends StatelessWidget {
	Widget build(BuildContext context) {
		return add.Provider(context: context, child: _View());
	}
}

class _View extends StatelessWidget {

	Widget build(BuildContext context) {
		return _alert(context);
	}

	_alert(context) {
		add.Bloc bloc = add.Provider.of(context);

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
											onPressed:() {
												Navigator.of(context).pop();
											}
										)
									]
								);
							return AlertDialog(
								title: Text("Dodaje"),
								content: CircularIndicator.horizontal(Colors.blue)
							);
						}
					);
				return AlertDialog(
					title: Text("Dodaj"),
					content: _form(context),
					actions: [
						FlatButton(
							child: Text('Dodaj'),
							onPressed: !(snapshot.data == true) ?  () {
								bloc.add();
							} : null
						),
						FlatButton(child: Text('Anuluj'), onPressed:() {Navigator.of(context).pop(null);})
					]
				);
			},
		);

	}

	Widget _form(BuildContext context) {
		add.Bloc bloc = add.Provider.of(context);

		return SingleChildScrollView(
			child: Column(
				children: <Widget>[
					_name(bloc),
					_money(bloc),
					_date(context)
				],
			)
		);
	}

	Widget _name(bloc) {
		return StreamBuilder(
			stream: bloc.name,
			builder: (context, snapshot) {
				String text = snapshot.data ?? '';
				return _nameWidget(bloc, text);
			},
		);
	}

	Widget _nameWidget(bloc, text) {
		return TextFormField(
			initialValue: text,
			decoration: InputDecoration(
				labelText: 'Nazwa',
			),
			onChanged: bloc.changeName,
		);
	}

	Widget _money(bloc) {
		return StreamBuilder(
			stream: bloc.name,
			builder: (context, snapshot) {
				String text = snapshot.data ?? '';
				return _moneyWidget(bloc, text);
			},
		);
	}

	Widget _moneyWidget(bloc, text) {
		return TextFormField(
			initialValue: text,
			keyboardType: TextInputType.number,
			decoration: InputDecoration(
				labelText: 'Koszt',
			),
			onChanged: bloc.changeCost,
		);
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
			onChanged: add.Provider.of(context).changeDate,
			decoration: InputDecoration(
				labelText: 'Data',
			),
		);
	}
}
