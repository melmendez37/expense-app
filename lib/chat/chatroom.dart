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
  List<Map<String, String>> messages = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> sendMessage(String prompt) async {
    setState(() {
      messages.add({"role" : "user", "text" : prompt});
      isLoading = true;
    });

    try{
      final request = http.Request(
        "POST",
          Uri.parse("http://10.0.2.2:11434/v1/completions")

      );

      request.headers["Content-Type"] = "application/json";
      request.body = jsonEncode({
        "model" : "tinyllama",
        "prompt": prompt,
        "stream": false,
      });

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);
      final reply = (data["choices"] != null && data["choices"].isNotEmpty) 
          ? data["choices"][0]["text"] : "No response.";
      print(data["choices"][0]["text"]);

      setState(() {
        messages.add({"role": "assistant", "text": reply});
        isLoading = false;
      });
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
     backgroundColor: Color(0xFF434343),
     body: Column(
       children: [
         Expanded(
             child: ListView.builder(
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
                       color: isUser ? Colors.green : Colors.grey[700],
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Text(
                         msg['text'] ?? "",
                       style: TextStyle(
                         color: Colors.white,
                         fontFamily: "DM_Sans",
                         fontSize: 16,
                       ),
                     ),
                   ),
                 );
                 }
             )
         ),
         if(isLoading) CircularProgressIndicator(color: Colors.green,),
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
                 backgroundColor: Colors.green,
                 elevation: 0,
                 child: Icon(Icons.send, color: Colors.white, size: 18,),
               )
             ],
           ),
         ),
       ],
     )
   );

  }
}