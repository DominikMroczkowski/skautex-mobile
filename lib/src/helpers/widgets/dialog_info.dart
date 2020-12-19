import 'package:flutter/material.dart';
import 'circular_indicator.dart';

class DialogInfo extends StatelessWidget {
	final Future future;
	final String title;
	final Function runAfter;
	final List<dynamic> raArgs;

	DialogInfo({this.future, this.title, this.runAfter, this.raArgs});

	Widget build(BuildContext context) {
			return _alert(context);
	}

	_alert(BuildContext context) {
		return FutureBuilder(
			future: future,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					if (runAfter != null)
						Function.apply(runAfter, raArgs);
					return AlertDialog(
						title: Text("Powodzenie"),
						actions: [
							FlatButton(child: Text('Ok'), onPressed:() {
								Navigator.of(context).popUntil((route) {return '/home' == route.settings.name;});}
							)
						]
					);
				}
				if (snapshot.connectionState == ConnectionState.waiting)
					return AlertDialog(
						title: Text(title),
						content: CircularIndicator.horizontal(Colors.blue)
					);
				return AlertDialog(
					title: Text("Niepowodzenie"),
					actions: [
						FlatButton(child: Text('Ok'), onPressed:() {Navigator.of(context).pop();})
					]
				);
			}
		);
	}
}
