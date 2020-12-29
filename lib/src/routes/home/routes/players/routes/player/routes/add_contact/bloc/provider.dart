import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	var addContact;

	Provider({Key key, Widget child, BuildContext context, Function update, Player player})
		: addContact = Bloc(context, update: update, player: player),
		  super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).addContact;
	}
}
