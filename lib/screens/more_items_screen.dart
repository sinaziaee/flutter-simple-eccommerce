import 'package:ecommerce/models/item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MoreItemsScreen extends StatefulWidget {
  static String id = 'more_items_screen';

  @override
  _MoreItemsScreenState createState() => _MoreItemsScreenState();
}

class _MoreItemsScreenState extends State<MoreItemsScreen> {

  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child('Items');

  Map args;

  @override
  Widget build(BuildContext context) {

    search();

    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: dbRef.orderByChild('category').equalTo(args['type']).onValue,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            Event event = snapshot.data;
            DataSnapshot snap = event.snapshot;
            Map map = snap.value;
            List<Item> items = [];
            for (Map each in map.values) {
              // print(each);
              Item item = Item(
                id: each['id'],
                name: each['name'],
                description: each['description'],
                url: each['url'],
                price: each['price'],
                category: each['category'],
              );
              items.add(item);
            }
            return ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage: (items[index].url != null || items[index].url.length != 0)
                          ? NetworkImage(items[index].url)
                          : AssetImage('assets/images/person.png'),
                    ),
                    title: Text(
                      items[index].name,
                      style: kHeaderTextStyle.copyWith(
                        color: Colors.blueGrey[800],
                      ),
                    ),
                    trailing: Text(
                        '${items[index].price.toString()} \$'
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: kCustomProgressIndicator,
          );
        },
      ),
    );
  }

  search() async{
    Stream stream = dbRef.orderByChild('name').startAt('r')
        .endAt(['r' + '\uf8ff']).onValue;

    Event event = await stream.first;

  }

}
