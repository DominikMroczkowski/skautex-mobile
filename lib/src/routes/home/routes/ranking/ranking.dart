import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';

class Ranking extends StatefulWidget {
	const Ranking({ Key key }) : super(key: key);

  @override
  createState() => _State();
}

class _State extends State<Ranking> {
	Widget build(context) {
		return DefaultTabController(
			length: 2,
			child: Scaffold(
				appBar: AppBar(
					title: Text('Testy'),
					bottom: TabBar(tabs: <Widget>[
						Tab(icon: Icon(Icons.flag)),
						Tab(icon: Icon(Icons.flag))
					],)
				),
				body: _tabBarView(),
				drawer: HomeDrawer(),
			)
		);
	}

	Widget _tabBarView() {
		return TabBarView(
			children: <Widget>[
				_pitch(),
				Center(child: Text('To implement'))
			],
		);
	}

	Widget _pitch() {
		return Stack(
			fit: StackFit.expand,
			children: <Widget>[
				Container(
					child: Column(
						children: [
							Expanded(child: Container(), flex: 20),
							Expanded(child: Container(margin: EdgeInsets.all(15), decoration: BoxDecoration(border: Border.all(color: Colors.black)),), flex: 80),
						]
					),
					color: Colors.white
				),
				_lines(),
			],
		);
	}

	Widget _lines() {
		return Container(
			margin: EdgeInsets.all(15.0),
			child: Column(
				children: <Widget>[

			],)
		);
	}
}

const List _positions = [
	'Bramkarz',
	'Lewy Środkowy Obrońca',
	'Prawy Środkowy Obrońca',
	'Lewy Obrońca',
	'Pomocnik',
	'Prawy Obrońca',
	'Lewy Pomocnik',
	'Prawy Pomocnik',
	'Napastnik'
];
