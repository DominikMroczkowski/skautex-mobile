import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/contact_detail.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<ContactDetail> {
	final Player player;
	final Stream reload;
	final Function update;

	Bloc(BuildContext context, {@required this.player, @required this.reload, @required this.update}) {
		otp = context;
		super.fetch(uri: player.uri + 'contact_details/');
		reload.listen(
			(i) {
				fetch(uri: player.uri + 'contact_details/');
			}
		);
	}
}
