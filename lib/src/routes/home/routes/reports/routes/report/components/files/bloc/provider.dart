import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final files;

	Provider({Key key, Widget child, BuildContext context, Report report}) :
		files = Bloc(context, report: report),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).files;
	}
}
