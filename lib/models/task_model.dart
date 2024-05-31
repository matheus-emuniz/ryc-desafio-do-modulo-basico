import 'dart:math';

class TaskModel {
  String _id;
  final String title;
  final String description;
  final DateTime date;
  bool completed;
  bool failed;

  TaskModel({
    id,
    this.description = '',
    required this.title,
    required this.date,
    this.completed = false,
    this.failed = false,
  }) : _id = id ?? Random().nextDouble().toString();

  String get id => _id;
  set id (newId) => _id = newId;

  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  get remainingDays => _daysBetween(
    DateTime.now(),
    date,
  );

  void completeTask() {
    completed = true;
  }

  void failTask() {
    failed = true;
  }

  factory TaskModel.fromJson(String id, Map<String, dynamic> jsonData) {
    return TaskModel(
      id: id,
      title: jsonData['title'],
      date: DateTime.parse(jsonData['date']),
      description: jsonData['description'],
      completed: jsonData['completed'],
      failed: jsonData['failed'],
    );
  }
}
