import 'package:flutter/material.dart';
import '../../widgets/homeDrawer.dart';

class Ranking extends StatefulWidget {
	const Ranking({ Key key }) : super(key: key);

  @override
  createState() => _State();
}

class _State extends State<Ranking> {
	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Testy')
			),
			drawer: HomeDrawer(),
		);
	}
}
