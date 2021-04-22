import 'dart:io';

import 'package:ecommerce/components/bottom_container.dart';
import 'package:ecommerce/components/custom_avatar.dart';
import 'package:ecommerce/components/custom_text_field.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/static_methods.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddItemScreen extends StatefulWidget {
  static String id = 'add_item_screen';

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  bool showSpinner = false;

  File imageFile;

  TextEditingController nameController, descriptionController, priceController;

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
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        controller: nameController,
                        text: 'Name of your app',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        controller: descriptionController,
                        text: 'Description of your app',
                        inputType: TextInputType.text,
                        minLines: 3,
                        height: 100,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        controller: priceController,
                        text: 'Price of your app',
                        inputType: TextInputType.number,
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

  onAddItemPressed() {}

  void onSelectImagePressed() {}
}
