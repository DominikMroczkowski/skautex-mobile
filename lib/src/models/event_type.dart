class EventType {
	String uri;
	String name;

	EventType({this.uri, this.name});

	EventType.fromJson(Map<String, dynamic> parsedJson) :
		uri   = parsedJson['url'],
		name  = parsedJson['name'];

	Map<String, dynamic> toJson() {
		return <String, dynamic> {
			'url'   : uri,
			'name'  : name
		};
	}
}
