import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'package:path/path.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {
	final InvitationTemplate template;

	View({this.template});

	Widget build(context) {
		final bloc = Provider.of(context);

		return FlatButton(
			child:  Row(children: [Icon(Icons.download_sharp), Text('Pobierz')]),
			onPressed: () {
				showDialog(
					context: context,
					builder: (context) => DeleteDialog(
							stream: bloc.item,
							onTrue: bloc.download,
							title: 'Pobierz',
							ask: 'Czy napewno chcesz pobrać plik ${basename(template.templateFile)}',
							whileWorking: 'Pobieranie',
						)
				);
			},
			shape: BeveledRectangleBorder(),
			minWidth: 40.0,
 		);
	}

}
