import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/player_report.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<PlayerReport> {
	final Player player;

	_fetch() {
		var i = player.uri.split('/');
		i.removeLast();
		final index = i.removeLast();
		i.removeLast();
		var j = i.join('/');
		fetch(uri: (j + '/player_reports/'), where: {'player': index});
	}

	Bloc(BuildContext context, {@required this.player}) {
		otp = context;
		_fetch();
	}
}
