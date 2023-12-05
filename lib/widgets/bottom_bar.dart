import 'package:cashmate/controller/bottombar_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/views/transaction/add_transaction/addtransactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  void initState() {
    final provider = Provider.of<BottomProvider>(context, listen: false);
    super.initState();
    provider.currentIndex = widget.initialIndex;
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
    return Consumer<BottomProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: provider.tabs.elementAt(provider.currentIndex),
          extendBody: true,
          bottomNavigationBar: StylishBottomBar(
            hasNotch: true,
            fabLocation: StylishBarFabLocation.center,
            currentIndex: provider.currentIndex,
            onTap: (int index) {
              // setState(() {
              //   _currentIndex = index;
              // });
              provider.indexColors(index);
            },
            items: [
              BottomBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                selectedIcon: const Icon(Icons.home),
                selectedColor: cBlackColor54,
                backgroundColor: cBlackColor,
                title: const Text('Home'),
              ),
              BottomBarItem(
                icon: const Icon(Icons.history_rounded),
                unSelectedColor: cBlackColor,
                backgroundColor: cBlackColor,
                title: const Text('Recent'),
              ),
              BottomBarItem(
                  icon: const Icon(
                    Icons.insert_chart,
                  ),
                  selectedIcon: const Icon(
                    Icons.insert_chart,
                  ),
                  backgroundColor: cBlackColor,
                  selectedColor: cBlackColor54,
                  title: const Text('Statistics')),
              BottomBarItem(
                  icon: const Icon(
                    Icons.settings,
                  ),
                  selectedIcon: const Icon(
                    Icons.settings,
                  ),
                  backgroundColor: cBlackColor,
                  selectedColor: cBlackColor54,
                  title: const Text('Settings')),
            ],
            option: AnimatedBarOptions(
              barAnimation: BarAnimation.fade,
              iconStyle: IconStyle.animated,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddTransaction()));
            },
            backgroundColor: cAppThemeColor,
            child: const Icon(
              Icons.add,
              color: cWhiteColor,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
