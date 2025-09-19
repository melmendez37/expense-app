import 'package:expense_app/profiles/model.dart';
import 'package:expense_app/profiles/service.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget{
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>{
  final profileDatabase = ProfileService();
  final _formKey = GlobalKey<FormState>();

  final newUser = TextEditingController();
  final newLast = TextEditingController();
  final newFirst = TextEditingController();
  final newMiddle = TextEditingController();
  final newNum = TextEditingController();
  final newAddress = TextEditingController();

  void updateProfile (Profile profile) async {
    Profile newProfile = Profile(
        profileId: profile.profileId,
        username: newUser.text.trim().isNotEmpty
            ? newUser.text : profile.username,
        lastName: newLast.text.trim().isNotEmpty
            ? newLast.text : profile.lastName,
        firstName: newFirst.text.trim().isNotEmpty
            ? newFirst.text : profile.firstName,
        middleName: newMiddle.text.trim().isNotEmpty
            ? newMiddle.text : profile.middleName,
        number: newNum.text.trim().isNotEmpty
            ? newNum.text : profile.number,
        address: newAddress.text.trim().isNotEmpty
            ? newAddress.text : profile.address,
    );

    try{
      await profileDatabase.updateProfile(profile, newProfile);

      newUser.clear();
      newLast.clear();
      newFirst.clear();
      newMiddle.clear();
      newNum.clear();
      newAddress.clear();

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Color(0xFF008000),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
                label: "Dismiss",
                onPressed: (){},
                textColor: Color(0xFFE1FF8D)
            ),
            content: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFFD9D9D9),
                ),

                SizedBox(width: 10,),

                Text(
                  "Successfully updated profile.",
                  style: TextStyle(
                    color: Color(0xFFD9D9D9),
                    fontWeight: FontWeight.bold,
                    fontFamily: "DM_Sans",
                    fontSize: 16,
                  ),
                )
              ],
            )
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            content: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Color(0xFFD9D9D9),
                ),

                SizedBox(width: 10,),

                Text(
                  "Error updating profile: $error",
                  style: TextStyle(
                    color: Color(0xFFD9D9D9),
                    fontWeight: FontWeight.bold,
                    fontFamily: "DM_Sans",
                    fontSize: 18,
                  ),
                )
              ],
            ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    newUser.dispose();
    newLast.dispose();
    newFirst.dispose();
    newMiddle.dispose();
    newNum.dispose();
    newAddress.dispose();
    super.dispose();
  }

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
      body: StreamBuilder(
          stream: profileDatabase.stream,
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final profile = snapshot.data!.first;

            return Padding(
              padding: EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: newUser,
                      style: TextStyle(
                          color: Color(0xFF434343),
                          fontFamily: "DM_Sans",
                          fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        hintText: profile.username,
                        fillColor: const Color(0xFFD9D9D9),
                        filled: true,
                        errorStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: "DM_Sans",
                        ),

                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            )
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            )
                        ),
                        hintStyle: const TextStyle(
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
                      controller: newLast,
                      style: TextStyle(
                          color: Color(0xFF434343),
                          fontFamily: "DM_Sans",
                          fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        hintText: profile.lastName,
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
                      controller: newFirst,
                      style: TextStyle(
                          color: Color(0xFF434343),
                          fontFamily: "DM_Sans",
                          fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        hintText: profile.firstName,
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
                      controller: newMiddle,
                      style: TextStyle(
                          color: Color(0xFF434343),
                          fontFamily: "DM_Sans",
                          fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        hintText: profile.middleName,
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
                      controller: newNum,
                      style: TextStyle(
                          color: Color(0xFF434343),
                          fontFamily: "DM_Sans",
                          fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        hintText: profile.number,
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
                      controller: newAddress,
                      style: TextStyle(
                          color: Color(0xFF434343),
                          fontFamily: "DM_Sans",
                          fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        hintText: profile.address,
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
                          return 'Please enter city/municipality';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20,),

                    ElevatedButton(
                      onPressed: (){
                        updateProfile(profile);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF70C000),
                          minimumSize: Size(400,50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                      child: Text(
                        "Update",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF434343)
                        ),
                      ),
                    ),

                    SizedBox(height: 100,),

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
            );
          }
      ),
    );
  }
}