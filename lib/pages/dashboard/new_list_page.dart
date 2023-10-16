import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/services/authentication/auth_service.dart';
import 'package:shopmate/services/crud_services.dart';

class NewListPage extends StatefulWidget {
  @override
  State<NewListPage> createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  late final ListsService myListsService;
  late final TextEditingController titleController;

  DatabaseList? myList;

  Future<DatabaseList> createNewList() async {
    final existingList = myList;
    if (existingList != null) {
      return existingList;
    }
    final currentUser = AuthService.firebase().currentUser;
    if (currentUser == null) {
      throw Exception("User not authenticated");
    }
    final email = currentUser.email;
    if (email == null) {
      throw Exception("User email not available");
    }

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

  // Updating our text controller upon text changes
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

  void setUpTextControllerListener() {
    titleController.removeListener(textControllerListener);
    titleController.addListener(textControllerListener);
  }



  @override
  void initState() {
    myListsService = ListsService();
    titleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    deleteNoteIfTextIsEmpty();
    saveListsIfTextIsNotEmpty();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DatabaseList>(
      future: createNewList(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            myList = snapshot.data ;
            // myList = snapshot.data;
            setUpTextControllerListener();
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Create New Item",
                  style: TextStyle(
                    color: Colors.black, 
                  ),
                ),
                backgroundColor: Colors.transparent, 
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    context.go("/list_page");
                  },
                ),
              ),
              body: Column(
                children: [
                  TextField(
                    controller: titleController, 
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "list",
                    ),
                    onChanged: (value) {},
                  ),
                ],
              ),
            );
          default: return CircularProgressIndicator();
        }
      },
    );
  }
}
