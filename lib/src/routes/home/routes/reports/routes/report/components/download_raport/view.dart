import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return FlatButton(
			child: Icon(Icons.download_sharp, color: Colors.white),
			onPressed: () {
				showDialog(
					context: context,
					builder: (context) {
						return DeleteDialog(
							stream: bloc.item,
							onTrue: bloc.startDownload,
							title: 'Pobierz',
							ask: 'Czy napewno chcesz pobrać raport?',
							whileWorking: 'Inicializowanie',
						);
					}
				);
			},
			shape: CircleBorder(),
			minWidth: 10.0
 		);
	}
}
