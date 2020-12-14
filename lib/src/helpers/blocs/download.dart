import 'access.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class Download with Access {
	download(String url) {
		final taskId = FlutterDownloader.enqueue(
 		 	url: url,
  		savedDir: getDownloadsDirectory().toString(),
  		showNotification: true,
  		openFileFromNotification: true,
		);
		return taskId;
	}
}
