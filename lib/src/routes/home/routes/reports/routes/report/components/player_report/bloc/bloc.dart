import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/helpers/blocs/update.dart';
import 'package:skautex_mobile/src/models/player_report.dart';
import 'package:skautex_mobile/src/models/report.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<PlayerReport> {

	Bloc(BuildContext context, Report report) {
		fetch(uri: report.uri + '/player_report');
	}


	dispose() {
		super.dispose();
	}
}
