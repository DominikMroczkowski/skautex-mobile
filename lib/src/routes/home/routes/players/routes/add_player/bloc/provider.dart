import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final addPlayer;

	Provider({Key key, Widget child, BuildContext context, @required Function updateUpperPage})
		: addPlayer = Bloc(context, updateUpperPage: updateUpperPage),
		  super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).addPlayer;
	}

}
