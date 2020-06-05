import 'package:flutter/material.dart';
import '../../blocs/info/bloc.dart' as info;
import '../../models/user.dart';
import '../../models/permissions.dart';
import '../../helpers/navCard.dart';

enum _Headers {
	main, role, options
}

class Home extends StatelessWidget {

	Widget build(context) {
		return Scaffold(
			body: SafeArea(
				child: ListView(
					children: <Widget>[
						_gridSegment(Data.main(), context, _Headers.main),
						_gridSegment(Data.role(), context, _Headers.role),
						_gridSegment(Data.options(), context, _Headers.options)
					],
					padding: EdgeInsets.all(10.0)
				)
			),
			appBar: AppBar(
				title: Text('Skautex')
			)
		);
	}

	Widget _roleHeader(BuildContext c) {
		final u = info.Provider.of(c);

		return StreamBuilder(
			stream: u.me,
			builder: (context, snapshot) {
				if (!snapshot.hasData) {
					return Container(width: 0.0, height: 0.0);
				}

				return FutureBuilder(
					future: snapshot.data,
					builder: (context, snapshot) {
						if (snapshot.hasData) {
							return _header("Narzędzia ${(snapshot.data as User).groups}");
						}
						return _header("Narzędzia");
					}
				);
			}
		);
	}

	Widget _header(String name) {
		return Container( child: Column( children: [
			Container(
				child: Align(
					child: Text(
						name,
						style: TextStyle(
							fontSize: 24.0
						)
					),
					alignment: Alignment.topLeft
				),
				padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)
			),
			Container(
				child: Divider(),
				padding: EdgeInsets.only(bottom: 5.0)
			),
			],
		)
		);
	}

	Widget _gridSegment(List<DashCard> l, BuildContext c, _Headers header) {
		final p = info.Provider.of(c);
		return StreamBuilder(
			stream: p.permissions,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, snapshot) {
							if (snapshot.hasData) {
								List<Widget> toShow = [];
								l.forEach((i) {
									if ((snapshot.data as Permissions).XOR(i.perms)) {
										toShow.add(_iconCard(i, context));
									}
								});
								if (toShow.length == 0) {
									return Container(width: 0.0, height: 0.0);
								}

								Widget h;

								switch (header)  {
								case _Headers.main:
									h = _header("Narzędzia główne");
									break;
								case _Headers.role:
									h = _roleHeader(context);
									break;
								case _Headers.options:
									h = _header("Opcje");
									break;
								}

								return Column(
									children: [
										h,
										GridView.count(
						          			crossAxisCount: 4,
						          			childAspectRatio: 1.0,
						          			mainAxisSpacing: 4.0,
						          			crossAxisSpacing: 4.0,
										children: toShow,
										shrinkWrap: true,
										physics: NeverScrollableScrollPhysics()
										)
									]
								);
							}
							return Container(width: 0.0, height: 0.0);
						}
					);
				}
				return Container(width: 0.0, height: 0.0);
			}
		);
	}



	Widget _iconCard(DashCard card, BuildContext c) {
		return Container(
	     		child: InkWell(
				child: Card(
	     				child: Align(
	     			 		alignment: Alignment.center,
	     					child: Column(
	     						children: [
	     							Expanded( child: Container()),
	     								Icon(
	           								card.icon,
	           								color: Colors.grey[700],
	         							),
	     								FittedBox(
	         								fit: BoxFit.scaleDown, child: Text(
	     									card.text,
	     									overflow: TextOverflow.ellipsis,
	     									maxLines: 1,
	     								)
	     							),
	     							Expanded( child: Container()),
	     						],
	     					)
	     				)
				),
	     			onTap: () {
	     				Navigator.of(c).pushNamed(card.path);
	             	    	}
	     		),
	     		constraints: BoxConstraints(maxWidth: 60, maxHeight: 60)
	     	);
	}
}

