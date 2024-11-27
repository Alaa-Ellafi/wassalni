import 'package:flutter/material.dart';

class ChatServicePage extends StatefulWidget {
  @override
  _ChatServicePageState createState() => _ChatServicePageState();
}

class _ChatServicePageState extends State<ChatServicePage> {
  final List<Map<String, String>> _messages = []; // List to store messages
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({"text": text, "isSender": "true", "time": "Just now"});
      });
      _controller.clear();

      // Simulate a reply
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _messages.add({
            "text": "Got it!",
            "isSender": "false",
            "time": TimeOfDay.now().format(context)
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              // Add call functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  message: message["text"]!,
                  isSender: message["isSender"] == "true",
                  time: message["time"]!,
                );
              },
            ),
          ),
          ChatInputField(
            controller: _controller,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

// ChatBubble class
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final String time;

  const ChatBubble({
    required this.message,
    required this.isSender,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isSender ? Colors.red[300] : Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message,
              style: TextStyle(color: isSender ? Colors.white : Colors.black),
            ),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}

// ChatInputField class
class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;

  const ChatInputField({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          // Add "+" button for attachments
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              // Add functionality to attach files
            },
          ),
          // Text input field
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type your message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              textInputAction: TextInputAction.send,
              onSubmitted: onSend, // Send message on Enter
            ),
          ),
          // Emoji button
          IconButton(
            icon: Icon(Icons.emoji_emotions_outlined),
            onPressed: () {
              // Add functionality for emoji picker
            },
          ),
          // Send button
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              onSend(controller.text); // Send message
            },
          ),
        ],
      ),
    );
  }
}
