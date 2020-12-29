import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return FlatButton(
			child:  Row(children: [Icon(Icons.delete), Text('Usuń')]),
			onPressed: () => showDialog(
				context: context,
				builder: (context) {
					return DeleteDialog(
						stream: bloc.item,
						uri: bloc.contactDetail.uri,
						onTrue: bloc.addItem,
						title: 'Usuń',
						ask: 'Czy napewno chcesz usunąć zaproszenie?',
						whileWorking: 'Usuwanie',
					);
				}
			),
			shape: BeveledRectangleBorder(),
			minWidth: 40.0
 		);
	}

}
