import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chatbot_app/models/chat_model.dart';

class ChatService {
  final String apiKey = "can't push it";

  Future<String> getChatResponse(String message) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': message}
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      print('Failed to load response: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load response');
    }
  }
}
