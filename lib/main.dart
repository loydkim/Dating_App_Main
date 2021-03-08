import 'package:datingappmain/chat/chatlist.dart';
import 'package:datingappmain/search/searchmain.dart';
import 'package:datingappmain/lounge/loungeMain.dart';
import 'package:datingappmain/setting/settingmain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                    Tab(icon: FaIcon(FontAwesomeIcons.users,
                        size: 26,
                        color: _tabController.index == 0
                        ? Colors.indigo
                        : Colors.grey)),
                    Tab(icon: FaIcon(FontAwesomeIcons.handHoldingHeart,
                        size: 26,
                        color: _tabController.index == 1
                            ? Colors.red
                            : Colors.grey)),
                    Tab(icon: FaIcon(FontAwesomeIcons.solidComments,
                        size: 26,
                        color: _tabController.index == 2
                            ? Colors.green
                            : Colors.grey)),
                    Tab(icon: FaIcon(FontAwesomeIcons.cog,
                        size: 26,
                        color: _tabController.index == 3
                            ? Colors.deepPurple
                            : Colors.grey)),
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
    );
  }
}
