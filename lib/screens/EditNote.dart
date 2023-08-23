import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class EditNote extends StatefulWidget {

  final Map data;
 // final String time;
  final DocumentReference ref;

  EditNote(this.data, this.ref);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  final title = TextEditingController();
  final content = TextEditingController();

  //Sets up the text fields using textField widget and controllers based on retrieved data from homepage
  void getNoteInfo() async {
    title.text = "${widget.data['title']}";
    content.text = "${widget.data['content']}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNoteInfo();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[700],
                        ),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: (){
                        addEdits();
                        delete();
                      },
                      child: Icon(Icons.save),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[700],
                        ),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: (){
                        delete();
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.delete),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[700],
                        ),
                      ),
                    ),


                  ],
                ),
                SizedBox(height: 12),
                Column(
                  children: [

                    TextField(
                      controller: title,
                      style: TextStyle(fontSize: 32),
                    ),


                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: TextField(
                        controller: content,
                        decoration: InputDecoration.collapsed(hintText: 'Type Shit Here'),
                        style: TextStyle(fontSize: 18),
                        maxLines: 100,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    await widget.ref.delete();
  }


  void addEdits(){
    //modifies data in db
    CollectionReference ref =
    FirebaseFirestore.instance.collection('users').
    doc(FirebaseAuth.instance.currentUser!.uid).  //remove ! here if problems
    collection('notes');

    var newNoteData = {
      'title' : title.text,
      'content' : content.text,
      'edited' : DateTime.now(),
    };

    ref.add(newNoteData);

    Navigator.pop(context);

  }
}
