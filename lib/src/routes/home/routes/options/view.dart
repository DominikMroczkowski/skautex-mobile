import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/home_drawer.dart';

import 'bloc/bloc.dart';
import 'components/logout/logout.dart';
import 'components/change_password/change_password.dart';
import 'components/security_code/sercurity_code.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);
		return Scaffold(
			appBar: AppBar(
				title: Text('Opcje')
			),
			drawer: HomeDrawer(),
			body: SingleChildScrollView(
				child: Container(
					child: Column(
						children: _children()
					),
					padding: EdgeInsets.all(5),
					color: Colors.white
				),
			),
			backgroundColor: Colors.white
		);
	}

	List<Widget> _children() {
		return [
			SecurityCode(),
			Row(children: [ChangePassword()]),
			Row(children: [
				Expanded(child: Container()),
				Logout(),
				Expanded(child: Container()),
			],)
		];
	}
}
