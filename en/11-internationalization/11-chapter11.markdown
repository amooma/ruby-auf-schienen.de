# Internationalization

## Introduction

If you are in the lucky situation of only creating web pages in English,
then you can skip this chapter completely. For you, everything is set up
correctly by default. But even if you want to create a web page that
only uses one language (other than English), you will need to dive into
this chapter. It is not enough to just translate the views. Because
already if you use scaffolding, you will need to take care of the
English and therefore not yet translated validation errors.

The class `I18n`{.classname} is responsible for anything to do with
translation in the Rails application. It offers two important methods
for this purpose:

-   `I18n.translate`{.methodname} or `I18n.t`{.methodname} Takes care of
    inserting previously defined text blocks. These can contain
    variables.
-   `I18n.localize`{.methodname} or `I18n.l`{.methodname} Takes care of
    adapting time and date specifications to the local format.

With `I18n.locale`{.methodname} you define the language you want to use
in the current call. In the configuration file
`config/application.rb`{.filename}, the entry
`config.i18n.default_locale`{.varname} sets the default value for
`I18n.locale`{.methodname}. If you do not make any changes there, this
value is set by default to `:en`{.varname} for English.

For special cases such as displaying numbers, currencies and times,
there are special helpers available. For example, if you want to create
a German web page, you can ensure that the number 1000.23 can be
correctly displayed with a decimal comma as "1.000,23" on the German
page and with a decimal point on an English web page as "1,000.23".

Let's create an example application which includes the rails-i18n gem by
Sven Fuchs (`https://github.com/svenfuchs/i18n`{.uri}). The gem provides
a couple of language files with translations and format info.

``` {.screen}
$ rails new webshop
  [...]
$ cd webshop
$ echo "gem 'rails-i18n'" >> Gemfile
$ bundle install
  [...]
$
```

In the console we can see the different output of a number depending on
the language setting:

``` {.screen}
$ rails console
Loading development environment (Rails 4.0.0)
>> price = 1000.23
=> 1000.23
>> helper.number_to_currency(price, locale: :de)
=> "1.000,23 €"
>> helper.number_to_currency(price, locale: :en)
=> "$1,000.23"
>> helper.number_to_currency(price, locale: :fr)
=> "1 000,23 €"
>> exit
$
```

You see it is not just about translating some views.

# I18n.t

With `I18n.t`{.methodname} you can retrieve previously defined
translations. The translations are saved by default in YAML format in
the directory `config/locales/`{.filename}. Technically, you do not have
to use YAML as format.

In `config/locales/`{.filename} you can find an example file
`config/locales/en.yml`{.filename} with the following content:

``` {.programlisting}
en:
  hello: "Hello world"
```

In the Rails console we can try out how `I18n.t`{.methodname} works:

``` {.screen}
$ rails console
Loading development environment (Rails 4.0.0)
>> I18n.t :hello
=> "Hello world"
>> I18n.locale
=> :en
>> exit
$
```

Let's first create a `config/locales/de.yml`{.filename} with the
following content:

``` {.programlisting}
de:
  hello: "Hallo Welt"
```

In the console we can set the system language with
`I18n.locale = :de`{.code} to German.

``` {.screen}
$ rails console
Loading development environment (Rails 4.0.0)
>> I18n.locale
=> :en
>> I18n.locale = :de
=> :de
>> I18n.t :hello
=> "Hallo Welt"
>>
```

`I18n.t`{.methodname} looks by default for the entry in the language
defined in `I18n.locale`{.varname}. It does not matter if you are
working with `I18n.t`{.methodname} or `I18n.translate`{.methodname}. Nor
does it matter if you are searching for a symbol or a string:

``` {.screen}
>> I18n.locale = :en
=> :en
>> I18n.t :hello
=> "Hello world"
>> I18n.t 'hello'
=> "Hello world"
>> I18n.translate 'hello'
=> "Hello world"
>>
```

If a translation does not exist, you get an error message that says
"`translation missing:`{.code}". This also applies if a translation is
only missing in one language (then all other languages will work, but
for the missing translation you will get the error message). In that
case, you can define a default with
`:default       => 'any default value'`{.code}:

``` {.screen}
>> I18n.t 'asdfasdfasdf'
=> "translation missing: en.asdfasdfasdf"
>> I18n.t 'asdfasdfasdf', :default => 'asdfasdfasdf'
=> "asdfasdfasdf"
>> exit
$
```

In the YAML structure you can also specify several levels. Please amend
the `config/locale/en.yml`{.filename} as follows:

``` {.programlisting}
en:
  hello: "Hello world"
  example:
    test: "A test"
  aaa:
    bbb:
      test: "An other test"
```

You can display the different levels within the string with dots or with
a `:scope`{.code} for the symbols. You can also mix both options.

``` {.screen}
$ rails console
Loading development environment (Rails 4.0.0)
>> I18n.t 'example.test'
=> "A test"
>> I18n.t 'aaa.bbb.test'
=> "An other test"
>> I18n.t :test, scope: [:aaa, :bbb]
=> "An other test"
>> I18n.t :test, scope: 'aaa.bbb'
=> "An other test"
>> exit
$
```

It is up to you which structure you choose to save your translations in
the YAML files. But the structure described in [the section called “A
Rails Application in Only One Language:
German”](#i18n_einsprachig_deutsch "A Rails Application in Only One Language: German")
does make some things easier and that's why we are going to use it for
this application as well.

## Using I18n.t in the View

In the view, you can use `I18n.t`{.methodname} as follows:

``` {.programlisting}
<%= t :hello-world %>

<%= I18n.t :hello-world %>

<%= I18n.translate :hello-world %>

<%= I18n.t 'hello-world' %>

<%= I18n.t 'aaa.bbb.test' %>

<%= link_to I18n.t('views.destroy'), book, confirm: I18n.t('views.are_you_sure'), method: :delete %>
```

## Localized Views

In Rails, there is a useful option of saving several variations of a
view as "localized views", each of which represents a different
language. This technique is independent of the potential use of
`I18n.t`{.methodname} in these views. The file name results from the
view name, the language code (for example, `de`{.filename} for German)
and `html.erb`{.filename} for ERB pages. Each of these are separated by
a dot. So the German variation of the `index.html.erb`{.filename} page
would get the file name `index.de.html.erb`{.filename}.

Your views directory could then look like this:

``` {.screen}
|-app
|---views
|-----products
|-------_form.html.erb
|-------_form.de.html.erb
|-------edit.html.erb
|-------edit.de.html.erb
|-------index.html.erb
|-------index.de.html.erb
|-------new.html.erb
|-------new.de.html.erb
|-------show.html.erb
|-------show.de.html.erb
|-------
|-----page
|-------index.html.erb
|-------index.de.html.erb
```

The language set with `config.i18n.default_locale`{.varname} is used
automatically if no language was encoded in the file name. In a new and
not yet configured Rails project, this will be English. You can
configure it in the file `config/application.rb`{.filename}.

# A Rails Application in Only One Language: German

In a Rails application aimed only at German users, it is unfortunately
not enough to just translate all the views into German. The approach is
in many respects similar to a multi-lingual Rails application (see [the
section called “Multilingual Rails
Application”](#i18n_mehrsprachige_rails_applikation "Multilingual Rails Application")).
Correspondingly, there will be a certain amount of repetition. I am
going to show you the steps you need to watch out for by using a simple
application as example.

Let's go through all the changes using the example of this bibliography
application:

``` {.screen}
$ rails new bibliography
  [...]
$ cd bibliography
$ rails generate scaffold book title number_of_pages:integer 'price:decimal{7,2}'
  [...]
$ rake db:migrate
  [...]
$
```

To get examples for validation errors, please insert the following
validations in the `app/models/book.rb`{.filename}:

``` {.programlisting}
class Book < ActiveRecord::Base
  validates :title,
            presence: true,
            uniqueness: true,
            length: { within: 2..255 }

  validates :price,
            presence: true,
            numericality: { greater_than: 0 }
end
```

Please search the configuration file `config/application.rb`{.filename}
for the value `config.i18n.default_locale`{.varname} and set it to
`:de`{.code} for German. In the same context, we then also insert two
directories in the line above for the translations of the models and the
views. This directory structure is not a technical requirement, but
makes it easier to keep track of things if your application becomes big:

``` {.programlisting}
config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'models', '*', '*.yml').to_s]
config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'views', '*', '*.yml').to_s]
config.i18n.default_locale = :de
```

You then still need to create the corresponding directories:

``` {.screen}
$ mkdir -p config/locales/models/book
$ mkdir -p config/locales/views/book
$
```

Now you need to generate a language configuration file for German or
simply download a ready-made one by Sven Fuchs from his Github
repository at `https://github.com/svenfuchs/rails-i18n`{.uri}:

``` {.screen}
$ cd config/locales
$ curl -O https://raw.github.com/svenfuchs/rails-i18n/master/rails/locale/de.yml
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  4940  100  4940    0     0   4296      0  0:00:01  0:00:01 --:--:--  4862
$
```

## Note

If you know how Bundler works, you can also insert the line
`gem 'rails-i18n'`{.code} into the file `Gemfile`{.filename} and then
execute **bundle install**. This gives you all language files from the
repository.

In the file `config/locales/de.yml`{.filename}, you have all required
formats and generic wordings for German that you need for a normal Rails
application (for example, days of the week, currency symbols, etc). Have
a look at it with your favorite editor to get a first impression.

Next, we need to tell Rails that a model 'book' is not called 'book' in
German, but 'Buch'. The same applies to all attributes. So we create the
file `config/locales/models/book/de.yml`{.filename} with the following
structure. As side effect, we get the methods
`Model.model_name.human`{.methodname} and
`Model.human_attribute_name(attribute)`{.methodname}, with which we can
insert the model and attribute names in the view.

``` {.programlisting}
de:
  activerecord:
    models:
      book: 'Buch'
    attributes:
      book:
        title: 'Titel'
        number_of_pages: 'Seitenanzahl'
        price: 'Preis'
```

In the file `config/locales/views/book/de.yml`{.filename} we insert a
few values for the scaffold views:

``` {.programlisting}
de:
  views:
    show: Anzeigen
    edit: Editieren
    destroy: Löschen
    are_you_sure: Sind Sie sicher?
    back: Zurück
    edit: Editieren
    book:
      index:
        title: Bücherliste
        new: Neues Buch
      edit:
        title: Buch editieren
      new:
        title: Neues Buch
      flash_messages:
        book_was_successfully_created: 'Das Buch wurde erfolgreich angelegt.'
        book_was_successfully_updated: 'Das Buch wurde erfolgreich aktualisiert.'
```

Now we still need to integrate a "few" changes into the views. We use
the `I18n.t`{.methodname} helper that can also be abbreviated with
`t`{.methodname} in the view. `I18n.t`{.methodname} reads out the
corresponding item from the YAML file. In the case of a purely
monolingual German application, we could also write the German text
directly into the view, but with this method we can more easily switch
to multilingual use if required. You can find more information on I18n.t
in [the section called “I18n.t”](#i18n_i18n_t "I18n.t").

`app/views/books/_form.html.erb`{.filename}

``` {.programlisting}
<%= form_for(@book) do |f| %>
  <% if @book.errors.any? %>
    <div id="error_explanation">
      <h2><%= t 'activerecord.errors.template.header', :model => Book.model_name.human, :count => @book.errors.count %></h2>
      <ul>
      <% @book.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= f.label :title %><br>
    <%= f.text_field :title %>
  </div>
  <div class="field">
    <%= f.label :number_of_pages %><br>
    <%= f.number_field :number_of_pages %>
  </div>
  <div class="field">
    <%= f.label :price %><br>
    <%= f.text_field :price %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
```

`app/views/books/edit.html.erb`{.filename}

``` {.programlisting}
<h1><%= t 'views.book.edit.title' %></h1>

<%= render 'form' %>

<%= link_to I18n.t('views.show'), @book %> |
<%= link_to I18n.t('views.back'), books_path %>
```

`app/views/books/index.html.erb`{.filename}

``` {.programlisting}
<h1><%= t 'views.book.index.title' %></h1>

<table>
  <thead>
    <tr>
      <th><%= Book.human_attribute_name(:title) %></th>
      <th><%= Book.human_attribute_name(:number_of_pages) %></th>
      <th><%= Book.human_attribute_name(:price) %></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>

  <tbody>
    <% @books.each do |book| %>
      <tr>
        <td><%= book.title %></td>
        <td><%= number_with_delimiter(book.number_of_pages) %></td>
        <td><%= number_to_currency(book.price) %></td>
        <td><%= link_to I18n.t('views.show'), book %></td>
        <td><%= link_to I18n.t('views.edit'), edit_book_path(book) %></td>
        <td><%= link_to I18n.t('views.destroy'), book, method: :delete, data: { confirm: I18n.t('views.are_you_sure')} %></td>
      </tr>
    <% end %>
  </tbody>
</table>

<br>

<%= link_to I18n.t('views.book.index.new'), new_book_path %>
```

`app/views/books/new.html.erb`{.filename}

``` {.programlisting}
<h1><%= t 'views.book.new.title' %></h1>

<%= render 'form' %>

<%= link_to I18n.t('views.back'), books_path %>
```

`app/views/books/show.html.erb`{.filename}

``` {.programlisting}
<p id="notice"><%= notice %></p>

<p>
  <strong><%= Book.human_attribute_name(:title) %>:</strong>
  <%= @book.title %>
</p>

<p>
  <strong><%= Book.human_attribute_name(:number_of_pages) %>:</strong>
  <%= number_with_delimiter(@book.number_of_pages) %>
</p>

<p>
  <strong><%= Book.human_attribute_name(:price) %>:</strong>
  <%= number_to_currency(@book.price) %>
</p>

<%= link_to I18n.t('views.edit'), edit_book_path(@book) %> |
<%= link_to I18n.t('views.back'), books_path %>
```

### Note

In the show and index view, I have integrated the helpers
`number_with_delimiter`{.methodname} and
`number_to_currency`{.methodname} so the numbers are represented more
attractively for the user.

Right at the end, we still need to adapt a few flash messages in the
controller `app/controllers/books_controller.rb`{.filename}:

``` {.programlisting}
class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  ## GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: I18n.t('views.book.flash_messages.book_was_successfully_created') }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: I18n.t('views.book.flash_messages.book_was_successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :number_of_pages, :price)
    end
end
```

Now you can use the views generated by the scaffold generator entirely
in German. The structure of the YAML files shown here can of course be
adapted to your own preferences. The texts in the views and the
controller are displayed with `I18n.t`{.methodname}. At this point you
could of course also integrate the German text directly if the
application is purely in German.

# Paths in German

Our bibliography is completely in German, but the URLs are still in
English. If we want to make all books available at the URL
`http://0.0.0.0:3000/buecher`{.uri} instead of the URL
`http://0.0.0.0:3000/books`{.uri} then we need to add the following
entry to the `config/routes.rb`{.filename}:

``` {.programlisting}
Bibliography::Application.routes.draw do
  resources :books, path: 'buecher', path_names: { new: 'neu', edit: 'editieren' }
end
```

As a result, we then have the following new paths:

``` {.screen}
$ rake routes
   Prefix Verb   URI Pattern                      Controller#Action
    books GET    /buecher(.:format)               books#index
          POST   /buecher(.:format)               books#create
 new_book GET    /buecher/neu(.:format)           books#new
edit_book GET    /buecher/:id/editieren(.:format) books#edit
     book GET    /buecher/:id(.:format)           books#show
          PATCH  /buecher/:id(.:format)           books#update
          PUT    /buecher/:id(.:format)           books#update
          DELETE /buecher/:id(.:format)           books#destroy
$
```

The brilliant thing with Rails routes is that you do not need to do
anything else. The rest is managed transparently by the routing engine.

# Multilingual Rails Application

The approach for multilingual Rails applications is very similar to the
monoligual, all-German Rails application described in [the section
called “A Rails Application in Only One Language:
German”](#i18n_einsprachig_deutsch "A Rails Application in Only One Language: German").
But we need to define YAML language files for all required languages and
tell the Rails application which language it should currently use. We do
this via `I18n.locale`{.varname}.

# Using I18n.locale for Defining the Default Language

Of course, a Rails application has to know in which language a web page
should be represented. `I18n.locale`{.code} saves the current language
and can be read by the application. I am going to show you this with a
mini web shop example:

``` {.screen}
$ rails new webshop
  [...]
$ cd webshop
$
```

This web shop gets a homepage:

``` {.screen}
$ rails generate controller Page index
  [...]
$
```

We still need to enter it as root page in the
`config/routes.rb`{.filename}:

``` {.programlisting}
Webshop::Application.routes.draw do
  get "page/index"
  root 'page#index'
end
```

We populate the `app/views/page/index.html.erb`{.filename} with the
following example:

``` {.programlisting}
<h1>Example Webshop</h1>
<p>Welcome to this webshop.</p>

<p>
<strong>I18n.locale:</strong>
<%= I18n.locale %>
</p>
```

If we start the Rails server with **rails server** and go to
`http://0.0.0.0:3000/`{.uri} in the browser, then we see the following
web page:

![](screenshots/i18n_ganze_seite_page_index.jpg)

As you can see, the default is set to "en" for English. Stop the Rails
server with **CTRL-C** and change the setting for the default language
to German in the file `config/application.rb`{.filename}:

``` {.programlisting}
config.i18n.default_locale = :de
```

If you then start the Rails server and again go to
`http://0.0.0.0:3000/`{.uri} in the web browser, you will see the
following web page:

![](screenshots/i18n_ganze_seite_page_index_default_locale_de.jpg)

The web page has not changed, but as output of
`<%=       I18n.locale %>`{.code} you now get '`de`{.code}' for German
(Deutsch), not '`en`{.code}' for English as before.

Please stop the Rails server with **CTRL-C** and change the setting for
the default language to `en`{.code} for English in the file
`config/application.rb`{.filename}:

``` {.programlisting}
## The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
## config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

config.i18n.default_locale = :en
```

We now know how to set the default for `I18n.locale`{.varname} in the
entire application, but that only gets half the job done. A user wants
to be able to choose his own language. There are various ways of
achieving this. To make things clearer, we need a second page that
displays a German text.

Please create the file `app/views/page/index.de.html.erb`{.filename}
with the following content:

``` {.programlisting}
<h1>Beispiel Webshop</h1>
<p>Willkommen in diesem Webshop.</p>

<p>
<strong>I18n.locale:</strong>
<%= I18n.locale %>
</p>
```

# Setting I18n.locale via URL Path Prefix

The more stylish way of setting the language is to add it as prefix to
the URL. This enables search engines to manage different language
versions better. We want `http://0.0.0.0:3000/de`{.uri} to display the
German version of our homepage and `http://0.0.0.0:3000/en`{.uri} the
English version. The first step is adapting the
`config/routes.rb`{.filename}

``` {.programlisting}
Webshop::Application.routes.draw do
  scope ':locale', locale: /en|de/ do
    get "page/index"
    get '/', to: 'page#index'
  end

  root 'page#index'
end
```

Next, we need to set a `before_filter`{.methodname} in the
`app/controllers/application_controller.rb`{.filename}. This filter sets
the parameter locale set by the route as `I18n.locale`{.varname}:

``` {.programlisting}
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
```

To test it, start Rails with **rails server** and go to the URL
`http://0.0.0.0:3000/de`{.uri}.

![](screenshots/i18n_path_prefix_de_root.jpg)

Of course we can also go to `http://0.0.0.0:3000/de/page/index`{.uri}:

![](screenshots/i18n_path_prefix_de_page_index.jpg)

If we go to `http://0.0.0.0:3000/en`{.uri} and
`http://0.0.0.0:3000/en/page/index`{.uri} we get the English version of
each page.

But now we have a problem: by using the prefix, we initially get to a
page with the correct language, but what if we want to link from that
page to another page in our Rails project? Then we would need to
manually insert the prefix into the link. Who wants that? Obviously
there is a clever solution for this problem. We can set global default
parameters for URL generation by defining a method called
`default_url_options`{.methodname} in our controller.

So we just need to add this method in
`app/controllers/application_controller.rb`{.filename}:

``` {.programlisting}
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
```

As a result, all links created with `link_to`{.methodname} and
`url_for`{.methodname} (on which `link_to`{.methodname} is based) are
automatically expanded by the parameter `locale`{.varname}. You do not
need to do anything else. All links generated via the scaffold generator
are automatically changed accordingly.

## Navigation Example

To give the user the option of switching easily between the different
language versions, it makes sense to offer two links at the top of the
web page. We don't want the current language to be displayed as active
link. This can be achieved as follows for all views in the file
`app/views/layouts/application.html.erb`{.filename}:

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

<p>
<%= link_to_unless I18n.locale == :en, "English", locale: :en %>
|
<%= link_to_unless I18n.locale == :de, "Deutsch", locale: :de %>
</p>

<%= yield %>

</body>
</html>
```

The navigation is then displayed at the top of the page.

![](screenshots/I18n_locale_url_prefix_navigation.jpg)

## Setting I18n.locale via Accept Language HTTP Header of Browser

When a user goes to your web page for the first time, you ideally want
to immediately display the web page in the correct language for that
user. To do this, you can read out the accept language field in the HTTP
header. In every web browser, the user can set his preferred language
(see
`http://www.w3.org/International/questions/qa-lang-priorities`{.uri}).
The browser automatically informs the web server and consequently Ruby
on Rails of this value.

Please edit the `app/controllers/application_controller.rb`{.filename}
as follows:

``` {.programlisting}
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  private
  def extract_locale_from_accept_language_header
    http_accept_language = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    if ['de', 'en'].include? http_accept_language
      http_accept_language
    else
      'en'
    end
  end

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header || I18n.default_locale
  end
end
```

And please do not forget to clean the settings in [the section called
“Setting I18n.locale via URL Path
Prefix”](#i18n_url_path_prefix "Setting I18n.locale via URL Path Prefix")
out of the `config/routes.rb`{.filename}:

``` {.programlisting}
Webshop::Application.routes.draw do
  get "page/index"
  root 'page#index'
end
```

Now you always get the output in the language defined in the web
browser. Please note that
`request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first`{.code}
does not catch all cases. For example, you should make sure that you
support the specified language in your Rails application in the first
place. There are some ready-made gems that can easily do this job for
you. Have a look at
`https://www.ruby-toolbox.com/categories/i18n#http_accept_language`{.uri}
to find them.

# Saving I18n.locale in a Session

Often you want to save the value of `I18n.locale`{.varname} in a session
(see [the section called “Sessions”](#sessions "Sessions")).

## Note

The approach described here for sessions will of course work just the
same with cookies. See [the section called
“Cookies”](#cookies "Cookies").

To set the value, let's create a controller in our web shop as example:
the controller `SetLanguage`{.classname} with the two actions
`english`{.methodname} and `german`{.methodname}:

``` {.screen}
$ rails generate controller SetLanguage english german
  [...]
$
```

In the file `app/controllers/set_language_controller.rb`{.filename} we
populate the two actions as follows:

``` {.programlisting}
class SetLanguageController < ApplicationController
  def english
    I18n.locale = :en
    set_session_and_redirect
  end

  def german
    I18n.locale = :de
    set_session_and_redirect
  end

  private
  def set_session_and_redirect
    session[:locale] = I18n.locale
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to :root
  end
end
```

Finally, we also want to adapt the `set_locale`{.methodname} methods in
the file `app/controllers/application_controller.rb`{.filename}:

``` {.programlisting}
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  private
  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end
end
```

After starting Rails with **rails server**, you can now set the language
to German by going to the URL
`http://0.0.0.0:3000/set_language/german`{.uri} and to English by going
to `http://0.0.0.0:3000/set_language/english`{.uri}.

## Navigation Example

To give the user the option of switching easily between the different
language versions, it makes sense to offer two links at the top of the
web page. We don't want the current language to be displayed as active
link. This can be achieved as follows for all views in the file
`app/views/layouts/application.html.erb`{.filename}:

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

<p>
<%= link_to_unless I18n.locale == :en, "English", set_language_english_path %>
|
<%= link_to_unless I18n.locale == :de, "Deutsch", set_language_german_path %>
</p>

<%= yield %>

</body>
</html>
```

The navigation is then displayed at the top of the page.

![](screenshots/I18n_locale_url_prefix_navigation.jpg)

## Setting I18n.locale via Domain Extension

If you have several domains with the extensions typical for the
corresponding languages, you can of course also use these extensions to
set the language. For example, if a user visits the page
`http://www.example.com`{.uri} he would see the English version, if he
goes to `http://www.example.de`{.uri} then the German version would be
displayed.

To achieve this, we would need to go into the
`app/controllers/application_controller.rb`{.filename} and insert a
`before_filter`{.methodname} that analyses the accessed domain and sets
the `I18n.locale`{.varname} :

``` {.programlisting}
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  private
  def set_locale
    case request.host.split('.').last
    when 'de'
      I18n.locale = :de
    when 'com'
      I18n.locale = :en
    else
      I18n.locale = I18n.default_locale
    end
  end
end
```

### Tip

To test this functionality, you can add the following items on your
Linux or Mac OS X development system in the file
`/etc/hosts`{.filename}:

``` {.programlisting}
0.0.0.0 www.example.com
0.0.0.0 www.example.de
```

Then you can go to the URL `http://www.example.com:3000`{.uri} and
`http://www.example.de:3000`{.uri} and you will see the corresponding
language versions.

## Which Approach is the Best?

I believe that a combination of the approaches described above will lead
to the best result. When I first visit a web page I am happy if I find
that the accept language HTTP header of my browser is read and
implemented correctly. But it is also nice to be able to change the
language later on in the user configuration (in particular for badly
translated pages, English language is often better). And ultimately it
has to be said that a page that is easy to represent is worth a lot for
a search engine, and this also goes for the languages. Rails gives you
the option of easily using all variations and even enables you to
combine them together.

# Multilingual Scaffolds

As an example, we use a mini webshop in which we translate a product
scaffold. The aim is to make the application available in German and
English.

The Rails application:

``` {.screen}
$ rails new webshop
  [...]
$ cd webshop
$ rails generate scaffold Product name description 'price:decimal{7,2}'
  [...]
$ rake db:migrate
  [...]
$
```

We define the product model in the `app/models/product.rb`{.filename}

``` {.programlisting}
class Product < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: true,
            length: { within: 2..255 }

  validates :price,
            presence: true,
            numericality: { greater_than: 0 }
end
```

When selecting the language for the user, we use the URL prefix
variation described in [the section called “Setting I18n.locale via URL
Path
Prefix”](#i18n_url_path_prefix "Setting I18n.locale via URL Path Prefix").
We use the following
`app/controllers/application_controller.rb`{.filename}

``` {.programlisting}
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
```

This is the `config/routes.rb`{.filename}

``` {.programlisting}
Webshop::Application.routes.draw do
  scope ':locale', locale: /en|de/ do
    resources :products
    get '/', to: 'products#index'
  end

  root 'products#index'
end
```

Then we insert the links for the navigation in the
`app/views/layouts/application.html.erb`{.filename}:

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

<p>
<%= link_to_unless I18n.locale == :en, "English", locale: :en %>
|
<%= link_to_unless I18n.locale == :de, "Deutsch", locale: :de %>
</p>

<%= yield %>

</body>
</html>
```

Start the Rails server with **rails server.**

``` {.screen}
$ rails server
=> Booting WEBrick
=> Rails 4.0.0 application starting in development on http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
[2013-07-17 22:16:19] INFO  WEBrick 1.3.1
[2013-07-17 22:16:19] INFO  ruby 2.0.0 (2013-06-27) [x86_64-darwin12.4.0]
[2013-07-17 22:16:19] INFO  WEBrick::HTTPServer#start: pid=42806 port=3000
```

If we go to `http://0.0.0.0:3000`{.uri} we see the normal English page.

![](screenshots/i18n_webshop_base_version.jpg)

If we click the option German, nothing changes on the page, apart from
the language navigation right at the top.

![](screenshots/i18n_webshop_base_version_de.jpg)

Now we still need to find a way of translating the individual elements
of this page appropriately and as generically as possible.

## Text Blocks in YAML Format

Now we need to define the individual text blocks for
`I18n.t`{.methodname}. The corresponding directories still have to be
created first:

``` {.screen}
$ mkdir -p config/locales/models/product
$ mkdir -p config/locales/views/product
$
```

To make sure that the YAML files created there are indeed read in
automatically, you need to insert the following lines in the file
`config/application.rb`{.filename}:

``` {.programlisting}
## The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'models', '*', '*.yml').to_s]
config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'views', '*', '*.yml').to_s]
config.i18n.default_locale = :en
```

## German

Please create the file `config/locales/models/product/de.yml`{.filename}
with the following content.

``` {.programlisting}
de:
  activerecord:
    models:
      product: 'Produkt'
    attributes:
      product:
        name: 'Name'
        description: 'Beschreibung'
        price: 'Preis'
```

In the file `config/locales/views/product/de.yml`{.filename} we insert a
few values for the scaffold views:

``` {.programlisting}
de:
  views:
    show: Anzeigen
    edit: Editieren
    destroy: Löschen
    are_you_sure: Sind Sie sicher?
    back: Zurück
    edit: Editieren
    product:
      index:
        title: Liste aller Produkte
        new_product: Neues Produkt
      edit:
        title: Produkt editieren
      new:
        title: Neues Produkt
      flash_messages:
        product_was_successfully_created: 'Das Produkt wurde erfolgreich angelegt.'
        product_was_successfully_updated: 'Das Produkt wurde erfolgreich aktualisiert.'
```

Finally, we copy a ready-made default translation by Sven Fuchs from his
github repository `https://github.com/svenfuchs/rails-i18n`{.uri}:

``` {.screen}
$ cd config/locales
$ curl -O https://raw.github.com/svenfuchs/rails-i18n/master/rails/locale/de.yml
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  4940  100  4940    0     0   9574      0 --:--:-- --:--:-- --:--:-- 11932
$ cd ../..
$
```

### Note

If you know how Bundler works you can also insert the line
`gem 'rails-i18n'`{.code} into the file `Gemfile`{.filename} and then
execute **bundle install**. This gives you all language files from the
repository.

The file `config/locales/de.yml`{.filename} contains all required
formats and generic phrases for German that we need for a normal Rails
application (for example days of the week, currency symbols, etc). Use
your favorite editor to have a look in there to get an impression.

## English

As most things are already present in the system for English, we just
need to insert a few values for the scaffold views in the file
`config/locales/views/product/en.yml`{.filename}:

``` {.programlisting}
en:
  views:
    show: Show
    edit: Edit
    destroy: Delete
    are_you_sure: Are you sure?
    back: Back
    edit: Edit
    product:
      index:
        title: List of all products
        new_product: New product
      edit:
        title: Edit Product
      new:
        title: New product
      flash_messages:
        product_was_successfully_created: 'Product was successfully created.'
        product_was_successfully_updated: 'Product was successfully updated.'
```

## Equipping Views with I18n.t

Please edit the listed view files as specified.

## \_form.html.erb

In the file `app/views/products/_form.html.erb`{.filename} we need to
change the display of the validation errors in the top section to
`I18n.t`{.methodname}. The names of form errors are automatically read
in from `activerecord.attributes.product`{.varname}:

``` {.programlisting}
<%= form_for(@product) do |f| %>
  <% if @product.errors.any? %>
    <div id="error_explanation">
      <h2><%= t 'activerecord.errors.template.header', model: Product.model_name.human, count: @product.errors.count %></h2>

      <ul>
      <% @product.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= f.label :name %><br>
    <%= f.text_field :name %>
  </div>
  <div class="field">
    <%= f.label :description %><br>
    <%= f.text_field :description %>
  </div>
  <div class="field">
    <%= f.label :price %><br>
    <%= f.text_field :price %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
```

## edit.html.erb

In the file `app/views/products/edit.html.erb`{.filename} we need to
integrate the heading and the links at the bottom of the page with
`I18n.t`{.methodname}:

``` {.programlisting}
<h1><%= t 'views.product.edit.title' %></h1>

<%= render 'form' %>

<%= link_to I18n.t('views.show'), @product %> |
<%= link_to I18n.t('views.back'), products_path %>
```

## index.html.erb

In the file `app/views/products/index.html.erb`{.filename} we need to
change practically every line. In the table header I use
`human_attribute_name()`{.methodname}, but you could also do it directly
with `I18n.t`{.methodname}. The price of the product is specified with
the helper number\_to\_currency. In a real application, we would have to
specify a defined currency at this point as well.

``` {.programlisting}
<h1><%= t 'views.product.index.listing_products' %></h1>

<table>
  <thead>
    <tr>
      <th><%= Product.human_attribute_name(:name) %></th>
      <th><%= Product.human_attribute_name(:description) %></th>
      <th><%= Product.human_attribute_name(:price) %></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>

  <tbody>
    <% @products.each do |product| %>
      <tr>
        <td><%= product.name %></td>
        <td><%= product.description %></td>
        <td><%= number_to_currency(product.price) %></td>
        <td><%= link_to I18n.t('views.show'), product %></td>
        <td><%= link_to I18n.t('views.edit'), edit_product_path(product) %></td>
        <td><%= link_to I18n.t('views.destroy'), product, method: :delete, data: { confirm: I18n.t('views.are_you_sure')} %></td>
      </tr>
    <% end %>
  </tbody>
</table>

<br>

<%= link_to I18n.t('views.product.index.new_product'), new_product_path %>
```

## new.html.erb

In the `app/views/products/new.html.erb`{.filename} we need to adapt the
heading and the link:

``` {.programlisting}
<h1><%= t 'views.product.new.title' %></h1>

<%= render 'form' %>

<%= link_to I18n.t('views.back'), products_path %>
```

## show.html.erb

In the `app/views/products/show.html.erb`{.filename} we again use
`human_attribute_name()`{.methodname} for the attributes. Plus the links
need to be translated with `I18n.t`{.methodname}. As with the index
view, we again use `number_to_currency()`{.methodname} to show the price
in formatted form:

``` {.programlisting}
<p id="notice"><%= notice %></p>

<p>
  <strong><%= Product.human_attribute_name(:name) %>:</strong>
  <%= @product.name %>
</p>

<p>
  <strong><%= Product.human_attribute_name(:description) %>:</strong>
  <%= @product.description %>
</p>

<p>
  <strong><%= Product.human_attribute_name(:price) %>:</strong>
  <%= number_to_currency(@product.price) %>
</p>

<%= link_to I18n.t('views.edit'), edit_product_path(@product) %> |
<%= link_to I18n.t('views.back'), products_path %>
```

## Translating Flash Messages in the Controller

Finally, we need to translate the two flash messages in the
`app/controllers/products_controller.rb`{.filename} for creating
(create) and updating (update) records, again via `I18n.t`{.methodname}:

``` {.programlisting}
class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: I18n.t('views.product.flash_messages.product_was_successfully_created') }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: I18n.t('views.product.flash_messages.product_was_successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end
```

## The Result

Now you can use the scaffold products both in German and in English. You
can switch the language via the link at the top of the page.

## Further Information

The best source of information on this topic can be found in the Rails
documentation at `http://guides.rubyonrails.org/i18n.html`{.uri}. This
also shows how you can operate other backends for defining the
translations.

As so often, `Railscasts.com`{.uri} offers a whole range of Railscasts
on the topic I18n:
`http://railscasts.com/episodes?utf8=%E2%9C%93&search=i18n`{.uri}
