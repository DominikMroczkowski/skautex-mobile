import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/user.dart' as models;
import 'package:skautex_mobile/src/models/permissions.dart' as models;

import 'bloc/bloc.dart' as user;
import 'package:skautex_mobile/src/bloc/bloc.dart' as info;

import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'package:skautex_mobile/src/helpers/widgets/view_item_list.dart';
import 'package:skautex_mobile/src/helpers/widgets/card_body.dart';

class View extends StatelessWidget {
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
		var toXor = models.Permissions.toXOR();
		toXor.changePlayer = true;
		final bool canEditPlayer = perms.XOR(toXor);
		toXor = models.Permissions.toXOR();
		toXor.deleteUser = true;
		final bool canDeactivatePlayer = perms.XOR(toXor);

		return Container(
			child: Row(
				children: <Widget>[
					canDeactivatePlayer ? FlatButton(
						textColor: Colors.red,
						child: Text('Deaktywuj'),
						onPressed: () {
							_deactivate(context);
					}) : Container(),
					Expanded( child: Container()),
					canEditPlayer ? RaisedButton(
						color: Colors.blue,
						child: Text('Edytuj'),
						onPressed: () {
							Navigator.of(context).pushNamed('/home/users/editUser');
					}) : Container(),
				],
			),
			height: 50.0
		);
	}

	_deactivate(BuildContext context) {
		showDialog(
			context: context,
			builder: (_) {
				return _alert(context);
			}
		);
	}

	_alert(BuildContext context) {
		final u = user.Provider.of(context);
		return StreamBuilder(
			stream: u.deactivateOutput,
			builder: (context, snapshot) {
				if (!snapshot.hasData) {
					return AlertDialog(
						title: Text("Dezaktywacja"),
						content: Text("Czy napewno chcesz dezaktywować użytkownika?"),
						actions: [
							FlatButton(
								child: Text('Tak'),
								onPressed:() {
									u.deactivate();
								}
							),
							FlatButton(child: Text('Nie'), onPressed:() {Navigator.of(context).pop();})
						]
					);
				}
				return FutureBuilder(
					future: snapshot.data,
					builder: (context, snapshot) {
						if (snapshot.hasError)
							return AlertDialog(
								title: Text("Niepowodzenie"),
								actions: [
									FlatButton(child: Text('Ok'), onPressed:() {Navigator.of(context).pop();})
								]
							);
						if (snapshot.hasData)
							return AlertDialog(
								title: Text("Dezaktywowano"),
								actions: [
									FlatButton(child: Text('Ok'), onPressed:() {Navigator.of(context).popUntil((route) { return '/home' == route.settings.name;});})
								]
							);
						return AlertDialog(
							title: Text("Dezaktywuje"),
							content: CircularIndicator.horizontal(Colors.blue)
						);
					}
				);
			}
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
