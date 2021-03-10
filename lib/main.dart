import 'package:datingappmain/chat/chatlist.dart';
import 'package:datingappmain/search/searchmain.dart';
import 'package:datingappmain/lounge/loungeMain.dart';
import 'package:datingappmain/setting/settingmain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {setState(() {});}

  Tab _tabItem(IconData iconData, int index, Color selectedColor){
    return Tab(
      icon: FaIcon(
        iconData,
        size: 26,
        color: _tabController.index == index ? selectedColor : Colors.grey)
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        _tabItem(FontAwesomeIcons.users,0,Colors.indigo),
                        _tabItem(FontAwesomeIcons.handHoldingHeart,1,Colors.red),
                        _tabItem(FontAwesomeIcons.solidComments,2,Colors.green),
                        _tabItem(FontAwesomeIcons.cog,3,Colors.deepPurple),
                      ],
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
            ),
            body: TabBarView(
              physics: _tabController.index == 0 ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                SearchMain(),
                LoungeMain(),
                ChatList(),
                SettingMain(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
