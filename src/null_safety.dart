void main() {
  items.forEach((name, f) {
    print('--- ${name} ---');
    f();
  });
}

var items = {
  'chain': () {
    Something? something = Something();
    print(something.s.toUpperCase()); // HELLO
    something = null;
    // print(something.s.toUpperCase()); The property 's' can't be unconditionally accessed because the receiver can be 'null'.
    // When you use a null-aware operator in a method chain,
    // if the receiver evaluates to null,
    // then the entire rest of the method chain is short-circuited and skipped.
    print(something?.s.toUpperCase()); // null
  },
  'late': () {
    final Coffee coffee = Coffee();
    // coffee.serve(); LateInitializationError: Field '_temperature@18120273' has not been initialized.
    coffee.heat();
    print(coffee.serve());
  }
};

class Something {
  String get s => 'hello';
}

class HttpResponse {
  final int code;
  final String? error;

  HttpResponse.ok()
      : code = 200,
        error = null;
  HttpResponse.notFound()
      : code = 404,
        error = 'Not found';

  @override
  String toString() {
    if (code == 200) return 'OK';
    return 'ERROR $code ${error!.toUpperCase()}';
  }
}

class Coffee {
  late String _temperature;

  void heat() {
    _temperature = 'hot';
  }

  void chill() {
    _temperature = 'iced';
  }

  String serve() => _temperature + ' coffee';
}
