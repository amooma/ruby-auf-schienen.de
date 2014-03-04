# Caching

## Introduction

Where caching of web applications is concerned, most people tend to wait
until they encounter performance problems. Then the admin first looks at
the database and adds an index here and there. If that does not help, he
has a look at the views and adds fragment caching. But this is not the
best approach for working with caches. The aim of this chapter is to
help you understand how key based cache expiration works. You can then
use this approach to plan new applications already on the database
structure level in such a way that you can cache optimally during
development.

There are two main arguments for using caching:

-   The application becomes faster for the user. A faster web page
    results in happier users.
-   You need less hardware for the web server, because you require less
    resources for processing the queries. On average, a well cached
    system only needs a fifth of the processing power of a non-cached
    system. Quite often, it is even less.

If these two arguments are irrelevant for you, then you do not need to
read this chapter.

We are going to look at three different caching methods:

-   HTTP caching This is the sledge hammer among the caching methods and
    the ultimate performance weapon. In particular, web pages that are
    intended for mobile devices (for example iPhone) should try to make
    the most of HTTP caching. If you use a combination of key based
    cache expiration and HTTP caching, you save a huge amount of
    processing time on the server and also bandwidth.
-   Page caching This is the screwdriver among the caching methods. You
    can get a lot of performance out of the system, but it is not as
    good as HTTP caching.
-   Fragment caching The tweezers among the caching methods, so to
    speak. But don't underestimate it. Every little helps.

### Tip

The aim is to optimally combine all three methods.

## A Simple Example Application

To try out the caching methods, we need an example application. We are
going to use a simple phone book with a model for the company and a
model for the employees of the company.

### Important

Please consider: if the processing power you save (shown later) is
already so significant in such a simple application, it will be even
more significant in a more complex application with more complex views.

We create the new Rails app:

``` {.screen}
$ rails new phone_book
  [...]
$ cd phone_book
$ rails generate scaffold company name
  [...]
$ rails generate scaffold employee company_id:integer last_name first_name phone_number
  [...]
$ rake db:migrate
  [...]
$
```

## Models

We insert a few rudimentary rules in the two models.

`app/models/company.rb`{.filename}

``` {.programlisting}
class Company < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: true

  has_many :employees, dependent: :destroy

  def to_s
    name
  end
end
```

`app/models/employee.rb`{.filename}

``` {.programlisting}
class Employee < ActiveRecord::Base
  belongs_to :company, touch: true

  validates :first_name,
            presence: true

  validates :last_name,
            presence: true

  validates :company,
            presence: true

  def to_s
    "#{first_name} #{last_name}"
  end
end
```

## Views

We change the following two company views to list the number of
employees in the Index view and all the employees in the Show view.

`app/views/companies/index.html.erb`{.filename}

``` {.programlisting}
<h1>Listing companies</h1>

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Number of employees</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>

  <tbody>
    <% @companies.each do |company| %>
      <tr>
        <td><%= company.name %></td>
        <td><%= company.employees.count %></td>
        <td><%= link_to 'Show', company %></td>
        <td><%= link_to 'Edit', edit_company_path(company) %></td>
        <td><%= link_to 'Destroy', company, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>

<br>

<%= link_to 'New Company', new_company_path %>
```

`app/views/companies/show.html.erb`{.filename}

``` {.programlisting}
<p id="notice"><%= notice %></p>

<p>
  <strong>Name:</strong>
  <%= @company.name %>
</p>

<%= link_to 'Edit', edit_company_path(@company) %> |
<%= link_to 'Back', companies_path %>

<h1>Listing employees</h1>

<table>
  <thead>
    <tr>
      <th>Last name</th>
      <th>First name</th>
      <th>Phone number</th>
    </tr>
  </thead>

  <tbody>
    <% @company.employees.each do |employee| %>
      <tr>
        <td><%= employee.last_name %></td>
        <td><%= employee.first_name %></td>
        <td><%= employee.phone_number %></td>
      </tr>
    <% end %>
  </tbody>
</table>
```

## Example Data

To easily populate the database, we use the Faker gem (see
`http://faker.rubyforge.org/`{.uri}). With Faker, you can generate
random names and phone numbers. Please add the following line in the
`Gemfile`{.filename}:

``` {.programlisting}
gem 'faker'
```

Then start a **bundle install**:

``` {.screen}
$ bundle install
[...]
$
```

In the `db/seeds.rb`{.filename} we create 30 companies with a random
number of employees in each case:

``` {.programlisting}
30.times do
  company = Company.new(:name => Faker::Company.name)
  if company.save
    SecureRandom.random_number(100).times do
      company.employees.create(
                               first_name:   Faker::Name.first_name,
                               last_name:    Faker::Name.last_name,
                               phone_number: Faker::PhoneNumber.phone_number
                              )
    end
  end
end
```

We populate it via **rake db:seed**

``` {.screen}
$ rake db:seed
$
```

You can start the application with **rails server** and retrieve the
example data with a web browser by going to the URLs
`http://0.0.0.0:3000/companies`{.uri} and
`http://0.0.0.0:3000/companies/1`{.uri}.

# Normal Speed of the Pages to Optimize

In this chapter, we optimize the following web pages. Start the Rails
application in development mode with **rails server**. The relevant
numbers of course depend on the hardware you are using.

``` {.screen}
$ rails server
=> Booting WEBrick
=> Rails 4.0.0 application starting in development on http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
[2013-07-17 23:50:11] INFO  WEBrick 1.3.1
[2013-07-17 23:50:11] INFO  ruby 2.0.0 (2013-06-27) [x86_64-darwin12.4.0]
[2013-07-17 23:50:11] INFO  WEBrick::HTTPServer#start: pid=43210 port=3000
```

To access the web pages, we use the command line tool curl
(`http://curl.haxx.se/`{.uri}). Of course you can also access the web
pages with other web browsers. We look at the time shown in the Rails
log for creating the page. In reality, you need to add the time it takes
for the page to be delivered to the web browser.

## List of All Companies (Index View)

At the URL `http://0.0.0.0:3000/companies`{.uri} the user can see a list
of all saved companies with the relevant number of employees.

Generating the page takes 48ms.

``` {.screen}
Completed 200 OK in 48ms (Views: 38.9ms | ActiveRecord: 8.3ms)
```

## Detailled View of a Single Company (Show View)

At the URL `http://0.0.0.0:3000/companies/1`{.uri} the user can see the
details of the first company with all employees.

Generating the page takes 11ms.

``` {.screen}
Completed 200 OK in 11ms (Views: 8.6ms | ActiveRecord: 0.8ms)
```

## HTTP Caching

HTTP caching attempts to reuse already loaded web pages or files. For
example, if you visit a web page such as `http://www.heise.de`{.uri} or
`http://www.spiegel.de`{.uri} several times a day to read the latest
news, then certain elements of that page (for example, the logo image at
the top of the page) will not be loaded again on your second visit. Your
browser already has these files in the cache, which saves loading time
and bandwidth.

Within the Rails framework, our aim is answering the question "Has a
page changed?" already in the controller. Because normally, most of the
time is spent on rendering the page in the view. I'd like to repeat
that: Most of the time is spent on rendering the page in the view!

## Last-Modified

### Important

Please modify the times used in the examples in accordance with your own
local circumstances.

The web browser knows when it has downloaded a web page and then placed
it into the cache. It can pass this information to the web server in an
`If-Modified-Since:`{.code} header. The web server can then compare this
information to the corresponding file and either deliver a newer version
or return an HTTP 304 Not Modified code as response. In case of a 304,
the web server delivers the cached version. Now you are going to say,
"That's all very well for images, but it won't help me at all for
dynamically generated web pages such as the Index view of the
companies." Ah, but you are underestimating what Rails can do. ;-)

Please edit the `show`{.methodname} method in the controller file
`app/controllers/companies_controller.rb`{.filename} as follows :

``` {.programlisting}
## GET /companies/1
# GET /companies/1.json
def show
  fresh_when last_modified: @company.updated_at
end
```

After restarting the Rails application, we have a look at the HTTP
header of `http://0.0.0.0:3000/companies/1`{.uri}:

``` {.screen}
$ curl -I http://0.0.0.0:3000/companies/1
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Ua-Compatible: chrome=1
Last-Modified: Wed, 17 Jul 2013 21:50:01 GMT
[...]
$
```

The `Last-Modified`{.code} entry in the HTTP header was generated by
`fresh_when`{.methodname} in the controller. If we later go to the same
web page and specify this time as well, then we do not get the web page
back, but a `304 Not Modified`{.code} message:

``` {.screen}
$ curl -I http://0.0.0.0:3000/companies/1 --header 'If-Modified-Since: Wed, 17 Jul 2013 21:50:01 GMT'
HTTP/1.1 304 Not Modified
[...]
$
```

In the Rails log, we find this:

``` {.screen}
Started HEAD "/companies/1" for 127.0.0.1 at 2013-07-18 08:27:10 +0200
Processing by CompaniesController#show as */*
  Parameters: {"id"=>"1"}
  Company Load (0.1ms)  SELECT "companies".* FROM "companies" WHERE "companies"."id" = ? LIMIT 1  [["id", "1"]]
Completed 304 Not Modified in 2ms (ActiveRecord: 0.1ms)
```

Rails took 2ms to answer this request, compared to the 11ms of the
standard variation. This is way faster! So you have used less resources
on the server. And saved a massive amount of bandwidth. The user will be
able to see the page much more quickly.

# Etag

Sometimes the `update_at`{.varname} field of a particular object is not
meaningful on its own. For example, if you have a web page where users
can log in and this page then generates web page contents based on a
role model, it can happen that user A as admin is able to see an Edit
link that is not displayed to user B as normal user. In such a scenario,
the Last-Modified header explained in [the section called
“Last-Modified”](#http_caching_last_modified "Last-Modified") does not
help.

In these cases, we can use the etag header. The etag is generated by the
web server and delivered when the web page is first visited. If the user
visits the same URL again, the browser can then check if the
corresponding web page has changed by sending a `If-None-Match:`{.code}
query to the web server.

Please edit the `index`{.methodname} and `show`{.methodname} methods in
the controller file `app/controllers/companies_controller.rb`{.filename}
as follows:

``` {.programlisting}
## GET /companies
## GET /companies.json
def index
  @companies = Company.all
  fresh_when etag: @companies
end

## GET /companies/1
## GET /companies/1.json
def show
  fresh_when etag: @company
end
```

A special Rails feature comes into play for the etag: Rails
automatically sets a new CSRF token for each new visitor of the website.
This prevents cross-site request forgery attacks (see
`http://en.wikipedia.org/wiki/Cross_site_request_forgery`{.uri}). But it
also means that each new user of a web page gets a new etag for the same
page. To ensure that the same users also get identical CSRF tokens,
these are stored in a cookie by the web browser and consequently sent
back to the web server every time the web page is visited. The curl we
used for developing does not do this by default. But we can tell curl
that we want to save all cookies in a file and transmit these cookies
later if a request is received.

For saving, we use the `-c cookies.txt`{.code} parameter.

``` {.screen}
$ curl -I http://0.0.0.0:3000/companies -c cookies.txt
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Ua-Compatible: chrome=1
Etag: "e57e45d14a0afc4377c81fc5ecc951b0"
[...]

$
```

With the parameter `-b cookies.txt`{.code}, curl sends these cookies to
the web server when a request arrives. Now we get the same etag for two
subsequent requests:

``` {.screen}
$ curl -I http://0.0.0.0:3000/companies -b cookies.txt
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Ua-Compatible: chrome=1
Etag: "e57e45d14a0afc4377c81fc5ecc951b0"
[...]

$ curl -I http://0.0.0.0:3000/companies -b cookies.txt
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Ua-Compatible: chrome=1
Etag: "e57e45d14a0afc4377c81fc5ecc951b0"
[...]

$
```

We now use this etag to find out in the request with
`If-None-Match`{.code} if the version we have cached is still up to
date:

``` {.screen}
$ curl -I http://0.0.0.0:3000/companies -b cookies.txt --header 'If-None-Match: "e57e45d14a0afc4377c81fc5ecc951b0"'
HTTP/1.1 304 Not Modified
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Ua-Compatible: chrome=1
Etag: "e57e45d14a0afc4377c81fc5ecc951b0"
[...]

$
```

We get a `304 Not Modified`{.code} in response. Let's look at the Rails
log:

``` {.screen}
Started HEAD "/companies" for 127.0.0.1 at 2013-07-18 08:32:43 +0200
Processing by CompaniesController#index as */*
  Company Load (0.3ms)  SELECT "companies".* FROM "companies"
Completed 304 Not Modified in 4ms (ActiveRecord: 0.3ms)
```

Rails only took 4ms to process the request. Almost 10 times as fast as
the variation without cache! Plus we have saved bandwidth again. The
user will be happy with the speedy web application.

## current\_user and Other Potential Parameters

As basis for generating an etag, we can not just pass an object, but
also an array of objects. This way, we can solve the problem with the
logged-in user. Let's assume that a logged-in user is output with the
method `current_user`{.methodname}.

We only have to add `etag { current_user.try :id }`{.code} in the
`app/controllers/application_controller.rb`{.filename} to make sure that
all etags in the application include the current\_user.id which is nil
in case nobody is logged in.

``` {.programlisting}
class ApplicationController < ActionController::Base
  ## Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  etag { current_user.try :id }
end
```

You can chain other objects in this array too and use this approach to
define when a page has not changed.

## The Magic of touch

What happens if an `Employee`{.classname} is edited or deleted? Then the
show view and potentially also the index view would have to change as
well. That is the reason for the line

``` {.programlisting}
belongs_to :company, touch: true
```

in the employee model. Every time an object of the class
`Employee`{.classname} is saved in edited form, and if
`touch: true`{.code} is used, ActiveRecord updates the superordinate
`Company`{.classname} element in the database. The
`updated_at`{.varname} field is set to the current time. It is
"touched".

This approach ensures that a correct content is delivered.

## stale?

Up to now, we have always assumed that only HTML pages are deliverd. So
we were able to use `fresh_when`{.methodname} and then do without the
`respond_to do |format|`{.code} block. But HTTP caching is not limited
to HTML pages. Yet if we render JSON (for example) as well and want to
deliver it via HTTP caching, we need to use the method
`stale?`{.methodname}. Using `stale?`{.methodname} resembles using the
method `fresh_when`{.methodname}. Example:

``` {.programlisting}
def show
  @company = Company.find(params[:id])

  if stale? @company
    respond_to do |format|
      format.html
      format.json { render json: @company }
    end
  end
end
```

## Using Proxies (public)

Up to now, we always assumed that we are using a cache on the web
browser. But on the Internet, there are many proxies that are often
closer to the user and can therefore useful for caching in case of
non-personalized pages. If our example was a publicly accessible phone
book, then we could activate the free services of the proxies with the
parameter `public: true`{.code} in `fresh_when`{.methodname} or
`stale?`{.methodname}.

Example:

``` {.programlisting}
## GET /companies/1
## GET /companies/1.json
def show
  @company = Company.find(params[:id])

  fresh_when @company, public: true
end
```

We go to the web page and get the output:

``` {.screen}
$ curl -I http://0.0.0.0:3000/companies/1
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Ua-Compatible: chrome=1
Etag: "81cfb867cac24fad7ff1a7721bfb529a"
Last-Modified: Wed, 17 Jul 2013 21:50:01 GMT
Content-Type: text/html; charset=utf-8
Cache-Control: public
[...]
```

The header `Cache-Control: public`{.code} tells all proxies that they
can also cache this web page.

### Warning

Using proxies always has to be done with great caution. On the one hand,
they are brilliantly suited for delivering your own web page quickly to
more users, but on the other, you have to be absolutely sure that no
personalized pages are cached on public proxies. For example, CSRF tags
and Flash messages should never end up in a public proxy. To be sure
with the CSRF tags, it is a good idea to make the output of
`csrf_meta_tag`{.methodname} in the default
`app/views/layouts/application.html.erb`{.filename} layout dependent on
the question whether the page may be cached publicly or not:

``` {.programlisting}
<%= csrf_meta_tag unless response.cache_control[:public] %>
```

# Cache-Control With Time Limit

When using `Etag`{.code} and `Last-Modified`{.code} we assume in [the
section called “Etag”](#http_caching_etag "Etag") and [the section
called “Last-Modified”](#http_caching_last_modified "Last-Modified")
that the web browser definitely checks once more with the web server if
the cached version of a web page is still current. This is a very safe
approach.

But you can take the optimization one step further by predicting the
future: if I am already sure when delivering the web page that this web
page is not going to change in the next two minutes, hours or days, then
I can tell the web browser this directly. It then does not need to check
back again within this specified period of time. This overhead saving
has advantages, especially with mobile web browsers with relatively high
latency. Plus you also save server load on the web server.

In the output of the HTTP header, you may already have noticed the
corresponding line in the `Etag`{.code} and `Last-Modified`{.code}
examples:

``` {.screen}
Cache-Control: max-age=0, private, must-revalidate
```

The item `must-revalidate`{.code} tells the web browser that it should
definitely check back with the web server to see if a web page has
changed in the meantime. The second parameter `private`{.code} means
that only the web browser is allowed to cache this page. Any proxies on
the way are not permitted to cache this page.

If we decide for our phone book that the web page is going to stay
unchanged for at least 2 minutes, then we can expand the code example by
adding the method `expires_in`{.methodname}. The controller
`app/controllers/companies.rb`{.filename} would then contain the
following code for the method `show`{.methodname}:

``` {.programlisting}
## GET /companies/1
## GET /companies/1.json
def show
  expires_in 2.minutes
  fresh_when @company, public: true
end
```

Now we get a different cache control information in response to a
request:

``` {.screen}
$ curl -I http://0.0.0.0:3000/companies/1
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Ua-Compatible: chrome=1
Date: Thu, 18 Jul 2013 06:55:30 GMT
Etag: "81cfb867cac24fad7ff1a7721bfb529a"
Last-Modified: Wed, 17 Jul 2013 21:50:01 GMT
Content-Type: text/html; charset=utf-8
Cache-Control: max-age=120, public
[...]
```

The two minutes are specified in seconds (`max-age=120`{.code}) and we
no longer need `must-revalidate`{.code}. So in the next 120 seconds, the
web browser does not need to check back with the web server to see if
the content of this page has changed.

## Note

This mechanism is also used by the asset pipeline. Assets created there
in the production environment can be identified clearly by the checksum
in the file name and can be cached for a very long time both in the web
browser and in public proxies. That's why we have the following section
in the nginx configuration file in [Chapter 16, *Web Server in
Production
Mode*](#rails_production_webserver "Chapter 16. Web Server in Production Mode"):

``` {.programlisting}
location ^~ /assets/ {
  gzip_static on;
  expires max;
  add_header Cache-Control public;
}
```

# Fragment Caching

With fragment caching you can cache individual parts of a view. You can
safely use it in combination with [the section called “HTTP
Caching”](#http_caching "HTTP Caching") and [the section called “Page
Caching”](#page_caching "Page Caching"). The advantages once again are a
reduction of server load and faster web page generation, which means
increased usability.

Please install a new example application (see [the section called “A
Simple Example
Application”](#caching_beispielapplikation "A Simple Example Application")).

## Enabling Fragment Caching in Development Mode

First, we need to go to the file
`config/environments/development.rb`{.filename} and set the item
`config.action_controller.perform_caching`{.code} to `true`{.code}:

``` {.programlisting}
config.action_controller.perform_caching = true
```

Otherwise, we cannot try out the fragment caching in development mode.
In production mode, fragment caching is enabled by default.

## Caching Table of Index View

On the page `http://0.0.0.0:3000/companies`{.uri}, a very
computationally intensive table with all companies is rendered. We can
cache this table as a whole. To do so, we need to enclose the table in a
`<% cache('name_of_cache') do %> ... <% end       %>`{.code} block:

``` {.programlisting}
<% cache('name_of_cache') do %>

[...]

<% end %>
```

Please edit the file `app/views/companies/index.html.erb`{.filename} as
follows:

``` {.programlisting}
<h1>Listing companies</h1>

<% cache('table_of_all_companies') do %>
<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Number of employees</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>

  <tbody>
    <% @companies.each do |company| %>
      <tr>
        <td><%= company.name %></td>
        <td><%= company.employees.count %></td>
        <td><%= link_to 'Show', company %></td>
        <td><%= link_to 'Edit', edit_company_path(company) %></td>
        <td><%= link_to 'Destroy', company, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>
<% end %>

<br />

<%= link_to 'New Company', new_company_path %>
```

Then you can start the Rails server with **rails server** and go to the
URL `http://0.0.0.0:3000/companies`{.uri}. In the development log, you
will now see the following entry:

``` {.screen}
Write fragment views/table_of_all_companies (2.9ms)
  Rendered companies/index.html.erb within layouts/application (119.8ms)
Completed 200 OK in 209ms (Views: 143.1ms | ActiveRecord: 15.0ms)
```

Writing the cache took 2.9 ms. In total, rendering the page took 209 ms.

If you repeatedly go to the same page, you will get a different result
in the log:

``` {.screen}
Read fragment views/table_of_all_companies (0.2ms)
  Rendered companies/index.html.erb within layouts/application (0.8ms)
Completed 200 OK in 37ms (Views: 34.6ms | ActiveRecord: 0.3ms)
```

Reading the cache took 0.2 ms and rendering the page in total 37ms. Only
a fifth of the processing time!

# Deleting Fragment Cache

With the method `expire_fragment`{.methodname} you can clear specific
fragment caches. Basically, we can build this idea into the model in the
same way as shown in [the section called “Deleting Page Caches
Automatically”](#page_caches_automatisch_loeschen "Deleting Page Caches Automatically").

The model file `app/models/company.rb`{.filename} would then look like
this:

``` {.programlisting}
class Company < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: true

  has_many :employees, dependent: :destroy

  after_create   :expire_cache
  after_update   :expire_cache
  before_destroy :expire_cache

  def to_s
    name
  end

  def expire_cache
    ActionController::Base.new.expire_fragment('table_of_all_companies')
  end
end
```

As the number of employees also has an effect on this table, we would
also have to expand the file `app/models/employees.rb`{.filename}
accordingly:

``` {.programlisting}
class Employee < ActiveRecord::Base
  belongs_to :company, touch: true

  validates :first_name,
            presence: true

  validates :last_name,
            presence: true

  validates :company,
            presence: true

  after_create   :expire_cache
  after_update   :expire_cache
  before_destroy :expire_cache

  def to_s
    "#{first_name} #{last_name}"
  end

  def expire_cache
    ActionController::Base.new.expire_fragment('table_of_all_companies')
  end  
end
```

Deleting specific fragment caches often involves a lot of effort in
terms of programming. One, you often miss things and two, in big
projects it's not easy to keep track of all the different cache names.
Often it is easier to automatically create names via the method
`cache_key`{.methodname}. These then expire automatically in the cache
(see [the section called “Auto-Expiring
Caches”](#fragment_auto_expiring "Auto-Expiring Caches")).

# Auto-Expiring Caches

Managing fragment caching is rather complex with the naming convention
used in [the section called “Caching Table of Index
View”](#fragment_caching_tabelle_cachen "Caching Table of Index View").
On the one hand, you can be sure that the cache does not have any
superfluous ballast if you have programmed neatly, but on the other, it
does not really matter. A cache is structured in such a way that it
deletes old and no longer required elements on its own. If we use a
mechanism that gives a fragment cache a unique name, as in the asset
pipeline (see [Chapter 12, *Asset
Pipeline*](#asset_pipeline "Chapter 12. Asset Pipeline")), then we would
not need to go to all the trouble of deleting fragment caches.

That is precisely what the method `cache_key`{.methodname} is for.
`cache_key`{.methodname} gives you a unique name for an element. Let's
try it in the console. First, we get the always identical
`cache_key`{.methodname} of the first company item two times in a row
("companies/1-20130717215001729269000"), then we touch the item (a
`touch`{.methodname} sets the attribute `updated_at`{.varname} to the
current time) and finally we output the new `cache_key`{.methodname}
("companies/1-20130718081128853737000"):

``` {.screen}
$ rails console
Loading development environment (Rails 4.0.0)
>> Company.first.cache_key
  Company Load (0.1ms)  SELECT "companies".* FROM "companies" ORDER BY "companies"."id" ASC LIMIT 1
=> "companies/1-20130717215001729269000"
>> Company.first.cache_key
  Company Load (0.3ms)  SELECT "companies".* FROM "companies" ORDER BY "companies"."id" ASC LIMIT 1
=> "companies/1-20130717215001729269000"
>> Company.first.touch
  Company Load (0.2ms)  SELECT "companies".* FROM "companies" ORDER BY "companies"."id" ASC LIMIT 1
  SQL (4.2ms)  UPDATE "companies" SET "updated_at" = '2013-07-18 08:11:28.853737' WHERE "companies"."id" = 1
=> true
>> Company.first.cache_key
  Company Load (0.4ms)  SELECT "companies".* FROM "companies" ORDER BY "companies"."id" ASC LIMIT 1
=> "companies/1-20130718081128853737000"
>> exit
$
```

Let's use this knowledge to edit the index view in the file
`app/views/companies/index.html.erb`{.filename}:

``` {.programlisting}
<h1>Listing companies</h1>

<% cache(@companies) do %>
<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Number of employees</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>

  <tbody>
    <% @companies.each do |company| %>
      <tr>
        <td><%= company.name %></td>
        <td><%= company.employees.count %></td>
        <td><%= link_to 'Show', company %></td>
        <td><%= link_to 'Edit', edit_company_path(company) %></td>
        <td><%= link_to 'Destroy', company, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>
<% end %>

<br />

<%= link_to 'New Company', new_company_path %>
```

Here, we not only use a fragment cache for the whole table, but also one
for each line. So the initial call will take longer than before. But if
any individual companies change, only one line has to be re-rendered in
each case.

### Note

There is no general answer to the question in how much detail you should
use fragment caching. Just go ahead and experiment with it, then look in
the log to see how long things take.

## Change Code in the View results in an expired Cache

Rails tracks an MD5 sum of the view you use. So if you change the file
(e.g. `app/views/companies/index.html.erb`{.filename}) the MD5 changes
and all old caches will expire.

## Cache Store

The cache store manages the stored fragment caches. If not configured
otherwise, this is the Rails MemoryStore. This cache store is good for
developing, but less suitable for a production system because it acts
independently for each Ruby on Rails process. So if you have several
Ruby on Rails processes running in parallel in the production system,
each process holds its own MemoryStore.

## MemCacheStore

Most production systems use memcached (`http://memcached.org/`{.uri}) as
cache store. To enable memcached as cache store in the production
system, you need to add the following line in the file
`config/environments/production.rb`{.filename}:

``` {.programlisting}
config.cache_store = :mem_cache_store
```

The combination of appropriately used auto-expiring caches and memcached
is an excellent recipe for a successful web page.

For a description of how to install a Rails production system with
memcached, please read [Chapter 16, *Web Server in Production
Mode*](#rails_production_webserver "Chapter 16. Web Server in Production Mode").

# Other Cache Stores

In the official Rails documentation you will find a list of other cache
stores at
`http://guides.rubyonrails.org/caching_with_rails.html#cache-stores`{.uri}.

## Page Caching

Page Caching is extrem and was removed from the core of Rails 4.0. But
it is still available as a gem.

### Important

You need quite a bit of knowledge to configure your Webserver (e.g.
Nginx or Apache).

With page caching, it's all about placing a complete HTML page (in other
words, the render result of a view) into a subdirectory of the
`public`{.filename} directory and to have it delivered directly from
there by the web server (for example Nginx) whenever the web page is
visited next. Additionally, you can also save a compressed gz version of
the HTML page there. A production web server will automatically deliver
files below `public`{.filename} itself and can also be configured so
that any gz files present are delivered directly.

In complex views that may take 500ms or even more for rendering, the
amount of time you save is of course considerable. As web page operator,
you once more save valuable server resources and can service more
visitors with the same hardware. The web page user profits from a faster
delivery of the web page.

## Warning

When programming your Rails application, please ensure that you also
update this page itself, or delete it! You will find a description in
[the section called “Deleting Page Caches
Automatically”](#page_caches_automatisch_loeschen "Deleting Page Caches Automatically").
Otherwise, you end up with an outdated cache later.

Please also ensure that page caching rejects all URL parameters by
default. For example, if you try to go to
`http://0.0.0.0:3000/companies?search=abc`{.uri} this automatically
becomes `http://0.0.0.0:3000/companies`{.uri}. But that can easily be
fixed with a better route logic.

Please install a fresh example application (see [the section called “A
Simple Example
Application”](#caching_beispielapplikation "A Simple Example Application"))
and add the gem with the following line in Gemfile.

``` {.programlisting}
gem 'actionpack-page_caching'
```

Now install it with the command **bundle install**.

``` {.screen}
$ bundle install
[...]
$
```

Lastly you have to tell Rails where to store the cache files. Please add
the following line in your `config/application.rb`{.filename} file:

``` {.programlisting}
config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/deploy"
```

## Activating Page Caching in Development Mode

First we need to go to the file
`config/environments/development.rb`{.filename} and set the item
`config.action_controller.perform_caching`{.code} to `true`{.code}:

``` {.programlisting}
config.action_controller.perform_caching = true
```

Otherwise, we cannot try the page caching in development mode. In
production mode, page caching is enabled by default.

## Configure our Webserver

Know you have to tell your webserver (e.g. Nginx or Apache) that it
should check the `/public/deploy`{.filename} directory first before
hitting the Rails application. You have to configure too, that it will
deliver a gz file if one is available.

There is no one perfect way of doing it. You have to find the best way
of doing it in your environment by youself.

## Tip

As a quick and dirty hack for development you can set the
`page_cache_directory`{.code} to public. Than your development system
will deliver the cached page.

``` {.programlisting}
config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public"
```

## Caching Company Index and Show View

Enabling page caching happens in the controller. If we want to cache the
show view for Company, we need to go to the controller
`app/controllers/companies_controller.rb`{.filename} and enter the
command `caches_page :show`{.code} at the top:

``` {.programlisting}
class CompaniesController < ApplicationController
  caches_page :show

[...]
```

Before starting the application, the `public`{.filename} directory looks
like this:

``` {.screen}
public/
├── 404.html
├── 422.html
├── 500.html
├── favicon.ico
└── robots.txt
```

After starting the appliation with **rails server** and going to the
URLs `http://0.0.0.0:3000/companies`{.uri} and
`http://0.0.0.0:3000/companies/1`{.uri} via a web browser, it looks like
this:

``` {.screen}
public
├── 404.html
├── 422.html
├── 500.html
├── deploy
│   └── companies
│       └── 1.html
├── favicon.ico
└── robots.txt
```

The file `public/deploy/companies/1.html`{.filename} has been created by
page caching.

From now on, the web server will only deliver the cached versions when
these pages are accessed.

## gz Versions

If you use page cache, you should also cache directly zipped gz files.
You can do this via the option `:gzip => true`{.code} or use a specific
compression parameter as symbol instead of `true`{.code} (for example
`:best_compression`{.code}).

The controller `app/controllers/companies_controller.rb`{.filename}
would then look like this at the beginning:

``` {.programlisting}
class CompaniesController < ApplicationController
  caches_page :show, gzip: true

[...]
```

This automatically saves a compressed and an uncompressed version of
each page cache:

``` {.screen}
public
├── 404.html
├── 422.html
├── 500.html
├── deploy
│   └── companies
│       ├── 1.html
│       └── 1.html.gz
├── favicon.ico
└── robots.txt
```

# The File Extension .html

Rails saves the page accessed at `http://0.0.0.0:3000/companies`{.uri}
under the file name `companies.html`{.filename}. So the upstream web
server will find and deliver this file if you go to
`http://0.0.0.0:3000/companies.html`{.uri}, but not if you try to go to
`http://0.0.0.0:3000/companies`{.uri}, because the extension
`.html`{.filename} at the end of the URI is missing.

If you are using the Nginx server as described in [Chapter 16, *Web
Server in Production
Mode*](#rails_production_webserver "Chapter 16. Web Server in Production Mode"),
the easiest way is adapting the `try_files`{.code} instruction in the
Nginx configuration file as follows:

``` {.programlisting}
try_files $uri/index.html $uri $uri.html @unicorn;
```

Nginx then checks if a file with the extension `.html`{.filename} of the
currently accessed URI exists.

# Deleting Page Caches Automatically

As soon as the data used in the view changes, the saved cache files have
to be deleted. Otherwise, the cache would no longer be up to date.

According to the official Rails documentation, the solution for this
problem is the class `ActionController::Caching::Sweeper`{.classname}.
But this approach, described at
`http://guides.rubyonrails.org/caching_with_rails.html#sweepers`{.uri},
has a big disadvantage: it is limited to actions that happen within the
controller. So if an action is triggered via URL by the web browser, the
corresponding cache is also changed or deleted. But if an object is
deleted in the console, for example, the sweeper would not realize this.
For that reason, I am going to show you an approach that does not use a
sweeper, but works directly in the model with ActiveRecord callbacks.

In our phone book application, we always need to delete the cache for
`http://0.0.0.0:3000/companies`{.uri} and
`http://0.0.0.0:3000/companies/company_id`{.uri} when editing a company.
When editing an employee, we also have to delete the corresponding cache
for the relevant employee.

# Models

Now we still need to fix the models so that the corresponding caches are
deleted automatically as soon as an object is created, edited or
deleted.

`app/models/company.rb`{.filename}

``` {.programlisting}
class Company < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: true

  has_many :employees, dependent: :destroy

  after_create   :expire_cache
  after_update   :expire_cache
  before_destroy :expire_cache

  def to_s
    name
  end

  def expire_cache
    ActionController::Base.expire_page(Rails.application.routes.url_helpers.company_path(self))
    ActionController::Base.expire_page(Rails.application.routes.url_helpers.companies_path)
  end

end
```

`app/models/employee.rb`{.filename}

``` {.programlisting}
class Employee < ActiveRecord::Base
  belongs_to :company, touch: true

  validates :first_name,
            presence: true

  validates :last_name,
            presence: true

  validates :company,
            presence: true

  after_create   :expire_cache
  after_update   :expire_cache
  before_destroy :expire_cache

  def to_s
    "#{first_name} #{last_name}"
  end

  def expire_cache
    ActionController::Base.expire_page(Rails.application.routes.url_helpers.employee_path(self))
    ActionController::Base.expire_page(Rails.application.routes.url_helpers.employees_path)
    self.company.expire_cache
  end

end
```

# Preheating

Now that you have read your way through the caching chapter, here is a
final tip: preheat your cache!

For example, if you have a web application in a company and you know
that at 9 o'clock in the morning, all employees are going to log in and
then access this web application, then it's a good idea to let your web
server go through all those views a few hours in advance with cron-job.
At night, your server is probably bored anyway.

Check out the behavior patterns of your users. With public web pages,
this can be done for example via Google Analytics
(`http://www.google.com/analytics/`{.uri}). You will find that at
certain times of the day, there is a lot more traffic going in. If you
have a quiet phase prior to this, you can use it to warm up your cache.

The purpose of preheating is once more saving server ressources and
achieving better quality for the user, as the web page is displayed more
quickly.
