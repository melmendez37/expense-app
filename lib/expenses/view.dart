import 'package:flutter/material.dart';

class ExpensesView extends StatefulWidget{
  const ExpensesView({super.key});
  
  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView>{
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
                leading: const Icon(Icons.search),
                // trailing: <Widget>[
                //   Tooltip(
                //     message: 'Change brightness mode?',
                //     child: IconButton(
                //         isSelected: isDark,
                //         icon: const Icon(icon)
                //     ),
                //   )
                // ],
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
      body: Padding(
          padding: EdgeInsets.all(30),
          child: Text('Test'),
      ),
    );
  }
  
}