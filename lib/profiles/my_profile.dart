import 'package:expense_app/profiles/avatar.dart';
import 'package:expense_app/profiles/service.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';

class MyProfile extends StatefulWidget{
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile>{
  final profileDatabase = ProfileService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Color(0xFFD9D9D9),
        ),
        centerTitle: true,
        title: Text(
            'My Profile',
            style: TextStyle(
              color: Color(0xFFD9D9D9),
              fontWeight: FontWeight.bold,
              fontFamily: "DM_Serif",
              fontSize: 26
            ),
        ),
      ),
      backgroundColor: Color(0xff434343),
      body: StreamBuilder(
          stream: profileDatabase.stream,
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final profile = snapshot.data!.first;

            return Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        height: 350,
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(10),
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Avatar()),
                                    );
                                  },
                                  icon: Icon(Icons.image_search_outlined,),
                                  color: Color(0xFFD9D9D9),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${profile.lastName}, ${profile.firstName} ${profile.middleName}",
                                    style: TextStyle(
                                      color: Color(0xFFD9D9D9),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DM_Sans",
                                    ),
                                ),
                                IconButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EditProfile()),
                                      );
                                    },
                                    icon: Icon(Icons.edit,),
                                    color: Color(0xFFD9D9D9),
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Username",
                                  style: TextStyle(
                                    color: Color(0xFF888888),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "DM_Sans",
                                  ),
                                ),
                                Text(
                                  profile.username,
                                  style: TextStyle(
                                    color: Color(0xFFD9D9D9),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "DM_Sans",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(
                                    color: Color(0xFF888888),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "DM_Sans",
                                  ),
                                ),
                                Text(
                                  profile.address,
                                  style: TextStyle(
                                    color: Color(0xFFD9D9D9),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "DM_Sans",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
            );
          }
      )
    );
  }
}