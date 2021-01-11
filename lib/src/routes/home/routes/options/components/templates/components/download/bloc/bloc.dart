import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/download.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'package:skautex_mobile/src/models/file.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Download {
	final InvitationTemplate template;

	download() {downloadItem(File(uri: template.uri + 'download/', file: template.templateFile ));}

	Bloc(BuildContext context, {@required this.template}) {
		otp = context;
	}
}
