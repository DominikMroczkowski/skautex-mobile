import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/home_drawer.dart';

import 'bloc/bloc.dart';

import 'components/logout/logout.dart';
import 'components/change_password/change_password.dart';
import 'components/security_code/sercurity_code.dart';
import 'components/templates/templates.dart';
import 'components/add_template/add_template.dart';

class View extends StatefulWidget {
	const View({ Key key }) : super(key: key);

  @override
  createState() => _View();

}

class _View extends State<View> with SingleTickerProviderStateMixin {

	Widget build(context) {
		final bloc = Provider.of(context);
		var tabController = TabController(length: 2, vsync: this);
		tabController.addListener(() {
			bloc.changeTab(tabController.index);
		});

		return Scaffold(
			body: _tabView(context, bloc, tabController),
			drawer: HomeDrawer(),
			appBar: AppBar(
				title: Text('Opcje'),
				bottom: TabBar(tabs: <Widget>[
						Tab(icon: Icon(Icons.info_sharp)),
						Tab(icon: Icon(Icons.insert_invitation)),
					],
					controller: tabController
				)
			),
			backgroundColor: Colors.white,
			floatingActionButton: _floatingButtonBuilder(bloc),
		);
	}

	Widget _tabView(BuildContext context, Bloc p, tabController) {
		return TabBarView(
			controller: tabController,
			children: <Widget>[
				_body(),
				Templates(reload: p.templates),
			],
		);
	}

	Widget _floatingButtonBuilder(Bloc bloc ) {
		return StreamBuilder(
			stream: bloc.tab,
			builder: (_, snapshot) {
				if (snapshot.hasData && snapshot.data == 1)
						return AddTemplate(reloadTemplates: bloc.reloadTemplates);
				return Container(width: 0.0, height: 0.0);
			}
		);
	}

	_body() {
		return SingleChildScrollView(
			child: Container(
				child: Column(
					children: _children()
				),
				padding: EdgeInsets.all(5),
				color: Colors.white
			)
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

	Widget _padding(Widget child) {
		return Container(
			child: child,
			padding: EdgeInsets.all(5.0)
		);
	}
}
