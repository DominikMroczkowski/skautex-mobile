import 'package:flutter/material.dart';


import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';
import 'package:skautex_mobile/src/helpers/widgets/card_body.dart';
import 'package:skautex_mobile/src/helpers/widgets/view_item_list.dart';

import 'package:skautex_mobile/src/models/user.dart';


class EditReport extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Edytuj raport')
			),
			drawer: HomeDrawer(),
		);
	}
}
