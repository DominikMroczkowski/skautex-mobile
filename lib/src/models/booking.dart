class Booking {
	String uri;
	String name;
	BookingType type;

	Booking({this.uri, this.name, this.type});

	Booking.fromJson(Map<String, dynamic> parsedJson) :
		uri   = parsedJson['url'],
		name  = parsedJson['name'],
		type  = BookingType(name: parsedJson['type']['url'], uri: parsedJson['type']['url']);

	Map<String, dynamic> toJson() {
		return <String, dynamic> {
			'url'   : uri,
			'name'  : name,
			'type'  : type.uri
		};
	}

	Map<String, dynamic> toPost() {
		var map = toJson();
		map.remove('url');
		map.remove('owner');
		return map;
	}
}

class BookingType {
	String uri;
	String name;
	BookingType({this.name, this.uri});
}
