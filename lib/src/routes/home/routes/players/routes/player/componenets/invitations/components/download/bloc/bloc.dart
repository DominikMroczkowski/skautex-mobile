import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/download.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'package:skautex_mobile/src/models/invitation.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Download {
	final Invitation invitation;

	Bloc(BuildContext context, {this.invitation}) {
		otp = context;
	}

	download() {
		downloadItem(
			File(
				uri: invitation.uri + '/download',
				file: 'zaproszenie_${invitation.player.toString()}'
			)
		);
	}

	dispose() {
	}
}
