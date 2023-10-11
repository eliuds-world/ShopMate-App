import 'package:flutter/material.dart';
import 'package:shopmate/widgets/elevated_button_widget.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<String> itemList = ["List 1", "List 2", "List 3"];
  void addNewList() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newItemList = "";
        return AlertDialog(
          title: Text("Create New Itemlist"),
          content: TextField(
            onChanged: (value) {
              newItemList = value;
            },
          ),
          actions: <Widget>[
            ElevatedButtonWidget(
              text: "Save",
              onPressed: () {
                setState(() {
                  itemList.add(newItemList);
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
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.07,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_rounded),
                iconSize: 30,
              ),
              Text(
                "Shopping list",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu),
                iconSize: 40,
              )
            ],
          ),

          // Your list of items
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                final item = itemList[index];
                return   ListTile(
                    // visualDensity: VisualDensity.compact,
                    title: Text(
                      item,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    subtitle: Text("items"),
                  );
              },
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home),
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: () {
                    addNewList();
                  },
                  icon: Icon(Icons.add_circle),
                  iconSize: 60,
                )
                // Where the home and addition icons will be placed at the very bottom.
              ],
            ),
          ),
        ],
      ),
    );
  }
}
