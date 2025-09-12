
import 'dart:developer';

import 'package:expense_app/expenses/model.dart';
import 'package:expense_app/expenses/service.dart';
import 'package:expense_app/expenses/update.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/expenses/categories.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ExpensesView extends StatefulWidget{
  const ExpensesView({super.key});
  
  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView>{
  final database = Supabase.instance.client;
  final expenseService = ExpenseService();
  var uuid = const Uuid();
  String? _category;
  String? _type;

  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController datePaidController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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

    Navigator.pop(context);
  }

  void insertExpense() async {
    final userId = database.auth.currentUser?.id;
    final ref = referenceController.text;
    final amount = amountController.text;
    final dueDate = dueDateController.text;
    final datePaid = datePaidController.text;

    double amountVal = double.tryParse(amount)!;

    DateTime? dueDateFinal;
    //CHECK IF DATE FIELD HAS INPUT
    if(dueDate.isNotEmpty){
      dueDateFinal = DateTime.parse(dueDateController.text);
    }

    DateTime? datePaidFinal;
    if(datePaid.isNotEmpty){
      DateTime datePaidFinal = DateTime.parse(datePaid);
    }

    //validate form
    final isValid = _formKey.currentState!.validate();
    if(!isValid) return;
    try{
      final newExpense = Expenses(
        id: uuid.v4(),
        title: titleController.text,
        type: _type.toString(),
        category: _category.toString(),
        amount: amountVal,
        ref: ref,
        dueDate: dueDateFinal,
        datePaid: datePaidFinal,
        profileId: userId!,
      );

      await expenseService.createExpense(newExpense);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Successfully added expense")
        ),
      );

      titleController.clear();
      amountController.clear();
      referenceController.clear();
      dueDateController.clear();
      datePaidController.clear();
      setState(() {
        _category = null;
        _type = null;
      });

    } catch(e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Error: $e")
        ),
      );
    }
  }

  void addExpense(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Color(0xFF434343),
            child: StatefulBuilder(
                builder: (context, setState) {
                  return SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "New Expense",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "DM_Serif",
                                  fontSize: 24,
                                  color: Color(0xFFD9D9D9),
                                ),
                              ),
                              IconButton(
                                  onPressed: dispose,
                                  icon: Icon(
                                    Icons.close,
                                    size: 24,
                                    color: Color(0xFFD9D9D9),
                                  )
                              )
                            ],
                          ),

                          SizedBox(height: 15,),

                          Form(
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
                                    hintText: "Title",
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
                                    hintText: "Category",
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
                                      hintText: "Type",
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
                                    hintText: "Amount",
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
                                    hintText: "Reference number (optional)",
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
                                    hintText: "Due Date (optional)",
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
                                  onPressed: insertExpense,
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
                          ),
                        ],
                      ),
                    ),
                  );
                }
            )
          );
        }
    );
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
        title: SearchAnchor(
            builder: (BuildContext context, SearchController controller){
              return SearchBar(
                controller: controller,
                backgroundColor: MaterialStateProperty.all(Colors.black26),
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(
                      horizontal: 16.0
                  ),
                ),
                onTap: (){
                  controller.openView();
                },
                onChanged: (_){
                  controller.openView();
                },
                trailing: <Widget>[
                  const Icon(Icons.search),
                ],
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller){
              return List<ListTile>.generate(5, (int index){
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: (){
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },

        ),
        leading: BackButton(
          onPressed: () async {
            if(context.mounted){
              Navigator.pop(context);
            }
          },
        ),
        iconTheme: IconThemeData(
          color: Color(0xFFD9D9D9)
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Color(0xFF434343),

      body: StreamBuilder<List<Expenses>>(
        stream: expenseService.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator()
            );
          }

          final expenses = snapshot.data!;

          return ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index){
                final expense = expenses[index];

                return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        expense.title,
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Color(0xFFD9D9D9),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "DM_Sans"
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: (){},
                                              icon: Icon(
                                                Icons.remove_red_eye,
                                                size: 30,
                                                color: Color(0xFFD9D9D9),
                                              )
                                          ),
                                          IconButton(
                                              onPressed: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => const UpdateExpenses()),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.edit_note,
                                                size: 30,
                                                color: Color(0xFFD9D9D9),
                                              )
                                          )
                                        ],
                                      )
                                    ]
                                ),

                                SizedBox(height: 10,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child:  Text(
                                          expense.category,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFFD9D9D9),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "DM_Sans"
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                    ),
                                    Expanded(
                                      child:  Text(
                                        expense.amount.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF009A00),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "DM_Sans"
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ),
                      ],
                    )
                );

              }
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: addExpense,
          backgroundColor: Color(0xFF70C000),
          child: Icon(
              Icons.add_rounded,
              size: 36,
              color: Color(0xFF434343),
          ),
      ),
    );
  }
  
}