import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return FlatButton(
			child:  Row(children: [Icon(Icons.download_sharp), Text('Pobierz')]),
			onPressed: () {
				showDialog(
					context: context,
					builder: (context) {
						return DeleteDialog(
							stream: bloc.item,
							onTrue: bloc.download,
							title: 'Pobierz',
							ask: 'Czy napewno chcesz pobrać zaproszenie?',
							whileWorking: 'Inicializowanie',
						);
					}
				);
			},
			shape: BeveledRectangleBorder(),
			minWidth: 40.0
 		);
	}
}
