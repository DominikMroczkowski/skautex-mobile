import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';
import 'package:skautex_mobile/src/models/invitation.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Add<Invitation> {
	final GlobalKey<NavigatorState> navigator;

	Bloc(BuildContext context, {this.navigator}) {
		otp = context;
	}
}
