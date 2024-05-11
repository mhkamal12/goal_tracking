import 'package:intl/intl.dart';

class GoalModel {
  final int id;
  final String title;
  final String? description;
  final String date;
  final int priority;

  GoalModel({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'priority': priority,
    };
  }

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    // format the date into 'dd/MM/yyyy' by intl package
    final date = map['date'];
    final dateFormatted = DateFormat('dd/MM/yyyy').format(DateTime.parse(date));

    return GoalModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: dateFormatted,
      priority: map['priority'],
    );
  }
}
