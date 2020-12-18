import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final add;

	Provider({Key key, Widget child, BuildContext context, @required Report report}) :
		add = Bloc(context, report: report),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return context.dependOnInheritedWidgetOfExactType<Provider>().add;
	}
}
