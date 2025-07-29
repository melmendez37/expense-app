import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Avatar extends StatefulWidget{
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar>{
  File? _imageFile;
  final supabase = Supabase.instance.client;

  //pick image
  Future pickImage() async {
    //picker
    final ImagePicker picker = ImagePicker();

    //pick from gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    //update image preview
    if(image != null){
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future upload() async {
    if(_imageFile == null) return;

    //generate unique filepath
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName';
    final user = supabase.auth.currentUser?.id;

    await supabase.storage
        .from('profiles')
        .upload(path, _imageFile!).then((value) =>
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Picture successfully added.')))
    );

    final publicUrl = supabase.storage.from('profiles').getPublicUrl(path);

    await supabase
        .from('profiles')
        .update({'avatar_url' : publicUrl})
        .match({'profile_id': user as String});

    Navigator.pop(context);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Color(0xFFD9D9D9),
        ),
        title: Text(
            "Avatar",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "DM_Sans",
            fontWeight: FontWeight.bold,
            color: Color(0xFFD9D9D9)
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xff434343),
      body: Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _imageFile != null ? Image.file(_imageFile!, fit: BoxFit.fill,) : const Text(
                      "No image yet. Time to avatar.",
                      style: TextStyle(
                        color: Color(0xFFD9D9D9),
                        fontFamily: "DM_Sans",
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                  ),



                SizedBox(height: 20,),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: pickImage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.image,
                                color: Color(0xFFD9D9D9),
                                size: 20,
                              ),

                              SizedBox(width: 5,),

                              const Text(
                              "Insert Image",
                              style: TextStyle(
                                  color: Color(0xFFD9D9D9),
                                  fontFamily: "DM_Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                              ),
                            ],
                          ),

                      ),
                      ElevatedButton(
                        onPressed: upload,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.upload,
                              color: Color(0xFFD9D9D9),
                              size: 20,
                            ),

                            SizedBox(width: 5,),

                            Text(
                              "Upload",
                              style: TextStyle(
                                  color: Color(0xFFD9D9D9),
                                  fontFamily: "DM_Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],

                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}