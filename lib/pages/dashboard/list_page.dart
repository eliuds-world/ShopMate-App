import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:shopmate/pages/dashboard/menubar.dart';
import 'package:shopmate/services/authentication/auth_service.dart';
import 'package:shopmate/services/crud_services.dart';
// import 'package:shopmate/widgets/elevated_button_widget.dart';
// import 'package:shopmate/widgets/elevated_button_widget.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late final ListsService myListsService;

  //exposing the functionality in my list_page that grabs the users email
  String get userEmail =>
      AuthService.firebase().currentUser!.email ?? "shoppinglist@gmail.com";

  @override
  void initState() {
    myListsService = ListsService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;

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
        // backgroundColor: ,
      ),
      body: FutureBuilder(
        future: myListsService.getOrCreateUser(email: userEmail),
        // future: createNewList(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              //how we get our notes from our snapshot
              // myList = snapshot.data as DatabaseList;
              // setUpTextControllerListener();
              return StreamBuilder(
                stream: myListsService.allLists,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      if (snapshot.hasData) {
                        final allLists = snapshot.data as List<DatabaseList>;

                        return ListView.builder(
                          itemCount: allLists.length,
                          itemBuilder: (context, index) {
                            final list = allLists[index];
                            return ListTile(
                              title: Text(
                                list.listText,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              subtitle: Text("my items"),
                              tileColor: Color(0xFFD9D9D9),
                              minVerticalPadding: 12,
                              contentPadding: EdgeInsets.all(10),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Add your edit logic here
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Add your delete logic here
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                   
          
                    default:
                      return CircularProgressIndicator();
                  }
                },
              );
            case ConnectionState.waiting:
            case ConnectionState.active:
              return CircularProgressIndicator();

            default:
              return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
