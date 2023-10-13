import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/pages/dashboard/menubar.dart';
import 'package:shopmate/services/authentication/auth_service.dart';
import 'package:shopmate/services/crud_services.dart';
import 'package:shopmate/widgets/elevated_button_widget.dart';
// import 'package:shopmate/widgets/elevated_button_widget.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late final ListsService myListsService;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  DatabaseList? myList;

  Future<DatabaseList> createNewList() async {
    final existingList = myList;
    if (existingList != null) {
      return existingList;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final email = currentUser.email!;
    final owner = await myListsService.getUser(email: email);
    return await myListsService.createLists(owner: owner);
  }

  void deleteNoteIfTextIsEmpty() {
    final list = myList;
    if (titleController.text.isEmpty && list != null) {
      myListsService.deleteList(id: list.id);
    }
  }

  void saveListsIfTextIsNotEmpty() async {
    final list = myList;
    final text = titleController.text;
    if (list != null && text.isNotEmpty) {
      await myListsService.updateList(
        list: list,
        text: text,
      );
    }
  }

  void textControllerListener() async {
    final list = myList;
    if (list == null) {
      return;
    }

    final text = titleController.text;
    await myListsService.updateList(
      list: list,
      text: text,
    );
  }

  void descriptionControllerListener() async {
    final list = myList;
    if (list == null) {
      return;
    }

    final text = titleController.text;
    await myListsService.updateList(
      list: list,
      text: text,
    );
  }

  void setUpTextControllerListener() {
    titleController.removeListener(textControllerListener);
    titleController.addListener(textControllerListener);
    descriptionController.removeListener(descriptionControllerListener);
    descriptionController.addListener(descriptionControllerListener);
  }

  String get userEmail =>
      AuthService.firebase().currentUser!.email ?? "shoppinglist@gmail.com";

//adding and myTitle to the list builder
  List<String> descriptionList = ["List 1", "List 2", "List 3"];
  List<String> titleList = ["List 1", "List 2", "List 3"];

  void addNewList() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTitleList = "";
        return AlertDialog(
          title: Text("Create New Itemlist"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Title",
                ),
                controller: titleController,
                onChanged: (value) {
                  newTitleList = value;
                },
              ),
              SizedBox(
                  height: 16), // Add some vertical space between the fields
              TextField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Description",
                ),
                onChanged: (value) {
                  // newDescriptionList = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButtonWidget(
              text: "Save",
              onPressed: () {
                // Handle the saving of the title and description
                // You can access the title and description from the onChanged handlers.
                setState(() {
                  // descriptionList.add(newDescriptionList);
                  titleList.add(newTitleList);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    myListsService = ListsService();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    myListsService.closeDb();
    deleteNoteIfTextIsEmpty();
    saveListsIfTextIsNotEmpty();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
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
      body: FutureBuilder(
        // future: myListsService.getOrCreateUser(email: userEmail),
        future: createNewList(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              //how we get our notes from our snapshot
              // myList = snapshot.data as DatabaseList;
              // setUpTextControllerListener();
              return Column(
                children: [
                  // Your myList of items

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: titleList.length,
                    itemBuilder: (context, index) {
                      final myTitle = titleList[index];
                      return ListTile(
                        title: Text(
                          myTitle,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        subtitle: Text("my items"),
                        tileColor: Color(0xFFD9D9D9),
                        minVerticalPadding: 12,
                        contentPadding: EdgeInsets.all(10),
                        // leading: Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     IconButton(
                        //       onPressed: () {},
                        //       icon: Icon(Icons.edit),
                        //     ),
                        //     IconButton(
                        //       onPressed: () {},
                        //       icon: Icon(Icons.delete),
                        //     ),
                        //   ],
                        // ),
                      );
                    },
                  ),

                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.go("/login_page");
                              },
                              icon: Icon(Icons.home),
                              iconSize: 40,
                            ),
                            IconButton(
                              onPressed: () {
                                addNewList();
                              },
                              icon: Icon(Icons.add_circle),
                              iconSize: 60,
                            ),
                            // Where the home and addition icons will be placed at the very bottom.
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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

//       body: FutureBuilder(
//         future: myListsService.getOrCreateUser(email: userEmail),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               return StreamBuilder(
//                 stream: myListsService.allLists,
//                 builder: (context, snapshot) {
//                   switch (snapshot.connectionState) {
//                     case ConnectionState.waiting:
//                       return Text("Waiting For All Notes.......");
//                     default:
//                       return CircularProgressIndicator();
                    
//                   }
//                 },
//               );
//             default:
//               return CircularProgressIndicator();
//           }
//           // if (snapshot.connectionState == ConnectionState.done) {
//           //   return Text("hey baby");
//           // }
//         },
//       ),
//     );
//   }
// }
 


  
  //         // Your myList of items
  //         Expanded(
  //           child: ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: descriptionList.length,
  //             itemBuilder: (context, index) {
  //               final myTitle = descriptionList[index];
  //               return   ListTile(
  //                   // visualDensity: VisualDensity.compact,
  //                   title: Text(
  //                     myTitle,
  //                     style: TextStyle(fontSize: 20, color: Colors.black),
  //                   ),
  //                   subtitle: Text("items"),
  //                 );
  //             },
  //           ),
  //         ),

 
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),