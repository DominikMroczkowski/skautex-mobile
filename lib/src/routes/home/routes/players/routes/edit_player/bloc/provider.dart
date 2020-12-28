import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	var editPlayer;

	Provider({Key key, Widget child, BuildContext context, @required Player player, @required Function updateUpperPage})
		: editPlayer = Bloc(context, player: player, updateUpperPage: updateUpperPage),
		  super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).editPlayer;
	}

}
