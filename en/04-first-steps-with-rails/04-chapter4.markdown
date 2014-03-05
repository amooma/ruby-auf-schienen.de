# First Steps with Rails

Now that you have painstakingly read your way through "Ruby Basics"
we can move on to a more exciting bit. In this chapter, we will start
our first Ruby on Rails project and find our way into the topic step
by step.

We will use Ruby on Rails version 4.0. Please update to this version in
case have installed an older one.

## Note

In this chapter, we will also move on the double in some cases. Once
more, there will be some typical chicken and egg problems.

### Environment (Development)

By default a Rails project offers three different environments:

* Development
* Test
* Production

In this chapter, we are only working with the Development environment.
Once you have gained a better feeling for Rails, we will start using
tests and then we will need the corresponding environment (where, for
example, the Test database is populated when you start a test and then
cleared). Later, I will explain the various scenarios to show how you can
roll out your Rails application from the Development environment to the
Production environment.

The Development environment has everything you need for developing,
apart from an editor and a web browser. So you do not need to install a
special web server, but can use the integrated Rails web server. It does
not exactly have extremely high performance, but you do not need that
for developing. Later, you can switch to big web servers like Apache or
Nginx. The same applies to the database.

In order to work in the Development environment, you do not need to make
any changes to start with - all commands work by default.

### SQLite-3 Database

In terms of the database, the main focus in this chapter is once more
not on optimum performance, but on showing you a simple way of getting
started. That's why we are using the SQLite-3 database. You already have
everything you need fully installed and you don't need to worry about
anything. Later I will explain how you can use other databases (for
example MySQL).

### Why Is It All in English?

If you are a native English speaker, you may not find it surprising that
Rails apparently loves the English language. Even if you are not a
native English speaker, you should try to accept and even adopt Rails'
love for the English language. Much of it will then be much easier and
more logical. Most of the code then reads just like a normal English
sentence. For example, many mechanisms automagically use plural or
singular forms of normal English words. If you get used to naming
database fields and tables with English terms (even if you are
programming in a different language), then you can make use of the whole
power of this magic. This mechanism is referred to as `Inflector`{.code}
or *Inflections* (inflexions).

If you are programming in a language other than English, it still makes
sense to use English names for variables, classes and methods. You can
write the comments in your own language, but if you take part in
international projects, you should obviously write the comments in
English as well. Yeah, sure … well written code does not need any
comments. ;-)

### Static Content (HTML and Graphics Files)

If you are reading this text, you will already know that you can use
Rails to somehow output web pages. The question is just how it's done.
Let's first create a new Rails project.

### Create Rails Project

Before we even get going, please check that you are using Ruby version
2.0:

``` {.screen}
$ ruby -v
ruby 2.0.0p247 (2013-06-27 revision 41674) [x86_64-darwin12.4.0]
$
```

Next, check if Rails 4.0 is also installed:

``` {.screen}
$ rails -v
Rails 4.0.0
$
```

That's looking good. If you have an older version of Ruby or Rails
installed, please install the 4.0 version before you read any further.

Now we start by creating a new Rails project with the name
`testproject`{.literal}. Ruby on Rails is a framework, so we first need
to set up the corresponding directory structure and basic configuration,
including several scripts. Easy as pie, just use the command **rails new
testproject**:

``` {.screen}
$ rails new testproject
      create  
      create  README.rdoc
      create  Rakefile
      create  config.ru
      [...]
$
```

#### Note

In previous versions of Rails, you had to do a **bundle install** first.
With Rails 3.2 onwards, this is done automatically when you create a new
Rails project. The Rails project then has all required *gems* available.
A *gem* is a kind of software library. You can integrate certain
ready-made functionalities with it, without having to reinvent the
wheel.

Next, we check if the new Rails application is working by launching the
integrated web server.

#### Tip

Depending on the operating system (for example, Mac OS X) and on your
firewall settings, you may see a popup window when first starting a
Rails application, asking you if the firewall should permit the
corresponding connection. As we are only working locally, you can safely
confirm.

``` {.screen}
$ cd testproject
$ rails server
=> Booting WEBrick
=> Rails 4.0.0 application starting in development on http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
[2013-07-15 13:58:48] INFO  WEBrick 1.3.1
[2013-07-15 13:58:48] INFO  ruby 2.0.0 (2013-06-27) [x86_64-darwin12.4.0]
[2013-07-15 13:58:48] INFO  WEBrick::HTTPServer#start: pid=98552 port=3000
```

The start of the Rails application is looking good. It tells us:

``` {.screen}
Rails 4.0.0 application starting in development on http://0.0.0.0:3000
```

So let's go to the URL `http://0.0.0.0:3000`{.uri} or
`http://localhost:3000`{.uri} in the web browser.

Insert virgin_rails_app.png
New Rails Application

Looks good. Rails seems to be working fine. The log of it tells what
just happend:

``` {.screen}
Started GET "/" for 127.0.0.1 at 2013-07-15 13:59:35 +0200
Processing by Rails::WelcomeController#index as HTML
  Rendered /Users/xyz/.rvm/gems/ruby-2.0.0-p247/gems/railties-4.0.0/lib/rails/templates/rails/welcome/index.html.erb (1.1ms)
Completed 200 OK in 21ms (Views: 5.3ms | ActiveRecord: 0.0ms)
```

If we now click the link “*About your application's environment*”, we
can more information on the current environment.

#### Important

With **Ctrl**+**C** you can stop the web server.

### Static Pages

There are certain static pages, images and JavaScript files that are
automatically output by Rails. Remember part of the output of the
command **rails new testproject**:

``` {.screen}
$ rails new testproject
      [...]
      create  public/404.html
      create  public/422.html
      create  public/500.html
      create  public/favicon.ico
      create  public/robots.txt
      [...]
```

The directory name `public`{.filename} and the files it contains already
look very much like static pages. Let's have a go and create the file
`public/hello-world.html`{.filename} with the following content:

``` {.programlisting}
<html>
<head>
  <title>Hello World!</title>
</head>
<body>
  <h1>Hello World!</h1>
  <p>An example page.</p>
</body>
</html>
```

Now start the Rails web server with **rails server**

``` {.screen}
$ rails server
=> Booting WEBrick
=> Rails 4.0.0 application starting in development on http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
[2013-07-15 14:05:57] INFO  WEBrick 1.3.1
[2013-07-15 14:05:57] INFO  ruby 2.0.0 (2013-06-27) [x86_64-darwin12.4.0]
[2013-07-15 14:05:57] INFO  WEBrick::HTTPServer#start: pid=98564 port=3000
```

We can have a look at this web page at the URL
`http://0.0.0.0:3000/hello-world`{.uri}:

Insert hello-world-html.png
Hello World

No output in the log means: This page was not handled by the Rails
framework. It was delivered directly from the webserver.

### Note

We can of course also use the URL
`http://0.0.0.0:3000/hello-world.html`{.uri}. But Rails regards HTML and
therefore the file ending `.html`{.literal} as standard output format,
so you can omit the “`.html`{.literal}” here.

Now you know how you can integrate fully static pages in Rails. This is
useful for pages that never change and that you want to work even if
Rails is not currently working, for example because of an update. In a
production environment, you would usually put a classic web server such
as Apache or Nginx infront of the Rails server. Which is capable of
autonomously delivering static files from the `public`{.filename}
directory. You'll learn how to set up a production webserver in
[Chapter 16, *Web Server in Production
Mode*](#rails_production_webserver "Chapter 16. Web Server in Production Mode").

With **Ctrl**+**C** you can stop the Rails server.

## Creating HTML Dynamically with erb

The the content of an `erb`{.literal} file will propably seem familiar
to you. It is a mixture of HTML and Ruby code (`erb`{.literal} stands
for ***e**mbedded **R**u**b**y*). erb pages are rendered as Views. This
is the first time for us to get in touch with the MVC
model. We need a controller to use a view. That
can be created it via the generator **rails generate controller**. Let's
have a look at the onboard help of this generator:

``` {.screen}
$ rails generate controller
Usage:
  rails generate controller NAME [action action] [options]

Options:
      [--skip-namespace]        # Skip namespace (affects only isolated applications)
  -e, [--template-engine=NAME]  # Template engine to be invoked
                                # Default: erb
  -t, [--test-framework=NAME]   # Test framework to be invoked
                                # Default: test_unit
      [--helper]                # Indicates when to generate helper
                                # Default: true
      [--assets]                # Indicates when to generate assets
                                # Default: true

Runtime options:
  -f, [--force]    # Overwrite files that already exist
  -p, [--pretend]  # Run but do not make any changes
  -q, [--quiet]    # Suppress status output
  -s, [--skip]     # Skip files that already exist

Description:
    Stubs out a new controller and its views. Pass the controller name, either
    CamelCased or under_scored, and a list of views as arguments.

    To create a controller within a module, specify the controller name as a
    path like 'parent_module/controller_name'.

    This generates a controller class in app/controllers and invokes helper,
    template engine, assets, and test framework generators.

Example:
    `rails generate controller CreditCards open debit credit close`

    CreditCards controller with URLs like /credit_cards/debit.
        Controller: app/controllers/credit_cards_controller.rb
        Test:       test/controllers/credit_cards_controller_test.rb
        Views:      app/views/credit_cards/debit.html.erb [...]
        Helper:     app/helpers/credit_cards_helper.rb
$
```

Nice! We are kindly provided with an example further down:

``` {.programlisting}
rails generate controller CreditCard open debit credit close
```

Doesn't really fit the bill for our case but I am feeling brave and
suggest that we simply try **rails generate controller Example test**

``` {.screen}
$ rails generate controller Example test
      create  app/controllers/example_controller.rb
       route  get "example/test"
      invoke  erb
      create    app/views/example
      create    app/views/example/test.html.erb
      invoke  test_unit
      create    test/controllers/example_controller_test.rb
      invoke  helper
      create    app/helpers/example_helper.rb
      invoke    test_unit
      create      test/helpers/example_helper_test.rb
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/example.js.coffee
      invoke    scss
      create      app/assets/stylesheets/example.css.scss
$
```

Phew... that's a lot of stuff being created. Amongst others, the file
`app/views/example/test.html.erb`{.filename}. Let's have a closer look
at it:

``` {.screen}
$ cat app/views/example/test.html.erb
<h1>Example#test</h1>
<p>Find me in app/views/example/test.html.erb</p>
$
```

It's HTML, but for it to be a valid HTML page, something is “missing” at
the top and bottom (the missing HTML "rest" will be explained in [the
section called “Layouts”](#erb_layouts "Layouts")). We launch the web
server to test it

``` {.screen}
$ rails server
```

and have a look at the web page in the browser at the URL
`http://0.0.0.0:3000/example/test`{.uri}:

Insert example-test-erb.png
Example Test ERB

In the log `log/development.log`{.filename} we find the following lines:

``` {.programlisting}
Started GET "/example/test" for 127.0.0.1 at 2013-07-15 14:32:07 +0200
Processing by ExampleController#test as HTML
  Rendered example/test.html.erb within layouts/application (0.8ms)
Completed 200 OK in 768ms (Views: 751.0ms | ActiveRecord: 0.0ms)

Started GET "/assets/example.css?body=1" for 127.0.0.1 at 2013-07-15 14:32:08 +0200
Started GET "/assets/example.js?body=1" for 127.0.0.1 at 2013-07-15 14:32:08 +0200
Started GET "/assets/application.css?body=1" for 127.0.0.1 at 2013-07-15 14:32:08 +0200
Started GET "/assets/jquery_ujs.js?body=1" for 127.0.0.1 at 2013-07-15 14:32:08 +0200
Started GET "/assets/jquery.js?body=1" for 127.0.0.1 at 2013-07-15 14:32:08 +0200
Started GET "/assets/application.js?body=1" for 127.0.0.1 at 2013-07-15 14:32:08 +0200
Started GET "/assets/turbolinks.js?body=1" for 127.0.0.1 at 2013-07-15 14:32:08 +0200
```

That almost reads like normal English. Let us analyse the first part:

``` {.programlisting}
Started GET "/example/test" for 127.0.0.1 at 2013-07-15 14:32:07 +0200
Processing by ExampleController#test as HTML
  Rendered example/test.html.erb within layouts/application (0.8ms)
```

`localhost`{.literal} (127.0.0.1) sent in an HTTP GET request for the
URI “`/example/test`{.literal}”. That was then apparently rendered as
HTML by the controller `ExampleController`{.code} using the method
`test`{.methodname}.

### Note

The other lines tell us that a bunch of CSS and JavaScript files are
compiled and than delivered. In production mode these would be
precompiled and delivered as one CSS and one J

Now we just need to find the controller. Good thing you bough this book.
;-) All controllers are in the directory `app/controllers`{.filename},
and there you go, we indeed find the corresponding file
`app/controllers/example_controller.rb.`{.filename}

``` {.screen}
$ ls -l app/controllers/
total 16
-rw-r--r--  1 xyz  staff  204 15 Jul 13:56 application_controller.rb
drwxr-xr-x  3 xyz  staff  102 15 Jul 13:56 concerns
-rw-r--r--  1 xyz  staff   69 15 Jul 14:31 example_controller.rb
$
```

Please open the file `app/controllers/example_controller.rb`{.filename}
with your favorite editor:

``` {.programlisting}
class ExampleController < ApplicationController
  def test
  end
end
```

That is very clear. The controller `ExampleController`{.code} is a
descendant of the `ApplicationController`{.code} and contains currently
just one method with the name `test`{.methodname}. This method contains
currently no program logic.

You will probably ask yourself how Rails knows that for the URL path
`/example/test`{.uri} it should process the controller
`ExampleController`{.code} and the method `test`{.code}. This is not
determined by some magical logic, but by a *routing* configuration. The
current routings can be listed with the command **rake routes**

``` {.screen}
$ rake routes
      Prefix Verb URI Pattern             Controller#Action
example_test GET /example/test(.:format) example#test
$
```

These routes are configured in the file `config/routes.rb`{.filename}
which has been auto-filled by the controller generator with a route to
`example/test`{.code}. The one line which is important for us right now
is the second one:

``` {.screen}
$ head -n 2 config/routes.rb
Testproject::Application.routes.draw do
  get "example/test"
$
```

The `config/routes.rb`{.filename} file includes a lot of examples. Give
it a read when you have time. We'll dive into that later ([Chapter 6,
*Routes*](#routes "Chapter 6. Routes")).

#### Important

A static file in the directory `public`{.filename} always has higher
priority than a route in the `config/routes.rb`{.filename}! So if we
were to save a static file `public/example/test`{.filename} that file
will be delivered.

### Programming in an erb File

`Erb`{.literal} pages can contain Ruby code. You can use it to program
and give these page dynamic content.

Let's start with something very simple: adding 1 and 1. First we try out
the code in `irb`{.literal}:

``` {.screen}
$ irb --simple-prompt
>> 1 + 1
=> 2
>> exit
$
```

That was easy. We fill the `erb`{.literal} file
`app/views/example/test.html.erb`{.filename} as follows:

``` {.programlisting}
<h1>First experiment with erb</h1>
<p>Addition:
<%= 1 + 1 %>
</p>
```

Then use **rails server** to launch the web server.

``` {.screen}
$ rails server
```

Visit that page with the URL `http://0.0.0.0:3000/example/test`{.uri}

Insert erb_einfache_addition.png
Einfache Addition

### Important

If you want to output the result of Ruby code, enclose the code within a
`<%=`{.code} ... `%>`{.code}.

You may ask yourself: how can the result of adding two
`Fixnums`{.classname} be displayed as a String? Let's first look up in
`irb`{.literal} if it really is a `Fixnum`{.classname}:

``` {.screen}
$ irb --simple-prompt
>> 1.class
=> Fixnum
>> (1 + 1).class
=> Fixnum
```

Yes, both the number 1 and the result of 1 + 1 is a
`Fixnum`{.classname}. What happened? Rails is so intelligent that it
automatically calls all objects in a view (that is the file
`test.html.erb`{.filename}) that are not already a string via the method
`.to_s`{.methodname}, which always converts the content of the object to
a string ([the section called “Method to\_s for Your Own
Classes”](#ruby-to_s "Method to_s for Your Own Classes")). Once more, a
brief trip to `irb`{.literal}:

``` {.screen}
>> (1 + 1).to_s
=> "2"
>> (1 + 1).to_s.class
=> String
>> exit
$
```

You are now going to learn the finer points of `erb`{.literal} step by
step. Don't worry, it's neither magic nor rocket science.

### Syntax

In a `.html.erb`{.filename}file, there are two kinds of Ruby code
instructions in addition to the HTML elements:

-   \<% … %\> Executes the Ruby code it contains, but does not output
    anything (unless you explicitly use something like `print`{.code} or
    `puts`{.code}).
-   \<%= … %\> Executes the Ruby code it contains and outputs the result
    as a String. If is is not a String the methode `to_s`{.methodname}
    will be called.

#### Important

The output of \<%= ... %\> is automatically escaped. So you don't need
to worry about "dangerous" HTML.

Let's use an example, to make sure it all makes sense. We use
`each`{.methodname} to iterate through the `Range`{.classname}
`(0..5)`{.code}. Edit the `app/views/example/test.html.erb`{.filename}
as follows:

``` {.programlisting}
<p>Loop from 0 to 5:
<% (0..5).each do |i| %>
<%= "#{i}, " %>
<% end %>
</p>
```

Open this view In the browser:

Insert erb_einfache_schleife.png
Einfache Schleife

Let's now have a look at the HTML source code in the browser:

``` {.programlisting}
<!DOCTYPE html>
<html>
<head>
  <title>Testproject</title>
  <link data-turbolinks-track="true" href="/assets/application.css?body=1" media="all" rel="stylesheet" />
<link data-turbolinks-track="true" href="/assets/example.css?body=1" media="all" rel="stylesheet" />
  <script data-turbolinks-track="true" src="/assets/jquery.js?body=1"></script>
<script data-turbolinks-track="true" src="/assets/jquery_ujs.js?body=1"></script>
<script data-turbolinks-track="true" src="/assets/turbolinks.js?body=1"></script>
<script data-turbolinks-track="true" src="/assets/example.js?body=1"></script>
<script data-turbolinks-track="true" src="/assets/application.js?body=1"></script>
  <meta content="authenticity_token" name="csrf-param" />
<meta content="FjIAd8nQGbKSAdbXdY47d3dhW1ZNLhe4eWJYYOgVdes=" name="csrf-token" />
</head>
<body>

<p>Loop from 0 to 5:
  0,
  1,
  2,
  3,
  4,
  5,
</p>


</body>
</html>
```

Now you have the important tools to use Ruby code in a view.

## Q & A

Potentially, there are two open questions:

**Q:**

I don't understand anything. I can't cope with the Ruby code. Could you
please explain that again?

**A:**

Is it possible that you have not completely worked your way through
[Chapter 2, *Ruby Basics*](#ruby-grundlagen "Chapter 2. Ruby Basics")?
Please do take your time with it and have another thorough look.
Otherwise, the rest won't make any sense here.

**Q:**

I can understand the Ruby code and the HTML output. But I don't get why
some HTML code was rendered around it if I didn't even write that HTML
code. Where does it come from, and can I influence it?

**A:**

Excellent question! We will get to that next (see [the section called
“Layouts”](#erb_layouts "Layouts")).

## Layouts

The `erb`{.literal} file in the directory
`app/views/example/`{.filename} only forms the core of the later HTML
page. By default, an automatically generated
`app/views/layouts/application.html.erb`{.filename} is always rendered
around it. Let's have a closer look at it:

``` {.programlisting}
<!DOCTYPE html>
<html>
<head>
  <title>Testproject</title>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
<body>

<%= yield %>

</body>
</html>
```

The interesting bit is the line

``` {.programlisting}
<%= yield %>
```

With `<%= yield %>`{.code} the View file is included here. The lines
with the stylesheets, the JavaScript and the csrf\_meta\_tags can stay
as they are for now. They integrate default CSS and JavaScript files.
We'll have a look into that in [Chapter 12, *Asset
Pipeline*](#asset_pipeline "Chapter 12. Asset Pipeline"). No need to
bother with that right now.

The file `app/views/layouts/application.html.erb`{.filename} enables you
to determine the basic layout for the entire Rails application. If you
want to enter a `<hr>`{.code} for each page and above it a text, then
you can do this between the `<%= yield %>`{.code} and the
`<body>`{.code} tag:

``` {.programlisting}
<!DOCTYPE html>
<html>
<head>
  <title>Testproject</title>
  <%= stylesheet_link_tag    "application", :media => "all" %>
  <%= javascript_include_tag "application" %>
  <%= csrf_meta_tags %>
</head>
<body>

<h1>My Header</h1>
<hr>

<%= yield %>

</body>
</html>
```

You can also create other layouts in the directory
`app/views/layouts/`{.filename} and apply these layouts depending on the
relevant situation. But let's leave it for now. The important thing is
that you understand the basic concept.

## Passing Instance Variables from a Controller to a View

One of the cardinal sins in the MVC model is to
put too much program logic into the view. That's more or less what used
to be done frequently in PHP programming in the past. I'm guilty of
having done it myself. But one of the aims of MVC is that any HTML
designer can create a view without having to worry about the
programming. Yeah, yeah, … if only it was always that easy. But let's
just play it through in our minds: if I have a value in the controller
that I want to display in the view, then I need a mechanism for this.
This is referred to as *instance variable* and always starts with a
`@`{.code}. If you are not 100 % sure any more which variable has which
*scope*, then please have another quick look at [the section called
“Scope of Variables”](#scope_von_variablen "Scope of Variables").

In the following example, we insert an instance variable for the current
time in the controller and then insert it in the view. So we are taking
programming intelligence from the view to the controller.

The controller file `app/controllers/example_controller.rb`{.filename}
looks like this:

``` {.programlisting}
class ExampleController < ApplicationController
  def test
    @current_time = Time.now
  end
end
```

In the view file `app/views/example/test.html.erb`{.filename} we can
then access this instance variable:

``` {.programlisting}
<p>
The current time is
<%= @current_time %>
</p>
```

With the controller and the view, we now have a clear separation of
programming logic and presentation logic. So now we can automatically
adjust the time in the controller in accordance with the user's time
zone, without the designer of the page having to worry about it. As
always, the method `to_s`{.methodname} is automatically applied in the
view.

I am well aware that no-one will now jump up from their chair and shout:
“Thank you for enlightening me! From now on, I will only program neatly
in accordance with MVC.” The above example is just the first small step
in the right direction and shows how we can easily get values from the
controller to the view with instance variables.

### Partials

Even with small web projects, there are often elements that appear
repeatedly, for example a *footer* on the page with contact info or a
menu. Rails gives us the option of encapsulate this HTML code in form of
*partials* and then integrating it within a view. A partial is also
stored in the directory `app/views/example/`{.filename}. But the file
name must start with an underscore (`_`{.literal}).

As an example, we now add a mini footer to our page in a separate
partial. Copy the following content into the new file
`app/views/example/_footer.html.erb`{.filename}:

``` {.programlisting}
<hr>
<p>
Copyright 2009 - <%= Date.today.year %> the Easter Bunny.
</p>
```

#### Note

Yes, this is not the MVC way of doing it. Date.today.year should be
defined in the Controller. I'm glad that you caught this mistake. I made
it to show the use of a partial.

We edit the file `app/views/example/test.html.erb`{.filename} as follows
and insert the partial via the command`render`{.methodname}:

``` {.programlisting}
<p>Loop from 0 to 5:
<% (0..5).each do |i| %>
<%= "#{i}, " %>
<% end %>
</p>

<%= render "footer" %>
```

So now we have the following files in the directory
`app/views/example`{.filename}:

``` {.screen}
$ ls app/views/example
_footer.html.erb
test.html.erb
$
```

The new web page now looks like this:

Insert partials_footer.png
Partial Footer

#### Important

The name of a partial in the code is always specified *without* the
preceding underscore (`_`{.literal}) and *without* the file extension
`.erb`{.literal} and `.html`{.literal}. But the actual file must have
the underscore at the beginning of the file name and end with the file
extension `.erb`{.literal} and `.html`{.literal}.

Partials can also be integrated from other areas of the subdirectory
`app/views`{.filename}. For example, you can create a directory
`app/views/shared`{.filename} for recurring and shared content and
create a file `_footer.html.erb`{.filename} in this directory. You would
then integrate this file into the `erb`{.literal} code via the line:

``` {.programlisting}
<%= render "shared/footer" %>
```

### Passing Variables to a Partial

Partials are great in the sense of the DRY (***D**on't **R**epeat
**Y**ourself*) concept. But what makes them really useful is the option
of passing variables. Let's stick with the copyright example. If we want
to pass the start year as value, we can integrate this by adding the
following in the file `app/views/example/_footer.html.erb`{.filename}:

``` {.programlisting}
<hr>
<p>
Copyright <%= start_year %> - <%= Date.today.year %> the Easter Bunny.
</p>
```

So let's change the file `app/views/example/test.html.erb`{.filename} as
follows:

``` {.programlisting}
<p>Loop from 0 to 5:
<% (0..5).each do |i| %>
<%= "#{i}, " %>
<% end %>
</p>

<%= render "footer", :start_year => '2000' %>
```

If we now go to the URL `http://0.0.0.0:3000/example/test`{.uri}, we see
the 2000:

Insert partial_start_year_2000.png
Partial Start Year

Sometimes you need a partial that partially uses a local variable and
somewhere else you may need the same partial, but without the local
variable. We can take care of this in the partial itself with an if
statement:

``` {.programlisting}
<hr>
<p>
Copyright
<%= "#{start_year} - " if defined? start_year %>
<%= Date.today.year %>
the Easter Bunny.
</p>
```

#### Note

`defined?`{.methodname} can be used to check if an expression has been
defined.

You can call this partial with
`<%= render 'footer',         :start_year => '2000' %>`{.code} and with
`<%= render         'footer' %>`{.code}.

### Alternative Notation

In [the section called “Passing Variables to a
Partial”](#partials_locale_variables "Passing Variables to a Partial")
we only use the short form for rendering partials. Often, you will also
see this long version:

``` {.programlisting}
<%= render :partial => "footer", :locals => { :start_year => '2000' } %>
```

## Further Documentation on Partials

We have really only barely scratched the surface here. Partials are very
powerful tools. You can find the official Ruby on Rails documentation on
partials at
`http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials`{.uri}.

### Redirects

The name says it all, really: *redirects* are commands that you can use
within the controller to “skip”, i.e. redirect, to other to other web
pages.

#### Note

A redirect returns to the browser the response "302 Moved" with the new
target. So each redirect does a roundtrip to the browser and back.

Let's create a new Rails project for a suitable example:

``` {.screen}
$ rails new redirect_example
[...]
$ cd redirect_example
$
```

Before we can redirect, we need a controller with at least two different
methods. Off we go then:

``` {.screen}
$ rails generate controller Game ping pong
      create  app/controllers/game_controller.rb
       route  get "game/pong"
       route  get "game/ping"
      invoke  erb
      create    app/views/game
      create    app/views/game/ping.html.erb
      create    app/views/game/pong.html.erb
      invoke  test_unit
      create    test/controllers/game_controller_test.rb
      invoke  helper
      create    app/helpers/game_helper.rb
      invoke    test_unit
      create      test/helpers/game_helper_test.rb
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/game.js.coffee
      invoke    scss
      create      app/assets/stylesheets/game.css.scss
$
```

The controller `app/controllers/game_controller.rb`{.filename} has the
following content:

``` {.programlisting}
class GameController < ApplicationController
  def ping
  end

  def pong
  end
end
```

Now for the redirect: how can we achieve that we get immediately
redirected to the method `pong`{.methodname} when we go to
`http://0.0.0.0:3000/game/ping`{.uri}? Easy, you will say, we just
change the route in `config/routes.rb`{.filename}. And you are right. So
we don't necessarily need a redirect. But if we want to process
something else in the method `ping`{.methodname} before redirecting,
then this is only possible by using a `redirect_to`{.methodname} in the
controller `app/controllers/game_controller.rb`{.filename}:

``` {.programlisting}
class GameController < ApplicationController
  def ping
   logger.info '+++  Example  +++'
   redirect_to game_pong_path
  end

  def pong
  end
end
```

But what is `game_pong_path`{.code}? Let's have a look a the routes
generated for this Rails application:

``` {.screen}
$ rake routes
   Prefix Verb URI Pattern          Controller#Action
game_ping GET /game/ping(.:format) game#ping
game_pong GET /game/pong(.:format) game#pong
$
```

### Note

As you can see, the route to the *action*`ping`{.literal} of the
controller `GameController`{.literal} now gets the name
`game_ping`{.literal} (see beginning of the line). We could also write
the redirect like this:

``` {.programlisting}
redirect_to :action => 'pong'
```

I will explain the details and the individual options of the redirect
later in the context of each specific case. For now, you just need to
know that you can redirect not just to another method, but also to
another controller or an entirely different web page.

When we try to go to `http://0.0.0.0:3000/game/ping`{.uri} we are
automatically redirected to `http://0.0.0.0:3000/game/pong`{.uri} and in
the log output we see this:

``` {.screen}
Started GET "/game/ping" for 127.0.0.1 at 2013-07-15 18:49:01 +0200
Processing by GameController#ping as HTML
+++  Example  +++
Redirected to http://0.0.0.0:3000/game/pong
Completed 302 Found in 19ms (ActiveRecord: 0.0ms)


Started GET "/game/pong" for 127.0.0.1 at 2013-07-15 18:49:01 +0200
Processing by GameController#pong as HTML
  Rendered game/pong.html.erb within layouts/application (1.3ms)
Completed 200 OK in 743ms (Views: 741.9ms | ActiveRecord: 0.0ms)
```

### redirect\_to :back

If you want to redirect the user of your webapplication to the page he
has just been you can use `redirect_to :back`{.code}. This is very
useful in a scenario where your user first has to login to get access to
a specific page.

### Flash Messages

In my eyes, the term “*flash messages*” is somewhat misleading. Almost
anyone would associate the term “*Flash*” with more or less colorful web
pages that were implemented with the Adobe Shockwave Flash Plug-in. But
in Ruby on Rails, flash messages are something completely different.
They are messages that are displayed, for example on the new page after
a redirect (see [the section called
“Redirects”](#redirects "Redirects")).

Flash messages are good friends with redirects. The two often work
together in a team to give the user feedback on an action he just
carried out. A typical example of a flash message is the system feedback
when a user has logged in. Often the user is redirected back to the
original page and gets the message “You are now logged in.”

As an example, we are once more constructing the ping pong scenario from
[the section called “Redirects”](#redirects "Redirects"):

``` {.screen}
$ rails new pingpong
      [...]
$ cd pingpong
$ rails generate controller Game ping pong
      [...]
$
```

We fill the `app/controllers/game_controller.rb`{.filename} with the
following content:

``` {.programlisting}
class GameController < ApplicationController
  def ping
   redirect_to game_pong_path, notice: 'Ping-Pong!'
  end

  def pong
  end
end
```

Now we start the Rails web server with **rails server** and use the
browser to go to `http://0.0.0.0:3000/game/ping`{.uri}. We are
redirected from `ping`{.methodname} to `pong`{.methodname}. But the
flash message "Ping-Pong!" is nowhere to be seen. We first need to
expand `app/views/layouts/application.html.erb`{.filename}:

``` {.programlisting}
<html>
<head>
  <title>Pingpong</title>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
<body>

<%- flash.each do |name, message| %>
<p><i><%= "#{name}: #{message}" %></i></p>
<% end %>

<%= yield %>

</body>
</html>
```

Now we see the flash message at the top of the page when we go to
`http://0.0.0.0:3000/game/ping`{.uri} in the browser:

Insert flash_pong_notice.png
Pong Flash Notice

If we go to `http://0.0.0.0:3000/game/pong`{.uri} we still see the
normal Pong page. But if we go to `http://0.0.0.0:3000/game/ping`{.uri}
we are redirected to the Pong page and then the flash message is
displayed at the top.

#### Tip

If you do not see a flash message that you were expecting, first check
in the view to see if the flash message is output there.

### Different Types of Flash Message

Flash messages are automagically passed to the view in a hash. By
default, there are three different types: `error`{.literal},
`warning`{.literal} and `notice`{.literal}. You can also invent your own
category and then get it in the view later.

## Different Syntaxes

Depending on the programmer's preferences, you will find different
syntaxes of flash messages in practice. I am not going to take part in
the discussion about which is the best syntax, but just show you briefly
the two most common variations:

-   `{.programlisting}     redirect_to game_pong_path, notice: 'Ping-Pong!'`

-   `{.programlisting}     flash[:notice] = 'Ping-Pong!'     redirect_to action: pong`

Please have a look at the official documentation at
`http://guides.rubyonrails.org/action_controller_overview.html#the-flash`{.uri}
for more information.

### Why Are There Flash Messages At All?

You may wonder why there are flash messages in the first place. Couldn't
you just build them yourself if you need them? Yes, indeed. But flash
messages have the advantage that they offer a defined approach that is
the same for any programmer. So you don't need to start from scratch
every single time you need one.

### The Rails Console

The *console* in Rails is nothing more than an `irb`{.literal} (see [the
section called “irb”](#irb "irb")) built around the Rails environment.
The console is very useful both for developing and for administration
purposes, because the whole Rails environment is represented and
available.

For our working environment, we again use a variation of the ping pong
scenario from [the section called “Redirects”](#redirects "Redirects"):

``` {.screen}
$ rails new pingpong
      [...]
$ cd pingpong
$ rails generate controller Game ping pong
      [...]
$
```

Start the Rails console with the command **rails console**:

``` {.screen}
$ rails console
Loading development environment (Rails 4.0.0)
2.0.0-p247 :001 >
```

And you can use **exit** to get back out:

``` {.screen}
2.0.0-p247 :001 > exit
$
```

Many readers use this document on mobile devises. For them I try to keep
any code or terminal output width to a minimum. To save the real estate
which is by default occupied by `2.0.0-p247 :001 >`{.code} we can start
**rails console** with the parameter *`-- --simple-prompt`*.

``` {.screen}
$ rails console -- --simple-prompt
Loading development environment (Rails 4.0.0)
>> exit
$
```

Alternativly you can change the IRB configuration in the file
`.irbrc`{.filename} which is located in your home directory. If you want
to have the simple prompt you have to add the following line in that
file.

``` {.programlisting}
IRB.conf[:PROMPT_MODE] = :SIMPLE
```

In the console, you have access to all variables that are also available
later in the proper application:

``` {.screen}
$ rails console
Loading development environment (Rails 4.0.0)
>> Rails.env
=> "development"
>> Rails.root
=> #<Pathname:/Users/xyz/pingpong>
>> exit
$
```

Already in [Chapter 4,
*ActiveRecord*](#activerecord_chapter "Chapter 4. ActiveRecord") we are
going to be working lots with the console and will soon begin to
appreciate the possibilities it offers.

#### Tip

One of my best buddies when developing Rails applications is the Tab
key. Whenever you are looking for a method for a particular problem,
recreate it in the Rails console and then press the Tab key twice to
list all available methods. The names of the methods are usually
self-exlanatory.

### app

**app** is useful if you want to analyze things to do with routing:

``` {.screen}
$ rails console
Loading development environment (Rails 4.0.0)
>> app.url_for(:controller => 'game', :action => 'ping')
=> "http://www.example.com/game/ping"
>> app.get 'game/ping'


Started GET "/game/ping" for 127.0.0.1 at 2013-07-15 19:19:36 +0200
Processing by GameController#ping as HTML
Redirected to http://www.example.com/game/pong
Completed 302 Found in 16ms (ActiveRecord: 0.0ms)
=> 302
>> app.get 'game/pong'


Started GET "/game/pong" for 127.0.0.1 at 2013-07-15 19:19:39 +0200
Processing by GameController#pong as HTML
  Rendered game/pong.html.erb within layouts/application (0.9ms)
Completed 200 OK in 50ms (Views: 49.2ms | ActiveRecord: 0.0ms)
=> 200
>> exit
$
```

### Misc

You have now already created a simple Rails application and in the next
chapter you will dive deeply into the topic ActiveRecord. So now is a
good time to very briefly introduce a few terms that often surface in
the world of Rails.

### "Model View Controller" Architecture (MVC)

According to Wikipedia
(`http://en.wikipedia.org/wiki/Model–view–controller`{.uri}), MVC is a
design pattern that separates the representation of information from the
user's interaction with it.

MVC is a structure for software development. It was agreed that it makes
sense to have one part of the software in one place and another part of
the software in another place. Nothing more, nothing less. This
agreement has the enormous advantage that once you are used to this
concept, you know exactly where you can find or need to integrate a
certain functionaity in a Rails project.

## Model

"Model" in this case means data model. By default, Rails applications
are an ActiveRecord data model (see [Chapter 4,
*ActiveRecord*](#activerecord_chapter "Chapter 4. ActiveRecord")).

All models can be found in the directory `app/models/.`{.filename}

### View

The "view" is responsible for the presentation of the application. It
takes care of rendering the web page, an XML or JSON file. A view could
also render a PDF or an ASCII text. It depends entirely on your
application.

You will find all the views in the directory `app/views/.`{.filename}

### Controller

Once a web page call has ended up in a route (see [Chapter 6,
*Routes*](#routes "Chapter 6. Routes")), it goes from there to the
controller. The route specifies a certain method (action) as target.
This method can then fulfil the desired tasks (such as finding a
specific set of data and saving it in an instance variable) and then
renders the desired view.

All controllers can be found in the directory
`app/controllers/.`{.filename}

### What is a Generator?

We have already used the command **rails generate controller**. It
starts the generator with the name `controller`{.code}. There are other
generators as well. You can use the command **rails generate** to
display a list of available generators:

``` {.screen}
$ rails generate
Usage: rails generate GENERATOR [args] [options]

General options:
  -h, [--help]     ## Print generator's options and usage
  -p, [--pretend]  # Run but do not make any changes
  -f, [--force]    # Overwrite files that already exist
  -s, [--skip]     # Skip files that already exist
  -q, [--quiet]    # Suppress status output

Please choose a generator below.

Rails:
  assets
  controller
  generator
  helper
  integration_test
  jbuilder
  mailer
  migration
  model
  resource
  scaffold
  scaffold_controller
  task

Coffee:
  coffee:assets

Jquery:
  jquery:install

Js:
  js:assets

TestUnit:
  test_unit:plugin

$
```

What does a generator do? A generator makes a programmer's job easier by
doing some of the mindless tasks for you. It creates files and fills
them with content, depending on the parameters passed. You could do the
same manually, without the generator. So you do not have to use a
generator. It is primarily intended to save you work and avoid potential
errors that can easily arise from mindless repetitive tasks.

#### Tip

Someday you might want to create your own generator. Have a look at
`http://guides.rubyonrails.org/generators.html`{.uri} to find a
description of how to do that.

### Helper

A helper method takes care of recurring tasks in a view. For example, if
you want to display stars (\*) for rating a restaurant and not a number
from 1 to 5, you can define the following helper in the file
`app/helpers/application_helper.rb`{.filename} :

``` {.programlisting}
module ApplicationHelper

  def render_stars(value)
    output = ''
    if (1..5).include?(value)
      value.times { output += '*'}
    end
    output
  end

end
```

With this helper, we can then apply the following code in a view:

``` {.programlisting}
<p>
<b>Rating:</b> <%= render_stars(5) %>
</p>
```

You can also try out the helper in the console:

``` {.screen}
$ rails console
Loading development environment (Rails 4.0.0)
>> helper.render_stars(5)
=> "*****"
>> helper.render_stars(3)
=> "***"
>> exit
$
```

There are lots of predefined helpers in Rails and we will use some of
them in the next chapters. But you can also define your own custom
helpers. Any of the helpers from the file
`app/helpers/application_helper.rb`{.filename} can be used in any view.
Helpers that you want to be only available in certain views must be
defined for each controller. When creating a controller, a file for
helpers of that controller is automatically created in
`app/helpers`{.filename}. This gives you the option of defining helpers
only for this controller or for the views of this controller.

All helpers are in the directory `app/helpers/.`{.filename}

### Rails Lingo

Here you find a couple of words which you'll often find in the Ruby on
Rails universe.

### DRY - Don't repeat yourself

Many Rails programmers are big fans of DRY. DRY means purely and simply
that you should try to place repeated programming logic into separate
methods.

### Refactoring

You often hear the word refactoring in the context of DRY. This involves
functioning applications that are further improved. The application in
itself remains unchanged in its interface. But its core is optimized,
amongst others through DRY.

### Convention Over Configuration

Convention over configuration (also known as coding by convention, see
`http://en.wikipedia.org/wiki/Convention_over_configuration`{.uri}) is
an important pillar of a Rails application. It states that the
programmer does not need to decide in favour of certain features when
starting a project and set these via configuration parameters. It
specifies an underlying basic consensus and this is set by default. But
if you want to work outside of this conventional basic consensus, then
you will need to change the corresponding parameters.
