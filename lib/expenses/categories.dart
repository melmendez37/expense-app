List<String> expenseCategory = [
  "Living",
  "Transportation",
  "Family",
  "Personal",
  "Health",
  "Technology",
  "Debt",
  "Save/Invest",
  "Entertainment",
  "Miscellaneous"
];

List<String> livingExpenses = [
  "Rent expenses",
  "Mortgage payments",
  "Grocery bills",
  "Utility bills",
  "Household maintenance/repair",
  "Clothing costs",
  "Property taxes",
  "Home/rent insurances"
];

List<String> transportExpenses = [
  "Car payments",
  "Public transportation fees",
  "Toll fees",
  "Car insurance payments",
  "Gas costs",
  "Auto repair/maintenance",
  "Vehicle registration fees"
];

List<String> familyExpenses = [
  "Child care/daycare expenses",
  "School supplies/fees",
  "Elder care costs",
  "Pet food/supplies",
  "Veterinarian care costs",
  "Pet insurance premiums",
  "Babysitting/pet-sitting costs"
];

List<String> personalExpenses = [
  "Toiletries and personal hygiene products",
  "Haircuts and grooming services",
  "Clothing and shoes",
  "Laundry and dry cleaning",
  "Skincare/cosmetics",
  "Wellness (e.g. massages, manicure)",
];

List<String> healthExpenses = [
  "Health insurance premiums",
  "Prescription medications",
  "Over-the-counter medicines",
  "Copays for doctor/specialist visits",
  "Dental and vision care",
  "Mental health services",
  "Gym/fitness memberships"
];

List<String> techExpenses = [
  "Smartphone plans and devices",
  "Internet service",
  "Computer hardware/software",
  "Streaming services (ex. Netflix,Spotify)",
  "Gaming subscriptions",
  "Tech accessories/upgrades"
];

List<String> debtExpenses = [
  "Credit card",
  "Student loans",
  "Personal loans",
  "Medical debt payments",
  "Any outstanding debt/payment plans"
];

List<String> saveInvest = [
  "Emergency savings fund",
  "Retirement accounts",
  "Investment contributions",
  "College savings plans",
  "Other long term financial goals"
];

List<String> entertainExpenses = [
  "Dine out/order in",
  "Movie tickets/streaming rentals",
  "Concert/event tickets",
  "Hobbies/recreational activities",
  "Books/magazines/others",
  "Vacation/travel",
];

List<String> miscExpenses = [
  "Gift for birthdays/holidays/occasions",
  "Charitable donations",
  "Professional dues/memberships",
  "Education/professional development costs",
  "Unexpected expenses/large purchases",
];

List<String> selectCategory(String typeName) {
  return typeName == expenseCategory[0] ? livingExpenses
      : typeName == expenseCategory[1] ? transportExpenses
      : typeName == expenseCategory[2] ? familyExpenses
      : typeName == expenseCategory[3] ? personalExpenses
      : typeName == expenseCategory[4] ? healthExpenses
      : typeName == expenseCategory[5] ? techExpenses
      : typeName == expenseCategory[6] ? debtExpenses
      : typeName == expenseCategory[7] ? saveInvest
      : typeName == expenseCategory[8] ? entertainExpenses
      : miscExpenses;
}