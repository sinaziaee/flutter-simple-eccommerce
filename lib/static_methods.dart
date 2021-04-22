import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

import 'models/item.dart';

class StaticMethods {
  static void showErrorDialog(
      {@required BuildContext context, @required String text}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            text,
            style: kHeaderTextStyle.copyWith(),
          ),
          content: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }

  static void simplePopAndPushNavigation(
      {@required BuildContext context, @required String routeName}) {
    Navigator.popAndPushNamed(context, routeName);
  }

  static AlertDialog myAlertDialog(
      Function selectFromCamera, Function selectFromGallery) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Select Image',
                  textDirection: TextDirection.rtl,
                  style: kHeaderTextStyle.copyWith(color: Colors.grey[800]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              selectFromCamera();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'From Camera‌',
                    textDirection: TextDirection.rtl,
                    style: kHeaderTextStyle.copyWith(color: Colors.grey[700]),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.camera_alt,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              selectFromGallery();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'From Gallery',
                    textDirection: TextDirection.rtl,
                    style: kHeaderTextStyle.copyWith(color: Colors.grey[700]),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.insert_photo,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static PreferredSize myAppBar(String text){
    return PreferredSize(
      child: Container(
        decoration: kCustomAppBarDecoration,
        child: SafeArea(
          child: Container(
            decoration: kCustomAppBarDecoration,
            child: Center(
              child: Text(
                text,
                style: kHeaderTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      preferredSize: Size(
        double.infinity,
        70,
      ),
    );
  }

  static bool onBucketAddedPressed(Item item) {
    if (item == null) {
      item = Item(
        name: 'Name',
        description: 'Description',
        price: 100,
        url: '',
        id: '3',
      );
    }
    bool canBeAddedToTheList = true;
    for(Item each in BucketList.items){
      if(each.id == item.id){
        canBeAddedToTheList = false;
        break;
      }
    }
    if(canBeAddedToTheList == true){
      BucketList.items.add(item);
      BucketList.itemsCount.add(1);
      return true;
    }
    else{
      return false;
    }
  }


}
