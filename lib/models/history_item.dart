class HistoryItem {
  final String imagePath;
  final String result;
  final double confidence;
  final DateTime timestamp;

  HistoryItem({
    required this.imagePath,
    required this.result,
    required this.confidence,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'result': result,
      'confidence': confidence,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      imagePath: json['imagePath'],
      result: json['result'],
      confidence: json['confidence'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
