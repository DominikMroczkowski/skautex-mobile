import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final player;

	Provider({Key key, Widget child, BuildContext context, @required Player player, reloadUpperPage}) :
		player = Bloc(player: player, reloadUpperPage: reloadUpperPage),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).player;
	}
}
