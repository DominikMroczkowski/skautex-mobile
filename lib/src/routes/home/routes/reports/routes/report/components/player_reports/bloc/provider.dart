import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player_report.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final playerReport;

	Provider({Key key, Widget child, BuildContext context, List<PlayerReport> reports}):
		playerReport = Bloc(reports),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).playerReport;
	}
}
