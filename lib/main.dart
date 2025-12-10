import 'package:expense_app/auth/auth_gate.dart';
import 'package:expense_app/auth/auth_service.dart';
import 'package:expense_app/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await Supabase.initialize(
     url: dotenv.env["SUPABASE_URL"] ?? "",
     anonKey: dotenv.env["SUPABASE_ANON_KEY"] ?? "",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  final authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;

    final isValid = _formKey.currentState!.validate();
    if(!isValid){
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Color(0xFF008000),
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Loading...",
              style: TextStyle(
                color: Color(0xFFD9D9D9),
                fontWeight: FontWeight.bold,
                fontFamily: "DM_Sans",
                fontSize: 16,
              ),
            )
        ),
      );
    }

    try{
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: $e"),
            )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0b101c),

      body: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Login.',
                  style: TextStyle(
                    color: Color(0xFFF2F2F2),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "DM_Serif",
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
                    prefixIcon: Icon(Icons.email),
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
                  controller: passwordController,
                  obscureText: passwordVisible,
                  style: TextStyle(
                    color: Color(0xFF434343),
                    fontFamily: "DM_Sans",
                    fontWeight: FontWeight.bold
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
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
                        fontWeight: FontWeight.bold
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

                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFD800),
                      minimumSize: Size(400,50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Center(
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text(
                      "No account yet? Sign in",
                      style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "DM_Sans",

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
