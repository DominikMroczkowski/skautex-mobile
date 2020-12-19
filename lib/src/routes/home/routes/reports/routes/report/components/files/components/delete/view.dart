import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/delete_dialog.dart';
import 'package:skautex_mobile/src/models/booking_blacklist.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {
	final BookingBlacklist blacklist;

	View({this.blacklist});


	Widget build(context) {
		final bloc = Provider.of(context);

		return FlatButton(
			child: Icon(Icons.delete),
			onPressed: () {
				showDialog(
					context: context,
					builder: (context) {
						return DeleteDialog(
							stream: bloc.item,
							uri: blacklist.uri,
							onTrue: bloc.addItem,
							title: 'Usuń',
							ask: 'Czy napewno chcesz usunąć blokade',
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
