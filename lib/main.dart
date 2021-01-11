import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'src/main.dart';

initialize() async {
	await FlutterDownloader.initialize(
 		debug: true
	);
}

void main() async {
	await initialize();
	runApp(App());
}
