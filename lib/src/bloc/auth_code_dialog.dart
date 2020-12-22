import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthCodeDialog extends StatelessWidget {
	String otpauth;

	AuthCodeDialog({@required this.otpauth});

	Widget build(context) {
		return AlertDialog(
			title: Text("Kod urządzenia OAUTH  do logowania"),
			content: _body(),
			actions: [
				_ok(context)
			],
		);
	}

	Widget _body() {
		return SizedBox(
			child: Row(
				children: [
					Expanded(child: Container()),
					_QRcode(),
					Expanded(child: Container()),
				],
			),
			width: 200,
			height: 200
		);
	}

	Widget _QRcode() {
		return InkWell(
			child: QrImage(
 				data: otpauth,
 				version: QrVersions.auto,
 				size: 200.0,
			),
			onTap: () {
				launch(otpauth);
			}
		);
	}

	Widget _ok(BuildContext context) {
		return FlatButton(
			child: Text('Ok'),
			onPressed: () {
				Navigator.of(context, rootNavigator: true).pop();
			},
		);
	}
}
