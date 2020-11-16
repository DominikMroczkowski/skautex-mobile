import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final chooseUser;

	Provider({Key key, Widget child, BuildContext context, bloc}) :
		chooseUser = Bloc(context, bloc: bloc),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).chooseUser;
	}
}
