import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/user.dart' as models;
import 'package:skautex_mobile/src/models/permissions.dart' as models;

import 'package:skautex_mobile/src/blocs/user/bloc.dart' as user;
import 'package:skautex_mobile/src/blocs/info/bloc.dart' as info;

import 'package:skautex_mobile/src/widgets/circular_indicator.dart';
import 'package:skautex_mobile/src/widgets/view_item_list.dart';
import 'package:skautex_mobile/src/widgets/card_body.dart';

class User extends StatelessWidget {
	build(context) {
		final u = user.Provider.of(context);
		u.fetchLastClicked();

		List<Widget> children = [];
		children.add(
			CardBody(
				children: [
					_buttons(context),
						_userDataObserver(u)
				]
			)
		);

		return Scaffold(
			appBar: AppBar(
				title: Text('Użytkownicy')
			),

			body:
			SingleChildScrollView(
				child: Column(
					children: children
				),
			),
		);
	}

	Widget _buttons(BuildContext context) {
		final perms = info.Provider.of(context);

		return StreamBuilder(
			stream: perms.permissions,
			builder: (context, snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, permsFuture) {
							if (permsFuture.hasData)
								return _buttonsWidget(context, ((permsFuture.data ?? models.Permissions.toXOR()) as models.Permissions));
							return CircularProgressIndicator();
						}
					);
					return CircularProgressIndicator();
			}
		);
	}

	Widget _buttonsWidget(BuildContext context, models.Permissions perms) {
		final toXor = models.Permissions.toXOR();
		toXor.changePlayer = true;
		final bool canEditPlayer = perms.XOR(toXor);
		return Container(
			child: Row(
				children: <Widget>[
					Expanded( child: Container()),
					canEditPlayer ? RaisedButton(
						color: Colors.blue,
						child: Text('Edytuj'),
						onPressed: () {
							Navigator.of(context).pushNamed('/home/player/editPlayer');
					}) : Container(),
				],
			),
			height: 50.0
		);
	}

	Widget _userDataObserver(user.Bloc u) {
		return StreamBuilder(
			stream: u.user.item,
			builder: (context, snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, AsyncSnapshot<models.User> snapshot) {
							if (snapshot.hasData)
								return ViewItemList(snapshot.data.toList());
							return CircularIndicator.color(Colors.blue);
						}
					);
				return CircularIndicator.color(Colors.blue);
			}
		);
	}
}
