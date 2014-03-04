# Forms

## The Data-Input Workflow

To understand forms we take a look at the data workflow. Understanding
it better will help to understand the work of forms.

Example application:

``` {.screen}
$ rails new testapp
[...]
$ cd testapp
$ rails generate scaffold Person first_name last_name
[...]
$ rake db:migrate
[...]
$ rails s
=> Booting WEBrick
=> Rails 4.0.0 application starting in development on http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
[2013-07-20 09:48:23] INFO  WEBrick 1.3.1
[2013-07-20 09:48:23] INFO  ruby 2.0.0 (2013-06-27) [x86_64-darwin12.4.0]
[2013-07-20 09:48:23] INFO  WEBrick::HTTPServer#start: pid=72655 port=3000
```

Most times we create forms by using the Scaffold. Let's go through the
flow the data

# Request the people\#new form

Wenn we request the `http://0.0.0.0:3000/people/new`{.uri} URL the
router answers the following route:

``` {.screen}
new_person GET    /people/new(.:format)      people#new
```

The controller `app/controllers/people_controller.rb`{.filename} runs
this code:

``` {.programlisting}
## GET /people/new
def new
  @person = Person.new
end
```

So a new Instance of Person is created and stored in the instance
variable `@person`{.varname}.

Rails takes `@person`{.varname} and starts processing the view file
`app/views/people/new.html.erb`{.filename}

``` {.programlisting}
<h1>New person</h1>

<%= render 'form' %>

<%= link_to 'Back', people_path %>
```

`render 'form'`{.code} renders the file
`app/views/people/_form.html.erb`{.filename}

``` {.programlisting}
<%= form_for(@person) do |f| %>
  [...]
    <%= f.text_field :first_name %>
  [...]
    <%= f.text_field :last_name %>
  [...]
    <%= f.submit %>
  [...]
<% end %>
```

`form_for(@person)`{.code} embeddeds the two text\_fields
`:first_name`{.code} and `:last_name`{.code} plus a `submit`{.code}
Button.

The resulting HTML:

``` {.programlisting}
[...]
<form accept-charset="UTF-8" action="/people" class="new_person" id="new_person" method="post">
  [...]
    <input id="person_first_name" name="person[first_name]" type="text" />
  [...]
    <input id="person_last_name" name="person[last_name]" type="text" />
  [...]
    <input name="commit" type="submit" value="Create Person" />
  [...]
</form>
[...]
```

This form uses the `post`{.code} method to upload the data to the
server.

## Push the Data to the Server

We enter 'Stefan' in the `first_name`{.code} field and 'Wintermeyer' in
the `last_name`{.code} field and click the submit button. The browser
uses the post method to uploads the data to the URL `/people`{.uri}. The
log shows:

``` {.screen}
Started POST "/people" for 127.0.0.1 at 2013-07-20 10:14:02 +0200
Processing by PeopleController#create as HTML
  Parameters: {"utf8"=>"✓", "authenticity_token"=>"cIZ+XFBx75mnXb6WiVv4xj6S88ahPjwVedDg1YgGuJs=", "person"=>{"first_name"=>"Stefan", "last_name"=>"Wintermeyer"}, "commit"=>"Create Person"}
   (0.1ms)  begin transaction
  SQL (4.6ms)  INSERT INTO "people" ("created_at", "first_name", "last_name", "updated_at") VALUES (?, ?, ?, ?)  [["created_at", Sat, 20 Jul 2013 08:14:02 UTC +00:00], ["first_name", "Stefan"], ["last_name", "Wintermeyer"], ["updated_at", Sat, 20 Jul 2013 08:14:02 UTC +00:00]]
   (0.9ms)  commit transaction
Redirected to http://0.0.0.0:3000/people/1
Completed 302 Found in 10ms (ActiveRecord: 5.5ms)
```

What happend in Rails?

The router answers the request with this route

``` {.programlisting}
POST   /people(.:format)          people#create
```

The controller `app/controllers/people_controller.rb`{.filename} runs
this code

``` {.programlisting}
## POST /people
## POST /people.json
def create
  @person = Person.new(person_params)
  [...]
    if @person.save
      format.html { redirect_to @person, notice: 'Person was successfully created.' }
    [...]
    end
  end
end
[...]

## Never trust parameters from the scary internet, only allow the white list through.
def person_params
  params.require(:person).permit(:first_name, :last_name)
end
```

A new instance variable `@person`{.code} is created. It represense a new
Person which was created with the params that were send from the browser
to the Rails application. The params are checked in the person\_params
method which is a whitelist. That is done so the user can not just
inject params which we don't want to be injected.

Once `@person`{.varname} is saved a `redirect_to       @person`{.code}
is triggered. That would be `http://0.0.0.0:3000/people/1`{.uri} in this
example.

## Present the new Data

The redirect to `http://0.0.0.0:3000/people/1`{.uri} is traceable in the
log file

``` {.screen}
Started GET "/people/1" for 127.0.0.1 at 2013-07-20 10:14:02 +0200
Processing by PeopleController#show as HTML
  Parameters: {"id"=>"1"}
  Person Load (0.2ms)  SELECT "people".* FROM "people" WHERE "people"."id" = ? LIMIT 1  [["id", "1"]]
  Rendered people/show.html.erb within layouts/application (1.1ms)
Completed 200 OK in 9ms (Views: 5.3ms | ActiveRecord: 0.2ms)
```

The router answers to this request with

``` {.screen}
person GET    /people/:id(.:format)      people#show
```

Which gets handled be the show method in
`app/controllers/people_controller.rb`{.filename}

## Generic Forms

A form doesn't have to be hardwired to an ActiveRecord object. You can
use the `form_tag`{.code} helper to create a form by youself. I use the
example of `http://guides.rubyonrails.org/form_helpers.html`{.uri}(which
is the official Rails guide about forms) to show how to create a search
form which is not connected to a model:

``` {.programlisting}
<%= form_tag("/search", method: "get") do %>
  <%= label_tag(:q, "Search for:") %>
  <%= text_field_tag(:q) %>
  <%= submit_tag("Search") %>
<% end %>
```

It results in this HTML code:

``` {.programlisting}
<form accept-charset="UTF-8" action="/search" method="get">
  <label for="q">Search for:</label>
  <input id="q" name="q" type="text" />
  <input name="commit" type="submit" value="Search" />
</form>
```

To handle this you'd have to create a new route in
`config/routes.rb`{.filename} and write a method in a controller to
handle it.

## FormTagHelper

There is not just a helper for text fields. Have a look at the offical
API documentation for all FormTagHelpers at
`http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html`{.uri}
to get an overview. Because normaly we use Scaffold to create a form
there is no need to memorize them. It is just important to know where to
look in case you need something else.

# Alternatives

Many Rails developer use Simple Form as an alternative to the standard
way of defining forms. It is worth a try because you can really safe
time and most of the times it is just easier. Simple Form is available
as a Gem at `https://github.com/plataformatec/simple_form`{.uri}
