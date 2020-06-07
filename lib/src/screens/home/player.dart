import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import '../../widgets/homeDrawer.dart';
import '../../blocs/player/bloc.dart' as player;
import '../../blocs/info/bloc.dart' as info;
import '../../models/player.dart' as models;
import '../../widgets/circular_indicator.dart';

class Player extends StatelessWidget {

	Widget build(context) {
		final p = player.Provider.of(context);
		p.fetchPlayer(Object());

		return Scaffold(
			body: body(context, p),
			appBar: AppBar(
				title: Text('Zawodnik')
			),
			drawer: HomeDrawer(),
		);
	}

	body(context, player.Bloc p) {
		return Container(
			child: Card(
				child: SingleChildScrollView(
					child: Container(
						child: Column(
							children: [
								_buttons(context),
								_player(p)
							]
						)
					),
					padding: EdgeInsets.all(15.0),
				),
			),
			margin: EdgeInsets.all(15.0),
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
								return _buttonsWidget(context, ((permsFuture.data ?? Permissions.toXOR()) as Permissions));
							return CircularProgressIndicator();
						}
					);
					return CircularProgressIndicator();
			}
		);
	}

	Widget _buttonsWidget(BuildContext context, Permissions perms) {
		var toXor = Permissions.toXOR();
		toXor.changePlayer = true;
		final bool canEditPlayer = perms.XOR(toXor);
		toXor = Permissions.toXOR();
		toXor.deletePlayer = true;
		final bool canDeactivatePlayer = perms.XOR(toXor);

		return Container(
			child: Row(
				children: <Widget>[
					Expanded( child: Container()),
					canDeactivatePlayer ? RaisedButton(
						color: Colors.red,
						child: Text('Deaktywuj'),
						onPressed: () {
							_deactivate(context);
					}) : Container(),
					Container(padding: EdgeInsets.only(left: 10.0)),
					canEditPlayer ? RaisedButton(
						color: Colors.blue,
						child: Text('Edytuj'),
						onPressed: () {
							Navigator.of(context).pushNamed('/home/user/editUser');
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
		final u = player.Provider.of(context);
		return StreamBuilder(
			stream: u.deactivateOutput,
			builder: (context, snapshot) {
				if (!snapshot.hasData) {
					return AlertDialog(
						title: Text("Dezaktywacja"),
						content: Text("Czy napewno chcesz dezaktywować zawodnika?"),
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

	Widget _player(player.Bloc p) {
		return StreamBuilder(
			stream: p.player,
			builder: (context, snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, snapshot) {
							if (snapshot.hasData)
								return _buildPlayer(snapshot.data);
							return CircularIndicator.color(Colors.blue);
						}
					);
				return Text('Oczekiwanie na request');
			}
		);
	}

	Widget _buildPlayer(models.Player data) {
		final list = data.toList();
		List<Widget> items = [];

		list.forEach(
			(i) {
				items.add(_goldenRow(i[0], _header(i[1], Alignment.centerLeft)));
			}
		);

		return Column(
			children: items
		);
	}

	Widget _goldenRow(String name, Widget field) {
		return Container(
			height: 50.0,
			child: Row(
				children: <Widget>[
					Expanded(
						flex: 21,
						child: _header(name, Alignment.centerRight),
					),
					Container(
						padding: EdgeInsets.only(left: 10)
					),
					Expanded(
						flex: 34,
						child: field,
					)
				],
			)
		);
	}

	Widget _header(String name, Alignment alignment) {
		return Align(
			alignment: alignment,
			child: Text(
				name,
				style: TextStyle(
						fontSize: 16
				)
			)
		);
	}
}
