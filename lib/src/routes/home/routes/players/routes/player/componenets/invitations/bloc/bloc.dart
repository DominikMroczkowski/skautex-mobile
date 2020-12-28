import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/invitation.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/routes/home/routes/players/bloc/bloc.dart' as playersBloc;

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<Invitation> {
	final Player player;

	Bloc(BuildContext context, {@required this.player}) {
		otp = context;
		final list = player.uri.split('/');
		super.fetch(where: {'player': list[list.length - 2]});
	}
}
