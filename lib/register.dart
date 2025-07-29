import 'package:expense_app/auth/auth_service.dart';
import 'package:expense_app/homepage.dart';
import 'package:expense_app/main.dart';
import 'package:expense_app/profiles/model.dart';
import 'package:expense_app/profiles/service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>  {
  final authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool confirmPassVisible = false;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    confirmPassVisible = true;
  }

  void signUp() async {
    final email = emailController.text;
    final pass = passController.text;
    final confirmPass = confirmPassController.text;

    //is password = confirm password?
    if(pass != confirmPass){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords don't match.")));
      return;
    }
    //validate form
    final isValid = _formKey.currentState!.validate();
    if(!isValid){
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Valid form sent! Proceeding to next page...")
        ),
      );
    }

    //try signup
    try{
      await authService.signUpWithEmailPassword(email, pass);
      if(mounted){
        setState(() {});
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AddProfile()),
        );
      }

    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e"))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff434343),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Register.',
                  style: TextStyle(
                      color: Color(0xFFF2F2F2),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: "DM_Serif"
                  ),

                ),

                SizedBox(height: 30,),

                TextFormField(
                  controller: emailController,
                  style: TextStyle(
                      color: Color(0xFF434343),
                      fontFamily: "DM_Sans",
                      fontWeight: FontWeight.bold
                  ),
                  decoration: const InputDecoration(
                    hintText: "Email address",
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
                    if (value == null || value.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter valid email address';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20,),

                TextFormField(
                  controller: passController,
                  obscureText: passwordVisible,
                  style: TextStyle(
                      color: Color(0xFF434343),
                      fontFamily: "DM_Sans", fontWeight: FontWeight.bold
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: (){
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    hintText: "Password",
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
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20,),

                TextFormField(
                  controller: confirmPassController,
                  obscureText: confirmPassVisible,
                  style: TextStyle(
                      color: Color(0xFF434343),
                      fontFamily: "DM_Sans",
                      fontWeight: FontWeight.bold
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(confirmPassVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: (){
                        setState(() {
                          confirmPassVisible = !confirmPassVisible;
                        });
                      },
                    ),
                    hintText: "Confirm password",
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
                      return 'Please confirm password';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20,),

                ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF70C000),
                      minimumSize: Size(400,50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans"
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Center(
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Have an account? Log In",
                      style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "DM_Sans"
                      ),
                    ),
                  ),
                )
              ],
            ),
        )
      ),
    );

  }
}



class AddProfile extends StatefulWidget{
  const AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile>{
  final database = Supabase.instance.client;
  final profileDatabase = ProfileService();
  final _formKey = GlobalKey<FormState>();

  final userController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void addProfile() async {

    final userId = database.auth.currentUser?.id;

    //validate form
    final isValid = _formKey.currentState!.validate();
    if(!isValid){
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Loading...")
        ),
      );
    }

    if(userId == null){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: NOT LOGGED IN!"))
      );
    }

    //try signup
    try{
      final newProfile = Profile(
        profileId: userId!,
        username: userController.text,
        lastName: lastNameController.text,
        firstName: firstNameController.text,
        middleName: middleNameController.text,
        number: numberController.text,
        address: addressController.text,
      );

      await profileDatabase.createProfile(newProfile);

      if(mounted){
        setState(() {});
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      }

    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e"))
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff434343),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Add your profile.',
                style: TextStyle(
                    color: Color(0xFFF2F2F2),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "DM_Serif"
                ),

              ),

              SizedBox(height: 30,),

              TextFormField(
                controller: userController,
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
                controller: lastNameController,
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

              SizedBox(height: 20,),

              TextFormField(
                controller: firstNameController,
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

              SizedBox(height: 20,),

              TextFormField(
                controller: middleNameController,
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

              SizedBox(height: 20,),

              TextFormField(
                controller: numberController,
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

              SizedBox(height: 20,),

              TextFormField(
                controller: addressController,
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

              SizedBox(height: 20,),

              ElevatedButton(
                onPressed: addProfile,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF70C000),
                    minimumSize: Size(400,50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
                child: Text(
                  "Sign Up",
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
        )
      ),
    );
  }

}