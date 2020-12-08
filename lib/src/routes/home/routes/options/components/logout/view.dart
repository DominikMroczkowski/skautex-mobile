import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);

		return RaisedButton(
			child: Text('Wyloguj'),
			onPressed: () {
				showDialog(
					context: context,
					builder: (context) {
						return DeleteDialog(
							stream: bloc.watcher,
							onTrue: () => bloc.deleteItem(),
							title: 'Wylogowywanie',
							ask: 'Czy napewno chcesz się wylogować?',
							whileWorking: 'Wylogowywanie',
							runAfterDeletion: _logout,
							radArgs: [context]
						);
					}
				);
			},
		);
	}

	_logout(BuildContext context) async {
		exit(exitCode);
	}
}
