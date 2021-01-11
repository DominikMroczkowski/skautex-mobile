import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/invitation.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<Invitation> {
	final Player player;
	final Stream reload;

	update() {
		_fetch();
	}

	_fetch() {
		final list = player.uri.split('/');
		super.fetch(where: {'player': list[list.length - 2]});
	}

	Bloc(BuildContext context, {@required this.player, @required this.reload}) {
		otp = context;
		_fetch();
		reload.listen((_) => _fetch());
	}
}
