class StoryViewModels {
  final String type;
  final String url;
  final int id;
  final Duration duration;

  StoryViewModels({
    required this.type,
    required this.url,
    required this.id,
    required this.duration});

  factory StoryViewModels.fromJson(Map<String, dynamic> json) {
    Duration storyDuration = Duration(seconds: json["duration"]);

    return StoryViewModels(
      type: json["type"],
      url: json["url"],
      id: json["id"],
      duration: storyDuration,
    );
  }
}
