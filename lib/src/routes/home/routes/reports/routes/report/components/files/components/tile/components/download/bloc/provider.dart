import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
	final download;

	Provider({Key key, Widget child, BuildContext context, File blacklist}) :
		download = Bloc(context, file: blacklist),
		super(key: key, child: child);

	bool updateShouldNotify(_) => true;

	static Bloc of(BuildContext context) {
		return (context.inheritFromWidgetOfExactType(Provider) as Provider).download;
	}
}
