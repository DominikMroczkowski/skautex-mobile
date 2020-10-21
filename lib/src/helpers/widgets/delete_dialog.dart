import 'package:flutter/material.dart';
import 'circular_indicator.dart';

class DeleteDialog extends StatelessWidget {
	final Stream stream;
	final Function onTrue;
	final String uri;

	DeleteDialog({this.stream, this.onTrue, this.uri});

	Widget build(BuildContext context) {
			return _alert(context);
	}

	_alert(BuildContext context) {
		return StreamBuilder(
			stream: stream,
			builder: (context, snapshot) {
				if (!snapshot.hasData) {
					return AlertDialog(
						title: Text("Dezaktywacja"),
						content: Text("Czy napewno chcesz dezaktywować zawodnika?"),
						actions: [
							FlatButton(
								child: Text('Tak'),
								onPressed: () { Function.apply(onTrue, [uri]);}
							),
							FlatButton(child: Text('Nie'), onPressed:() {Navigator.of(context).pop();})
						]
					);
				}
				return FutureBuilder(
					future: snapshot.data,
					builder: (context, snapshot) {
						if (snapshot.hasError)
							return AlertDialog(
								title: Text("Niepowodzenie"),
								actions: [
									FlatButton(child: Text('Ok'), onPressed:() {Navigator.of(context).pop();})
								]
							);
						if (snapshot.hasData)
							return AlertDialog(
								title: Text("Dezaktywowano"),
								actions: [
									FlatButton(child: Text('Ok'), onPressed:() {Navigator.of(context).popUntil((route) { return '/home' == route.settings.name;});})
								]
							);
						return AlertDialog(
							title: Text("Dezaktywuje"),
							content: CircularIndicator.horizontal(Colors.blue)
						);
					}
				);
			}
		);
	}
}
