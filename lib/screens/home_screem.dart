import 'package:dragon_ball_app/screens/screens.dart';
import 'package:dragon_ball_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          drawer: const CustomDrawerNavigator(),
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 2,
              title: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Image(
                      height: 50,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/logo_dragon_ball.png'),
                    ),
                    Builder(
                        builder: (context) => TextButton(
                            onPressed: () => Scaffold.of(context).openDrawer(),
                            child: Icon(
                              Icons.menu,
                              color: Colors.yellow[600],
                              size: 30,
                            )))
                  ],
                ),
              ),
              backgroundColor: Colors.orange[900]),
          bottomNavigationBar: menu(context),
          body: const TabBarView(
            children: [MenuRender(), MoviesScreen(), MangaScreen()],
          )),
    );
  }

  Widget menu(context) {
    List listTabs = <Widget>[
      const Tab(icon: Icon(Icons.house_rounded) , text: 'Home', iconMargin:  EdgeInsets.only(bottom: 0) , height: 50,  ),
     const Tab(icon: Icon(Icons.movie_rounded) , text: 'Movies', iconMargin:  EdgeInsets.only(bottom: 0) , height: 50,  ),
      const Tab(icon: Icon(Icons.library_books_rounded) , text: 'Manga', iconMargin:  EdgeInsets.only(bottom: 0) , height: 50,  ),
    ];

    return Container(
      color: Colors.orange[900],
      child: TabBar(
        onTap: (value) {},
        labelColor: Colors.yellow[600],
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        // indicatorPadding: EdgeInsets.all(3.0),
        indicatorColor: Colors.red[900],
        tabs: [...listTabs],
      ),
    );
  }
}
