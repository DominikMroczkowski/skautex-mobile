import 'package:flutter/material.dart';
import '../helpers/navCard.dart';

import '../models/permissions.dart';
import '../models/user.dart';

import '../blocs/user/bloc.dart' as user;

class HomeDrawer extends StatelessWidget {
	Widget build(c) {
		final u = user.Provider.of(c);

		return Drawer(
			child: StreamBuilder(
				stream: u.permissions,
				builder: (context, snapshot) {
					if (snapshot.hasData) {
						return FutureBuilder(
							future: snapshot.data,
							builder: (context, snapshot) {
								if (snapshot.hasData) {
									List<Widget> toShow = [];
									List<Widget> tmp = [];
									<List<DashCard>>[Data.main(), Data.role(), Data.options()].forEach(
										(i) { i.forEach( (j) {
											if ((snapshot.data as Permissions).XOR(j == null ? Permissions.toXOR() : j.perms)) {
												tmp.add(_element(j, context));
											}
											}
										);
										if (tmp.isNotEmpty) {
											tmp.add(Divider());
											toShow = toShow + tmp;
										}
										tmp = [];
										}
									);

									Widget column;
									column = Column(children: toShow);

									if (toShow.length == 0) {
										return Container(width: 0.0, height: 0.0);
									}

									return ListView(
      										padding: EdgeInsets.all(0.0),
          									children: <Widget> [
											_header(c),
											column
          									],
        								);
								}
								return Container(height: 0.0, width: 0.0);
							}
						);
					}
					return Container(height: 0.0, width: 0.0);
				}
			)
		);
	}

	Widget _header(BuildContext c) {
		return Container(child: DrawerHeader(
              		child: Row(children: [
				Container(
					height: 70.0,
					width: 70.0,
                    			child: CircleAvatar(
						child: _initials(c),
						radius: 7.0
					)
				),
				Container(
					width: 10
				),
				_nameHeader(c)
			]
			),

              		decoration: BoxDecoration(
                		color: Colors.white,
              		),
            		),
                    	height: 120.0,
		);
	}

	Widget _initials(BuildContext c) {
		final u = user.Provider.of(c);
		final double fontSize = 20;

		return StreamBuilder(
			stream: u.me,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, snapshot) {
							if (snapshot.hasData) {
								User u = (snapshot.data as User);
								String first = u.firstName ?? '';
								String last = u.lastName ?? '';
								String name;

								if (first != '' && last != '') {
									name = first[0] + last[0];
								} else if (first != '' && last == '') {
									name = first[0];
								} else if (first == '' && last != '') {
									name = last[0];
								} else {
									name = '';
								}
								return Text(name, style: TextStyle( fontSize: fontSize));

							}
							return Text('');
						}
					);
				}
				return Text('');
			}
		);

	}

	Widget _nameHeader(BuildContext c) {
		return Expanded(
			child: Container(
				child: Column(
					children: [
						Align(
							alignment: Alignment.centerLeft,
							child: FittedBox(
		    						fit: BoxFit.scaleDown,
								child: _name(c)
							)
						),
						Align(
							alignment: Alignment.centerLeft,
							child: FittedBox(
								fit: BoxFit.scaleDown,
								child: _group(c)
							)
						)
					]
				)
			)
		);
	}

	Widget _name(BuildContext context) {
		final u = user.Provider.of(context);
		final double fontSize = 20;

		return StreamBuilder(
			stream: u.me,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, snapshot) {
							if (snapshot.hasData) {
								User u = (snapshot.data as User);
								String first = u.firstName ?? '';
								String last = u.lastName ?? '';
								String name;

								if (first != '' && last != '') {
									name = first + ' ' + last;
								} else if (first != '' && last == '') {
									name = first;
								} else if (first == '' && last != '') {
									name = last;
								} else {
									name = "Brak imienia";
								}

								return _textHeader(
									name,
									fontSize
								);
							}
							return _textHeader("Ładowanie", fontSize);
						}
					);
				}
				return _textHeader("Oczekiwanie na dane", fontSize);
			}
		);
	}

	Widget _group(BuildContext context) {
		final u = user.Provider.of(context);
		final double fontSize = 15;

		return StreamBuilder(
			stream: u.groups,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder<List<String>>(
						future: snapshot.data,
						builder: (context, snapshot) {
							if (snapshot.hasData) {
								List<String> data = snapshot.data;
								return _textHeader(
									data == null || data.isEmpty ? "Brak grupy" : data[0],
									fontSize
								);
							}
							return _textHeader("Ładowanie", fontSize);
						}
					);
				}
				return _textHeader("Oczekiwanie na dane", fontSize);
			}
		);
	}

	Widget _textHeader(String text, double fontSize) {
		return Text(
			text,
			overflow: TextOverflow.ellipsis,
			maxLines: 1,
			style: TextStyle( fontSize: fontSize)
		);
	}

	Widget _element(DashCard i, BuildContext c) {
		return ListTile(
       			title: Text(i.text, style: TextStyle(color: _currentRouteEquals(c, i.path) ? Colors.black : Colors.grey[700])),
			leading: Icon(
      				i.icon,
      				color: Colors.grey[700],
    			),
			dense: true,
			enabled: !_currentRouteEquals(c, i.path),
        	      	onTap: () {
				Navigator.of(c).pushNamed(i.path);
        	      	},
        	);
	}

	bool _currentRouteEquals(context, String path) {
 		var p;
		Navigator.of(context).popUntil((route) {
			p = route.settings.name;
			return true;
		});

    		return p == path;
	}
}
