import 'package:ecommerce/models/item.dart';
import 'package:ecommerce/screens/item_details_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SlideShow extends StatefulWidget {
  @override
  _SlideShowState createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  final PageController controller = PageController(viewportFraction: 0.8);
  final DatabaseReference dbRef =
  FirebaseDatabase.instance.reference().child('Items');
  Stream slides;

  int currentPage = 0;

  @override
  void initState() {
    queryDB();
    controller.addListener(() {
      int next = controller.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  void queryDB() {
    Stream stream = dbRef.limitToFirst(4).onValue;
    slides = stream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: slides,
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
          // List slideList = snap.data.toList();
          List mapList = [];
          Event event = snap.data;
          DataSnapshot snapshot = event.snapshot;
          Map map = snapshot.value;
          for (Map each in map.values){
            mapList.add(each);
          }
          return PageView.builder(
            itemBuilder: (context, index) {
              bool active = currentPage == index;
              return buildEachSlide(mapList[index], active);
            },
            itemCount: mapList.length,
            controller: controller,
          );
        } else {
          return Center(
            child: kCustomProgressIndicator,
          );
        }
      },
    );
  }

  buildEachSlide(Map map, bool active) {
    final double blur = active ? 30 : 0;
    final double offSet = active ? 20 : 0;
    final double top = active ? 10 : 50;

    Item item = Item(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      url: map['url'],
      price: map['price'],
      category: map['category'],
    );

    return InkWell(
      onTap: (){
        onItemPressed(item);
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(map['url']),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: blur,
              offset: Offset(offSet, offSet),
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Text(
                map['name'],
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onItemPressed(Item item) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemDetailScreen(item);
    }));
  }

}