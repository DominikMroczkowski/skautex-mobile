import 'package:flutter/material.dart';
import '../models/user.dart';
import '../blocs/session/bloc.dart' as session;
import 'tile.dart';

class UserTile extends StatelessWidget {
	final User user;

	UserTile({this.user});

	Widget build(context) {
		return Container(
			child: buildTile(context, user),
			padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
		);
	}

	Widget buildTile(BuildContext context, User user) {
		List<Widget> children = [
			Align(
				child: Text(
					_userName(user),
					style: TextStyle(
						fontSize: 18,
					)
				),
				alignment: Alignment.topLeft,
			),
		];

		return Tile(
			children: children,
			func: onTileTap,
			args: null,
			positionalArgs: [context]
		);
	}

	_userName(User user) {
		if (user.firstName != '' || user.lastName != '')
			return '${user.firstName} ${user.lastName}';
		return user.username;
	}

	onTileTap(context)	{
		final s = session.Provider.of(context);
		s.changeClicked(user.uri);
		Navigator.pushNamed(context, '/home/user');
	}
}
