import 'package:cloud_firestore/cloud_firestore.dart';

Future addUserCollectionDetails(String fullName, String email) async {
  await FirebaseFirestore.instance.collection("users").add(
    {
      "full name": fullName,
      "email": email,
    },
  );
}