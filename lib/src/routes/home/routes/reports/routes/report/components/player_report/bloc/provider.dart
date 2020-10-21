import 'package:flutter/material.dart';
import 'bloc.dart';
import '../../models/player_report.dart';

class Provider extends InheritedWidget {
	final playerReport;

	Provider({Key key, Widget child, BuildContext context, PlayerReport playerReport}):
		playerReport = Bloc(context, playerReport),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).playerReport;
	}
}
