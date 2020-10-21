import 'package:flutter/material.dart';
import 'bloc.dart';
import 'package:skautex_mobile/src/models/cost.dart';

class Provider extends InheritedWidget {
	final editButton;

	Provider({Key key, Widget child, BuildContext context, Cost cost}) :
		editButton = Bloc(context, cost),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).editButton;
	}
}
