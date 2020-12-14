import 'package:flutter/material.dart';
import 'bloc.dart';
import 'package:skautex_mobile/src/models/player_report.dart';

class Provider extends InheritedWidget {
	final playerReport;

	Provider({Key key, Widget child, BuildContext context, PlayerReport playerReport, Function updateReport}):
		playerReport = Bloc(context, value: playerReport, updateReport: updateReport),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).playerReport;
	}
}
