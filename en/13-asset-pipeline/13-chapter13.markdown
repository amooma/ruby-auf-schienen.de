# Asset Pipeline

## Introduction

The asset pipeline offers the Rails developer the opportunity of
delivering CSS, JavaScript and image files to the browser more optimally
- in other words, in a more compressed form and therefore more quickly.
Different CSS files are combined into one big file and delivered to the
browser with a fingerprint in the file name. This fingerprinting enables
the browser and any proxy in between to optimally cache the data, so the
browser can load these files more quickly.

Within the asset pipeline, you can program CSS, SASS, JavaScript and
CoffeeScript extensively and clearly, in order to let them be delivered
later as automatically compressed CSS and JavaScript files.

As an example we use once more our web shop with a product scaffold:

``` {.screen}
$ rails new webshop
  [...]
$ cd webshop
$ rails generate scaffold product name 'price:decimal{7,2}'
  [...]
$ rake db:migrate
  [...]
$
```

In the directory `app/assets`{.filename} you will then find the
following files:

``` {.screen}
app/assets
├── images
├── javascripts
│   ├── application.js
│   └── products.js.coffee
└── stylesheets
    ├── application.css
    ├── products.css.scss
    └── scaffolds.css.scss
```

The files `app/assets/javascripts/application.js`{.filename} and
`app/assets/stylesheets/application.css`{.filename} are what is referred
to as manifest files. They automatically include the other files in the
relevant directory.

## Manifest Files

In `app/assets/javascripts`{.filename} and
`app/assets/stylesheets`{.filename} there are always manifest files that
contain instructions to the asset pipeline. They define everything that
is to be integrated.

## application.js

The file `app/assets/javascripts/application.js`{.filename} has the
following content:

``` {.programlisting}
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
```

In the `application.js`{.filename}, the jQuery files defined in the
`jquery-rails`{.code} gem are automatically integrated (for further
information on jQuery, please visit `http://jquery.com/`{.uri}). Plus
all other files in this directory are integrated via
`require_tree         .`{.code} as shown above.

The not yet optimized result can be viewed in the development
environment at the URL
`http://0.0.0.0:3000/assets/application.js`{.uri}.

## application.css

The file `app/assets/stylesheets/application.css`{.filename} has the
following content:

``` {.programlisting}
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
 * or vendor/assets/stylesheets of plugins, if any, can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the top of the
 * compiled file, but it's generally better to create a new file per style scope.
 *
 *= require_self
 *= require_tree .
 */
```

With the command `require_tree .`{.code} all files in this directory are
automatically integrated.

## rake assets:precompile

When using the asset pipeline, you need to remember that you have to
precompile the assets before starting the Rails server in the production
environment. This happens via the command **rake assets:precompile:**

``` {.screen}
$ rake assets:precompile
I, [2013-07-17T22:58:32.807148 #42981]  INFO -- : Writing /Users/xyz/webshop/public/assets/application-723d1be6cc741a3aabb1cec24276d681.js
I, [2013-07-17T22:58:32.880512 #42981]  INFO -- : Writing /Users/xyz/webshop/public/assets/application-12b3c7dd74d2e9df37e7cbb1efa76a6d.css
$
```

### Note

If you forget to do this, you will find the following error message in
the log:

``` {.screen}
ActionView::Template::Error (application.css isn't precompiled)
```

The files created by **rake assets:precompile** appear in the directory
`public/assets`{.filename}

``` {.screen}
public/assets/
├── application-12b3c7dd74d2e9df37e7cbb1efa76a6d.css
├── application-12b3c7dd74d2e9df37e7cbb1efa76a6d.css.gz
├── application-723d1be6cc741a3aabb1cec24276d681.js
├── application-723d1be6cc741a3aabb1cec24276d681.js.gz
└── manifest-720d2116dee3d83d194ffd9d0957c21c.json
```

Go ahead and use your favorite editor to have a look at the created
`css`{.filename} and `js`{.filename} files. You will find optimized
code. If the web server supports it, the zipped `gz`{.filename} files
are delivered directly, which speeds things up a bit more.

### Note

The difference in file size is enormous. The file
`application.js`{.filename} created in the development environment has a
file size of 296 KB. The file `js.gz`{.filename} created by **rake
assets:precompile** is only 88 KB. Users of cellphones in particular
will be grateful for smaller file sizes.

The speed advantage incidentally lies not just in the file size, but
also in the fact that only one file is downloaded, not several. The HTTP
overhead for loading a file is time-consuming.

## The Fingerprint

The fingerprint in the file name consists of a hash sum generated from
the content of the relevant file. This fingerprint ensures optimal
caching and prevents an old cache being used if any changes are made to
the content. A simple but very effective method.

## Coding Links to an Asset

All files below the directory `app/assets`{.filename} are delivered in
normal form by the Rails server. For example, you can go to the URL
`http://0.0.0.0:3000/assets/rails.png`{.uri} to view the Rails logo
saved under `app/assets/images/rails.png`{.filename} and to
`http://0.0.0.0:3000/assets/application.js`{.uri} to view the content of
`app/assets/javascripts/application.js`{.filename}. The Rails image
`rails.png`{.filename} is delivered 1:1 and the file
`application.js`{.filename} is first created by the asset pipeline.

But you should never enter these files as hard-wired in a view. To make
the most of the asset pipeline, you must use the helpers described here.

## Coding Link to an Image

You can retrieve an image via the helper `image_tag`{.code}. This is
what it would look like in the view for the file
`app/assets/images/rails.png`{.filename}:

``` {.programlisting}
<%= image_tag "rails.png" %>
```

In development mode, the following HTML code results from this:

``` {.programlisting}
<img alt="Rails" src="/assets/rails.png" />
```

In production mode, you get an HTML code that points to a precompiled
file with fingerprint:

``` {.programlisting}
<img alt="Rails" src="/assets/rails-be8732dac73d845ac5b142c8fb5f9fb0.png" />
```

## Coding Link to a JavaScript File

You can use the helper `javascript_include_tag`{.code} to retrieve a
JavaScript file compiled by the asset pipeline. This is what it would
look like in the view for the file
`app/assets/javascripts/application.js`{.filename}:

``` {.programlisting}
%= javascript_include_tag "application" %>
```

In development mode, the following HTML code results from this:

``` {.programlisting}
<link href="/assets/application.css?body=1" media="all" rel="stylesheet" type="text/css" />
<link href="/assets/products.css?body=1" media="all" rel="stylesheet" type="text/css" />
<link href="/assets/scaffolds.css?body=1" media="all" rel="stylesheet" type="text/css" />
```

In production mode, you get an HTML code that points to a precompiled
file with fingerprint:

``` {.programlisting}
<link href="/assets/application-0149f820dbdd285aa65e241569d8c256.css" media="all" rel="stylesheet" type="text/css" />
```

## Coding Link to a CSS File

A stylesheet compiled by the asset pipeline can be retrieved via the
helper `stylesheet_link_tag`{.code}. In the view, it would look like
this for the file `app/assets/stylesheets/application.css`{.filename}:

``` {.programlisting}
<%= stylesheet_link_tag "application" %>
```

In development mode, the following HTML code results from this:

``` {.programlisting}
<script src="/assets/jquery.js?body=1" type="text/javascript"></script>
<script src="/assets/jquery_ujs.js?body=1" type="text/javascript"></script>
<script src="/assets/products.js?body=1" type="text/javascript"></script>
<script src="/assets/application.js?body=1" type="text/javascript"></script>
```

In production mode, you get an HTML code that points to a precompiled
file with fingerprint:

``` {.programlisting}
<script src="/assets/application-f8ca698e63b86d217c88772a65d2d20e.js" type="text/javascript"></script>
```

## Defaults in the application.html.erb

Incidentally, the file
`app/views/layouts/application.html.erb`{.filename} that the scaffold
generator creates by default already contains the coding links for these
JavaScript and stylesheet files:

``` {.programlisting}
<!DOCTYPE html>
<html>
<head>
  <title>Webshop</title>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
<body>

<%= yield %>

</body>
</html>
```
