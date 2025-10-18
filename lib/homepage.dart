import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:expense_app/auth/auth_service.dart';
import 'package:expense_app/chat/chatroom.dart';
import 'package:expense_app/expenses/expense_summary_card.dart';
import 'package:expense_app/expenses/service.dart';
import 'package:expense_app/expenses/view.dart';
import 'package:expense_app/main.dart';
import 'package:expense_app/profiles/my_profile.dart';
import 'package:expense_app/profiles/service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class Homepage extends StatefulWidget{
  const Homepage({ super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>  {
  String quote = "";
  Timer? _timer;
  final authService = AuthService();
  final profileDatabase = ProfileService();
  final expenseDatabase = ExpenseService();

  void logout() async {
      await authService.signOut();

      if(mounted){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
        );
      }
  }

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
    _timer = Timer.periodic(Duration(minutes: 1), (_){
      _getRandomQuote();
    });
  }

  Future<void> _getRandomQuote() async {
    try{
      final response = await http.get(Uri.parse('https://api.adviceslip.com/advice'));
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        setState(() {
          quote = data['slip']['advice'];
        });
      } else {
        setState(() {
          quote = 'Failed to generate quote.';
        });
      }
    } catch(e){
      setState(() {
        quote = 'Error $e';
      });
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        title: StreamBuilder(
            stream: profileDatabase.stream,
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final profile = snapshot.data!.first;

              return Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                        profile.avatarUrl != null ?
                        NetworkImage(profile.avatarUrl!) : null,
                      child: profile.avatarUrl == null ? Icon(
                        Icons.person,
                        size: 40,
                      ) : null,
                    ),
                  ),

                  SizedBox(width: 20,),

                  Text(
                    "Hello, ${profile.username}",
                    style: TextStyle(
                        fontFamily: "DM_Sans",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD9D9D9)
                    ),
                  )
                ],
              );
            }
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          )
        ),
        iconTheme: IconThemeData(
          color: Color(0xFFF2F2F2)
        ),
      ),

      backgroundColor: Color(0xff434343),

      body: Expanded(
          child: Container(
            padding: EdgeInsets.all(20),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: StreamBuilder(
                      stream: expenseDatabase.stream,
                      builder: (context, snapshot){
                        if(!snapshot.hasData){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final expenses = snapshot.data!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on_outlined,
                                  color: Color(0xFFD9D9D9),
                                  size: 24,
                                ),
                                SizedBox(width:5),
                                Text(
                                  'Spending',
                                  style: TextStyle(
                                    color: Color(0xFFD9D9D9),
                                    fontSize: 20,
                                    fontFamily: "DM_Sans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),

                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Today',
                                            style: TextStyle(
                                              color: Color(0xFFD9D9D9),
                                              fontFamily: "DM_Sans",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ExpenseSummaryCard(range: 'daily'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),

                                  Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              'This Week',
                                              style: TextStyle(
                                                color: Color(0xFFD9D9D9),
                                                fontFamily: "DM_Sans",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            ExpenseSummaryCard(range: 'weekly'),
                                          ],
                                        ),
                                      ),
                                  ),

                                  SizedBox(width: 10,),

                                  Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius: BorderRadius.circular(10),

                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              'This Month',
                                              style: TextStyle(
                                                color: Color(0xFFD9D9D9),
                                                fontFamily: "DM_Sans",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            ExpenseSummaryCard(range: 'monthly'),
                                          ],
                                        ),
                                      ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                  )
                ),

                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyProfile()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                             backgroundColor: Colors.transparent,
                            padding: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          icon: Icon(
                              Icons.person,
                              color: Color(0xFFD9D9D9),
                            size: 20,
                          ),
                          label: Text(
                              "My Profile",
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 20,
                                fontFamily: "DM_Serif",
                                fontWeight: FontWeight.bold,
                              ),
                          ),
                      ),
                    ),

                    SizedBox(width: 10,),


                    Expanded(
                        child: ElevatedButton.icon(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExpensesView()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          icon: Icon(
                            Icons.monetization_on_outlined,
                            color: Color(0xFFD9D9D9),
                            size: 20,
                          ),
                          label: Text(
                            "Spending",
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 20,
                              fontFamily: "DM_Serif",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    )

                  ],
                ),

                SizedBox(height: 20,),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.area_chart,
                                color: Color(0xFFD9D9D9),
                                size: 24,
                              ),
                              SizedBox(width:5),
                              Text(
                                'Analytics',
                                style: TextStyle(
                                  color: Color(0xFFD9D9D9),
                                  fontSize: 20,
                                  fontFamily: "DM_Sans",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          IconButton(
                              onPressed: (){},
                              icon: Icon(
                                Icons.navigate_next,
                                color: Color(0xFFD9D9D9),
                              )
                          )

                        ],
                      ),

                      SizedBox(height: 15,),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            StreamBuilder(
                                stream: expenseDatabase.stream,
                                builder: (context, snapshot){
                                  if (!snapshot.hasData) {
                                    return const Center(child: CircularProgressIndicator());
                                  }

                                  final expenses = snapshot.data!;
                                  final Map<String, double> categoryTotals = {};

                                  // Group expenses by category
                                  for (var e in expenses) {
                                    final category = e.category ?? 'Other';
                                    categoryTotals[category] = (categoryTotals[category] ?? 0) + e.amount;
                                  }

                                  final barGroups = categoryTotals.entries.map((entry) {
                                    final index = categoryTotals.keys.toList().indexOf(entry.key);
                                    return BarChartGroupData(
                                      x: index,
                                      barRods: [
                                        BarChartRodData(
                                          toY: entry.value,
                                          color: Colors.green,
                                          width: 30,
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ],
                                    );
                                  }).toList();

                                  return SizedBox(
                                    height: 250,
                                    width: double.infinity,
                                    child: BarChart(
                                      BarChartData(
                                        backgroundColor: Colors.transparent,
                                        alignment: BarChartAlignment.spaceAround,
                                        borderData: FlBorderData(show: false),
                                        titlesData: FlTitlesData(
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) {
                                                int index = value.toInt();
                                                if (index < categoryTotals.length) {
                                                  return Text(
                                                    categoryTotals.keys.elementAt(index),
                                                    style: TextStyle(
                                                        color: Color(0xFFD9D9D9),
                                                        fontFamily: "DM_Sans",
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 10
                                                    ),
                                                  );
                                                }
                                                return const SizedBox.shrink();
                                              },
                                            ),
                                          ),
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(showTitles: false),
                                          ),
                                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                        ),
                                        barGroups: barGroups,
                                      ),
                                    ),
                                  );
                                }
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20,),

                // Container(
                //   width: double.infinity,
                //   padding: EdgeInsets.all(20),
                //   decoration: BoxDecoration(
                //     color: Colors.black26,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.psychology,
                //             color: Color(0xFFD9D9D9),
                //             size: 24,
                //           ),
                //           SizedBox(width:5),
                //           Text(
                //             'Food for Thought...',
                //             style: TextStyle(
                //               color: Color(0xFFD9D9D9),
                //               fontSize: 20,
                //               fontFamily: "DM_Sans",
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(height: 5,),
                //       Column(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.all(15.0),
                //             child: Text(
                //                 '"$quote"',
                //                 style: TextStyle(
                //                   color: Color(0xFFD9D9D9),
                //                   fontSize: 20,
                //                   fontFamily: "DM_Serif",
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                SizedBox(height: 50,),

                Center(
                  child: Text(
                    "2025 Meru Coding. All Mels Reserved.",
                    style: TextStyle(
                      color: Color(0xFFD9D9D9),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "DM_Sans",
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xFF434343),
        child: StreamBuilder(
            stream: profileDatabase.stream,
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final profile = snapshot.data!.first;

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 250,
                    child: DrawerHeader(
                        decoration: BoxDecoration(
                          image: profile.avatarUrl != null ?
                          DecorationImage(
                            image: NetworkImage(profile.avatarUrl!),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.6),
                                BlendMode.darken
                            )
                          ) : null,

                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              bottom: 16,
                            ),
                            child: Text(
                              'Welcome, ${profile.username}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "DM_Serif",
                                  fontSize: 28,
                                  color: Color(0xFFD9D9D9)
                              ),
                            ),
                          ),
                        )
                    ),
                  ),

                  ListTile(
                    leading: Icon(
                        Icons.monetization_on_outlined,
                        color: Color(0xFFD9D9D9),
                        size: 26
                    ),
                    title: const Text(
                      'My Expenses',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "DM_Sans",
                          fontSize: 16.0,
                          color: Color(0xFFD9D9D9)
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExpensesView()),
                      );
                    },
                  ),

                  ListTile(
                    leading: Icon(
                        Icons.chat_bubble_rounded,
                        color: Color(0xFFD9D9D9),
                        size: 26
                    ),
                    title: const Text(
                      'AI Assistant',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "DM_Sans",
                          fontSize: 16.0,
                          color: Color(0xFFD9D9D9)
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Chatroom()),
                      );
                    },
                  ),

                  ListTile(
                    leading: Icon(
                        Icons.person,
                        color: Color(0xFFD9D9D9),
                        size: 26
                    ),
                    title: const Text(
                      'Account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "DM_Sans",
                          fontSize: 16.0,
                          color: Color(0xFFD9D9D9)
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyProfile()),
                      );
                    },
                  ),

                  ListTile(
                    leading: Icon(
                        Icons.exit_to_app,
                        color: Color(0xFFFF0038),
                        size: 26
                    ),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "DM_Sans",
                          fontSize: 16.0,
                          color: Color(0xFFFF0038)
                      ),
                    ),
                    onTap: logout,
                  )
                ],
              );
            }
        )
      ),
    );
  }
}