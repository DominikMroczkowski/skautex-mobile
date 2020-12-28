import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';

import 'componenets/delete/delete.dart';
import 'componenets/invitations/invitations.dart';
import 'componenets/add_invitation/add_invitation.dart';
import 'componenets/edit.dart';

import 'bloc/bloc.dart';

class View extends StatefulWidget {
	const View({ Key key }) : super(key: key);

  @override
  createState() => _View();

}

class _View extends State<View> with SingleTickerProviderStateMixin {

	Widget build(context) {
		final p = Provider.of(context);
		return StreamBuilder(
			stream: p.player,
			builder: (_, snapshot) {
				if (snapshot.hasData)
					return _tabController(context, snapshot.data, p);
				return Center(child: Text('Brak danych'));
			},
		);
	}

	Widget _tabController(BuildContext context, Player player, Bloc bloc) {
		var tabController = TabController(length: 2, vsync: this);
		tabController.addListener(() {
			bloc.changeTab(tabController.index);
		});
		return _scaffold(context, player, bloc, tabController);
	}

	Widget _scaffold(BuildContext context, Player player, Bloc bloc, tabController) {
		return Scaffold(
			body: _tabView(context, player, bloc, tabController),
			appBar: AppBar(
				title: Text(player.toString()),
				//leading: bloc.pop != null ?
					//BackButton(
						//onPressed: () async {bloc.pop(); return false;}
					//) :
					//Container(width: 0.0, height: 0.0),
				actions: [
					Delete(player: player),
					Edit(player: player, updateUpperPage: bloc.reloadUpperPage)
				],
				bottom: TabBar(tabs: <Widget>[
						Tab(icon: Icon(Icons.person)),
						Tab(icon: Icon(Icons.insert_invitation_rounded))
					],
					controller: tabController
				)
			),
			floatingActionButton: _floatingButtonBuilder(bloc),
		);
	}

	Widget _tabView(BuildContext context, Player player, Bloc p, tabController) {
		return TabBarView(
			controller: tabController,
			children: <Widget>[
				body(context, p),
				Invitations(player: player)
			],
		);
	}

	Widget _floatingButtonBuilder(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.tab,
			builder: (_, snapshot) {
				if (snapshot.hasData)
					if (snapshot.data == 1)
						return AddInvitation();
				return Container(width: 0.0, height: 0.0);
			}
		);
	}

	body(context, Bloc p) {
		return SingleChildScrollView(
			child: _player(p)
		);
	}

	Widget _player(Bloc p) {
		return StreamBuilder(
			stream: p.player,
			builder: (context, snapshot) {
				if (snapshot.hasData)
					return _buildPlayer(snapshot.data);
				return CircularIndicator.color(Colors.blue);
			}
		);
	}

	Widget _buildPlayer(Player data) {
		final list = data.toList();
		List<Widget> items = [];

		list.forEach(
			(i) {
				items.add(
					_padding(TextFormField(
						enabled: false,
						initialValue: i[1],
						decoration: InputDecoration(
							labelText: i[0]
						),
					)
					)
				);
			}
		);

		return Column(
			children: items
		);
	}

	Widget _padding(Widget child) {
		return Container(
			child: child,
			padding: EdgeInsets.all(5.0)
		);
	}
}
