import 'package:flutter/material.dart';
import 'package:chatbot_app/models/chat_model.dart';
import 'package:chatbot_app/services/chat_service.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  final ChatService _chatService = ChatService();

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    addMessage(ChatMessage(message: message, isUser: true));
    final response = await _chatService.getChatResponse(message);
    addMessage(ChatMessage(message: response, isUser: false));
  }
}
