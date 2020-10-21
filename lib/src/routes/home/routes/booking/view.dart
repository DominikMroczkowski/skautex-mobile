import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as info;

import 'bloc/bloc.dart' as costs;

import 'components/items/items.dart';
import 'components/reservations/reservations.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final p = costs.Provider.of(context);
		final u = info.Provider.of(context);
		return DefaultTabController(
			length: 2,
			child: Scaffold(
			appBar: AppBar(
				title: Text('Rezerwacje'),
				bottom: TabBar(
					tabs: <Widget>[
						Tab(text: 'Przedmioty'),
						Tab(text: 'Rezerwacje')
					],
				)
			),
			body:  TabBarView(
				children: [
					Items(),
					Reservations()
				],
			),
			drawer: HomeDrawer(),
			floatingActionButton: _addButton(u),
		));
	}

	Widget _addButton(info.Bloc u) {
		return StreamBuilder(
			stream: u.permissions,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, futureSnap) {
							if (!futureSnap.hasData || !(futureSnap.data as Permissions).addUser) {
								return Container();
							}
							return _addButton2(context);
						}
					);
				}
				return Container();
			}
		);
	}

	Widget _addButton2(BuildContext context) {
		return FloatingActionButton(
     	onPressed: () {
				_showDialog(context);
     	},
     	child: Icon(Icons.add),
    	backgroundColor: Colors.blue,
    );
	}

	_showDialog(BuildContext context) {
		showDialog(
  		context: context,
  		builder: (_) => null,
		);
	}
}
