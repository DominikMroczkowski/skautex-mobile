final contactTypes = ['phone', 'email'];

class ContactDetail {
	String uri;
	String type;
	String value;
	String contentObject;

	ContactDetail({this.uri, this.type, this.value, this.contentObject});

	ContactDetail.fromJson(Map<String, dynamic> parsedJson) :
		uri   = parsedJson['url'] ?? '',
		type = parsedJson['type'] ?? '',
		value = parsedJson['value'] ?? '',
		contentObject = parsedJson['content_object'] ?? '';

	Map<String, dynamic> toJson() {
		return <String, dynamic> {
			'url'   : uri,
			'type'  : type,
			'value'  : value,
			'content_object'  : contentObject,
		};
	}

	Map<String, dynamic> toPost() {
		var map = toJson();
		map.remove('url');
		map.remove('owner');
		return map;
	}
}
