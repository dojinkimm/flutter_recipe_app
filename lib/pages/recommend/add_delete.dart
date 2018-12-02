import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Null> saveData(
    String recipeUid, String reName, String imageURL) async {
  List allRecipeUid = new List();
  List allUserUid = new List();
  List recipeName = new List();
  List recipeURL = new List();
  allRecipeUid.add(recipeUid);
  recipeName.add(reName);
  recipeURL.add(imageURL);

  FirebaseAuth.instance.currentUser().then((user) {
    allUserUid.add(user.uid);

    final DocumentReference docRef =
        Firestore.instance.document('users/${user.uid}');
    final DocumentReference recipeRef =
        Firestore.instance.document('recipe/$recipeUid');

    docRef.get().then((item) {
      //user DB에 saved list에 uid 추가
      //user의 DocumentSnapshot을 의미한다
      if (item.data['saved'].length == 0) {
        docRef.updateData({
          'saved': allRecipeUid,
          'savedName': recipeName,
          'savedURL': recipeURL
        });
      } else {
        for (int i = 0; i < item.data['saved'].length; i++) {
          allRecipeUid.add(item.data['saved'][i]);
          recipeName.add(item.data['savedName'][i]);
          recipeURL.add(item.data['savedURL'][i]);
        }
        docRef.updateData({
          'saved': allRecipeUid,
          'savedName': recipeName,
          'savedURL': recipeURL
        });
      }
    }).catchError((e) => print("user DB에 업로드 오류 - $e"));

    recipeRef.get().then((item) {
      //recipe의 DocumentSnapshot을 의미한다
      if (item.data['saved'].length == 0) {
        recipeRef.updateData({
          'saved': [user.uid]
        });
      } else {
        for (int i = 0; i < item.data['saved'].length; i++) {
          allUserUid.add(item.data['saved'][i]);
        }
        recipeRef.updateData({'saved': allUserUid});
      }
    });
  }).catchError((e) => print("user DB에 업로드 오류 - $e"));
}

Future<Null> deleteData(
    String recipeUid, String recipeName, String imageURL) async {
  FirebaseAuth.instance.currentUser().then((user) {
    final DocumentReference docRef =
        Firestore.instance.document('users/${user.uid}');

    final DocumentReference recipeRef =
        Firestore.instance.document('recipe/$recipeUid');

    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot snapshot = await tx.get(docRef);
      if (snapshot.data['saved'].contains(recipeUid)) {
        await tx.update(snapshot.reference, <String, dynamic>{
          'saved': FieldValue.arrayRemove([recipeUid]),
          'savedName': FieldValue.arrayRemove([recipeName]),
          'savedURL': FieldValue.arrayRemove([imageURL]),
        });
      }
    });

    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot snapshot = await tx.get(recipeRef);
        if (snapshot.data['saved'].contains(user.uid)) {
          await tx.update(snapshot.reference, <String, dynamic>{
            'saved': FieldValue.arrayRemove([user.uid])
          });
        }
      });
    });
  });
}
