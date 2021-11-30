// ignore_for_file: file_names

// import 'package:advesting/screens/infoWid.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:advesting/app_navigator.dart';

class newCard extends StatefulWidget {
  const newCard({Key? key}) : super(key: key);

  @override
  _newCardState createState() => _newCardState();
}

class _newCardState extends State<newCard> {
  String? imageFile;
  TextEditingController controllName = new TextEditingController();
  TextEditingController controllTel = new TextEditingController();
  TextEditingController controllEmail = new TextEditingController();
  int isLoadImage = 0;
  final picker = ImagePicker();
  chooseFile(ImageSource source) async {
    setState(() {
      isLoadImage = 1;
      imageFile = 'http://simpleicon.com/wp-content/uploads/loading.png';
    });
    final PickedFile = await picker.getImage(
      source: source == 'gallery' ? ImageSource.camera : ImageSource.gallery,
    );

    FirebaseStorage storage = FirebaseStorage.instance;
    String mal = '';

    // if (File(PickedFile!.path) != null) {
    Reference ref = storage.ref().child("image" + DateTime.now().toString());
    if (PickedFile != null) {
      UploadTask uploadTask = ref.putFile(File(PickedFile.path));

      uploadTask.whenComplete(() async {
        try {
          String mal = await ref.getDownloadURL();
          setState(() {
            imageFile = mal;
          });
        } catch (onError) {
          print("Error");
        }

        print(mal);
      });
    } else {
      imageFile = '';
    }

    // }

    // print(File(PickedFile!.path));

    return null;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    List<Widget> banners = <Widget>[];
    PageController controller =
        PageController(viewportFraction: 0.9, initialPage: 0);
    double width = MediaQuery.of(context).size.width;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Добавить новую карту',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  width: width - 20,
                  child: TextFormField(
                    decoration: InputDecoration(
                        // filled: true,
                        // fillColor: Color(0xFFF2F2F2),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 2, color: Color(0xffC9BEA8)),
                        ),
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Color(0xffC9BEA8))),
                        prefixIcon:
                            Icon(Icons.people, color: Color(0xffC9BEA8)),
                        labelText: 'Имя локации',
                        labelStyle: TextStyle(color: Colors.black)),
                    controller: controllName,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  width: width - 20,
                  child: TextFormField(
                    decoration: InputDecoration(
                        // filled: true,
                        // fillColor: Color(0xFFF2F2F2),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 2, color: Color(0xffC9BEA8)),
                        ),
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Color(0xffC9BEA8))),
                        prefixIcon:
                            Icon(Icons.people, color: Color(0xffC9BEA8)),
                        labelText: 'Текст',
                        labelStyle: TextStyle(color: Colors.black)),
                    controller: controllEmail,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  width: 360,
                  height: 230,
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        blurRadius: 20.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 70),
                            child: (isLoadImage != 0)
                                ? Image.network(
                                    imageFile.toString(),
                                  )
                                : Icon(
                                    Icons.photo_camera_back,
                                    size: 200,
                                    color: Color(0xffC9BEA8),
                                  ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                chooseFile(ImageSource.gallery);
                              },
                              child: Container(
                                width: width,
                                height: 40,

                                // margin: const EdgeInsets.all(15.0),
                                // padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          4, 3), // changes position of shadow
                                    ),
                                  ],
                                ),

                                child: Center(
                                    child: (imageFile != null)
                                        ? Text(
                                            'Поменять картинку',
                                            style: TextStyle(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          )
                                        : Text(
                                            'Добавить картинку',
                                            style: TextStyle(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                  color: Color(0xffC9BEA8),
                  child: Text(
                    'Добавить',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    final firebase = FirebaseFirestore.instance;
                    DocumentReference refs =
                        await firebase.collection('widgets').doc();
                    if (imageFile.toString() != null &&
                        controllName.text.toString() != '' &&
                        controllEmail.text.toString() != '') {
                      print(imageFile.toString());
                      print(controllName.text);
                      print(controllEmail.text);
                      refs.set({
                        'image': imageFile.toString(),
                        'address': controllName.text.toString(),
                        'text': controllEmail.text.toString(),
                        'id_del': refs.id.toString(),
                      }).then((value) => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Успешно'),
                              content: Text('Успешно создана!'),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text('OK'),
                                    onPressed: () async {
                                      Navigator.pop(context, true);
                                    }),
                              ],
                            );
                          }));
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Ошибка'),
                              content: Text('Все поле не заполнены!'),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text('OK'),
                                    onPressed: () async {
                                      Navigator.pop(context, true);
                                    }),
                              ],
                            );
                          });
                    }
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
