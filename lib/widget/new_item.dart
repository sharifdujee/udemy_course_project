import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/model/category.dart';
import 'package:shopping_list/model/grocery_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var enteredName = '';
  var enterQuantity = 1;
  var selectedCategory = categories[Categories.vegetables]!;
  var _isSending = false;

  void _saveItem() async  {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https('shopping-list-1acc5-default-rtdb.firebaseio.com',
          'shopping-list.json');
     final response =  await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': enteredName,
            'quantity': enterQuantity,
            'category': selectedCategory.title,
          },
        ),
      );
     final Map<String, dynamic> resData = json.decode(response.body);
     /*print(response.body);
     print(response.statusCode);*/
     if(!context.mounted){
       return;
     }
     Navigator.of(context).pop(GroceryItem(id: resData['name'], name: enteredName, quantity: enterQuantity, category: selectedCategory));

     /* Navigator.of(context).pop(GroceryItem(
          id: DateTime.now().toString(),
          name: enteredName,
          quantity: enterQuantity,
          category: selectedCategory));*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return "Must be 1 and 50 characters";
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredName = value!;
                },
                maxLength: 50,
                decoration: InputDecoration(
                    label: const Text('Title'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: true),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return "Must be a valid positive number";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          label: Text('Quantity'),
                          border: OutlineInputBorder()),
                      initialValue: enterQuantity.toString(),
                      onSaved: (value) {
                        enterQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                        value: selectedCategory,
                        decoration: InputDecoration(
                            label: const Text('Select Category'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: category.value.color,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(category.value.title)
                                  ],
                                ))
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: _isSending? null : () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('Reset')),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: _isSending ? null : _saveItem,
                      child: _isSending? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      ): const Text('Saving'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
