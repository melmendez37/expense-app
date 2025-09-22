import 'package:expense_app/expenses/service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'model.dart';

class ExpenseDetails extends StatefulWidget{
  final Expenses expense;
  const ExpenseDetails({required this.expense, super.key});

  @override
  State<ExpenseDetails> createState() => _ExpenseDetailsState();
}

class _ExpenseDetailsState extends State<ExpenseDetails>{
  final database = Supabase.instance.client;
  final expenseService = ExpenseService();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () async {
            if(context.mounted){
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
            "Details",
          style: TextStyle(
              color: Color(0xFFD9D9D9),
              fontSize: 24,
              fontFamily: "DM_Serif",
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.more_horiz,
                size: 30,
                color: Color(0xFFD9D9D9),
              )
          ),
        ],
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Color(0xFFD9D9D9)
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Color(0xFF434343),
      body: StreamBuilder(
          stream: expenseService.stream,
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return const Center(
                  child: CircularProgressIndicator()
              );
            }

            final expense = snapshot.data!.first;

            return Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.expense.title,
                    style: TextStyle(
                      color: Color(0xFFD9D9D9),
                      fontSize: 24,
                      fontFamily: "DM_Serif",
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  SizedBox(height: 30,),


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                            color: Color(0xFFD9D9D9),
                            fontSize: 18,
                            fontFamily: "DM_Sans",
                            fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        widget.expense.category,
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: 20,
                          fontFamily: "DM_Sans",
                          fontWeight: FontWeight.bold,

                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Type",
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: 18,
                          fontFamily: "DM_Sans",
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        widget.expense.type,
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: 20,
                          fontFamily: "DM_Sans",
                          fontWeight: FontWeight.bold,

                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amount Paid",
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 18,
                                fontFamily: "DM_Sans",
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              widget.expense.amount.toString(),
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 20,
                                fontFamily: "DM_Sans",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),),

                      SizedBox(height:20),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reference number",
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 18,
                                fontFamily: "DM_Sans",
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              widget.expense.ref ?? "N/A",
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 20,
                                fontFamily: "DM_Sans",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Due Date",
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 18,
                                fontFamily: "DM_Sans",
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              widget.expense.dueDate.toString().split(" ")[0],
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 20,
                                fontFamily: "DM_Sans",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 10,),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date Paid",
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 18,
                                fontFamily: "DM_Sans",
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              widget.expense.datePaid.toString().split(" ")[0],
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 20,
                                fontFamily: "DM_Sans",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );


          }
      ),
    );
  }
}