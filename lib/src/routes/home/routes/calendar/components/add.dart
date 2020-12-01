import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/widget_with_permision.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as home;

class Add extends StatelessWidget {
	Widget build(context) {
		final perms = home.Provider.of(context).permissions;

		return WidgetWithPermission(
			permissions: Permissions(addPlayer: true),
			stream: perms,
			widget: _add,
			arguments: [context]
		);
	}

	_add(BuildContext context) {
		return FloatingActionButton(
     	onPressed: () {
				Navigator.of(context).pushNamed('/home/calendar/add');
     	},
     	child: Icon(Icons.add),
    	backgroundColor: Colors.blue,
    );
	}
}
