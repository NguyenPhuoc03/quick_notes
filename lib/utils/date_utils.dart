class Date {
  static List<String> monthsName = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  static String now() {
    DateTime now = DateTime.now();
    String month = monthsName[now.month - 1];
    return "${month} ${now.day.toString().padLeft(2, "0")},${now.year} ${now.hour}:${now.minute} ";
  }

  static String formatDayMonth() {
    DateTime now = DateTime.now();
    String month = monthsName[now.month - 1];
    return "${month} ${now.day.toString().padLeft(2, "0")}";
  }
}
