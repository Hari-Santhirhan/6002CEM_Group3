import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/utils/colors_util.dart';
import 'package:safeguard_group3_project/utils/date_utils.dart' as date_util;

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
    super.initState();
  }

  Widget backgroundView() {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("FFEAEAEA"),
        // image: DecorationImage(
        //   image: const AssetImage("assets/images/bg.png"),
        //   fit: BoxFit.cover,
        //   colorFilter: ColorFilter.mode(
        //       Colors.black.withOpacity(0.2), BlendMode.lighten),
        // ),
      ),
    );
  }

  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Text(
        date_util.DateUtils.months[currentDateTime.month - 1] +
            ' ' +
            currentDateTime.year.toString(),
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }

  Widget hrizontalCapsuleListView() {
    return Column(
      children: [
        Container(
          width: width,
          height: 150,
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: currentMonthList.length,
            itemBuilder: (BuildContext context, int index) {
              return capsuleView(index);
            },
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget capsuleView(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Container(
        width: 80,
        height: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: (currentMonthList[index].day != currentDateTime.day)
                ? [
              Colors.white.withOpacity(0.8),
              Colors.white.withOpacity(0.7),
              Colors.white.withOpacity(0.6)
            ]
                : [
              HexColor("ED6184"),
              HexColor("EF315B"),
              HexColor("E2042D")
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: const [0.0, 0.5, 1.0],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 4,
              spreadRadius: 2,
              color: Colors.black12,
            )
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                currentMonthList[index].day.toString(),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: (currentMonthList[index].day != currentDateTime.day)
                      ? HexColor("149EBD") //!unhighlighted date color (12)
                      : Colors.white,
                ),
              ),
              Text(
                date_util.DateUtils.weekdays[currentMonthList[index].weekday - 1],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: (currentMonthList[index].day != currentDateTime.day)
                      ? HexColor("A4351D") //unhighlighted day color (monday)
                      : Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget topView() {
    return ListView(
      children: <Widget>[
        Container(
          height: height * 0.35,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor("488BC8").withOpacity(0.7),
                HexColor("488BC8").withOpacity(0.5),
                HexColor("488BC8").withOpacity(0.3),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: const [0.0, 0.5, 1.0],
              tileMode: TileMode.clamp,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black12,
                offset: Offset(4, 4),
                spreadRadius: 2,
              ),
            ],
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              titleView(),
              hrizontalCapsuleListView(),
            ],
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: 200,
          height: 100,
          child: ElevatedButton(
            onPressed: () {
              // Handle forecast button press
              // Navigate to forecast page or perform desired action
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20), // Adjust the radius as needed
              ),
            ),
            child: Text(
              "Forecast",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: 200,
          height: 100,
          child: ElevatedButton(
            onPressed: () {
              // Handle news button press
              // Navigate to news page or perform desired action
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20), // Adjust the radius as needed
              ),
            ),
            child: Text(
              "News",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: 200,
          height: 100,
          child: ElevatedButton(
            onPressed: () {
              // Handle news button press
              // Navigate to news page or perform desired action
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20), // Adjust the radius as needed
              ),
            ),
            child: Text(
              "Report",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          backgroundView(),
          topView(),
        ],
      ),
    );
  }
}