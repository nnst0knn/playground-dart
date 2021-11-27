void main() {
  items.forEach((name, f) {
    print('--- ${name} ---');
    f();
  });
}

var items = {
  'cast inference': () {
    // var s = 'string' as int; // runtime error: type 'String' is not a subtype of type 'int' in type cast
    List<Object> objects1 = [1, 2, 's', Animal(name: 'cat')];
    final objects2 = [1, 2, 's', Animal(name: 'cat')];
    print(objects1.runtimeType == objects2.runtimeType);
  },
  'num': () {
    var integer = 1;
    integer = 2; // ok
    // integer = 1.0; A value of type 'double' can't be assigned to a variable of type 'int'.
    num number = integer; // An integer or floating-point number.
    number = 1.0; // ok
    print(number);

    var doubles = [1.0, 2.0];
    doubles.map((d) => d.toInt()).forEach(print);
  },
  'assignment': () {
    // upcasting
    Animal cat = Cat(); // ok
    print(cat.name);
    // downcasting
    // Cat animal = Animal('cat'); A value of type 'Animal' can't be assigned to a variable of type 'Cat'.
    List<Animal> cats1 = <Cat>[Cat(), Cat()]; // ok
    cats1.forEach((cat) => print(cat.name));
    // List<Cat> cats = <Animal>[Cat(), Cat()]; A value of type 'List<Animal>' can't be assigned to a variable of type 'List<Cat>'.
  }
};

class Animal {
  final String name;
  Animal({required this.name});
}

class Cat extends Animal {
  Cat() : super(name: 'cat');
}

class Dog extends Animal {
  Dog() : super(name: 'dog');
}
