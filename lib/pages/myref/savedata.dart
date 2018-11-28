import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Null> saveData(BuildContext context, String category, String ingredient,
    String quantity) async {
  List allItems = new List();
  List allQuantity = new List();
  allItems.add(ingredient);
  allQuantity.add(quantity);
  FirebaseAuth.instance.currentUser().then((user) {
    final DocumentReference docRef = Firestore.instance
        .document('users/${user.uid}')
        .collection('ingredients')
        .document(category);

    docRef.get().then((item) {
      if (item.data['item'][0] == "") {
        docRef.updateData({'item': allItems, 'quantity': allQuantity});
      } else {
        for (int i = 0; i < item.data['item'].length; i++) {
          allItems.add(item.data['item'][i]);
          allQuantity.add(item.data['quantity'][i]);
        }

        docRef.updateData({'item': allItems, 'quantity': allQuantity});
      }
    });
  });
}
