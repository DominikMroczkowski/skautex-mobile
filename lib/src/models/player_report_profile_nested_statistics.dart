class PlayerReportProfileNestedStatistics {
	String name;
	int value;

	PlayerReportProfileNestedStatistics({this.name, this.value});

	toJson() {
		return {
			'name' : name,
			'value' : value
		};
	}

	PlayerReportProfileNestedStatistics.fromJson(Map<String, dynamic> parsedJson) :
		name = parsedJson['name'],
		value = parsedJson['value'];
}
