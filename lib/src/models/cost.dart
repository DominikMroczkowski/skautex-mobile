class Cost {
	String uri;
	String name;
	String cost;
	String date;
	String owner;
	String file;

	Cost({this.uri, this.name, this.owner, this.cost, this.date, this.file});

	Cost.fromJson(Map<String, dynamic> parsedJson) :
		uri   = parsedJson['url'] ?? '',
		name  = parsedJson['name'] ?? '',
		cost  = parsedJson['money'] ?? '',
		date  = parsedJson['record_date'] ?? '',
		file  = parsedJson['file'] ?? '';

	Map<String, dynamic> toJson() {
		return <String, dynamic> {
			'url'   : uri,
			'name'  : name,
			'cost'  : cost,
			'date'  : date,
			'owner' : owner,
			'file'  : file
		};
	}

	Map<String, dynamic> toPost() {
		var map = toJson();
		map.remove('url');
		map.remove('owner');
		return map;
	}
}
