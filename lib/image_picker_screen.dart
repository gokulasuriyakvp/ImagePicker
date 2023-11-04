import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? image;
  late String imagePath;

  Future pickImageGallery() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      print('Gallery Image Path:');
      print(image.path);

      imagePath = image.path;

      setState(() => this.image = imageTemp);
    }on PlatformException catch(e){
      print('Failed to pick image: $e');
    }
  }
  Future PickImageCamera() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      print('Camera Image Path');
      print(image.path);

      imagePath = image.path;
      setState(() => this.image = imageTemp);
    }on PlatformException catch (e){
      print('Failed to pick image: $e');
    }
  }

  _uploadImageDialog(BuildContext context){
    return showDialog(context: context,
        barrierDismissible: true,
        builder:(param){
      return AlertDialog(
        title: Text('Upload image'),
        content: SingleChildScrollView(
          child: Column(children:[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(15, 53, 73, 1)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
                onPressed: (){
                pickImageGallery();
                print('------------------> upload from gallery');
                Navigator.pop(context);
                },
                child: Text('Gallery'),
            ),
            ElevatedButton(
                style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(15, 53, 73, 1)),
                    foregroundColor:MaterialStateProperty.all(Colors.white),
                  ),
                onPressed:(){
                    print('----------------> Image: $image');
                    PickImageCamera();
                    Navigator.pop(context);
                    print('----------------> upload from Camera');
    },
    child: Text('camera'),
    )
          ]),
          ),
        );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image Picker Ref'),
        ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image != null
                  ? Padding(
                padding: const EdgeInsets.only(left: 130.0),
                child: ClipOval(
                  child: Image.file(
                    image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  : FlutterLogo(),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 40,
                width: 125,
                child: ElevatedButton(
                    onPressed: () {
                      _uploadImageDialog(context);
                    },
                    child: Text('+ Add Photo')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
