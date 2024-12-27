import 'package:intl/intl.dart';

class HomeService{

  String formatHighlightsDateRange(DateTime start, DateTime end) {
    // Format the start and end dates
    final startFormat = DateFormat('dd MMM'); // e.g., "30 Oct"
    final endFormat = DateFormat('dd MMM');   // e.g., "31 Oct"

    // Check if the month is the same for both dates
    if (start.month == end.month && start.year == end.year) {
      return '${startFormat.format(start)} - ${endFormat.format(end)}';
    } else {
      return '${startFormat.format(start)} - ${endFormat.format(end)}'; // You can customize this further if needed
    }
  }

  String formatEnrollDateRange(DateTime start, DateTime end) {
    // Create a DateFormat instance for the desired format
    DateFormat monthDayYearFormat = DateFormat('MMM d');

    // Format both dates
    String startFormatted = monthDayYearFormat.format(start);
    String endFormatted = monthDayYearFormat.format(end);

    // Return the formatted string in the desired format
    return '$startFormatted - $endFormatted, ${start.year}';
  }

  String formatEnrollTimeRange(DateTime fromTime, DateTime toTime) {
    // Define the time format
    final DateFormat formatter = DateFormat('hh:mm a'); // 08:30 am format

    // Format both DateTime objects
    String formattedFromTime = formatter.format(fromTime);
    String formattedToTime = formatter.format(toTime);

    // Return the formatted time range
    return '$formattedFromTime - $formattedToTime';
  }


}