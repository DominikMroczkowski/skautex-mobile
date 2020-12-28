import 'package:flutter/material.dart';
import '../../bloc/bloc.dart' as home;
import '../../models/permissions.dart';
import '../../helpers/navCard.dart';

class Home extends StatelessWidget {
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: ListView(
					children: <Widget>[
						_gridSegment(Data.data(), context,),
					],
					padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
				)
			),
			appBar: AppBar(
				title: Text('Skautex')
			)
		);
	}

	Widget _gridSegment(List<DashCard> l, BuildContext c) {
		final p = home.Provider.of(c);
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

								return Column(
									children: [
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
			child: Card(
	   		child: InkWell(
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
	     			),
	     			onTap: () {
	     				Navigator.of(c).pushNamed(card.path);
						}
	     		),
				),
	     	constraints: BoxConstraints(maxWidth: 60, maxHeight: 60)
	    );
	}
}



