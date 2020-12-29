import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final invitations;

	Provider({Key key, Widget child, BuildContext context, @required Player player, @required Stream contacts}) :
		invitations = Bloc(context, player: player, reload: contacts),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).invitations;
	}
}
