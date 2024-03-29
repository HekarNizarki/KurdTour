import 'package:KurdTour/style_widget/card.dart';
import 'package:KurdTour/style_widget/smallcard.dart';
import 'package:flutter/material.dart';
import '../locationDetiles/locationdetiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:KurdTour/data/location.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  _HomeMainScreenState createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  final _fireStore = FirebaseFirestore.instance;

  // Initial Selected Value
  String dropdownvalue = 'Duhok';

  // List of items in our dropdown menu
  var items = [
    'Duhok',
    'Erbil',
    'Sulaimaniya',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Most important location',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.amber[500],
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    'Most Imported location in kurdistan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: _fireStore
                        .collection("Location")
                        .orderBy('rating', descending: true)
                        .limit(10)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const LinearProgressIndicator();
                      }
                      List<Location> _locations = snapshot.data!.docs
                          .map((e) => Location.fromMap(
                              e.data() as Map<String, dynamic>))
                          .toList();

                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _locations.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: smallcard(
                                    image: _locations[index].image,
                                    titledoc: _locations[index].title,
                                    ratingnew: _locations[index].rating),
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => LocationDetileView(
                                          loc: _locations[index]))),
                            );
                          });
                    }),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Most Imported location in   ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton(
                          // Initial Value
                          value: dropdownvalue,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  )),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: _fireStore
                        .collection("Location")
                        .where('locationname', isEqualTo: dropdownvalue)
                        .limit(10)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const LinearProgressIndicator();
                      }
                      List<Location> _locations = snapshot.data!.docs
                          .map((e) => Location.fromMap(
                              e.data() as Map<String, dynamic>))
                          .toList();

                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _locations.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: smallcard(
                                    image: _locations[index].image,
                                    titledoc: _locations[index].title,
                                    ratingnew: _locations[index].rating),
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => LocationDetileView(
                                          loc: _locations[index]))),
                            );
                          });
                    }),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    'All locations',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Expanded(
                flex: 2,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _fireStore.collection("Location").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const LinearProgressIndicator();
                      }
                      List<Location> _locations = snapshot.data!.docs
                          .map((e) => Location.fromMap(
                              e.data() as Map<String, dynamic>))
                          .toList();

                      return ListView.builder(
                          itemCount: _locations.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: generalcard(
                                    image: _locations[index].image,
                                    titledoc: _locations[index].title,
                                    discription: _locations[index].description,
                                    ratingnew: _locations[index].rating),
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => LocationDetileView(
                                          loc: _locations[index]))),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    _fireStore.collection("Location").add({
      'description': "very new",
      'email': "h@gmail.com",
      'image':
          "https://firebasestorage.googleapis.com/v0/b/kurdtour-3d30f.appspot.com/o/05.jpg?alt=media&token=431a3130-573d-448a-9546-318cc2699fc7",
      'lid': "",
      'loca': 25,
      'locl': 22,
      'openhourse': "10:30 12:30",
      'rating': 1,
      'locationname': 'locationname',
      'title': "duhok mall",
      'website': "www.com"
    }).then((value) {
      print(value.id);
    });
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _fireStore.collection('Location').get();
    // Get data from docs and convert map to List
    //for a specific field
    final allData = querySnapshot.docs.map((doc) => doc.get('title')).toList();
    print(allData);
  }
}
