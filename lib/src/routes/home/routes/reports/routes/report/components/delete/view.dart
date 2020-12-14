import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {
	final Report report;

	View({this.report});

	Widget build(context) {
		final bloc = Provider.of(context);

		return FlatButton(
			child: Icon(Icons.delete, color: Colors.white),
			onPressed: () {
				showDialog(
					context: context,
					builder: (context) {
						return DeleteDialog(
							stream: bloc.item,
							uri: report.uri,
							onTrue: bloc.addItem,
							title: 'Usuń',
							ask: 'Czy napewno chcesz usunąć raport?',
							whileWorking: 'Usuwanie',
						);
					}
				);
			},
			shape: CircleBorder(),
			minWidth: 10.0
 		);
	}
}
