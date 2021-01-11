import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/helpers/blocs/delete.dart';

class Bloc extends Delete {
	final Function update;

	Bloc(BuildContext context, {this.update}) {
		otp = context;

		item.listen(
			(Future i) {
				i.then((_) {update();});
			}
		);
	}
}
