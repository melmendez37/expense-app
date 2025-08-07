
//Types of expenses from different categories
enum Living {
  rent(title: "Rent expenses"),
  mortgage(title: "Mortgage payments"),
  grocery(title: "Grocery bills"),
  utility(title: "Utility bills"),
  household(title: "Household maintenance/repair"),
  clothes(title: "Clothing costs"),
  property(title: "Property taxes"),
  insurances(title: "Home/rent insurances");

  const Living({required this.title});
  final String title;
}

enum Transportation {
  car(title: "Car payments"),
  transportation(title: "Public transportation fees"),
  toll(title: "Toll fees"),
  insurance(title: "Car insurance payments"),
  gas(title: "Gas costs"),
  auto(title: "Auto repair/maintenance"),
  registration(title: "Vehicle registration fees");

  const Transportation({required this.title});
  final String title;
}

enum Family {
  child(title: "Child care/daycare expenses"),
  school(title: "School supplies/fees"),
  elder(title: "Elder care costs"),
  pet(title: "Pet food/supplies"),
  vet(title: "Veterinarian care costs"),
  petInsurance(title: "Pet insurance premiums"),
  baby(title: "Babysitting/pet-sitting costs");

  const Family({required this.title});
  final String title;
}

enum Personal {
  toiletries(title: "Toiletries and personal hygiene products"),
  groom(title: "Haircuts and grooming services"),
  clothes(title: "Clothing and shoes"),
  laundry(title: "Laundry and dry cleaning"),
  skin(title: "Skincare/cosmetics"),
  wellness(title: "Wellness (e.g. massages, manicure)");

  const Personal({required this.title});
  final String title;
}

enum Health {
  insurance(title: "Health insurance premiums"),
  prescription(title: "Prescription medications"),
  medicines(title: "Over-the-counter medicines"),
  copay(title: "Copays for doctor/specialist visits"),
  dental(title: "Dental and vision care"),
  mental(title: "Mental health services"),
  gym(title: "Gym/fitness memberships");

  const Health({required this.title});
  final String title;
}

enum Technology {
  plans(title: "Smartphone plans and devices"),
  wifi(title: "Internet service"),
  comp(title: "Computer hardware/software"),
  stream(title: "Streaming services (ex. Netflix,Spotify)"),
  game(title: "Gaming subscriptions"),
  acc(title: "Tech accessories/upgrades");

  const Technology({required this.title});
  final String title;
}

enum Debt {
  card(title: "Credit card"),
  student(title: "Student loans"),
  personal(title: "Personal loans"),
  medical(title: "Medical debt payments"),
  misc(title: "Any outstanding debt/payment plans");

  const Debt({required this.title});
  final String title;
}

enum Savings {
  emergency(title: "Emergency savings fund"),
  retire(title: "Retirement accounts"),
  invest(title: "Investment contributions"),
  college(title: "College savings plans"),
  misc(title: "Other long term financial goals");

  const Savings({required this.title});
  final String title;
}

enum Entertainment {
  food(title: "Dine out/order in"),
  movie(title: "Movie tickets/streaming rentals"),
  event(title: "Concert/event tickets"),
  hobby(title: "Hobbies/recreational activities"),
  read(title: "Books/magazines/others"),
  travel(title: "Vacation/travel");

  const Entertainment({required this.title});
  final String title;
}

enum Misc {
  gift(title: "Gift for birthdays/holidays/occasions"),
  charity(title: "Charitable donations"),
  prof(title: "Professional dues/memberships"),
  dev(title: "Education/professional development costs"),
  sudden(title: "Unexpected expenses/large purchases");

  const Misc({required this.title});
  final String title;
}