class ResponseList<T> {
	String next;
	String previous;
	int count;
	List<T> results;

	ResponseList(this.next, this.previous, this.count, this.results);

	ResponseList.fromJson(Map<String, dynamic> parsedJson):
		next = parsedJson['next'],
		previous= parsedJson['access'],
		count = parsedJson['count'],
		results = List<T>();
}
