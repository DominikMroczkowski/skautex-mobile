import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Delete {
	final Player player;
	final Function updateUpperPage;

	Bloc(BuildContext context, {@required this.player, @required this.updateUpperPage}) {
		otp = context;
		item.listen(
			(i) {
				i.then((i) {
					updateUpperPage != null ? updateUpperPage() : null;
					Navigator.of(context).pop();
				});
			}
		);
	}
}
