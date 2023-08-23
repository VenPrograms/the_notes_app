import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_notes_app/screens/AddNote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:the_notes_app/screens/EditNote.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CollectionReference ref =
  FirebaseFirestore.instance.collection('users').
  doc(FirebaseAuth.instance.currentUser!.uid).  //remove ! here if problems
  collection('notes');


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
          backgroundColor: Colors.grey[700],
          title: Text('Rizz Notes Ultra'),
      ),
      
      body: FutureBuilder(
        future: ref.get(),
          builder: (context, snapshot){

          if(snapshot.hasData){
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              itemCount: snapshot.data!.docs.length, // remove ! if problems
                itemBuilder: (context, index) {
                Map noteData = snapshot.data!.docs[index].data() as Map;
                DateTime currentDateTime = noteData['created'].toDate();
                return Card(
                  color: Colors.grey[700],
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 15),
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: GestureDetector(
                    onDoubleTap: () {

                    },
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EditNote(
                                  noteData,
                                 // "Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(currentDateTime)}",
                                  snapshot.data!.docs[index].reference,
                                )
                        )).then((value) {
                          setState(() {});
                        });
                      },
                      title: RichText(
                        text: TextSpan(
                          text: "${(noteData['title'])} \n", //ADD TITLE
                          style: TextStyle(
                            color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1.5,
                        ),

                          children: [
                            TextSpan(
                              text: "${(noteData['content'])}", //ADD CONTENT
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 1.5 //try deleting this
                              )
                            )
                          ]
                        ),
                      ),
                      subtitle: Container(
                        padding: const EdgeInsets.only(top: 8.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(currentDateTime)}",
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.white
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.access_alarms),
                      ),
                    ),
                  ),
                );
                }
            );
          }
          else{
           return Center(child: Text('Loading'));
          }
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddNote())
          ).then((value) {
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey[700],
      ),
      
    );

  }
}
