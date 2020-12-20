import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {
	final File file;

	View({this.file});

	Widget build(context) {
		final bloc = Provider.of(context);

		return FlatButton(
			child:  Row(children: [Icon(Icons.delete), Text('Usuń')]),
			onPressed: () => showDialog(
				context: context,
				builder: (context) {
					return DeleteDialog(
						stream: bloc.item,
						uri: file.uri,
						onTrue: bloc.addItem,
						title: 'Usuń',
						ask: 'Czy napewno chcesz usunąć blokade',
						whileWorking: 'Usuwanie',
					);
				}
			),
			shape: BeveledRectangleBorder(),
			minWidth: 40.0
 		);
	}

}
