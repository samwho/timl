# Timl

Timl is an amalgamation of Tiny XML. I created it because I find the builder DSL
to be a little bit cluttered and hard to digest at first glance.

Timl aims to be very small and very intuitive to use. The main code that does
all of the heavy lifting is less than 100 lines of code, including comments.

# Installation

The installation is a standard RubyGem installation:

    gem install timl

# Usage

The Timl DSL is very intuitive. It relies on some Ruby metaprogramming under the
hood that will catch methods that have not been defined and define them. What
this means to you, the user, is that you can use any XML tag you want as part of
the DSL. Let's see an example:

``` ruby
Timl.start do
  body do
    p { "This is a paragraph tag." }
  end
end
```

The return value of that code is the following XML:

``` xml
<body>
  <p>
    This is a paragraph tag.
  </p>
</body>
```

Which is what you would expect, right?

## Attributes in XML

The above example is a bit simple. What is you want attributes in your XML? Timl
can do that too:

``` ruby
Timl.start do
  div id: "content" do
    p style: "font-weight: bold" do
      "This is a bold paragraph.
    end
  end
end
```

Which, unsurprisingly, produces the following XML (I realise these are HTML
examples, but the library really isn't constrained to HTML):

``` xml
<div id='content'>
  <p style='font-weight: bold'>
    This is a bold paragraph.
  </p>
</div>
```

## XML and HTML headers

If you want to include XML and HTML header/doctype information, that's possible
as well:

``` ruby
Timl.start do
  xml_header
end
```

Translates to:

``` xml
<?xml version='1.0' encoding='UTF-8'?>
```

If you want to use a different encoding, that's possible too:

``` ruby
Timl.start do
  xml_header encoding: "UTF-16"
end
```

Translates to:

``` xml
<?xml version='1.0' encoding='UTF-16'?>
```

### HTML doctype

The HTML doctype is inserted in a very similar way:

``` ruby
Timl.start do
  html5_doctype
end
```

Translates to:

``` xml
<!DOCTYPE html>
```

Unfortunately doctypes before HTML5 are not currently supported. If there's
overwhelming need for it in future, I might consider adding it.

# Contributing

If you want to contribute, please feel free. File an issue, fork the repo,
submit a pull request, whatever you want to do. Please not, however, that I use
git-flow as a branching strategy. If you aren't familiar with git-flow, look it
up, learn it, love it :)

Please don't submit pull requests to master. Pull requests must go to develop
and come from a feature branch. Thanks!
