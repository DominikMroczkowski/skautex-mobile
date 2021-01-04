import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'package:skautex_mobile/src/models/file.dart';

import 'bloc/bloc.dart';

import 'components/file_field.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);
		return FlatButton(
			child: Icon(Icons.add),
			onPressed: () { _add(context, bloc); } ,
			minWidth: 0.0
		);
	}

	_add(BuildContext context, Bloc bloc) {
		showDialog(
			context: context,
			child: _GetDialog(bloc: bloc)
		);
	}
}

class _GetDialog extends StatelessWidget {
	final Bloc bloc;

	_GetDialog({this.bloc});

	Widget build(BuildContext context) {
		return _getDialog(context);
	}

	Widget _getDialog(BuildContext context) {
		return StreamBuilder(
			stream: bloc.item,
			builder: (context, AsyncSnapshot<Future<String>> snapshot) {
				if (!snapshot.hasData)
					return _input(context);

				return FutureBuilder(
					future: snapshot.data,
					builder: (context, AsyncSnapshot<String> snapshot) {
						if (snapshot.hasData)
							return AlertDialog(
								title: Text('Powodzenie'),
								actions: [_popButton(context)],
							);
						if (snapshot.hasError)
							return AlertDialog(
								title: Text('Niepowodzenie'),
								actions: [_popButton(context)],
							);
						return AlertDialog(
							title: Text('Dodawanie'),
							content: CircularIndicator.horizontal(Colors.blue)
						);
					},
				);
			}
		);
	}

	Widget _input(BuildContext context) {
		return AlertDialog(
			title: Text('Wybierz plik'),
			content: Container(
				child: _fileField(),
				height: 80.0
			),
			actions: [
				_popButton(context, 'Anuluj'),
				_addButton(context)
			]
		);
	}

	Widget _fileField() {
		return StreamBuilder(
			stream: bloc.path,
			builder: (_, snapshot) {
				return FileField(
					snapshot: snapshot,
					change: bloc.changePath
				);
			}
		);
	}


	Widget _popButton(context, [String text]) {
		return FlatButton(
			child: Text(text ?? 'Ok'),
			onPressed: Navigator.of(context, rootNavigator: true).pop
		);
	}

	Widget _addButton(BuildContext context) {
		return StreamBuilder(
			stream: bloc.submitValid,
			builder: (_, snapshot) {
				return FlatButton(
					child: Text('Dodaj'),
					onPressed: snapshot.data != null ? bloc.uploadFile : null
				);
			}
		);
	}
}
