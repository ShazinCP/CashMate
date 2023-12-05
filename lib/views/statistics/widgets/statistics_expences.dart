import 'package:cashmate/controller/transactiondb_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScreenExpenseChart extends StatelessWidget {
  const ScreenExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cWhiteARGBColor3,
        body: Consumer<TransactionDBProvider>(
            builder: (context, transactionProvider, child) {
            var allIncome = transactionProvider.graphList
                .where((element) => element.type == 'expense')
                .toList();
            return transactionProvider.graphList.isEmpty
                ? const SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(child: Text('No data found')),
                        ],
                      ),
                    ),
                  )
                : SfCircularChart(
                    series: <CircularSeries>[
                      PieSeries<MoneyModel, String>(
                        dataSource: allIncome,
                        xValueMapper: (MoneyModel expenseDate, _) =>
                            expenseDate.name,
                        yValueMapper: (MoneyModel expenseDate, _) =>
                            num.parse(expenseDate.amount),
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      )
                    ],
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll,
                      alignment: ChartAlignment.center,
                    ),
                  );
          },
        ),
      ),
    );
  }
}


// import 'package:cashmate/controller/transactiondb_provider.dart';
// import 'package:cashmate/model/data_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';


// class pichartExpense extends StatefulWidget {
//   const pichartExpense({super.key});

//   @override
//   State<pichartExpense> createState() => _pichartExpenseState();
// }

// class _pichartExpenseState extends State<pichartExpense> {
//   @override
//   Widget build(BuildContext context) {
//      final Size size = MediaQuery.of(context).size;
//     return Consumer<TransactionDBProvider>(
//       builder: (context, value, child) {
//         var allExpense=Provider.of<TransactionDBProvider>(context).graphList.where((element) => element.type=='Expense').toList();
//         return  Provider.of<TransactionDBProvider>(context).graphList.isEmpty
//       ?SingleChildScrollView(
//        child: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//            children: [
//              SizedBox(height: size.height*0.2,),
//                Image.asset('asset/notdataIcon/notDataIcon-removebg-preview.png'),
//            ],
//          ),
//        ),
//       )
//       :SfCircularChart(
//        series: <CircularSeries>[
//          PieSeries<MoneyModel,String>(
//            dataSource: allExpense,
//            xValueMapper: (MoneyModel expenseDate,_)=>expenseDate.name,
//            yValueMapper: (MoneyModel expenseDate,_)=>num.parse(expenseDate.amount),
//          dataLabelSettings: const DataLabelSettings(
//            isVisible: true,
//          )
//          )
//        ],
//        legend: Legend(
//          isVisible: true,
//          overflowMode: LegendItemOverflowMode.scroll,
//          alignment: ChartAlignment.center
//        ) ,
//       );
//       },
      
//     );
//   }
// }