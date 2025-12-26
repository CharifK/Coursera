class TimeEntry {
  final String id;
  final String projectId;
  final String taskId;
  final DateTime date;
  final double totalTime;
  final String note;

  TimeEntry({
    required this.id,
    required this.projectId,
    required this.taskId,
    required this.date,
    required this.totalTime,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'projectId': projectId,
        'taskId': taskId,
        'date': date.toIso8601String(),
        'totalTime': totalTime,
        'note': note,
      };

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      projectId: json['projectId'],
      taskId: json['taskId'],
      date: DateTime.parse(json['date']),
      totalTime: (json['totalTime'] as num).toDouble(),
      note: json['note'],
    );
  }
}
