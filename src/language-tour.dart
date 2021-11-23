import 'dart:convert';

import 'package:characters/characters.dart';

void main() {
  items.forEach((name, f) {
    print('--- ${name} ---');
    f();
  });
}

var items = {
  'null safety': () {
    int? number = 1;
    number = null;
    print(number);
  },
  'private member': () {
    List<Item> items = [];
    items.add(Item(item: 'Apple', grams: 100));
    items.add(Item(item: 'Orange', grams: 200));
    items.add(Item(item: 'Banana', grams: 700));
    try {
      Box box = Box(
        items: items,
        from:
            'Tesutoko-po 5-32-1 Test Test-ku,Test-shi, Test-ken 111-1122 Japan',
        to: 'Tesutohaitsu 4-32-1 Test Test-ku,Test-shi, Test-ken 111-1133 Japan',
      );
      print('size: ${box.size}\nfrom: ${box.from}\nto: ${box.to}');
      print(box._items); // ???
    } on ArgumentError catch (_) {
      print('overweight!!!');
    }
  },
  'final const': () {
    // const s1; must be initialized.
    const String s1 = 'Hello';
    const String s2 = '${s1} World';
    print(s2);

    final String s3;
    s3 = 'Hello World';
    // s3 = 'Hello Dart'; can only be set once.
    print(s3);

    const Map<String, String> o1 = {
      'name': 'const obj',
    };
    // o1['name'] = 'changed'; Cannot modify an unmodifiable ***
    print(o1);

    final Map<String, String> o2 = {
      'name': 'final obj',
    };
    o2['name'] = 'changed';
    print(o2);
    // o2 = {
    //   'name': 'new final obj',
    // }; can only be set once.
  },
  'parse': () {
    const String s = '1';
    print(int.parse(s));
    print(double.parse(s));
  },
  'list': () {
    const List<int> numbers = [1, 2, 3];
    const newNumbers = [...numbers, 4, 5];
    print(newNumbers);
    print([...newNumbers, if (newNumbers.length >= 5) 6]);
    print([...newNumbers, for (int n in newNumbers) n]);
  },
  'set': () {
    // final names = {}; Map<dynamic, dynamic> names
    final names = <String>{};
    names.add('taro');
    names.add('jiro');
    names.add('taro');
    names.add('saburo');
    print(names);
  },
  'map': () {
    final image = <String, String>{
      'name': 'sample',
      'url': 'https://...',
    };
    print(image);
  },
  'runes': () {
    const pien = 'ぴえん🥺';
    print(pien.length); // 5
    print(pien.runes.length); // 4
    print(pien.substring(pien.length - 1));
    print(pien.characters.last);
  },
  'positional|named parameters': () {
    // The default value of an optional parameter must be constant.
    final positional = (String url,
            [String method = 'GET', Map<String, String> payload = const {}]) =>
        print('${method}: ${url} ${jsonEncode(payload)}');
    positional('http://localhost', 'GET', {
      'name': 'taro',
    });
    final named = (String url,
            {String method = 'GET', Map<String, String> payload = const {}}) =>
        print('${method}: ${url} ${jsonEncode(payload)}');
    named('http://localhost', payload: {
      'name': 'taro',
    });
  },
  'lexixal': () {
    final Function f = () {
      int i = 0;
      return () => ++i;
    };
    final Function f1 = f();
    final Function f2 = f();
    print(f1()); // 1
    print(f1()); // 2
    print(f1()); // 3
    print(f2()); // 1
  },
  'operaters': () {
    String? s = null;
    print(s ?? 's is null');
    s ??= 'default';
    print(s);
    final map = {'name': s};
    map
      ..update('name', (value) => '${value} value')
      ..forEach((key, value) {
        print('${key}: ${value}');
      });
  },
  'abstract class': () {
    List<Authenticatable> users = [
      HogeUser(),
      FugaUser(),
    ];
    users.forEach((user) =>
        print('class: ${user.name()} identifier_key: ${user.identifierKey()}'));
  },
  'async await': () async {
    final fetch = () async {
      await Future.delayed(Duration(milliseconds: 300));
      return 'success';
    };

    String res = await fetch();
    print(res);
    String res2 = await fetch();
    print(res2);

    Stream<int> numbers(int n) async* {
      int k = 0;
      while (k < n) {
        await Future.delayed(Duration(milliseconds: 200));
        yield k++;
      }
    }

    await for (var k in numbers(10)) {
      print(k);
    }
  },
};

abstract class Authenticatable {
  name();

  identifierKey();
}

class HogeUser implements Authenticatable {
  @override
  name() {
    return 'hoge';
  }

  @override
  identifierKey() {
    return 'token';
  }
}

class FugaUser implements Authenticatable {
  @override
  name() {
    return 'huga';
  }

  @override
  identifierKey() {
    return 'email';
  }
}

class Box {
  static const int weight = 5;
  static const int max = 1000 + weight;

  late List<Item> _items;
  String from;
  String to;

  Box({required List<Item> items, required this.from, required this.to}) {
    this._items = items;
    if (this.size > max) {
      throw new ArgumentError();
    }
  }

  get size =>
      _items.fold<int>(0, (total, item) => total + item.grams) + Box.weight;

  @override
  noSuchMethod(Invocation invocation) {
    print('no such method');
  }
}

class Item {
  dynamic item;
  int grams;

  Item({required this.item, required this.grams});

  void call() => print('called?');
}
