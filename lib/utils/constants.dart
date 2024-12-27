import 'package:my_trainings_app/models/training_model.dart';

import '../models/trainer_model.dart';

class Constants {
  // Routes
  static const String homeRoute = '/home';
  static const String trainingDetailsRoute = '/trainingDetails';

  // Titles
  static const String trainingsTitle = 'Trainings';
  static const String trainingDetailsTitle = 'Training Details';

  // Labels
  static const String highlightsLabel = 'Highlights';
  static const String filterLabel = 'Filter';
  static const String earlyBirdLabel = 'Early Bird!';
  static const String fillingFastLabel = 'Filling Fast!';
  static const String enrolNowLabel = 'Enrol Now';
  static const String enrolledLabel = 'Enrolled!';
  static const String viewDetailsLabel = 'View Details';
  static const String keynoteSpeakerLabel = 'Keynote Speaker';
  static const String heresWhyLabel = "Here's why you should enrol";
  static const String cancelLabel = 'cancel';
  static const String sortAndFilterLabel = 'Sort and Filters';
  static const String sortByLabel = 'Sort by';
  static const String locationLabel = 'Location';
  static const String trainingNameLabel = 'Training name';
  static const String trainerLabel = 'Trainer';

  // Service's labels

  // Asset paths
  static const String logoPath = 'assets/logo.png';

  //sample training model
  static TrainingModel trainingModel = TrainingModel(
    id: 'id',
    title: 'Safe Scrum Master',
    imageUrl:
        'https://images.unsplash.com/photo-1542744095-fcf48d80b0fd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHdvcmt8ZW58MHx8MHx8fDA%3D',
    venue: 'Coventional Hall, 23rd street',
    location: 'Brooklyn, NY',
    amount: '\$299',
    fromTime: DateTime.now(),
    toTime: DateTime.now().add(const Duration(days: 3)),
    description: '''
        Scrum Master training is designed to equip participants with the knowledge and skills necessary to effectively facilitate Scrum practices within teams. The training typically covers the following key areas:
\n1. Understanding the Scrum Framework: Participants learn about the fundamental principles of Scrum, including team roles, events, and artifacts. This foundational knowledge is crucial for guiding teams in applying Scrum effectively.
\n2. Team Facilitation: The training emphasizes the role of the Scrum Master as a facilitator, helping teams improve their collaboration and productivity. Participants learn techniques for managing team dynamics and resolving conflicts.
\n3. Agile Principles: The course provides insights into Agile methodologies, enabling participants to understand how Scrum fits within the broader Agile landscape.
\n4. Practical Application: Through interactive exercises and real-world examples, attendees gain hands-on experience in applying Scrum practices. This includes organizing and leading daily stand-ups, sprint planning meetings, and retrospectives.
\n5. Certification Preparation: Most courses prepare participants for certification exams, such as the Certified ScrumMaster (CSM) offered by Scrum Alliance. Successful completion of the course typically includes a test that participants must pass to earn their certification.
\n6. Networking Opportunities: Participants often gain access to local user groups and online communities, enhancing their professional network within the Agile community.
        ''',
    enrollments: 45,
    trainer: TrainerModel(
      id: 'id',
      name: 'Wendy Byrde',
      url:
          'https://plus.unsplash.com/premium_photo-1708271135038-35e776cce861?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjl8fGZhY2V8ZW58MHx8MHx8fDA%3D',
    ),
  );
}
