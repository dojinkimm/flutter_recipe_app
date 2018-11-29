import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future delete(BuildContext context, String foodDetail, String foodQuantity,
    String category) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("삭제하시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "삭제",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                FirebaseAuth.instance.currentUser().then((user) {
                  final DocumentReference docRef = Firestore.instance
                      .document('users/${user.uid}')
                      .collection('ingredients')
                      .document(category);
                  Firestore.instance.runTransaction((Transaction tx) async {
                    DocumentSnapshot snapshot = await tx.get(docRef);
                    if (snapshot.data['item'].contains(foodDetail)) {
                      await tx.update(snapshot.reference, <String, dynamic>{
                        'item': FieldValue.arrayRemove([foodDetail])
                      });
                    }
                    if (snapshot.data['quantity'].contains(foodQuantity)) {
                      await tx.update(snapshot.reference, <String, dynamic>{
                        'quantity': FieldValue.arrayRemove([foodQuantity])
                      });
                    }
                  });
                }).whenComplete(() {
                  Navigator.pop(context);
                });
              },
            ),
            RaisedButton(
              color: Colors.black,
              child: Text(
                "닫기",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      });
}
