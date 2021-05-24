import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourm_app/core/presentation/customization/ripple_transition.dart';
import 'package:tourm_app/core/presentation/customization/tm_colors.dart';
import 'package:tourm_app/presentation/articles/articles_page.dart';
import 'package:tourm_app/presentation/beacon/beacons_scan_page.dart';
import 'package:tourm_app/presentation/room/rooms_page.dart';
import 'package:tourm_app/presentation/settings/settings_page.dart';

import 'audioguides/audioguides_page.dart';

class TMNavigator extends StatefulWidget {
  const TMNavigator({Key key}) : super(key: key);

  @override
  _TMNavigatorState createState() => _TMNavigatorState();
}

class _TMNavigatorState extends State<TMNavigator> {
  int _currentIndex = 0;
  final GlobalKey _fabButtonKey = GlobalKey();
  RipplePageTransition _ripplePageTransition;
  List<Widget> children = [
    ArticlesPage(),
    RoomsPage(),
    AudioguidesPage(),
    SettingsPage()
  ];

  @override
  void initState() {
    _ripplePageTransition = RipplePageTransition(
      _fabButtonKey,
      color: TMColors.primary,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   bottomNavigationBar: buildBottomNavigationBar(),
    //   body: IndexedStack(index: _currentIndex, children: children),
    // );
    return Stack(
      children: [
        Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            heroTag: 'fab',
            key: _fabButtonKey,
            backgroundColor: TMColors.primary,
            onPressed: () {
              _ripplePageTransition.navigateTo(BeaconsScanPage());
            },
            child: const Icon(
              Icons.headset,
            ),
          ),
          bottomNavigationBar: _buildBottomAppBar(),
          body: IndexedStack(
            index: _currentIndex,
            children: children,
          ),
        ),
        _ripplePageTransition,
      ],
    );
  }

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIcon(Icons.home, 0),
          _buildIcon(Icons.list, 1),
          SizedBox(
            width: 40,
          ),
          _buildIcon(Icons.queue_music, 2),
          _buildIcon(Icons.settings, 3),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(icon),
      color: index == _currentIndex ? TMColors.primary : null,
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: TMColors.primary,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        if (index == 0) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
          ));
        } else {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
          ));
        }
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.list),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
