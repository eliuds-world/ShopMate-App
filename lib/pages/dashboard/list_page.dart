import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/models/dashboard/shopping_list_model.dart';
import 'package:shopmate/pages/dashboard/menubar.dart';
import 'package:shopmate/services/authentication/auth_service.dart';
import 'package:shopmate/services/dashboard/list_service.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  String get userEmail => AuthService.firebase().currentUser!.email ?? "shoppinglist@gmail.com";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: SizedBox(
        width: 200,
        child: NavBarWidget(),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Icon(Icons.notifications_rounded),
        title: Text(
          "Shopping List",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go("/new_list_page");
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<ShoppingList>>(
        stream: ListService.shoppingLists,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allLists = snapshot.data ?? [];

                if (allLists.isEmpty) {
                  return Center(
                    child: Text("No shopping lists available."),
                  );
                }

                return ListView.builder(
                  itemCount: allLists.length,
                  itemBuilder: (context, index) {
                    final list = allLists[index];
                    return ListTile(
                      title: Text(
                        list.name,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      subtitle: Text(
                        'Category: ${list.category}',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      minVerticalPadding: 12,
                      contentPadding: EdgeInsets.all(10),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit, color: Colors.orange),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }

            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
