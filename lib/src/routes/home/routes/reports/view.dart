import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'bloc/bloc.dart' as reports;
import 'package:skautex_mobile/src/helpers/widgets/home_drawer.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as info;

import 'componenets/tile.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final p = reports.Provider.of(context);
		final u = info.Provider.of(context);

		return Scaffold(
			body: _reportsList(p),
			appBar: AppBar(
				title: Text('Raporty')
			),
			drawer: HomeDrawer(),
			floatingActionButton: _addButton(u, p),
		);
	}

	Widget _reportsList(reports.Bloc bloc) {
		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: (i) => ReportsTile(report: i, bloc: bloc)
		);
	}

	Widget _addButton(info.Bloc u, reports.Bloc bloc) {
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
									Navigator.pushNamed(context, '/home/reports/addReport', arguments: bloc.reloadReports);
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
