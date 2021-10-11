import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';

const darkBlue = const Color(0xFF2A2B90);
const lightBlue = const Color(0xFFF0F3FD);
const darkGrey = const Color(0xFF464646);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [SummarySection(), TransactionsListSection()],
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Transactions',
        style: GoogleFonts.openSans(color: darkGrey, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      backgroundColor: lightBlue,
      shadowColor: Colors.transparent,
    );
  }
}

class SummarySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 6,
          offset: Offset(0, 3),
        )
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(height: 100, child: ExpenseChart()),
          Container(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                    child: Row(
                  children: [
                    Text(
                      'Net Balance:',
                      style: GoogleFonts.openSans(
                        color: darkGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )),
                Container(
                    child: Row(
                  children: [
                    Text(
                      '1257.32€',
                      style: GoogleFonts.openSans(
                        color: darkGrey,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Income: 2573.66€',
                      style: GoogleFonts.openSans(
                        color: darkGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Expense: 1316.34€',
                      style: GoogleFonts.openSans(
                        color: darkGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ))
              ]))
        ],
      ),
    );
  }
}

class ExpenseChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BezierChart(
        bezierChartScale: BezierChartScale.CUSTOM,
        xAxisCustomValues: const [0, 1, 2, 3, 4, 5, 6, 7],
        series: const [
          BezierLine(
            lineColor: darkBlue,
            dataPointStrokeColor: lightBlue,
            data: const [
              DataPoint<double>(value: 750, xAxis: 0),
              DataPoint<double>(value: 600, xAxis: 1),
              DataPoint<double>(value: 350, xAxis: 2),
              DataPoint<double>(value: 552, xAxis: 3),
              DataPoint<double>(value: 632, xAxis: 4),
              DataPoint<double>(value: 421, xAxis: 5),
              DataPoint<double>(value: 153, xAxis: 6),
              DataPoint<double>(value: 527, xAxis: 7),
            ],
          ),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          bubbleIndicatorColor: lightBlue,
          showVerticalIndicator: false,
          snap: false,
          footerHeight: 10.0,
        ),
      ),
      // decoration: BoxDecoration(border: Border.all(width: 1)),
    );
  }
}

enum TransactionType { Expense, Income }

abstract class TransactionTypeHelper {
  static Widget toWidget(TransactionType type, double amount, double fontSize) {
    var color = darkGrey;
    var text = amount.toString() + "€";
    switch (type) {
      case TransactionType.Expense:
        color = Colors.redAccent;
        text = "-" + text;
        break;
      case TransactionType.Income:
        color = Colors.lightGreenAccent;
        text = "+" + text;
        break;
    }

    return Text(
      text,
      style: GoogleFonts.openSans(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

enum TransactionCategory { Home, Income, Food, Shopping }

abstract class TransactionCategoryHelper {
  static Widget toWidget(TransactionCategory category, Color color) {
    var icon = Icons.help_outline;

    switch (category) {
      case TransactionCategory.Home:
        icon = Icons.home;
        break;
      case TransactionCategory.Income:
        icon = Icons.monetization_on;
        break;
      case TransactionCategory.Food:
        icon = Icons.shopping_basket;
        break;
      case TransactionCategory.Shopping:
        icon = Icons.shopping_bag;
        break;
    }

    return Icon(
      icon,
      color: color,
    );
  }
}

class TransactionsListSection extends StatelessWidget {
  final List transactionsList = [
    {
      'title': 'Electricity',
      'type': TransactionType.Expense,
      'description': 'State Provider',
      'amount': 29.99,
      'category': TransactionCategory.Home,
      'date': DateTime.utc(2021, 9, 25),
      'id': 0
    },
    {
      'title': 'Rent',
      'type': TransactionType.Income,
      'description': 'SCPI',
      'amount': 529.99,
      'category': TransactionCategory.Income,
      'date': DateTime.utc(2021, 9, 25),
      'id': 1
    },
    {
      'title': 'Electricity',
      'type': TransactionType.Expense,
      'description': 'State Provider',
      'amount': 37.69,
      'category': TransactionCategory.Food,
      'date': DateTime.utc(2021, 9, 23),
      'id': 2
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: GroupedListView<dynamic, DateTime>(
        elements: transactionsList,
        groupBy: (transaction) => transaction['date'],
        itemComparator: (transaction1, transaction2) => transaction1['id'].compareTo(transaction2['id']),
        groupComparator: (value1, value2) => value2.compareTo(value1),
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (DateTime value) {
          return Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
            child: Text(
              value.day.toString() + "/" + value.month.toString(),
              style: GoogleFonts.openSans(
                color: darkGrey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        itemBuilder: (context, transaction) {
          return TransactionCard(transaction);
        },
        shrinkWrap: true,
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Map transactionData;
  TransactionCard(this.transactionData);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 6,
          offset: Offset(0, 3),
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: 40,
            height: 40,
            child: TransactionCategoryHelper.toWidget(transactionData['category'], darkBlue),
            decoration: BoxDecoration(
              color: lightBlue,
              // border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            child: Container(
              height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactionData['title'],
                    style: GoogleFonts.openSans(
                      color: darkGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    transactionData['description'],
                    style: GoogleFonts.openSans(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            width: 100,
            height: 40,
            child: TransactionTypeHelper.toWidget(transactionData['type'], transactionData['amount'], 14),
          ),
        ],
      ),
    );
  }
}

/*
class ExpenseChart extends StatelessWidget {
  final List<MonthlyExpense> seriesList = [
    MonthlyExpense(0, 1200),
    MonthlyExpense(1, 1115),
    MonthlyExpense(2, 1000),
    MonthlyExpense(3, 1300),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<MonthlyExpense, num>> series = [
      charts.Series(
        id: "developers",
        data: seriesList,
        domainFn: (MonthlyExpense series, _) => series.month,
        measureFn: (MonthlyExpense series, _) => series.expense,
      )
    ];

    return Container(
      child: charts.LineChart(series, animate: true),
    );
  }
}

class MonthlyExpense {
  late final int month;
  late final int expense;

  MonthlyExpense(this.month, this.expense);
}*/
