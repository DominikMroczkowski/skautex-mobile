import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'package:skautex_mobile/src/models/event.dart';

class Indicator extends StatelessWidget {
	final Future<Event> item;
	final Function popOnSuccess;

	Indicator({@required this.item, @required this.popOnSuccess});

	build(BuildContext context) {
		return FutureBuilder(
			future: item,
			builder: (_, snapshot) {
				if (snapshot.hasData)
					return AlertDialog(
						title: Text('Powodzenie'),
						actions: [FlatButton(child: Text('Ok'), onPressed: () {popOnSuccess(); Navigator.of(context).pop();})],
					);

				return AlertDialog(
					title: Text('Działam'),
					content: CircularIndicator.horizontal(Colors.blue)
				);
			}
		);
	}
}
