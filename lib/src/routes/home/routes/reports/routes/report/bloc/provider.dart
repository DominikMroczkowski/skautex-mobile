import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final report;

	Provider({Key key, Widget child, BuildContext context, Report report, Function updateUpperPage})
		: report = Bloc(context, report: report, updateUpperPage: updateUpperPage),
		  super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).report;
	}
}
