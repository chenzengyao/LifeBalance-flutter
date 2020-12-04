/*class CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      /// we have the default tab bar view whcih creates a tabbed page for us, we have to give it the count of tabs we want and then we provide it
      /// that many widgets to display, on this case we set the length to 3 and provide three widgets.
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          //Changed colour of the top bar to myPink = kGreen
          backgroundColor: myPink,
          title: Text("Community"),
          bottom: TabBar(
            labelColor: LightColors.kDarkYellow,
            unselectedLabelColor: Colors.white,
            indicatorColor: LightColors.test4,
            tabs: [
            Tab(
              text: "Calenders",
            ),
            Tab(
              text: "Friends",
            ),
            Tab(
              text: "People",
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            // these are the three widgets provided
            AllCalenders(),
            AllFriends(),
            AllUsers(),
          ],
        ),
      ),
    );
  }
}