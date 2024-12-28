import 'package:my_trainings_app/models/trainer_model.dart';

class TrainingModel {
  final String id;
  final String title;
  final String imageUrl;
  final String venue;
  final String location;
  final String amount;
  final DateTime fromTime;
  final DateTime toTime;
  final List description;
  final int enrollments;
  final TrainerModel trainer;

  TrainingModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.venue,
    required this.location,
    required this.amount,
    required this.fromTime,
    required this.toTime,
    required this.description,
    required this.enrollments,
    required this.trainer,
  });

  // Method to convert TrainingModel instance to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'venue': venue,
      'location': location,
      'amount': amount,
      'fromTime': fromTime.toIso8601String(),
      'toTime': toTime.toIso8601String(),
      'description': description,
      'enrollments': enrollments,
      'trainer': trainer.toMap(),
    };
  }

  // Method to create a TrainingModel from a map
  factory TrainingModel.fromMap(Map<String, dynamic> map) {
    return TrainingModel(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      venue: map['venue'],
      location: map['location'],
      amount: map['amount'],
      fromTime: DateTime.parse(map['fromTime']),
      toTime: DateTime.parse(map['toTime']),
      description: map['description'],
      enrollments: map['enrollments'],
      trainer: TrainerModel.fromMap(map['trainer']),
    );
  }
}
