import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'bloc/bloc.dart';
import 'package:skautex_mobile/src/helpers/widgets/home_drawer.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as info;

import 'components/tile.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final p = Provider.of(context);
		final u = info.Provider.of(context);

		return Scaffold(
			body: _list(p),
			appBar: AppBar(
				title: Text('Zadania')
			),
			drawer: HomeDrawer(),
		);
	}

	Widget _list(Bloc bloc) {
		return SizedBox.expand(child:StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: (i) => Tile(event: i, bloc: bloc),
			notify: bloc.fetch
		));
	}

	Widget _addButton(info.Bloc u, Bloc bloc) {
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

							return FloatingActionButton(
     						onPressed: () {
									Navigator.pushNamed(context, '/home/task/add', arguments: bloc.reloadReports);
      					},
      					child: Icon(Icons.add),
      					backgroundColor: Colors.blue,
    					);
						}
					);
				}
				return Container();
			}
		);
	}
}
