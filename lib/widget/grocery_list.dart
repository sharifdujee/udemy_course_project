import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/model/grocery_item.dart';
import 'package:shopping_list/widget/new_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  String? _error;
  var _isLoading = true;
  void _loadItem() async {
    setState(() {
      _isLoading = true; // Show loading indicator at the start
    });

    final url = Uri.https('shopping-list-1acc5-default-rtdb.firebaseio.com', 'shopping-list.json');

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _error = "Something went wrong, please try again later.";
          _isLoading = false;
        });
        return;
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
          _groceryItems = []; // Clear items if no data is returned
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> loadedItems = [];

      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere((catItem) => catItem.value.title == item.value['category'])
            .value;

        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }

      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false; // Stop loading indicator after data is loaded
      });
    } catch (error) {
      setState(() {
        _error = "An error occurred while loading items.";
        _isLoading = false;
      });
    }
  }


  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (context) => const NewItem()),
    );

    // Only add to the list if `newItem` is not null
    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem);
      });
    }

    // Reload items to ensure the latest data is fetched from Firebase
    _loadItem();
  }


  void _removeItem(GroceryItem item) async{
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https('shopping-list-1acc5-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    final response = await http.delete(url);

    if(response.statusCode>=400){
      setState(() {
       _groceryItems.insert(index, item);
      });

    }

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _loadItem();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No Items added yet'),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    } else if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            resizeDuration: const Duration(milliseconds: 500),
            onDismissed: (direction) {
              _removeItem(_groceryItems[index]);
            },
            key: ValueKey(_groceryItems[index].id),
            child: ListTile(
              title: Text(_groceryItems[index].name),
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItems[index].category.color,
              ),
              trailing: Text(_groceryItems[index].quantity.toString()),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Grocery'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}

/// Use Future Builder
/*
import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/model/grocery_item.dart';
import 'package:shopping_list/widget/new_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  late Future<List<GroceryItem>> _loadedItems;
  String? _error;
  Future <List<GroceryItem>> _loadItem() async {
    final url = Uri.https('shopping-list-1acc5-default-rtdb.firebaseio.com',
        'shopping-list.json');

     final response = await http.get(url);
     if (response.statusCode > 400) {
       throw Exception('Failed to fetch grocery item please try again later');
       /*setState(() {
         _error = "Something went wrong please try again later";
       });*/
     }

     if(response.body == 'null'){

       return [];
     }
     final Map<String, dynamic> listData = json.decode(response.body);
     final List<GroceryItem> loadedItem = [];
     for (final item in listData.entries) {
       final category = categories.entries
           .firstWhere(
               (catItem) => catItem.value.title == item.value['category'])
           .value;
       loadedItem.add(GroceryItem(
           id: item.key,
           name: item.value['name'],
           quantity: item.value['quantity'],
           category: category));
     }
     return loadedItem;





  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (context) => const NewItem()));

    if (newItem == null) {
      setState(() {
        _groceryItems.add(newItem!);
      });
    }

    // Reload items to ensure the latest data is fetched from Firebase
    _loadItem();
  }

  void _removeItem(GroceryItem item) async{
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https('shopping-list-1acc5-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    final response = await http.delete(url);

    if(response.statusCode>=400){
      setState(() {
       _groceryItems.insert(index, item);
      });

    }

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadedItems = _loadItem();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No Items added yet'),
    );
   /* if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }*/
    /*if (_groceryItems.isNotEmpty) {

    }*/
    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Grocery'),
          actions: [
            IconButton(
                onPressed: () {
                  _addItem();
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(future: _loadedItems, builder: (context, snapshot){
          if(snapshot.connectionState== ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );

          }
          if(snapshot.data!.isEmpty){
            return const Center(
              child: Text('No Item added yet'),
            );
          }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    resizeDuration: const Duration(milliseconds: 500),
                    onDismissed: (direction) {
                      _removeItem(snapshot.data![index]);
                    },
                    key: ValueKey(snapshot.data![index].id),
                    child: ListTile(
                      title: Text(snapshot.data![index].name),
                      leading: Container(
                        width: 24,
                        height: 24,
                        color: snapshot.data![index].category.color,
                      ),
                      trailing: Text(snapshot.data![index].quantity.toString()),
                    ),
                  );
                });
          }

        ));
  }
}

 */
