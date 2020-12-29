import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/models/contact_detail.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Delete {
	final ContactDetail contactDetail;
	final Function update;

	Bloc(BuildContext context, {@required this.contactDetail, @required this.update}) {
		otp = context;
		item.listen(
			(i) {
			}
		);
	}
}
