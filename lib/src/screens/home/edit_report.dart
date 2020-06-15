import 'package:flutter/material.dart';

import 'package:skautex_mobile/src/blocs/edit_user/bloc.dart' as editUser;

import 'package:skautex_mobile/src/widgets/circular_indicator.dart';
import 'package:skautex_mobile/src/widgets/homeDrawer.dart';
import 'package:skautex_mobile/src/widgets/card_body.dart';
import 'package:skautex_mobile/src/widgets/view_item_list.dart';

import 'package:skautex_mobile/src/models/user.dart';


class EditReport extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		editUser.Provider.of(context).init();
		return Scaffold(
			appBar: AppBar(
				title: Text('Edytuj raport')
			),
			drawer: HomeDrawer(),
		);
	}
}
