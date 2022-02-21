import 'package:dragon_ball_app/screens/screens.dart';
import 'package:dragon_ball_app/widgets/widgets.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  final controller = ScrollController();

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
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(

            //   drawer: const CustomDrawerNavigator(),
            appBar: AppBar(
              toolbarHeight: 6.7.h,
              automaticallyImplyLeading: false,
              title: const CustomLayoutAppBar(),
            ),
            bottomNavigationBar: MotionTabBar(
              initialSelectedTab: "Home",
              useSafeArea: false, // default: true, apply safe area wrapper
              labels: const ["Home", 'Movies', 'Manga'],
              icons: const [
                Icons.home,
                Icons.movie_outlined,
                Icons.book_outlined
              ],
              tabSize: 4.h,
              tabBarHeight: 4.5.h,
              textStyle: TextStyle(
                fontSize: 8.5.sp,
                color: Colors.yellow,
                fontWeight: FontWeight.w500,
              ),
              tabIconColor: Colors.white,
              tabIconSize: 3.h,
              tabIconSelectedSize: 3.5.h,
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
              children: const [
                MenuViewScreen(),
                MoviesScreen(
                  isTab: true,
                ),
                MangaScreen(isTab: true)
              ],
            )),
      ),
    );
  }
}
