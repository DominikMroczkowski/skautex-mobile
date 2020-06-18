import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/blocs/mixins/item_list.dart';
import '../../models/player.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<Player> {
	Bloc(BuildContext context) {
		otp = context;
	}
}
