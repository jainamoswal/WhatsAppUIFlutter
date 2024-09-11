import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/chat_model.dart';
import '../widgets/chat_tile.dart';
import 'dart:math';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<ChatModel> chatList = [];
  List<String> sentences = [];

  @override
  void initState() {
    super.initState();
    loadSentences();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final jsonString = await rootBundle.loadString('assets/users.json');
    final data = json.decode(jsonString) as List;
    final List<ChatModel> fetchedChatList = [];
    for (var user in data.take(20)) {
      final name = "${user['first']} ${user['last']}";
      final profilePic = user['photo'];
      final message = getRandomMessage();
      final time = generateRandomTime();
      fetchedChatList.add(ChatModel(
          name: name, message: message, time: time, profilePic: profilePic));
    }
    setState(() {
      chatList = fetchedChatList;
    });
  }

  Future<void> loadSentences() async {
    final jsonString = await rootBundle.loadString('assets/sentences.json');
    final data = json.decode(jsonString);
    final sentencesData = data['data'] as List;
    sentences = sentencesData.map((sentence) => sentence as String).toList();
  }

  String getRandomMessage() {
    if (sentences.isEmpty) return "Hello!";
    final randomIndex = Random().nextInt(sentences.length);
    final sentence = sentences[randomIndex];
    return sentence;
  }

  String generateRandomTime() {
    final random = Random();
    final hour = random.nextInt(24).toString().padLeft(2, '0');
    final minute = random.nextInt(60).toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          actions: const [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 20),
            Icon(Icons.more_vert, color: Colors.white),
            SizedBox(width: 10),
          ],
          backgroundColor: Colors.green.shade900,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(icon: Icon(Icons.camera_alt)),
              Tab(text: "Chats",),
              Tab(text: "Status",),
              Tab(text: "Calls",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(child: Text("Camera")),
            chatList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      return ChatTile(chat: chatList[index]);
                    },
                  ),
            const Center(child: Text("Status")),
            const Center(child: Text("Calls")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green.shade500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 2,
          child: const Icon(
            Icons.messenger_outline_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}