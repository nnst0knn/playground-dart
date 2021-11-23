import 'dart:math';

void main() {
  items.forEach((name, f) {
    print('--- ${name} ---');
    f();
  });
}

var items = {
  'hello': () {
    print('Hello Dart!!!');
  },
  'variables': () {
    var s = 'string value';
    var i = 1;
    var hash = {
      'url': 'http://...',
      'tags': ['animal'],
    };

    print('${s} is ${s.runtimeType.toString()}');
    print('${i} is ${i.runtimeType.toString()}');
    print('${hash} is ${hash.runtimeType.toString()}');
  },
  'controll flow': () {
    int year = 2021;

    if (year >= 2001) {
      print('21st century');
    } else if (year >= 1901) {
      print('20th century');
    }

    for (final y in Iterable.generate(2, (i) => year + i)) {
      print(y);
    }

    for (int y = year; y < year + 2; y++) {
      print(y);
    }

    while (year <= 2022) {
      print(year);
      ++year;
    }
  },
  'functions': () {
    int f(int n) {
      if (n == 0) return n;
      return n + f(n - 1);
    }

    List<int> numbers = Iterable.generate(30, (i) => i + 1).toList();

    numbers.where((number) => number <= 15).map(f).forEach(print);
  },
  'classes': () {
    User user = User(familyName: 'Fam', givenName: 'Giv');
    user.greet();

    User anonymousUser = User.anonymous();
    anonymousUser.greetWithDelay(2);
  },
};

class User with IdGeneratable {
  late String id;
  String familyName;
  String givenName;

  User({required this.familyName, required this.givenName}) {
    this.id = generateId();
  }

  User.anonymous() : this(familyName: 'Anony', givenName: 'Mous');

  get fullName => '${this.givenName} ${this.familyName}';

  void greet() {
    print('[${this.id}] Hello, I\'m ${this.fullName}.');
  }

  Future<void> greetWithDelay(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
    this.greet();
  }
}

mixin IdGeneratable {
  String generateId() {
    return Generator.generateId(8);
  }
}

class Generator {
  /// https://stackoverflow.com/questions/61919395/how-to-generate-random-string-in-dart#:~:text=const%20_chars%20%3D%20%27AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890%27%3B%0ARandom%20_rnd%20%3D%20Random()%3B%0A%0AString%20getRandomString(int%20length)%20%3D%3E%20String.fromCharCodes(Iterable.generate(%0A%20%20%20%20length%2C%20(_)%20%3D%3E%20_chars.codeUnitAt(_rnd.nextInt(_chars.length))))%3B
  static String generateId(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}
