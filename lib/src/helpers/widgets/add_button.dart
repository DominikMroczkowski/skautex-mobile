import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as home;

/* Letter generalize class for MainButton */

class AddButton {
	final Permissions perms;
	final Function    onClick;

	AddButton({this.perms, this.onClick});

	Widget build(BuildContext context) {
		return StreamBuilder(
			stream: home.Provider.of(context).permissions,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, futureSnap) {
							if (!futureSnap.hasData || !(futureSnap.data as Permissions).XOR(perms)) {
								return Container();
							}
							return _addButton2();
						}
					);
				}
				return Container();
			}
		);
	}

	Widget _addButton2() {
		return FloatingActionButton(
     	onPressed: onClick,
     	child: Icon(Icons.add),
    	backgroundColor: Colors.blue,
    );
	}
}
