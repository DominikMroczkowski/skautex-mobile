import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/routes/home/routes/options/components/add_template/components/add_dialog/bloc/bloc.dart';
import 'package:skautex_mobile/src/routes/home/routes/reports/routes/report/components/files/components/add/components/file_field.dart';

class Form extends StatelessWidget {
	final Bloc bloc;

	Form({this.bloc});

	Widget build(context) {
		return AlertDialog(
			title: Text('Wybierz szablon formularza zaproszenia'),
			actions: [_add()],
			content: SingleChildScrollView(
				child: Column(
					children: [
						_nameField(),
						_fileField()
					]
				),
			)
		);
	}

	Widget _nameField() {
		return TextFormField(
			onChanged: bloc.changeName,
			decoration: InputDecoration(
				labelText: 'Nazwa identyfikująca'
			),
		);
	}

	Widget _fileField() {
		return StreamBuilder(
			stream: bloc.file,
			builder: (_, AsyncSnapshot<String> snapshot) {
				return FileField(change: bloc.changeFile, snapshot: snapshot);
			}
		);
	}

	Widget _add() {
		return FlatButton(
			child: Text('Dodaj plik'),
			onPressed: bloc.addTemplate
		);
	}
}
