import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:skautex_mobile/src/models/totp_device.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {

	Widget build(context) {
		return Card(
			child: ExpansionTile(
				title: Text('Rozwiń by wyświetlić kod urządzenia OAUTH'),
				children: [
					_info(),
					Row(children: [
						Expanded(child: Container()),
						_children(context),
						Expanded(child: Container()),
					])
				],
				childrenPadding: EdgeInsets.all(5.0)
			),
		);
	}

	Widget _info() {
		return Text('Kliknij na kod by dodać w aplikacji zewnętrznej');
	}

	Widget _children(BuildContext context) {
		return  Row(
			children: [
				Container(child: _QRcodeBuilder(context), height: 200.0, width: 200.0),
			]
		);
	}

	Widget _QRcodeBuilder(BuildContext context) {
		return StreamBuilder(
			stream: Provider.of(context).itemsWatcher,
			builder: (_, AsyncSnapshot<List<TOTPDevice>> snapshot) {
				if (snapshot.hasData) {
					if (snapshot.data.isEmpty)
						return Text('Brak urządzenia OAUTH');
					return _QRcode(snapshot.data.first.configUri);
				}
				return _loading();
			}
		);
	}

	Widget _QRcode(String otpauth) {
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

	_loading() {
		return Container(
			height: 200.0,
			width: 200.0
		);
	}
}
