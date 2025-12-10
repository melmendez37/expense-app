import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chatroom extends StatefulWidget{
  const Chatroom({super.key});

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<Map<String, String>> messages = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose(){
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> sendMessage(String prompt) async {
    setState(() {
      messages.add({"role": "user", "text": prompt});
      isLoading = true;
    });

    // Scroll to bottom after a tiny delay
    Future.delayed(Duration(milliseconds: 100), () {
      if(scrollController.hasClients){
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:11434/v1/completions"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "model": "finance-llama",
          "prompt": prompt,
          "stream": false
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = (data["choices"] != null && data["choices"].isNotEmpty)
            ? data["choices"][0]["text"]
            : "No response.";
        setState(() {
          messages.add({"role": "assistant", "text": reply});
        });

        // Scroll to bottom after a tiny delay
        Future.delayed(Duration(milliseconds: 100), () {
          if(scrollController.hasClients){
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      } else {
        setState(() {
          messages.add({"role": "assistant", "text": "Error: ${response.statusCode}"});
        });
      }
    } catch (e) {
      setState(() {
        messages.add({"role": "assistant", "text": "Error: $e"});
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       toolbarHeight: 100,
       backgroundColor: Colors.transparent,
       title: Text(
         'AI Assistant',
         style: TextStyle(
           color: Color(0xFFD9D9D9),
           fontFamily: "DM_Sans",
           fontSize: 20,
           fontWeight: FontWeight.bold
         ),
       ),
       leading: BackButton(
         onPressed: () async {
           if(context.mounted){
             Navigator.pop(context);
           }
         },
       ),
       iconTheme: IconThemeData(
           color: Color(0xFFD9D9D9)
       ),
       automaticallyImplyLeading: true,
     ),
     backgroundColor: Color(0xFF0b101c),
     body: Column(
       children: [
         Expanded(
             child: ListView.builder(
               controller: scrollController,
               padding: EdgeInsets.all(15),
                 itemCount: messages.length,
                 itemBuilder: (context, index){
                 final msg = messages[index];
                 final isUser = msg['role'] == 'user';
                 return Align(
                   alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                   child: Container(
                     margin: EdgeInsets.symmetric(vertical: 4),
                     padding: EdgeInsets.all(12),
                     decoration: BoxDecoration(
                       color: isUser ? Color(0XFFFFD800) : Color(0XFF050610),
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Text(
                         msg['text'] ?? "",
                       style: TextStyle(
                         color: isUser ? Color(0xFF0b101c) : Color(0XFFF2F2F2),
                         fontFamily: "DM_Sans",
                         fontSize: 16,
                       ),
                     ),
                   ),
                 );
                 }
             )
         ),
         if(isLoading) CircularProgressIndicator(
           color: Color(0xFFFFD800),
           backgroundColor: Colors.transparent,
         ),
         Container(
           padding: EdgeInsets.all(15),
           height: 150,
           width: double.infinity,
           child: Row(
             children: <Widget>[
               Expanded(
                 child: TextField(
                   controller: messageController,
                   style: TextStyle(
                     color: Colors.white
                   ),
                   decoration: InputDecoration(
                       filled: true,
                       fillColor: Colors.black26,
                       hintText: "Ask AI Assistant...",
                       hintStyle: TextStyle(
                           color: Colors.grey,
                           fontFamily: "DM_Sans",
                           fontSize: 16
                       ),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                       )
                   ),
                 ),
               ),
               SizedBox(width: 15,),
               FloatingActionButton(
                 onPressed: () async {
                   final prompt = messageController.text.trim();
                   if(prompt.isEmpty) return;
                   messageController.clear();
                   await sendMessage(prompt);
                 },
                 backgroundColor: Color(0xFFFFD800),
                 elevation: 0,
                 child: Icon(Icons.send, color: Color(0xFF0b101c), size: 20,),
               )
             ],
           ),
         ),
       ],
     )
   );

  }
}