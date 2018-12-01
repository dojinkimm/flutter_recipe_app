import 'package:cloud_firestore/cloud_firestore.dart';

class BackendService {
  static Future<List> getSuggestions(String query) async {
    List nameList = new List();
    List uidList = new List();
    
    Firestore.instance.collection('recipe').getDocuments().then((docs) {
      docs.documents.forEach((doc) {
        if (query != "") {
          if (doc.data['recipeName'].contains(query)) {
            nameList.add(doc.data['recipeName']);
            uidList.add(doc.data['uid']);
          }
        }
      });
    });
    await Future.delayed(Duration(seconds: 1));

    return List.generate(nameList.length, (index) {
      return {'name': nameList[index], 'uid': uidList[index]};
    });
  }
}