import 'package:flutter/material.dart';
import 'bloc/bloc.dart' as reports;
import 'package:skautex_mobile/src/helpers/widgets/reports_tile.dart';
import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as info;

class View extends StatelessWidget {
	Widget build(context) {
		final p = reports.Provider.of(context);
		p.fetch();
		final u = info.Provider.of(context);

		return Scaffold(
			body: _reportsList(p),
			appBar: AppBar(
				title: Text('Raporty')
			),
			drawer: HomeDrawer(),
			floatingActionButton: _addButton(u),
		);
	}

	Widget _reportsList(reports.Bloc p) {
		return StreamBuilder(
			stream: p.watcher,
			builder: (context, snapshot) {
				if (!snapshot.hasData) {
					return Center(
						child: CircularProgressIndicator()
					);
				}

				return FutureBuilder(
					future: snapshot.data,
					builder: (context, snapshot) {
						if (!snapshot.hasData) {
							return Center(
								child: CircularProgressIndicator()
							);
						}

						return ListView.builder(
							itemCount: snapshot.data.length,
							itemBuilder: (context, int index) {
								return ReportsTile(
									report: snapshot.data[index]
								);
							}
						);
					}
				);
			}
		);
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

							return FloatingActionButton(
     						onPressed: () {
									Navigator.pushNamed(context, '/home/reports/addReport');
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
