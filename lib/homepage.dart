import 'package:expense_app/auth/auth_service.dart';
import 'package:expense_app/expenses/service.dart';
import 'package:expense_app/expenses/view.dart';
import 'package:expense_app/main.dart';
import 'package:expense_app/profiles/my_profile.dart';
import 'package:expense_app/profiles/service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget{
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>  {
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
                        fontFamily: "DM_Serif",
                        fontSize: 24,
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

                        double sum = 0;
                        for(var e in expenses){
                          sum += e.amount;
                        }

                        String displaySum;
                        if (sum >= 1000000000){
                          displaySum = "${(sum/1000000000).round()}b";
                        } else if (sum >= 1000000){
                          displaySum = "${(sum/1000000).round()}m";
                        } else if (sum >= 1000){
                          displaySum = "${(sum/1000).round()}k";
                        } else {
                          displaySum = sum.toStringAsFixed(0);
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Expenses',
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 24,
                                fontFamily: "DM_Serif",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20,),

                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Daily',
                                          style: TextStyle(
                                            color: Color(0xFFD9D9D9),
                                            fontFamily: "DM_Serif",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          displaySum,
                                          style: TextStyle(
                                            color: Color(0xFF008000),
                                            fontFamily: "DM_Sans",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: EdgeInsets.all(15),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Weekly',
                                          style: TextStyle(
                                            color: Color(0xFFD9D9D9),
                                            fontFamily: "DM_Serif",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: EdgeInsets.all(20),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Monthly',
                                          style: TextStyle(
                                            color: Color(0xFFD9D9D9),
                                            fontFamily: "DM_Serif",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                          onPressed: (){},
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
                          ),
                          label: Text(
                              "My Profile",
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 18,
                                fontFamily: "DM_Serif",
                                fontWeight: FontWeight.bold,
                              ),
                          ),
                      ),
                    ),

                    SizedBox(width: 10,),


                    Expanded(
                        child: ElevatedButton.icon(
                          onPressed: (){},
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
                          ),
                          label: Text(
                            "Spending",
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 18,
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
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('where the graphs of type/category of expenses will show'),
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('QUOTES FROM API FOR WISDOM IN BUDGETING'),
                  ),
                ),

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