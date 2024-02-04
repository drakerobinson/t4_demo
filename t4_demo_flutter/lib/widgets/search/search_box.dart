import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/providers/search_providers.dart';

class CustomSearchBar extends ConsumerStatefulWidget {

  final String hintText;

  CustomSearchBar(this.hintText);

  @override
  CustomSearchBarState createState()=> CustomSearchBarState(hintText);
}

class CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  String query = '';

  final String hintText;

  CustomSearchBarState(this.hintText);

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
          labelText: hintText,
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search)
        ),
      )
    );
  }

}