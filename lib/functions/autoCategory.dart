String autoCategory(String titleController) {
  String autoStr = "";
  String title = titleController;
  if (title == "salary")
    autoStr = "income";
  else
    autoStr = "expense";
  return autoStr;
}
