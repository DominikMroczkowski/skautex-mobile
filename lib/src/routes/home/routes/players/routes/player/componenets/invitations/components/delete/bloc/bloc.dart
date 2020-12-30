import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/models/invitation.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Delete {
	final Invitation invitation;
	final Function update;

	Bloc(BuildContext context, {@required this.invitation, @required this.update}) {
		otp = context;
		item.listen(
			(i) {
				i.then( (_) =>
					update()
				);
			}
		);
	}
}
