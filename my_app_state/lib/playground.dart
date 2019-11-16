

void main(){

  // Implicit
  var a1 = 1234;
  var a2 = '1234';
  var a3 = true;

  // Explicit
  int b1 = 1234;
  String b2 = '1234';
  bool b3 = true;

  // Implicit vs Explicit
  // bool a4 = getCodemobiles();

  a1 = 5555;
  print("a1: $a1, a2: $a2, a3: $a3");

  const TAX = 7;
  final FAC = 5;

  var xyz; // default value is null
  print(xyz);

  nameFunction(vat: 7, money: 1234 );
  name1Function(2);
}

void normalFN(){
  print("CodeMobiles");
}

void argsFN(int a, int b){
  print(a + b);
}

// named Function
void nameFunction({int money = 0, int vat = 0}){
  print(money * vat);
}

void name1Function([int money = 0, int vat = 0]){
  print(money * vat);
}
