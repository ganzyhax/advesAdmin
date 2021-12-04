// ignore_for_file: file_names

import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';

class Korzina extends StatefulWidget {
  const Korzina({Key? key}) : super(key: key);

  @override
  _KorzinaState createState() => _KorzinaState();
}

class _KorzinaState extends State<Korzina> {
  String? id_final;

  Future _saver(String url) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage('https://firebasestorage.googleapis.com/v0/b/calcium-task-254113.appspot.com/o/image2021-11-28%2015%3A43%3A39.449601?alt=media&token=2c98e989-50ea-4824-9858-ab2f9694bd98.jpeg');
      // if (imageId == null) {
      //   return;
      // }
      print('Downloaded!');
      // Below is a method of obtaining saved image information.
      // var fileName = await ImageDownloader.findName(imageId);
      // print(fileName);
      // var path = await ImageDownloader.findPath(imageId);
      // var size = await ImageDownloader.findByteSize(imageId);
      // var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
  }

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
      stream: FirebaseFirestore.instance.collection('zakazy').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            height: screenHeight * .8,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.data?.docs.length == 0) {
          return Container(
            height: screenHeight * .8,
            child: Center(
                child: Text(
              'Ваша корзина пуста!',
              style: TextStyle(fontSize: 24),
            )),
          );
        }
        return Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            width: width,
            height: screenHeight,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  PageController controller =
                      PageController(viewportFraction: 0.6, initialPage: 1);

                  String image = snapshot.data?.docs[index]['image'];
                  String email = snapshot.data?.docs[index]['email'];
                  String name = snapshot.data?.docs[index]['name'];
                  String tel = snapshot.data?.docs[index]['tel'];
                  String type = snapshot.data?.docs[index]['type'];
                  String time = snapshot.data?.docs[index]['data'];
                  String location = snapshot.data?.docs[index]['location'];
                  String del = snapshot.data?.docs[index]['id_del'];
                  String isV = '';
                  if (image.toString().contains('video')) {
                    isV =
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Video_camera_icon.svg/768px-Video_camera_icon.svg.png';
                  }
                  if (location == '1') {
                    location = 'Атакент';
                  } else {
                    location = 'пр. Жибек Жолы';
                  }
                  return InkWell(
                    onTap: () {
                      print(snapshot.data?.docs[index]['image'].toString());
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          child: Column(
                            children: [
                              Card(
                                child: Container(
                                  height: 220,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: (isV.toString() != '')
                                              ? NetworkImage(isV.toString())
                                              : NetworkImage(
                                                  image.toString()))),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Color(0xffC9BEA8),
                                                  size: 35,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        color: Color(0xffC9BEA8)
                                                            .withOpacity(0.7)),
                                                    child: Text(
                                                      location,
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        color: Color(0xffC9BEA8)
                                                            .withOpacity(0.7)),
                                                    child: Text(
                                                      type,
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.people,
                                              size: 30,
                                              color: Color(0xffC9BEA8),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              name,
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              size: 30,
                                              color: Color(0xffC9BEA8),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(tel,
                                                style: TextStyle(fontSize: 18)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.email,
                                                size: 30,
                                                color: Color(0xffC9BEA8),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(email,
                                                  style:
                                                      TextStyle(fontSize: 18))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RaisedButton(
                                child: Text('Скачать фотку'),
                                onPressed: () async {
                                  // showLoadingDialog(context);
                                  // Saved with this method.
                                  var imageId = await ImageDownloader.downloadImage(image.toString()).then((value) => 
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Фото сохранено!")))
                                  );
                                  // var path = await ImageDownloader.findPath(imageId);
                                  // await ImageDownloader.open(path);
                                  // _saver(image.toString());

                                  // showToast('Image downloaded.');
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RaisedButton(
                                  color: Color(0xffC9BEA8),
                                  child: Text(
                                    'Удалить',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('zakazy')
                                        .doc(del)
                                        .delete()
                                        .then((value) => showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Успешно'),
                                                content:
                                                    Text('Успешно удалено!'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      child: Text('OK'),
                                                      onPressed: () async {
                                                        Navigator.pop(
                                                            context, true);
                                                      }),
                                                ],
                                              );
                                            }));
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }

  Future<String?> _read() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_id.txt');
    String id_file = await file.readAsString();
    if (id_final == null) {
      setState(() {
        id_final = id_file;
      });
    }
  }
}
