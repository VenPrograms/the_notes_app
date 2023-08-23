import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  String title = "";
  String content = "";

  bool checkListMode = false;
  

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

                    SizedBox(width: 140),

                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          checkListMode = true;
                        });
                      },
                      child: Icon(Icons.checklist),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[700],
                        ),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: (){
                        add();
                      },
                      child: Icon(Icons.save),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[700],
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(height: 12),
                Form(child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration.collapsed(hintText: 'Title'),
                      style: TextStyle(fontSize: 32),
                      onChanged: (titleval){
                        title = titleval;
                      },
                    ),



                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(hintText: 'Type Shit Here'),
                        style: TextStyle(fontSize: 18),
                        onChanged: (contentval){
                          content = contentval;
                        },
                        maxLines: 100,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }



  void add(){
    //saves to database
    CollectionReference ref =
    FirebaseFirestore.instance.collection('users').
    doc(FirebaseAuth.instance.currentUser!.uid).  //remove ! here if problems
    collection('notes');

    var newNoteData = {
      'title' : title,
      'content' : content,
      'created' : DateTime.now(),
    };

    ref.add(newNoteData);

    Navigator.pop(context);
    
  }

}
