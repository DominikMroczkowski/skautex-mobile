import 'package:flutter/material.dart';
import '../../widgets/homeDrawer.dart';

class Home extends StatelessWidget {

	Widget build(context) {

		return Scaffold(
			body: SafeArea(
				child: Container()
			),
			appBar: AppBar(
				title: Text('Skautex')
			),
			drawer: HomeDrawer()
		);
	}
}
