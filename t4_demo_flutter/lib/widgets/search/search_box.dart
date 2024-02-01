import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/providers/search_providers.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  @override
  CustomSearchBarState createState()=> CustomSearchBarState();
}

class CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  String query = '';

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
      if(newQuery.isNotEmpty) {ref.read(queryProvider.notifier).update((state) => newQuery);}

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: InputDecoration(
          labelText: "Search For Groceries",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search)
        ),
      )
    );
  }

}