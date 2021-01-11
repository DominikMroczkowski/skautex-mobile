import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	var addInvitation;

	Provider({Key key, Widget child, BuildContext context, @required Player player, @required Function update})
		: addInvitation = Bloc(context, player: player, update: update),
		  super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).addInvitation;
	}
}
