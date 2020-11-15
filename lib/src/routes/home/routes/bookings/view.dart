import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as info;

import 'bloc/bloc.dart';

import 'components/items/items.dart';
import 'components/reservations/reservations.dart';
import 'components/add_dialog/add_dialog.dart';

class View extends StatelessWidget {

	Widget build(context) {
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
				),
			),
			body:  TabBarView(
				children: [
					Items(),
					Reservations()
				],
			),
			drawer: HomeDrawer(),
			floatingActionButton: _addButton(u, context),
		));
	}

	Widget _addButton(info.Bloc u, context) {
		return StreamBuilder(
			stream: u.permissions,
			builder: (_, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (_, futureSnap) {
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
				_showDialog(
					context,
						);
     	},
     	child: Icon(Icons.add),
    	backgroundColor: Colors.blue,
    );
	}

	_showDialog(BuildContext context) {
		final bloc = Provider.of(context);
		showDialog(
  		context: context,
  		builder: (_) => AddDialog(bloc: bloc),
		);
	}
}
