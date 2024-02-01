import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:t4_demo_flutter/widgets/grocery_browser.dart';
import 'package:t4_demo_flutter/widgets/persisted_grocery_list.dart';
import 'package:t4_demo_flutter/widgets/recipes_browser.dart';

import 'constants/colors.dart';
import 'constants/strings.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Strings.appTitle,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      home: const MyHomePage(title: Strings.appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List<Widget> pages = [
    PersistedGroceryList(),
    GroceryBrowser(),
    RecipesBrowser(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPage = 0;
    _pageController.addListener(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkPrimary,
        title: Text(widget.title),
      ),
      body: PageView(
        allowImplicitScrolling: false,
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          updatePage(index);
        },
      ),
      floatingActionButton: getPositionIndicator(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  getPositionIndicator() {
    Color activeColor = AppColors.lightPrimary;
    Color inactiveColor = Colors.grey.withOpacity(.5);
    return Container(

      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(25)
      ),
        child: DotsIndicator(
              dotsCount: 3,
            position: _currentPage,
            mainAxisAlignment: MainAxisAlignment.center,
          decorator: const DotsDecorator(
            activeColor: AppColors.darkPrimary,
            color: Colors.white
          ),
          onTap: (index) {
                updatePage(index);
          },
    ));
  }

  updatePage(int index) {
    setState(() {
      _currentPage = index;
      _pageController.jumpToPage(index);
    });
  }

}
