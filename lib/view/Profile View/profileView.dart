// ignore_for_file: file_names, camel_case_types
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:project_fluttercse10/getset.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:project_fluttercse10/main.dart';
import '../../generator.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

//VIEW FOR PROFILE
class profileView extends StatefulWidget {
  const profileView({super.key});

  @override
  State<profileView> createState() => _profileViewState();
}

class _profileViewState extends State<profileView> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Stack(children: [
          userBar(),
          Column(
            children: [
              UserInfo(),
              SizedBox(height: 30),
              userSpent(),
              SizedBox(height: 40),
              userChartDropdown(),
              SizedBox(height: 30),
              userChartInfo(),
              SizedBox(height: 30),
              aboutContainer(),
              SizedBox(height: 30),

            ],
          ),
        ]),
      ),
    );
  }
}

class userBar extends StatelessWidget {
  const userBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWid.wSize,
      height: getHgt.hSize / 2.8,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(15))),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: getHgt.hSize / 9.5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.network(
              'https://pop.inquirer.net/files/2021/05/gigachad.jpg',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Andrei Castro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Angeles, Philippines',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}

class userSpent extends StatefulWidget {
  const userSpent({
    super.key,
  });

  @override
  State<userSpent> createState() => _userSpentState();
}

class _userSpentState extends State<userSpent> {
  String fcCount = '0';
  String hrCount = '0';
  final GlobalKey widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          key: widgetKey,
          width: getWid.wSize * 0.89,
          height: 95,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 5,
                color: Colors.black26,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    BootstrapIcons.lightning_fill,
                    color: Colors.grey[600],
                    size: 30,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(fcCount, style: const TextStyle(fontSize: 20)),
                      const Text('Flashcards added',
                          style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
              const VerticalDivider(
                width: 10,
                thickness: 1.5,
                indent: 20,
                endIndent: 20,
              ),
              Row(
                children: [
                  Icon(BootstrapIcons.clock_fill,
                      color: Colors.grey[600], size: 30),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(hrCount, style: const TextStyle(fontSize: 20)),
                      const Text('Hours Spent', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class userChartDropdown extends StatefulWidget {
  const userChartDropdown({super.key});

  @override
  State<userChartDropdown> createState() => _userChartDropdownState();
}

class _userChartDropdownState extends State<userChartDropdown> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownMenu<String>(
          textStyle: const TextStyle(
            fontSize: 12,
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          enableSearch: false,
          initialSelection: "Screen Time",
          onSelected: (value) {
            setState(() {
              selectedValue = value;
              print(selectedValue);
            });
          },
          dropdownMenuEntries: const <DropdownMenuEntry<String>>[
            DropdownMenuEntry(value: "Screen Time", label: "Screen Time"),
            DropdownMenuEntry(value: "Option 2", label: "Option 2"),
            DropdownMenuEntry(value: "Option 3", label: "Option 3"),
          ],
          menuStyle: MenuStyle(
            elevation:
                const WidgetStatePropertyAll(4), // Shadow effect for the menu
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(5), // Rounded corners for the dropdown
            )),

            backgroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
        ),
      ],
    );
  }
}

class userChartInfo extends StatefulWidget {
  const userChartInfo({super.key});

  @override
  State<userChartInfo> createState() => _userChartInfoState();
}

class _userChartInfoState extends State<userChartInfo> {
  String getHr = '0';
  String getMn = '0';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$getHr hrs, $getMn mins",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            )),
        const Text("Today",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
        const chartTable(),
      ],
    );
  }
}

class chartTable extends StatefulWidget {
  const chartTable({super.key});

  @override
  State<chartTable> createState() => _chartTableState();
}

class _chartTableState extends State<chartTable> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    data = [
      _ChartData('Mon', 4),
      _ChartData('Tue', 4.5),
      _ChartData('Wed', 1),
      _ChartData('Thu', 6.4),
      _ChartData('Fri', 2),
      _ChartData('Sat', 3.5),
      _ChartData('Sun', 1)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.fromLTRB(30,15,30,0),
      child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: const CategoryAxis(
            majorGridLines: MajorGridLines(width: 0), // Remove vertical grid lines
          ),
          primaryYAxis: NumericAxis(minimum: 0, maximum: 8, interval: 2,
            majorGridLines: MajorGridLines(
            color: Colors.grey),
            axisLabelFormatter: (AxisLabelRenderDetails details) {
              // Append 'h' to each Y-axis label
              return ChartAxisLabel('${details.value.toInt()}h', const TextStyle(fontSize: 12));
            },opposedPosition: true,
            axisLine: const AxisLine(width: 0),),
          tooltipBehavior: _tooltip,
          series: <CartesianSeries<_ChartData, String>>[
            ColumnSeries<_ChartData, String>(
                dataSource: data,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                name: 'Gold',
                color: Theme.of(context).primaryColor)
          ]),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}

class aboutContainer extends StatelessWidget {
  const aboutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWid.wSize * 0.89,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(

            blurRadius: 15,
            color: Colors.black26,
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text("About You"),
            Divider(
              thickness: 1.5,
            ),
            Text("Lorem Ipsum"),
          ],
        ),
      ),
    );
  }
}
