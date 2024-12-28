import 'package:intl/intl.dart';

class HomeService {

  ///Method to format the date in [3Feb - 4Feb] format
  String formatHighlightsDateRange(DateTime start, DateTime end) {
    final startFormat = DateFormat('dd MMM');
    final endFormat = DateFormat('dd MMM');

    // Check if the month is the same for both dates
    if (start.month == end.month && start.year == end.year) {
      return '${startFormat.format(start)} - ${endFormat.format(end)}';
    } else {
      return '${startFormat.format(start)} - ${endFormat.format(end)}';
    }
  }

  ///Method to format the date in [Feb 3 - Feb 4, 2025] format
  String formatEnrollDateRange(DateTime start, DateTime end) {
    DateFormat monthDayYearFormat = DateFormat('MMM d');

    String startFormatted = monthDayYearFormat.format(start);
    String endFormatted = monthDayYearFormat.format(end);

    return '$startFormatted - $endFormatted, ${start.year}';
  }

  ///Method to format the date in [8:00 AM - 10:00 AM] format
  String formatEnrollTimeRange(DateTime fromTime, DateTime toTime) {
    final DateFormat formatter = DateFormat('hh:mm a');

    String formattedFromTime = formatter.format(fromTime);
    String formattedToTime = formatter.format(toTime);

    return '$formattedFromTime - $formattedToTime';
  }
}
