import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/cost.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';
import 'bloc/bloc.dart';

class DeleteButton extends StatelessWidget {
	final Cost cost;

	DeleteButton({@required this.cost});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: _View(cost: cost));
	}
}

class _View extends StatelessWidget {
	final Cost cost;

	_View({@required this.cost});

	Widget build(BuildContext context) {
		final Stream stream = Provider.of(context).item;
		final Function deactivate = Provider.of(context).addItem;

		return FlatButton(
			textColor: Colors.red,
			child: Text('Usuń'),
			onPressed: () {
				showDialog(
					context: context,
					child: DeleteDialog(
						stream: stream,
						onTrue: deactivate,
						uri: cost.uri
					)
				);
			}
		);
	}
}
