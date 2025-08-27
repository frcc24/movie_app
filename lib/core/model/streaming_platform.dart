class StreamingPlatform {
  final String name;
  final String type;
  final String? logoUrl;
  final String? deepLink;

  StreamingPlatform({
    required this.name,
    required this.type,
    this.logoUrl,
    this.deepLink,
  });

  factory StreamingPlatform.fromJson(Map<String, dynamic> json) {
    return StreamingPlatform(
      name: json['name'],
      type: json['type'],
      logoUrl: json['logoUrl'],
      deepLink: json['deepLink'],
    );
  }
}
