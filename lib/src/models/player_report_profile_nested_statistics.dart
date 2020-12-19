class Statistic {
	String name;
	int value;

	Statistic({this.name, this.value});

	toJson() {
		return {
			'name' : name,
			'value' : value
		};
	}

	Statistic.fromJson(Map<String, dynamic> parsedJson) :
		name = parsedJson['name'],
		value = parsedJson['value'];
}
