import 'dart:io';

import 'package:ecommerce/components/bottom_container.dart';
import 'package:ecommerce/components/custom_avatar.dart';
import 'package:ecommerce/components/custom_text_field.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/static_methods.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddItemScreen extends StatefulWidget {
  static String id = 'add_item_screen';

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  bool showSpinner = false;
  FirebaseStorage storage = FirebaseStorage.instance;
  File imageFile;
  String category = 'Recommended';
  TextEditingController nameController, descriptionController, priceController;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child('Items');
  @override
  void initState() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _clear() {
    setState(() {
      imageFile = null;
    });
  }

  selectFromGallery() {
    _pickImage(ImageSource.gallery);
    Navigator.pop(context);
  }

  selectFromCamera() {
    _pickImage(ImageSource.camera);
    Navigator.pop(context);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final _picker = ImagePicker();
      PickedFile image = await _picker.getImage(source: source);

      final File selected = File(image.path);

      setState(() {
        imageFile = selected;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _cropImage() async {
    try {
      File cropped = await ImageCropper.cropImage(
        cropStyle: CropStyle.circle,
        sourcePath: imageFile.path,
      );

      setState(() {
        imageFile = cropped ?? imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaticMethods.myAppBar('Add Item Screen'),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: kCustomProgressIndicator,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: CustomAvatar(
                          onImageSelectPressed: () {
                            onSelectImagePressed();
                          },
                          imageFile: imageFile,
                        ),
                      ),
                      if (imageFile != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: _cropImage,
                              child: Icon(Icons.crop),
                            ),
                            TextButton(
                              onPressed: _clear,
                              child: Icon(Icons.refresh),
                            ),
                          ],
                        ),
                      ] else ...[
                        SizedBox(),
                      ],
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        controller: nameController,
                        text: 'Name of your item',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        controller: descriptionController,
                        text: 'Description of your item',
                        inputType: TextInputType.text,
                        minLines: 3,
                        height: 100,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        controller: priceController,
                        text: 'Price of your item',
                        inputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        children: [
                          Text('Category:     '),
                          DropdownButton<String>(
                            value: category,
                            items: <String>['Recommended', 'Expensive'].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (val) {
                              category = val;
                              setState(() {

                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BottomContainer(
              onItemPressed: () {
                onAddItemPressed();
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  onAddItemPressed() {
    isValidated();
  }

  void onSelectImagePressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StaticMethods.myAlertDialog(selectFromCamera, selectFromGallery);
      },
    );
  }

  Future<String> uploadFile() async {
    setState(() {
      showSpinner = true;
    });
    try {
      TaskSnapshot task = await storage
          .ref(imageFile.path.split('/').last)
          .putFile(imageFile);
      final String downloadUrl = await task.ref.getDownloadURL();
      print(downloadUrl);

      return downloadUrl;

    } on FirebaseException catch (e) {
      print(e);
      setState(() {
        showSpinner = false;
      });
      return null;
    }
  }

  isValidated() async{
    String name = nameController.text;
    String description = descriptionController.text;
    String price = priceController.text;

    if(imageFile == null){
      StaticMethods.showErrorDialog(context: context, text: 'Select an image first');
      return;
    }
    if(name.length == 0){
      StaticMethods.showErrorDialog(context: context, text: 'Enter a name first');
      return;
    }
    if(description.length == 0){
      StaticMethods.showErrorDialog(context: context, text: 'Enter a description first');
      return;
    }
    if(price.length == 0){
      StaticMethods.showErrorDialog(context: context, text: 'Enter a price first');
      return;
    }

    String resultUrl = await uploadFile();
    if(resultUrl != null){
      uploadToDatabase(name, description, int.parse(price), category, resultUrl);
    }
    else{
      StaticMethods.showErrorDialog(context: context, text: 'An Erro occured while uploading file');
      return;
    }

  }

  uploadToDatabase(String name, String description, int price, String category, String imageUrl) async {
    try{
      DatabaseReference databaseRef = dbRef.push();

      await databaseRef.set({
        'name': name,
        'description': description,
        'price': price,
        'url': imageUrl,
        'category': category,
        'id': databaseRef.key,
      });
      setState(() {
        showSpinner = false;
      });

      StaticMethods.showErrorDialog(context: context, text: 'Your item was saved successfully');

    }
    catch(e){
      setState(() {
        showSpinner = false;
      });
      StaticMethods.showErrorDialog(context: context, text: 'sth went wrong');
      print(e);
    }
  }

}
