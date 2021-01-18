import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player_report.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	var addContact;

	Provider({Key key, Widget child, BuildContext context, Function update, PlayerReport report})
		: addContact = Bloc(context, update: update, report: report),
		  super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).addContact;
	}
}
