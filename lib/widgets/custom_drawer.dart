import 'package:dragon_ball_app/router/app_router.dart';
import 'package:flutter/material.dart';

class CustomDrawerNavigator extends StatefulWidget {
  const CustomDrawerNavigator({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawerNavigator> createState() => _CustomDrawerNavigatorState();
}

class _CustomDrawerNavigatorState extends State<CustomDrawerNavigator>
    with SingleTickerProviderStateMixin {
  late AnimationController _staggeredController;
  static const _initialDelayTime = Duration(milliseconds: 200);
  static const _itemSlideTime = Duration(milliseconds: 310);
  static const _staggerTime = Duration(milliseconds: 110);
  static const _buttonDelayTime = Duration(milliseconds: 210);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration = _initialDelayTime +
      (_staggerTime * AppRoute.menuOptions.length) +
      _buttonDelayTime +
      _buttonTime;
  final List<Interval> _itemSlideIntervals = [];
  late Interval _buttonInterval;
  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();

    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < AppRoute.menuOptions.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.yellow[100],
      child: ListView(
        children: [
          const DrawerHeader(
            curve: Curves.bounceOut,
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Image(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/adventure.jpeg'),
            ),
          ),
          ..._buildListItems()
        ],
      ),
    );
  }

  List<Widget> _buildListItems() {
    final listItems = <Widget>[];
    for (var i = 0; i < AppRoute.menuOptions.length; ++i) {
      listItems.add(
        AnimatedBuilder(
          animation: _staggeredController,
          builder: (context, child) {
            final animationPercent = Curves.easeOut.transform(
              _itemSlideIntervals[i].transform(_staggeredController.value),
            );
            final opacity = animationPercent;
            final slideDistance = (1.0 - animationPercent) * 150;

            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(slideDistance, 0),
                child: child,
              ),
            );
          },
          child: ListTile(
            selectedColor: Colors.white,
            style: ListTileStyle.list,
            leading: const Image(
              image: AssetImage('assets/icon_ball.png'),
              width: 30,
            ),
            title: Text(
              AppRoute.menuOptions[i].name,
              style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey[800],
            ),
            onTap: () =>
                Navigator.pushNamed(context, AppRoute.menuOptions[i].route),
          ),
        ),
      );
    }
    return listItems;
  }
}
