# Natural Language Generator Service

In my search for a good NLG library for a Ruby project, I found out that there isn't a lot of NLG code available.

The only open source one I found that seems to be the most mature and/or most contributed to is [SimpleNLG](https://github.com/simplenlg/simplenlg).

It is written in Java and compiles find using newest Java and Maven. The version I vendorized in this one is 4.4.9 (which I didn't find in common Maven repositories, by the way, just the older 4.4.8).

I considered rewritting it in another more embedabble language such as Rust, but then I see that one of SimpleNLG advantages is that it uses the [SPECIALIST NLP's NIH Lexicon database](https://www.ncbi.nlm.nih.gov/books/NBK9680/).

This lexicon database is a binary dump of HSQLDB, which is a Java-only database and the structures to read it are opaque within 'lexAccess2011dist.jar' and 'lvg2011api.jar'.

This current version is just using the smaller 'default_lexicon.xml', but if I ever want to use the more complete NIH database, it would a big hassle.

## JRUBY

So, instead of rewriting the damn thing, I decided to wrap it around a thin rails-api layer and load it with JRUBY 9.1.5.0.

This project should be able to load on Heroku without any problems like this:

```
heroku create your-nlg-service
git push heroku master
```

Now you can test it out like this:

```
rake test_heroku HEROKU=your-nlg-service.herokuapp.com
```

You can contribute sending Pull Requests or opening Issues.

## License

Author: Fabio Akita
Copyright 2016, Codeminer 42

NLG Service project is made available under the Affero GPL license version 3, see [LICENSE.txt](LICENCE.txt).
