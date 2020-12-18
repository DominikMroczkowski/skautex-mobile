import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {

	Widget build(BuildContext context) {
		final bloc = Provider.of(context);

		return FlatButton(
     	onPressed: () {
				showDialog(
					context: context,
					builder: (_) {
						return _Dialog(bloc: bloc);
					}
				);
			},
     	child: new Text(
				"Nie mam urządzenia",
				style: TextStyle(color: Colors.blue)
			)
 		);
	}
}

class _Dialog extends StatelessWidget {
	final Bloc bloc;

	_Dialog({@required this.bloc});

	Widget build(BuildContext context) {
		return DeleteDialog(
			stream: bloc.item,
			title: 'Kod weryfikacyjny',
			ask: 'Czy wysłać kod weryfikacyjny na email?',
			whileWorking: 'Wysyłam',
			onTrue: bloc.sendCodeOnEmail
		);
	}
}
