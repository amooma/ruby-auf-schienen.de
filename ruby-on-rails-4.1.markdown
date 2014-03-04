

Further Rails Documentation
===========================

Online
======

Here is a list of important websites on the topic Ruby on Rails:

-   `http://guides.rubyonrails.org`{.uri}
    A couple of very good official guides.
-   `http://rubyonrails.org/`{.uri}
    The project page of Ruby on Rails offers many links for further
    documentation. Please note: some parts of the documentation are now
    obsolete. Please check if what you are reading is related
    specifically to Rails 3.2 or to older Rails versions.
-   `http://railscasts.com/`{.uri}
    Ryan Bates publishes a new screencast every Monday on a topic
    associated with Rails. This page is definitely worth a visit once a
    week.

Index
-----

### A

abbreviations, [Abbreviations](#abkuerzungen)

Action Mailer, [Action Mailer](#action_mailer)

Active Record (pattern) (see ActiveRecord)

ActiveRecord, [ActiveRecord](#activerecord_chapter)

(see also database)

associations (see ActiveRecord, relations)

calculations, [Calculations](#activerecord_berechnungen)

callback, [Callbacks](#ar_callbacks)

after\_create, [Callbacks](#ar_callbacks)

after\_initialize, [Default Values](#ar_default_werte)

after\_save, [Callbacks](#ar_callbacks)

after\_validation, [Callbacks](#ar_callbacks)

before\_create, [Callbacks](#ar_callbacks)

before\_save, [Callbacks](#ar_callbacks)

before\_validation, [Callbacks](#ar_callbacks)

custom validations, [Writing Custom
Validations](#validates_eigene_validations_definieren)

errors

add, [Writing Custom
Validations](#validates_eigene_validations_definieren)

add\_to\_base, [Writing Custom
Validations](#validates_eigene_validations_definieren)

lazy loading, [Lazy Loading](#lazy_loading)

locking, [Locking](#activerecord_locking)

methods

all(), [first, last and all](#ar-first_last_all)

average(), [average](#activerecord_average)

build(), [build](#activerecord_hinzufuegen_build)

changed?(), [changed?](#activerecord_changed)

count(), [count](#activerecord_count)

create(), [create](#activerecord_create),
[create](#activerecord_has_many_create)

delete(), [delete and destroy](#has_many_delete), [dependent:
:destroy](#idp4515760), [delete](#activerecord_delete)

delete\_all(), [delete and destroy](#has_many_delete)

destroy(), [delete and destroy](#has_many_delete), [dependent:
:destroy](#idp4515760), [destroy](#activerecord_destroy)

destroy\_all(), [delete and destroy](#has_many_delete)

explain, [SQL EXPLAIN](#activerecord_explain)

find(), [find](#activerecord_find)

find\_each, [Batches](#activerecord_batches)

first(), [first, last and all](#ar-first_last_all)

first\_or\_create, [first\_or\_create and
first\_or\_initialize](#activerecord_first_or_create)

first\_or\_initialize, [first\_or\_create and
first\_or\_initialize](#activerecord_first_or_create)

group(), [group](#activerecord_group)

id(), [Manually](#activerecord_hinzufuegen_manuell)

includes(), [includes](#activerecord_1n_includes)

joins(), [joins](#activerecord_1n_joins),
[includes](#activerecord_1n_includes)

last(), [first, last and all](#ar-first_last_all)

limit(), [limit](#activerecord_limit)

maximum(), [maximum](#activerecord_maximum)

minimum(), [minimum](#activerecord_minimum)

new(), [new](#activerecord_new)

new\_record?(), [new\_record?](#activerecord_new_record)

offset(), [offset](#activerecord_offset)

order(), [order and reverse\_order](#activerecord_order)

pluck(), [pluck](#activerecord_pluck)

reverse\_order, [order and reverse\_order](#activerecord_order)

save(), [new](#activerecord_new), [Simple
Editing](#activerecord_einfaches_editieren), [save( validate: false
)](#validation_save_validate_false)

sum(), [sum](#activerecord_sum)

to\_sql(), [Lazy Loading](#lazy_loading)

transaction(), [Transactions](#activerecord_transaction)

update\_attributes(),
[update\_attributes](#activerecord_update_attributes)

valid?(), [valid?](#validation_valid)

validates\_exclusion\_of(), [exclusion](#validates_exclusion_of)

validates\_format\_of(), [format](#validates_format_of)

validates\_inclusion\_of(), [inclusion](#validates_inclusion_of)

validates\_length\_of(), [length](#validates_length_of)

validates\_numericality\_of(),
[numericality](#validates_numericality_of)

validates\_presence\_of(), [presence](#validates_presence_of)

validates\_uniqueness\_of(), [uniqueness](#validates_uniqueness_of)

where(), [where](#activerecord_where)

migrations, [Migrations](#activerecord_migration) (see migrations)

NamedScopes, [Scopes](#activerecord_named_scope)

polymorphic associations, [Polymorphic
Associations](#activerecord_polymorphic)

relations

belongs\_to(), [has\_many – 1:n Association](#activerecord_has_many),
[belongs\_to](#idp4497792), [Many-to-Many – n:n
Association](#ar-many_to_many), [has\_one – 1:1
Association](#ar-has_one)

has\_many(), [has\_many – 1:n Association](#activerecord_has_many),
[has\_many](#idp4504896), [Many-to-Many – n:n
Association](#ar-many_to_many)

has\_one(), [has\_one – 1:1 Association](#ar-has_one)

transactions, [Transactions](#activerecord_transaction)

validate, [Writing Custom
Validations](#validates_eigene_validations_definieren)

validates

allow\_blank, [General Validation
Options](#validates_allgemeine_validierungs_optionen)

allow\_nil, [General Validation
Options](#validates_allgemeine_validierungs_optionen)

exclusion, [exclusion](#validates_exclusion_of)

format, [format](#validates_format_of)

if, [General Validation
Options](#validates_allgemeine_validierungs_optionen)

inclusion, [inclusion](#validates_inclusion_of)

length, [length](#validates_length_of)

numericality, [numericality](#validates_numericality_of)

on, [General Validation
Options](#validates_allgemeine_validierungs_optionen)

presence, [presence](#validates_presence_of)

proc, [General Validation
Options](#validates_allgemeine_validierungs_optionen)

uniqueness, [uniqueness](#validates_uniqueness_of)

unless, [General Validation
Options](#validates_allgemeine_validierungs_optionen)

validation, [Validation](#activerecord_validation)

API (see web API)

app, [app](#idp2765312)

application.css, [application.css](#application.css_manifest)

application.html.erb, [Layouts](#erb_layouts)

application.js, [application.js](#application.js_manifest)

arrays

Ruby, [Arrays and Hashes](#ruby-array-und-hash), [Arrays](#ruby_array)

assert, [Unit Tests](#testing_beispiel_webshop_unit_tests) (see tests)

asset pipeline, [Asset Pipeline](#asset_pipeline)

asset pipeline fingerprint, [The
Fingerprint](#asset_pipeline_fingerabdruck)

attachments

e-maill, [Attachments](#email_attachments)

attr\_accessor(), [Getters and Setters](#ruby_getter_and_setter)

attr\_reader(), [Getters and Setters](#ruby_getter_and_setter)

attr\_writer(), [Getters and Setters](#ruby_getter_and_setter)

### B

bignum

Variables, [Fixnum and Bignum](#ruby-variables-fixnum-bignum)

binary

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

blocks

Ruby, [Blocks and Iterators](#ruby-blocks-iterators),
[Blocks](#ruby-block)

boolean

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

Variables, [Boolean Values and nil](#vartype_boolean_und_nil)

breadcrumbs, [Breadcrumbs via Session](#session_breadcrumbs)

bundle, [Create Rails Project](#rails-projekt-anlegen) (see Bundler)

bundler, [Create Rails Project](#rails-projekt-anlegen)

Bundler, [Bundler](#bundler)

bundle exec, [bundle exec](#bundle_exec)

bundle outdated, [bundle outdated](#bundle_outdated)

bundle update, [bundle update](#bundle_update)

button\_to\_function, [button\_to\_function](#button_to_function)

### C

cache store, [Cache Store](#fragment_cache_cache_store)

MemCacheStore, [MemCacheStore](#fragment_cache_memcachestore)

cache\_key, [Auto-Expiring Caches](#fragment_auto_expiring)

caching, [Caching](#caching)

fragment caching, [Fragment Caching](#fragment_caching)

auto-expiring, [Auto-Expiring Caches](#fragment_auto_expiring)

cache store, [Cache Store](#fragment_cache_cache_store)

cache\_key, [Auto-Expiring Caches](#fragment_auto_expiring)

deleting cache, [Deleting Fragment Cache](#fragment_cache_loeschen)

expire\_fragment, [Deleting Fragment Cache](#fragment_cache_loeschen)

HTTP caching, [HTTP Caching](#http_caching)

Cache-Control, [Cache-Control With Time Limit](#idp5669280)

etag, [Etag](#http_caching_etag)

last-modified, [Last-Modified](#http_caching_last_modified)

public, [Using Proxies (public)](#http_caching_public)

stale?, [stale?](#http_caching_stale)

time limit, [Cache-Control With Time Limit](#idp5669280)

page caching, [Page Caching](#page_caching)

:gzip =\> :best\_compression, [gz
Versions](#page_caching_gz_compression)

caches\_page, [Caching Company Index and Show
View](#page_caching_fuer_index_und_show)

delete, [Deleting Page Caches
Automatically](#page_caches_automatisch_loeschen)

Sweeper, [Deleting Page Caches
Automatically](#page_caches_automatisch_loeschen)

preheat, [Preheating](#cache_vorheizen)

casting

of objects in Ruby, [Converting from One to the Other:
Casting](#ruby-casting)

class (see classes in Ruby)

class methods and instance methods

Ruby, [Class Methods and Instance
Methods](#class_methods_vs_instance_methods)

classes

Ruby, [Classes](#ruby-class)

coding links, [Coding Links to an Asset](#coding_links_zu_assets)

comments

Ruby, [Comments](#kommentare-in-ruby)

conditional statements

Ruby, [if-Condition](#ruby-if-condition)

console, [The Rails Console](#die_console)

constants

Ruby, [Naming Conventions](#variablen_namenskonventionen)

constructor

classes in Ruby (see initialize())

controller, [Creating HTML Dynamically with erb](#dynamische_webseiten),
[Passing Instance Variables from a Controller to a
View](#erb_mit_programmierlogik)

convention over configuration, [Convention Over
Configuration](#convention_over_configuration)

cookies, [Cookies](#cookies)

permanent, [Permanent Cookies](#cookies_permanent)

signed, [Signed Cookies)](#cookies_signed)

created\_at

ActiveRecord, [The Attributes id, created\_at and
updated\_at](#idp3572080)

CRUD, [Scaffolding and REST](#scaffolding), [The Views](#scaffold_views)

### D

data types

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

database, [ActiveRecord](#activerecord_chapter), [Creating
Database/“Model”](#activerecord_datenbank_anlegen)

(see also ActiveRecord)

migrations (see migrations)

relational (SQL), [ActiveRecord](#activerecord_chapter)

transactions (see ActiveRecord, transactions)

database.yml, [Database Configuration](#idp3970464)

date

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

datetime

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

Debian 7.1

installation on Ruby on Rails, [Ruby on Rails 4.0 on Debian 7.1
(Wheeze)](#rails3-install-debian)

decimal

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

default\_url\_options, [Setting I18n.locale via URL Path
Prefix](#i18n_url_path_prefix)

defined?

methods, [Passing Variables to a Partial](#partials_locale_variables)

Development

environment, [Environment (Development)](#arbeits-umgebung-development)

Don't Repeat Yourself (see DRY)

DRY, [Passing Variables to a Partial](#partials_locale_variables), [DRY
- Don't repeat yourself](#dry)

### E

E-Mail, [Action Mailer](#action_mailer)

e-mail

HTML, [HTML E-Mails](#html_emails)

X-header, [Custom X-Header](#x_header)

each()

Ruby, [Iterator each](#array_iterator), [Iterator
each](#ruby-hash-iterator-each)

else

condition in Ruby (shorthand), [else](#ruby-if-condition-else)

elsif

conditon in Ruby (shorthand), [elsif](#ruby-if-condition-elsif)

environments, [Environment (Development)](#arbeits-umgebung-development)

erb, [Creating HTML Dynamically with erb](#dynamische_webseiten),
[Programming in an erb File](#erb-programmieren), [Partials](#partials)

### F

false

Variables, [Boolean Values and nil](#vartype_boolean_und_nil)

fixnum

Variables, [Fixnum and Bignum](#ruby-variables-fixnum-bignum)

fixtures (see tests)

static, [Static Fixtures](#statische_fixtures)

with ERB, [Fixtures with ERB](#fixtures_mit_erb)

flash messages, [Flash Messages](#flash), [Different Types of Flash
Message](#verschiedene_arten_von_flash_nachrichten), [Different
Syntaxes](#neue_flash_redirect_schreibweise), [Why Are There Flash
Messages At All?](#idp2740208)

float

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

Variables, [Floats](#ruby-variables-float)

footer, [Partials](#partials)

form\_for, [form\_for](#form_for)

frozen?(), [destroy](#activerecord_destroy)

functional tests (see tests)

### G

gems, [Create Rails Project](#rails-projekt-anlegen), [Gems](#gems)

getter

Ruby, [Getters and Setters](#ruby_getter_and_setter)

global variables

Ruby, [Global Variables (\$aaa)](#ruby-global-variables)

### H

hashes

Ruby, [Arrays and Hashes](#ruby-array-und-hash), [Hashes](#ruby_hash)

Hello World

in Rails, [Static Pages](#rails-statische-inhalte)

Ruby, [Hello World](#hello-world-in-ruby)

### I

I18n

German only, [A Rails Application in Only One Language:
German](#i18n_einsprachig_deutsch)

I18n.locale, [Using I18n.locale for Defining the Default
Language](#i18n_sprache_einstellen)

I18n.t, [I18n.t](#i18n_i18n_t)

I18n.translate, [I18n.t](#i18n_i18n_t)

localized views, [Localized Views](#i18n_localized_views)

paths in German, [Paths in German](#i18n_deutschsprachige_pfade)

I18n.locale

accept language HTTP header, [Setting I18n.locale via Accept Language
HTTP Header of Browser](#idp3341392)

domain extension, [Setting I18n.locale via Domain
Extension](#i18n_locale_per_domain_endung)

path prefix, [Setting I18n.locale via URL Path
Prefix](#i18n_url_path_prefix)

session, [Saving I18n.locale in a Session](#i18n_local_session)

id

ActiveRecord, [The Attributes id, created\_at and
updated\_at](#idp3572080)

if

condition in Ruby, [if-Condition](#ruby-if-condition)

condition in Ruby (shorthand), [Shorthand](#ruby-if-condition-short)

image\_tag, [Coding Link to an Image](#coding_link_image_tag)

inflections, [Why Is It All in English?](#warum_english), [Creating HTML
Dynamically with erb](#dynamische_webseiten)

ActiveRecord (see inflections)

ActiveSupport, [Naming Conventions (Country vs. country vs.
countries)](#activerecord_namenskonvention)

inflector (see inflections)

inflexion (see inflections)

inheritance

classes in Ruby, [Inheritance](#ruby-class-inheritance)

initialize(), [Instance Variables (@aaa)](#ruby-instance-variables)

classes in Ruby, [Method initialize()](#ruby-initialize)

Installation

Ruby on Rails

Debian 7.1, [Ruby on Rails 4.0 on Debian 7.1
(Wheeze)](#rails3-install-debian)

Mac OS X 10.7, [Ruby on Rails 4 on Mac OS X 10.7](#rails3-install-osx)

installation

of Ruby on Rails

on Windows, [Ruby on Rails 4 on Windows](#rails3-install-windows)

instance methods

Ruby, [List of All Instance Methods](#ruby-instance-methods)

instance variables, [Passing Instance Variables from a Controller to a
View](#erb_mit_programmierlogik)

Ruby, [Instance Variables (@aaa)](#ruby-instance-variables), [Getters
and Setters](#ruby_getter_and_setter)

instance\_methods() (see instance methods in Ruby)

integer

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

Variables, [Integers](#vartype_zahlen)

integration tests (see tests)

Interactive Ruby (see irb)

irb

Interactive Ruby (Ruby shell, Ruby console), [irb](#irb)

iterators

Ruby, [Blocks and Iterators](#ruby-blocks-iterators),
[Iterators](#iterator)

each(), [Iterator each](#array_iterator), [Iterator
each](#ruby-hash-iterator-each)

### J

JavaScript, [JavaScript](#javascript)

javascript\_include\_tag, [Coding Link to a JavaScript
File](#coding_link_javascript_include_tag)

javascript\_tag, [javascript\_tag](#javascript_tag)

JSON (see web API)

### L

layouts, [Layouts](#erb_layouts)

lazy loading (see ActiveRecord, lazy loading)

link\_to, [link\_to](#link_to)

link\_to\_function, [link\_to\_function](#link_to_function)

local variables

Ruby, [Local Variables (aaa or \_aaa)](#ruby-local-variables)

Log, [Creating HTML Dynamically with erb](#dynamische_webseiten)

loops

Ruby, [Loops](#ruby-schleifen)

until, [while and until](#ruby-loops-while-until)

while, [while and until](#ruby-loops-while-until)

### M

Mac OS X 10.7

Installation of Ruby on Rails, [Ruby on Rails 4 on Mac OS X
10.7](#rails3-install-osx)

manifest files, [Manifest Files](#manifest_dateien)

memcached, [MemCacheStore](#fragment_cache_memcachestore)

method chaining

Ruby, [Method Chaining](#ruby-method-chain)

methods

in Ruby chaining, [Method Chaining](#ruby-method-chain)

private, Ruby, [Private Methods](#ruby-private-methods)

Ruby, [Methods](#ruby-methoden)

migrations, [Creating Database/“Model”](#activerecord_datenbank_anlegen)
(see ActiveRecord, migrations)

model, [Creating Database/“Model”](#activerecord_datenbank_anlegen)

Model-View-Controller (see MVC)

Model–View–Controller (see MVC)

MVC, [Creating HTML Dynamically with erb](#dynamische_webseiten),
[Passing Instance Variables from a Controller to a
View](#erb_mit_programmierlogik), [Creating
Database/“Model”](#activerecord_datenbank_anlegen)

### N

nested routes (see routes)

new()

classes in Ruby (see initialize())

Nginx, [Web Server in Production Mode](#rails_production_webserver)

nil

Variables, [Boolean Values and nil](#vartype_boolean_und_nil)

null

Variables (see nil)

### O

object-relational mapping (see ORM)

ORM, [ActiveRecord](#activerecord_chapter)

(see also database)

ORM (object-relational mapping), [ActiveRecord](#activerecord_chapter)

### P

Partial, [Passing Variables to a Partial](#partials_locale_variables)

partials, [Partials](#partials)

pluralization (see inflections)

primary\_key

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

print, [puts and print](#puts-und-print)

Production

environment, [Environment (Development)](#arbeits-umgebung-development)

public

directory, [Static Pages](#rails-statische-inhalte)

puts, [puts and print](#puts-und-print)

### Q

quotation marks

for strings in Ruby, [Single and Double Quotations
Marks](#ruby-strings-quotes)

quotes

for strings in Ruby (see quotation marks)

### R

Rails

console, [The Rails Console](#die_console)

create project, [Create Rails Project](#rails-projekt-anlegen)

environments (see environments)

generator, [What is a Generator?](#was_ist_ein_generator)

helper, [Helper](#helper)

Installation, [Ruby on Rails 4.0 on Debian 7.1
(Wheeze)](#rails3-install-debian), [Ruby on Rails 4 on Mac OS X
10.7](#rails3-install-osx)

installation, [Ruby on Rails 4 on Windows](#rails3-install-windows)

introduction, [First Steps with Rails](#erste_schritte_mit_rails)

MVC

controller, [Controller](#mvc_controller)

model, [Model](#mvc_model)

view, [View](#mvc_view)

rake assets:precompile, [rake assets:precompile](#asset_precompile)

rake stats, [rake stats](#rake_stats)

rake test (see tests)

range, [Range](#range_class)

redirect

via routes, [Redirects](#routes_match_redirects)

redirects, [Redirects](#redirects), [Flash Messages](#flash)

refactoring, [Refactoring](#refactoring)

relational database (see database)

render(), [Partials](#partials), [Passing Variables to a
Partial](#partials_locale_variables)

REST

Representational State Transfer, [Scaffolding and REST](#scaffolding)

return, [return](#ruby-return)

rhtml (see erb)

ri

Ruby Index (Ruby Help), [Help via ri](#ri)

routen

names

as, [as](#routen_as)

to, [to](#routen_to)

routes, [Routes](#routes)

as, [as](#routen_as)

constraints, [Constraints](#routes_match_contraints)

get, [HTTP GET Requests for Singular Resources](#routes_get)

names, [Naming a Route](#namen_der_routen)

parameters, [Parameters](#routes_match_parameter)

redirect, [Redirects](#routes_match_redirects)

resources, [resources](#routes_resources)

except, [Selecting Specific Routes with only: or except:](#idp3679824)

nested, [Nested Resources](#routes_nested_resources)

only, [Selecting Specific Routes with only: or except:](#idp3679824)

shallow nesting, [Shallow Nesting](#shallow_nesting)

root, [root :to =\> 'welcome\#index'](#routes_root)

to, [to](#routen_to)

routes.rb, [Creating HTML Dynamically with erb](#dynamische_webseiten),
[Redirects](#redirects) (see routes)

routing, [Creating HTML Dynamically with erb](#dynamische_webseiten),
[Redirects](#redirects), [app](#idp2765312)

Ruby

Installation, [Ruby on Rails 4.0 on Debian 7.1
(Wheeze)](#rails3-install-debian), [Ruby on Rails 4 on Mac OS X
10.7](#rails3-install-osx)

installation, [Ruby on Rails 4 on Windows](#rails3-install-windows)

ri (integrated Help) (see ri)

Ruby Index (see ri)

Ruby on Rails (see Rails)

Ruby shell (see irb)

Ruby Version Manager, [Ruby on Rails 4 on Mac OS X
10.7](#rails3-install-osx) (see RVM)

RVM, [Ruby on Rails 4 on Mac OS X 10.7](#rails3-install-osx)

RVM (Ruby Version Manager), [Ruby on Rails 4.0 on Debian 7.1
(Wheeze)](#rails3-install-debian), [Ruby on Rails 4 on Mac OS X
10.7](#rails3-install-osx)

### S

scaffolding, [Scaffolding and REST](#scaffolding)

Rails 4.0, [Generating a Scaffold](#scaffold_anlegen)

scope

Variables, [Scope of Variables](#scope_von_variablen)

Scope, [Passing Instance Variables from a Controller to a
View](#erb_mit_programmierlogik)

seeds.rb, [Populating the Database with seeds.rb](#seed_rb), [It's all
just Ruby code](#seed_its_just_ruby)

seeds.rb, generate from existing data, [Generating seeds.rb From
Existing Data](#generating_seeds_from_existing_data)

sendmail, [Sending via Local Sendmail](#action_mailer_sendmail)

sessions, [Sessions](#sessions)

active\_record\_store, [Saving Sessions in the
Database](#sessions_datenbank)

reset\_session, [reset\_session](#reset_session)

setter

Ruby, [Getters and Setters](#ruby_getter_and_setter)

singularization (see inflections)

SMTP, [Sending via Direct SMTP](#idp3785984)

SQL database (see database)

SQLite, [SQLite-3 Database](#sqlite3_datenbank_default)

static pages/contents

in a Rails application, [Static Pages](#rails-statische-inhalte)

string

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

strings

Variables, [Strings](#variablen_string)

stylesheet\_link\_tag, [Coding Link to a CSS
File](#coding_link_stylesheet_link_tag)

symbols

Ruby, [Symbols](#ruby_symbol)

### T

TDD (see test-driven development)

templates, [Creating HTML Dynamically with erb](#dynamische_webseiten),
[Layouts](#erb_layouts), [Templates](#templates)

(see also erb)

(see also layouts)

(see also views)

Test

environment, [Environment (Development)](#arbeits-umgebung-development)

test-driven development (TDD), [Tests](#testing)

tests, [Tests](#testing)

fixtures, [Example for a User in a Web Shop](#testing_beispiel_webshop),
[Fixtures](#testing_fixtures)

functional, [Functional
Tests](#testing_beispiel_webshop_functional_tests)

setup, [Functional Tests](#testing_beispiel_webshop_functional_tests)

teardown, [Functional Tests](#testing_beispiel_webshop_functional_tests)

integration, [Integration Tests](#integration_testing)

unit, [Unit Tests](#testing_beispiel_webshop_unit_tests)

text

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

time

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

times()

Ruby, [Iterators](#iterator)

timestamp

ActiveRecord, [Possible Data Types in ActiveRecord](#idp3632304)

tixtures (see tests)

to\_i()

Ruby, [Converting from One to the Other: Casting](#ruby-casting)

to\_s(), [Programming in an erb File](#erb-programmieren)

Ruby, [Converting from One to the Other: Casting](#ruby-casting),
[Method to\_s for Your Own Classes](#ruby-to_s)

transactions (see ActiveRecord, transactions)

true

Variables, [Boolean Values and nil](#vartype_boolean_und_nil)

### U

Unicorn, [Web Server in Production Mode](#rails_production_webserver)

unit tests (see tests)

until

loops in Ruby, [while and until](#ruby-loops-while-until)

updated\_at

ActiveRecord, [The Attributes id, created\_at and
updated\_at](#idp3572080)

upto()

Ruby, [Method upto](#ruby-upto)

### V

variables

Ruby, [Variables](#ruby_variablen)

global, [Global Variables (\$aaa)](#ruby-global-variables)

instance variables, [Instance Variables
(@aaa)](#ruby-instance-variables)

local, [Local Variables (aaa or \_aaa)](#ruby-local-variables)

view, [Programming in an erb File](#erb-programmieren), [Passing
Instance Variables from a Controller to a
View](#erb_mit_programmierlogik), [Partials](#partials)

views, [Layouts](#erb_layouts)

### W

web API

JSON format, [Access via JSON](#scaffold_json_und_xml), [JSON as
Default](#scaffold_json)

web server

integrated, [Create Rails Project](#rails-projekt-anlegen)

production, [Web Server in Production Mode](#rails_production_webserver)

Webrick, [Create Rails Project](#rails-projekt-anlegen)

while

loops in Ruby, [while and until](#ruby-loops-while-until)

Windows

installation of Ruby on Rails, [Ruby on Rails 4 on
Windows](#rails3-install-windows)

### X

Xcode, [Xcode Installation or Upgrade](#xcode-install)

### Y

yield(), [Layouts](#erb_layouts)
