Gramophone
==========

[![Build Status](https://travis-ci.org/dblock/gramophone.svg?branch=master)](https://travis-ci.org/dblock/gramophone)

Run
---

```
$ bundle install
$ rackup

[2013-06-20 08:57:58] INFO  WEBrick 1.3.1
[2013-06-20 08:57:58] INFO  ruby 1.9.3 (2013-02-06) [x86_64-darwin11.4.2]
[2013-06-20 08:57:58] INFO  WEBrick::HTTPServer#start: pid=247 port=9292
```

Grab
----

```
$ rake instagram:import[warhol]
```

Repeat
------

```
$ rake instagram:import_all
```

Debug
-----

```
$ bundle exec rack-console

2.1.2 :001 > Gramophone::Models::Gram.count
 => 40
```

API
---

Currently in production [here](https://gramophone-production.herokuapp.com/api).


Copyright and License
---------------------

Copyright (c) 2014 Daniel Doubrovkine

MIT License, see [LICENSE](LICENSE) for details.
