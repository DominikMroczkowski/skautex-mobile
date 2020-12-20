import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<Player> {
	final GlobalKey<NavigatorState> navigator;

	final _reloadPlayers = BehaviorSubject<bool>();

	final _where = {
		'is_active': true.toString()
	};

	reloadPlayers() {
		_reloadPlayers.sink.add(true);
	}

	Bloc(BuildContext context, {@required this.navigator}) : super(paging: 8) {
		otp = context;
		_reloadPlayers.stream.listen(
			(i) {
				super.fetch(where: _where);
			}
		);

		super.fetch(where: _where);
	}
}
