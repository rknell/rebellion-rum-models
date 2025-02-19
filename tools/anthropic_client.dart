import 'dart:convert';
import 'package:http/http.dart' as http;

/// A simple client for interacting with the Anthropic API
class AnthropicClient {
  final String apiKey;
  final String model;
  static const String baseUrl = 'https://api.anthropic.com/v1/messages';
  static const String apiVersion = '2023-06-01';

  AnthropicClient({
    required this.apiKey,
    this.model = 'claude-3-5-sonnet-latest',
  });

  /// Sends a message to the Anthropic API and returns the response
  Future<Map<String, dynamic>> sendMessage({
    required String message,
    int maxTokens = 1024,
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'x-api-key': apiKey,
        'anthropic-version': apiVersion,
        'content-type': 'application/json',
      },
      body: jsonEncode({
        'model': model,
        'max_tokens': maxTokens,
        'messages': [
          {'role': 'user', 'content': message}
        ],
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to send message: ${response.statusCode} ${response.body}');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}

/// Example usage:
void main() async {
  const apiKey = '';

  final client = AnthropicClient(apiKey: apiKey);

  try {
    final response = await client.sendMessage(message: 'Hello, world');
    print('Response: ${response['content'][0]['text']}');
  } catch (e) {
    print('Error: $e');
  }
}
