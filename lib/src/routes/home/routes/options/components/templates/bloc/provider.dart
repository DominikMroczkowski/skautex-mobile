import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final templates;

	Provider({Key key, Widget child, BuildContext context, Stream reaload }) :
		templates = Bloc(context, reload: reaload),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).templates;
	}
}
