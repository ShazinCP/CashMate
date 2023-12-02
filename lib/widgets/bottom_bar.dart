import 'package:cashmate/views/settings/settings_screen.dart';
import 'package:cashmate/views/transaction/addtransactions_screen.dart';
import 'package:cashmate/views/transaction/transaction_list.dart';
import 'package:cashmate/views/home/home_screen.dart';
import 'package:cashmate/views/statistics/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  int initialIndex = 0;

  BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  final List tabs = [
     const HomeScreen(),
     const TransactionList(),
     const StatisticsScreen(),
     const Settings()
  ];
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  dynamic selected;
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs.elementAt(_currentIndex),
      extendBody: true, //to make floating action button notch transparent
      //to avoid the floating action button overlapping behavior,
      // when a soft keyboard is displayed
      // resizeToAvoidBottomInset: false,

      bottomNavigationBar: StylishBottomBar(
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: _currentIndex,
        onTap: (int index) {
          // controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomBarItem(
            icon: const Icon(
              Icons.home,
            ),
            selectedIcon: const Icon(Icons.home),
            selectedColor: Colors.black54,
            backgroundColor: Colors.black,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.history_rounded),
            // selectedIcon: const Icon(Icons.category),
            // selectedColor: Color(0xFF77C170),
            unSelectedColor: Colors.black,
            backgroundColor: Colors.black,
            title: const Text('Recent'),
          ),
          BottomBarItem(
              icon: const Icon(
                Icons.insert_chart,
              ),
              selectedIcon: const Icon(
                Icons.insert_chart,
              ),
              backgroundColor: Colors.black,
              selectedColor: Colors.black54,
              title: const Text('Statistics')),
          BottomBarItem(
              icon: const Icon(
                Icons.settings,
              ),
              selectedIcon: const Icon(
                Icons.settings,
              ),
              backgroundColor: Colors.black,
              selectedColor: Colors.black54,
              title: const Text('Settings')),
        ],
        option: AnimatedBarOptions(
          // iconSize: 32,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.animated,
          // opacity: 0.3,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) =>  const AddTransaction()));
        },
        backgroundColor: const Color(0xff368983),
        child: const Icon(
          // heart ? CupertinoIcons.add : CupertinoIcons.add,
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
