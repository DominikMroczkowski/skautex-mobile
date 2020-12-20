import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'package:path/path.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {
	final File file;

	View({this.file});

	Widget build(context) {
		final bloc = Provider.of(context);

		return FlatButton(
			child:  Row(children: [Icon(Icons.download_sharp), Text('Pobierz')]),
			onPressed: () {
				showDialog(
					context: context,
					builder: (context) => DeleteDialog(
							stream: bloc.item,
							uri: file.file,
							onTrue: bloc.downloadItem,
							title: 'Pobierz',
							ask: 'Czy napewno chcesz pobrać plik ${basename(file.file)}',
							whileWorking: 'Pobieranie',
						)
				);
			},
			shape: BeveledRectangleBorder(),
			minWidth: 40.0,
 		);
	}

}
