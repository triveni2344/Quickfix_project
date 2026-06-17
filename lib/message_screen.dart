import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
   final List<Map<String, String>> users = [
    {
      'name': 'John Carter',
      'message': 'Hello, I have a question...',
      'time': '2m',
      'avatar': 'assets/men1.jpg'
    },
    {
      'name': 'Sarah Johnson',
      'message': 'Hello, Thanks!',
      'time': '10:00 AM',
      'avatar': 'assets/men2.jpg'
    },
    {
      'name': 'David Williams',
      'message': 'Hello, I have a question..',
      'time': '8.45 AM',
      'avatar':'assets/men3.jpg'
    },
    {
      'name': 'Olivia Martinez',
      'message': 'Test moni',
      'time': 'Yesterday',
      'avatar':'assets/men4.jpg'
    },
    {
      'name': 'Johny',
      'message': 'Hello, I have a question...',
      'time': '2m',
      'avatar': 'assets/men5.jpg'
    },
    {
      'name': 'jack',
      'message': 'Hello, Thanks!',
      'time': '10:00 AM',
      'avatar':'assets/men6.jpg'
    },
    {
      'name': 'Warrior',
      'message': 'Hello, I have a question..',
      'time': '8.45 AM',
      'avatar': 'assets/men7.jpg'
    },
    {
      'name': 'Alice',
      'message': 'Test moni',
      'time': 'Yesterday',
      'avatar': 'assets/men8.jpg'
    },
    {
      'name': 'yashuu',
      'message': 'Hello, I have a question..',
      'time': '8.45 AM',
      'avatar': 'assets/men9.jpg'
    },
    {
      'name': 'pavani',
      'message': 'Test moni',
      'time': 'Yesterday',
      'avatar': 'https://tse4.mm.bing.net/th/id/OIP.fMt8bsfbuK4Lr4oLEm17QAHaHa?pid=Api&P=0&h=220'
    },
    {
      'name': 'Sandhya',
      'message': 'Hello, I have a question..',
      'time': '8.45 AM',
      'avatar': 'assets/girl1.jpg'
    },
    {
      'name': 'Triveni',
      'message': 'Test moni',
      'time': 'Yesterday',
      'avatar': 'assets/girl2.jpg'
    },
    {
      'name': 'Bhagya',
      'message': 'Hello, Thanks!',
      'time': '10:00 AM',
      'avatar': 'assets/men3.jpg'
    },
    {
      'name': 'BOb',
      'message': 'Hello, I have a question..',
      'time': '8.45 AM',
      'avatar': 'assets/men10.jpg'
    },
    {
      'name': 'Bunny',
      'message': 'Test moni',
      'time': 'Yesterday',
      'avatar': 'assets/men2.jpg'
    },
  ];

  List<Map<String, String>> filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  bool isChatScreen = false;
  String selectedUserName = '';
  String selectedUserAvatar = '';
  final TextEditingController _messageController = TextEditingController();
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = users;
  }

  void filterUsers(String query) {
    setState(() {
      filteredUsers = users
          .where((user) => user['name']!.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  void sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(text);
        _messageController.clear();
      });
    }
  }

  void openChat(String name, String avatar) {
    setState(() {
      selectedUserName = name;
      selectedUserAvatar = avatar;
      isChatScreen = true;
      messages.clear();
    });
  }

  void goBackToList() {
    setState(() {
      isChatScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          isChatScreen ? selectedUserName : 'Messages',
          style: TextStyle(color: Colors.white,fontSize: 24),
        ),
      
    backgroundColor: const Color(0xFF006D77),
        leading: isChatScreen
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: goBackToList,
              )
            : null,
      ),
      
      body:Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 0.35, 0.7, 1.0],
      colors: [
        Color(0xFFFFDEE9), // light pink
        Color.fromARGB(255, 193, 248, 246), // light blue
        Color.fromARGB(255, 212, 193, 238), // light purple
        Colors.white.withOpacity(0.5), // touch of white
      ],
    ),
  ),
      child: isChatScreen
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: messages.length,
                    itemBuilder: (_, index) => Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(messages[index], style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: sendMessage,
                        icon: Icon(Icons.send, color: Colors.black),
                      )
                    ],
                  ),
                )
              ],
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: searchController,
                    onChanged: filterUsers,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.search, color: const Color.fromARGB(238, 4, 4, 4)),
                    ),
                  ),
                ),
                Expanded(
                  child: filteredUsers.isEmpty
                      ? Center(
                          child: Text('No results found', style: TextStyle(color: Colors.black)),
                        )
                      : ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            var user = filteredUsers[index];
                            return ListTile(
                              leading: CircleAvatar(
                               backgroundImage: AssetImage(user['avatar']!),
                              ),
                              title: Text(user['name']!, style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                              subtitle: Text(user['message']!, style: TextStyle(color: Colors.black)),
                              trailing: Text(user['time']!, style: TextStyle(color: Colors.black)),
                              onTap: () => openChat(user['name']!, user['avatar']!),
                            );
                          },
                        ),
                ),
              ],
            ),
      )
    );
  }
}







