class ChatMessage {
  final String id;
  final String colectaId;
  final String senderName;
  final String text;
  final DateTime timestamp;
  final bool isOrganizer;

  const ChatMessage({
    required this.id,
    required this.colectaId,
    required this.senderName,
    required this.text,
    required this.timestamp,
    this.isOrganizer = false,
  });
}
