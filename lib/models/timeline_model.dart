class TimelineModel {
  final String uid;
  final bool unlock;
  final String date;
  final String time;
  final String command;
  final String displayName;

  TimelineModel(
      {this.command,
      this.displayName,
      this.date,
      this.time,
      this.uid,
      this.unlock});
}
