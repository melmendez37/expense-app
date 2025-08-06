import 'package:flutter/material.dart';

class ExpensesView extends StatefulWidget{
  const ExpensesView({super.key});
  
  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView>{
  void addExpense(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
              "New expense",
              style: TextStyle(
                color: Color(0xFFD9D9D9),
                fontFamily: "DM_Sans",
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
          ),
          insetPadding: EdgeInsets.all(20),
          content: TextField(),
          backgroundColor: Color(0xFF434343),

        )
    );
  }

  @override
  void initState() {
    super.initState();
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