import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as info;
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';
import 'package:skautex_mobile/src/helpers/widgets/users_tile.dart';

import 'bloc/bloc.dart' as users;

class View extends StatelessWidget {

	Widget build(context) {
		final p = users.Provider.of(context);
		p.fetch();
		final u = info.Provider.of(context);

		return Scaffold(
			body: _userList(p),
			appBar: AppBar(
				title: Text('Użytkownicy')
			),
			drawer: HomeDrawer(),
			floatingActionButton: _addButton(u),
		);
	}

	Widget _userList(users.Bloc p) {
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
								return UserTile(
									user: snapshot.data[index]
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
									Navigator.pushNamed(context, '/home/users/addUser');
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
