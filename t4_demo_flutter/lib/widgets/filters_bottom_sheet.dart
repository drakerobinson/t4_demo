import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersBottomSheet extends ConsumerStatefulWidget {
  @override
  FiltersBottomSheetState createState() => FiltersBottomSheetState();
}

class FiltersBottomSheetState extends ConsumerState<FiltersBottomSheet> {


  @override
  Widget build(BuildContext context) {
    return Container(
     child: getExclusions()
    );
  }



  getExclusions() {
    return ListView(

    );
  }


}