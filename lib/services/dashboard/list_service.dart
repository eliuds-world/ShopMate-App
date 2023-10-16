import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopmate/models/dashboard/shopping_list_model.dart';

final CollectionReference listsCollection = FirebaseFirestore.instance.collection('lists');

class ListService {

  // Create a new shopping list
  static Future<void> createShoppingList(ShoppingList shoppingList) async {
    await listsCollection.add(shoppingList.toJson());
  }

  // Read all shopping lists
  static Stream<List<ShoppingList>> get shoppingLists {
    return listsCollection.snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            return ShoppingList.fromJson(doc.data() as Map<String, dynamic>);
          },
        ).toList();
      },
    );
  }

  // Update a shopping list
  static Future<void> updateShoppingList(String documentId, ShoppingList shoppingList) async {
    await listsCollection.doc(documentId).update(shoppingList.toJson());
  }

  // Delete a shopping list
  static Future<void> deleteShoppingList(String documentId) async {
    await listsCollection.doc(documentId).delete();
  }
}
