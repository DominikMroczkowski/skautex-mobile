import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Delete {
	final InvitationTemplate template;
	final Function update;

	Bloc(BuildContext context, {@required this.template, @required this.update}) {
		otp = context;

		item.listen(
			(i) {
				i.then( (i) => update());
			}
		);
	}
}
