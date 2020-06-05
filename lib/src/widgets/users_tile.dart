import 'package:flutter/material.dart';
import '../models/user.dart';
import '../blocs/users/bloc.dart' as users;
import '../blocs/session/bloc.dart' as session;

import 'dart:async';

import 'loading_container.dart';
import 'tile.dart';

class UserTile extends StatelessWidget {
	final String uri;

	UserTile({this.uri});

	Widget build(context) {
		final u = users.Provider.of(context);

		return StreamBuilder(
			stream: u.watcher,
			builder: (context, AsyncSnapshot<Map<String, Future<User>>> snapshot) {
				if (!snapshot.hasData) {
					return LoadingContainer.lineCount(0);
				}

				return FutureBuilder(
					future: snapshot.data[uri],
					builder: (context, AsyncSnapshot<User> userFuture) {
						if (!userFuture.hasData) {
							return LoadingContainer.lineCount(0);
						}

						return Container(
							child: buildTile(context, userFuture.data),
							padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
						);
					}
				);
			}
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
		s.changeClicked(uri);
		Navigator.pushNamed(context, '/home/user');
	}
}
