class MessageModel {
  String ? message;
  String ? response;

  MessageModel({
    required this.message,
    required this.response,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      response: json['response'],
    );
  }
}