import 'package:bluefin/screens/transaction/widgets/categorySearch.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({Key? key}) : super(key: key);

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final _formKey = GlobalKey<FormState>();
  var categoryFilterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  "Transaction Filter",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              child: Text(
                "Type",
                style: TextStyle(fontSize: 18, color: Colors.black38),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child:
                        OutlinedButton(onPressed: () {}, child: Text("hello")),
                  )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child:
                        OutlinedButton(onPressed: () {}, child: Text("hello")),
                  )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child:
                        OutlinedButton(onPressed: () {}, child: Text("hello")),
                  )),
                ],
              ),
            ),
            Container(
              child: TextFormField(
                controller: categoryFilterController,
                onTap: () async {
                  final result = await showSearch(
                      context: context, delegate: CategorySearch());
                  categoryFilterController.text = result!;
                },
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Category",
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
