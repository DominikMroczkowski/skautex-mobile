class BookingType {
	String uri;
	String name;

	BookingType({this.uri, this.name});

	BookingType.fromJson(Map<String, dynamic> parsedJson) :
		uri   = parsedJson['url'],
		name  = parsedJson['name'];

	Map<String, dynamic> toJson() {
		return <String, dynamic> {
			'url'   : uri,
			'name'  : name
		};
	}
}
