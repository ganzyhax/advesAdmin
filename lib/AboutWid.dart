// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AboutWid extends StatefulWidget {
  const AboutWid({Key? key}) : super(key: key);

  @override
  _AboutWidState createState() => _AboutWidState();
}

class _AboutWidState extends State<AboutWid> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    List<Widget> banners = <Widget>[];
    PageController controller =
        PageController(viewportFraction: 0.9, initialPage: 1);
    double width = MediaQuery.of(context).size.width;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('widgets').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            height: screenHeight * .8,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return Container(
          width: width,
          height: screenHeight,
          // height: screenHeight,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                PageController controller =
                    PageController(viewportFraction: 0.6, initialPage: 1);

                String image = snapshot.data?.docs[index]['image'];
                String address = snapshot.data?.docs[index]['address'];
                String text = snapshot.data?.docs[index]['text'];
                String del = snapshot.data?.docs[index]['id_del'];
                return InkWell(
                    onTap: () {
                      // AppNavigator.pushToPage(
                      //     context, InfoWid(whichWid: index));
                    },
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 170),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              address,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Ink.image(
                                image: NetworkImage(image),
                                height: 220,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 24),
                        ),
                        RaisedButton(
                            color: Color(0xffC9BEA8),
                            child: Text(
                              'Удалить',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('widgets')
                                  .doc(del)
                                  .delete()
                                  .then((value) => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Успешно'),
                                          content: Text('Успешно удалено!'),
                                          actions: <Widget>[
                                            FlatButton(
                                                child: Text('OK'),
                                                onPressed: () async {
                                                  Navigator.pop(context, true);
                                                }),
                                          ],
                                        );
                                      }));
                            })
                      ],
                    ));
              }),
        );
      },
    );
  }
}
