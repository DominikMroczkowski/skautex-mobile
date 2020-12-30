import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	var addInvitation;

	Provider({Key key, Widget child, BuildContext context, @required Function change})
		: addInvitation = Bloc(context, change: change),
		  super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).addInvitation;
	}
}
