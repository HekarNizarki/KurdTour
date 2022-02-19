import 'package:KurdTour/favsreen/favscreen.dart';
import 'package:KurdTour/data/generaluser.dart';
import 'package:KurdTour/search_screen/serchvew.dart';
import 'package:KurdTour/servis/firestore_service.dart';
import 'package:KurdTour/style_widget/card.dart';
import 'package:flutter/material.dart';
import '../profilescreen/profilescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  _HomeMainScreenState createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Location');
  final _fireStore = FirebaseFirestore.instance;

  var rating = 3.0;
  String imagee = 'assets/images/01.jpg';
  String titlee = 'new';
  String discription = 'dec';

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
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 360,
              child: ListView(
                children: [
                  generalcard('assets/images/05.jpg', titlee, discription),
                  generalcard('assets/images/02.jpg', titlee, discription),
                  generalcard('assets/images/03.jpg', titlee, discription),
                  generalcard('assets/images/04.jpg', titlee, discription),
                  ElevatedButton(onPressed: getData, child: Text('data'))
                ],
              ),
            ),
          ),
        ));
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