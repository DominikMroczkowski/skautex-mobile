class File {
	String uri;
	String file;
	String postUri;

	File({this.uri, this.file, this.postUri});

	File.fromJson(Map<String, dynamic> parsedJson) :
		uri = parsedJson['url'],
		file = parsedJson['file'];
}
