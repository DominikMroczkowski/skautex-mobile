import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/invitation.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final delete;

	Provider({Key key, Widget child, BuildContext context, @required Invitation invitation}) :
		delete = Bloc(context, invitation: invitation),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).delete;
	}
}
