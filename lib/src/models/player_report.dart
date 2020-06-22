class PlayerReport {
	String uri;
	String report;
	String player;
	int rating;
	String description;
	String status;

	PlayerReport({String uri, String report, String player, int rating, String description, String status}) :
		uri = uri ?? '',
		report = report ?? '',
		player = player ?? '',
		rating = rating ?? 0,
		description = description ?? '',
		status = status ?? '';

	PlayerReport.fromJson(Map<String, dynamic> parsedJson) :
		uri         = parsedJson['url'] ?? '',
    report      = parsedJson['report'] ?? '',
		player      = parsedJson['player']['name'] ?? '',
   	rating      = parsedJson['rating'] ?? 0,
   	description = parsedJson['description'] ?? '',
   	status      = parsedJson['status'] ?? '';

	toJson() {
		return <String, dynamic> {
			'url' : uri,
			'report' : report,
			'player' : player,
			'rating' : rating,
			'description' : description,
			'status' : status
		};
	}

	Map<String, dynamic> toPost() {
		Map map = toJson();
		map.remove('url');
		print(map.toString());
		return map;
	}
}
