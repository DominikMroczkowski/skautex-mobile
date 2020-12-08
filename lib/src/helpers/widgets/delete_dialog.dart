import 'package:flutter/material.dart';
import 'circular_indicator.dart';

class DeleteDialog extends StatelessWidget {
	final Stream stream;
	final Function onTrue;
	final String uri;
	final String title;
	final String ask;
	final String whileWorking;
	final Function runAfterDeletion;
	final List<dynamic> radArgs;

	DeleteDialog({this.stream, this.onTrue, this.uri, String title, String ask, String whileWorking, this.runAfterDeletion, this.radArgs}) :
		this.title = title ?? 'Dezaktywacja',
		this.ask = ask ?? 'Czy napewno chcesz dezaktywować zawodnika',
		this.whileWorking = whileWorking ?? 'Dezaktywowano';

	Widget build(BuildContext context) {
			return _alert(context);
	}

	_alert(BuildContext context) {
		return StreamBuilder(
			stream: stream,
			builder: (context, snapshot) {
				if (!snapshot.hasData) {
					return AlertDialog(
						title: Text(title),
						content: Text(ask),
						actions: [
							FlatButton(
								child: Text('Tak'),
								onPressed: () {
									Function.apply(onTrue, uri != null ? [uri] : []);
								}
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
						if (snapshot.hasData) {
							if (runAfterDeletion != null)
								Function.apply(runAfterDeletion, radArgs);
							return AlertDialog(
								title: Text("Powodzenie"),
								actions: [
									FlatButton(child: Text('Ok'), onPressed:() {Navigator.of(context).popUntil((route) { return '/home' == route.settings.name;});})
								]
							);
						}
						return AlertDialog(
							title: Text(whileWorking),
							content: CircularIndicator.horizontal(Colors.blue)
						);
					}
				);
			}
		);
	}
}
