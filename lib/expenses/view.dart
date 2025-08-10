import 'package:flutter/material.dart';

import 'package:expense_app/expenses/categories.dart';

class ExpensesView extends StatefulWidget{
  const ExpensesView({super.key});
  
  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView>{
  final _formKey = GlobalKey<State>();
  String? _category;
  String? _type;

  @override
  void initState() {
    super.initState();
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
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    size: 24,
                                    color: Color(0xFFD9D9D9),
                                  )
                              )
                            ],
                          ),

                          SizedBox(height: 20,),

                          Form(
                            //key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  //controller: newUser,
                                  style: TextStyle(
                                      color: Color(0xFF434343),
                                      fontFamily: "DM_Sans",
                                      fontWeight: FontWeight.bold
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Title",
                                    fillColor: const Color(0xFFD9D9D9),
                                    filled: true,
                                    errorStyle: const TextStyle(
                                      fontSize: 14,
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
                                      return 'Please enter username';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: 20,),

                                DropdownButtonFormField<String>(
                                  value: _category,
                                  decoration: InputDecoration(
                                    hintText: "Category",
                                    hintStyle: TextStyle(
                                      fontFamily: "DM_Sans",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    fillColor: Color(0xFFD9D9D9),
                                    filled: true,
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
                                ),

                                SizedBox(height: 20,),

                                DropdownButtonFormField<String>(
                                    value: _type,
                                    decoration: InputDecoration(
                                      hintText: "Type",
                                      hintStyle: TextStyle(
                                        fontFamily: "DM_Sans",
                                        fontWeight: FontWeight.bold,
                                      ),
                                      fillColor: Color(0xFFD9D9D9),
                                      filled: true,

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
                                    }
                                ),


                                SizedBox(height: 20),

                                TextFormField(
                                  //controller: newFirst,
                                  style: TextStyle(
                                      color: Color(0xFF434343),
                                      fontFamily: "DM_Sans",
                                      fontWeight: FontWeight.bold
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Reference number",
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter first name';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: 20),

                                TextFormField(
                                  //controller: newMiddle,
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter middle name';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: 20),

                                TextFormField(
                                  onTap: selectDueDate,
                                  style: TextStyle(
                                      color: Color(0xFF434343),
                                      fontFamily: "DM_Sans",
                                      fontWeight: FontWeight.bold
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Due Date",
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter phone number';
                                    }
                                    return null;
                                  },
                                ),

                                //InputDatePickerFormField(firstDate: firstDate, lastDate: lastDate)

                                SizedBox(height: 20),

                                TextFormField(
                                  onTap: selectDatePaid,
                                  style: TextStyle(
                                      color: Color(0xFF434343),
                                      fontFamily: "DM_Sans",
                                      fontWeight: FontWeight.bold
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Date Paid",
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter city/municipality';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: 20,),

                                ElevatedButton(
                                  onPressed: (){
                                    //updateProfile(profile);
                                  },
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
      body: Expanded(

          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(20),
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
                              "Hurry Up Tomorrow Vinyl",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFD9D9D9),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "DM_Sans"
                              ),
                            ),

                            IconButton(
                                onPressed: (){},
                                icon: Icon(
                                  Icons.edit_note,
                                  size: 30,
                                  color: Color(0xFFD9D9D9),
                                )
                            )
                          ]
                        ),

                        SizedBox(height: 20,),

                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Color(0xFF70C000)
                                ),
                              ),
                              Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Color(0xFFD9D9D9)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ],
            )
          )
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