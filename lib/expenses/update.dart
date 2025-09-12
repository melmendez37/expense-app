import 'dart:developer';

import 'package:expense_app/expenses/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'categories.dart';

class UpdateExpenses extends StatefulWidget{
  const UpdateExpenses({super.key});

  @override
  State<UpdateExpenses> createState() => _UpdateExpensesState();

}
class _UpdateExpensesState extends State<UpdateExpenses>{
  final database = Supabase.instance.client;
  final expenseService = ExpenseService();

  String? _category;
  String? _type;

  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController datePaidController = TextEditingController();


  void dispose(){
    setState(() {
      _category = null;
      _type = null;
    });

    titleController.clear();
    referenceController.clear();
    amountController.clear();
    dueDateController.clear();
    datePaidController.clear();
  }

  Future <void> selectDueDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if(picked != null){
      setState(() {
        dueDateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future <void> selectDatePaid() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if(picked != null){
      setState(() {
        datePaidController.text = picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        title: Text(
          "Update"
        ),
        leading: BackButton(
          onPressed: () async {
            if(context.mounted){
              Navigator.pop(context);
              dispose();
            }
          },
        ),
        iconTheme: IconThemeData(
            color: Color(0xFFD9D9D9)
        ),
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
          stream: expenseService.stream,
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return const Center(
                  child: CircularProgressIndicator()
              );
            }

            final expenses = snapshot.data!.first;

            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: titleController,
                    style: TextStyle(
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.title),
                      hintText: expenses.title,
                      fillColor: const Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),

                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xFF434343),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20,),

                  DropdownButtonFormField<String>(
                    value: _category,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.category),
                      hintText: expenses.category,
                      hintStyle: TextStyle(
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold,
                      ),
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                    ),
                    isExpanded: true,
                    items: expenseCategory.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category,
                          style: TextStyle(
                              fontFamily: "DM_Sans",
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        _category = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter category';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20,),

                  DropdownButtonFormField<String>(
                    value: _type,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.category_outlined),
                      hintText: expenses.type,
                      hintStyle: TextStyle(
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold,
                      ),
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                    ),
                    isExpanded: true,
                    items: _category != null ? selectCategory(_category!).map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.toString(),
                          style: TextStyle(
                              fontFamily: "DM_Sans",
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis
                          ),
                        ),
                      );
                    }).toList() : [],
                    onChanged: _category == null ? null : (value) {
                      setState(() {
                        _type = value;
                      });
                    },
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    controller: amountController,
                    style: TextStyle(
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold
                    ),
                    decoration: InputDecoration(
                      hintText: expenses.amount.toString(),
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF434343),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    controller: referenceController,
                    style: TextStyle(
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.receipt),
                      hintText: expenses.ref ?? 'Reference number (optional)',
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF434343),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    controller: dueDateController,
                    onTap: selectDueDate,
                    style: TextStyle(
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold
                    ),
                    decoration: InputDecoration(
                      hintText: expenses.dueDate.toString(),
                      prefixIcon: Icon(Icons.calendar_month),
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF434343),
                      ),
                    ),
                    readOnly: true,
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    controller: datePaidController,
                    onTap: selectDatePaid,
                    style: TextStyle(
                        color: Color(0xFF434343),
                        fontFamily: "DM_Sans",
                        fontWeight: FontWeight.bold
                    ),
                    decoration: InputDecoration(
                      hintText: "Date Paid (optional)",
                      prefixIcon: Icon(Icons.calendar_month),
                      fillColor: Color(0xFFD9D9D9),
                      filled: true,
                      errorStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM_Sans",
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          )
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF434343),
                      ),
                    ),
                    readOnly: true,
                  ),

                  SizedBox(height: 20,),

                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF70C000),
                        minimumSize: Size(400,50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                    child: Text(
                      "Add expense",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF434343)
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}