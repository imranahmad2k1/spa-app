class Topic {
  final String id;
  final String name;
  final String subject;
  int understandingLevel;
  final Topic? dependeeTopic;

  Topic({
    required this.id,
    required this.name,
    required this.subject,
    this.understandingLevel = 7,
    this.dependeeTopic,
  });
}
