class NotesModel {
  String title;
  String subtitle;
  String noteId;
  String timestamp;
  String userId;

  NotesModel({
    required this.title,
    required this.subtitle,
    required this.noteId,
    required this.timestamp,
    required this.userId,
  });
  Map<String, dynamic> toMap() {
    return {
      'noteId': this.noteId,
      'timestamp': this.timestamp,
      'title': this.title,
      'subtitle': this.subtitle,
      'userId': this.userId,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      noteId: map['noteId'] as String,
      timestamp: map['timestamp'] as String,
      userId: map['userId'] as String,
    );
  }
}
