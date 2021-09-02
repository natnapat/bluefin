String autoCategory(String titleController) {
  String autoStr = "";
  String title = titleController;
  if (title == "salary")
    autoStr = "income";
  else
    autoStr = "expense";
  return autoStr;
}

/* 
category:
  income,
  foods/groceries/drink,
  salary,
  dining/meal,
  transportation,
  entertainment,
  fashion/cosmetic
  book,
  fuel,
  travel,
  car maintenance
  health care,
  electricity/water
  phone/internet,
  others
*/
