import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget{
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Color(0xFFD9D9D9),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
              color: Color(0xFFD9D9D9),
              fontWeight: FontWeight.bold,
              fontFamily: "DM_Serif",
              fontSize: 26
          ),
        ),
      ),
      backgroundColor: Color(0xff434343),
      body: Padding(
          padding: EdgeInsets.all(30),
          child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    //controller: userController,
                    style: TextStyle(
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold
                    ),
                    decoration: const InputDecoration(
                      hintText: "Username",
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF434343),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20,),

                  TextFormField(
                    //controller: userController,
                    style: TextStyle(
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold
                    ),
                    decoration: const InputDecoration(
                      hintText: "Last name",
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF434343),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    //controller: userController,
                    style: TextStyle(
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold
                    ),
                    decoration: const InputDecoration(
                      hintText: "First name",
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF434343),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    //controller: userController,
                    style: TextStyle(
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold
                    ),
                    decoration: const InputDecoration(
                      hintText: "Middle name",
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF434343),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter middle name';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    //controller: userController,
                    style: TextStyle(
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold
                    ),
                    decoration: const InputDecoration(
                      hintText: "Phone number",
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF434343),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    //controller: userController,
                    style: TextStyle(
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold
                    ),
                    decoration: const InputDecoration(
                      hintText: "Address",
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF434343),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  ),
                ],
              ),
          ),
      ),
    );
  }
}