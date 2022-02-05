import 'package:dragon_ball_app/screens/screens.dart';
import 'package:dragon_ball_app/widgets/widgets.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          //   drawer: const CustomDrawerNavigator(),
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 2,
              title: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      height: 50,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/logo_dragon_ball.png'),
                    ),
                    // Builder(
                    //     builder: (context) => TextButton(
                    //         onPressed: () => Scaffold.of(context).openDrawer(),
                    //         child: Icon(
                    //           Icons.menu,
                    //           color: Colors.yellow[600],
                    //           size: 30,
                    //         )))
                  ],
                ),
              ),
              backgroundColor: Colors.orange[900]),
          bottomNavigationBar: MotionTabBar(
            initialSelectedTab: "Home",
            useSafeArea: true, // default: true, apply safe area wrapper
            labels: const ["Home", 'Movies', 'Manga'],
            icons: const [
              Icons.home,
              Icons.movie_outlined,
              Icons.book_outlined
            ],
            tabSize: 40,
            tabBarHeight: 50,
            textStyle: const TextStyle(
              fontSize: 13,
              color: Colors.yellow,
              fontWeight: FontWeight.w500,
            ),
            tabIconColor: Colors.white,
            tabIconSize: 28.0,
            tabIconSelectedSize: 26.0,
            tabSelectedColor: Colors.yellow[700],
            tabIconSelectedColor: Colors.white,
            tabBarColor: Colors.orange[900],
            onTabItemSelected: (int value) {
              setState(() {
                _tabController!.index = value;
              });
            },
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: const [MenuViewScreen(), MoviesScreen(), MangaScreen()],
          )),
    );
  }
}
