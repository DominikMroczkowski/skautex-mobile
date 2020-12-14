class File {
	String uri;
	String file;

	File(this.uri, this.file);

	File.fromJson(Map<String, dynamic> parsedJson) :
		uri = parsedJson['url'],
		file = parsedJson['file'];
}
