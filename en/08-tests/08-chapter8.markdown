# Tests

## Introduction

I have been programming for 30 years and most of the time I have managed
quite well without test-driven development (TDD). I am not going to be
mad at IT dinosaurs if they decide to just skip this chapter. You can
create Rails applications without tests and are not likely to get any
bad karma as a result (at least, I hope not - but you can never be
entirely sure with the whole karma thing).

But if you should decide to go for TDD, then I can promise you that it
is an enlightenment. The basic idea of TDD is that you write a test for
each programming function to check this function. In the pure TDD
teaching, this test is written before the actual programming. Yes, you
will have a lot more to do initially. But later, you can run all the
tests and see that the application works exactly as you wanted it to.
The read advantage only becomes apparent after a few weeks or months,
when you look at the project again and write an extension or new
variation. Then you can safely change the code and check it still works
properly by running the tests. This avoids a situation where you find
yourself saying "oops, that went a bit wrong, I just didn't think of
this particular problem".

Often, the advantage of TDD already becomes evident when writing a
program. Tests can reveal many careless mistakes that you would
otherwise only have stumbled across much later on.

This chapter is a brief overview of the topic test-driven development
with Rails. If you have tasted blood and want to find out more, you can
dive into the official Rails documentation at
`http://guides.rubyonrails.org/testing.html`{.uri}.

#### Note

TDD is just like driving a car. The only way to learn it is by doing it.

### Example for a User in a Web Shop

Let's start with a user scaffold in an imaginary web shop:

``` {.screen}
$ rails new webshop
  [...]
$ cd webshop
$ rails generate scaffold user login_name first_name last_name birthday:date
      [...]
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
      [...]
      invoke    test_unit
      create      test/controllers/users_controller_test.rb
      invoke    helper
      [...]
      invoke      test_unit
      create        test/helpers/users_helper_test.rb
      [...]
$ rake db:migrate
      [...]
$
```

You already know all about scaffolds (if not, please go and read
[Chapter 5, *Scaffolding and
REST*](#scaffolding "Chapter 5. Scaffolding and REST") first) so you
know what the application we have just created does. The scaffold
created a few tests (they are easy to recognise because the word
`test`{.code} is in the file name).

The complete test suite of a Rails project is processed with the command
**rake test**. Let's have a go and see what a test produces at this
stage of development:

``` {.screen}
$ rake test
Run options: --seed 23117

## Running tests:

.......

Finished tests in 0.696922s, 10.0442 tests/s, 18.6535 assertions/s.

7 tests, 13 assertions, 0 failures, 0 errors, 0 skips
$
```

The output
"`7 tests, 13 assertions, 0 failures, 0 errors, 0     skips`{.literal}"
looks good. By default, a test will run correctly in a standard
scaffold.

Let's now edit the `app/models/user.rb`{.filename} and insert a few
validations (if these are not entirely clear to you, please read [the
section called “Validation”](#activerecord_validation "Validation")):

``` {.programlisting}
class User < ActiveRecord::Base
  validates :login_name,
            presence: true,
            length: { minimum: 10 }

  validates :last_name,
            presence: true
end
```

Then we execute **rake test** again:

``` {.screen}
$ rake test
Run options: --seed 51265

## Running tests:

F.....F

Finished tests in 0.178619s, 39.1896 tests/s, 55.9851 assertions/s.

  1) Failure:
UsersControllerTest#test_should_create_user [/Users/stefan/webshop/test/controllers/users_controller_test.rb:20]:
"User.count" didn't change by 1.
Expected: 3
  Actual: 2

  2) Failure:
UsersControllerTest#test_should_update_user [/Users/stefan/webshop/test/controllers/users_controller_test.rb:39]:
Expected response to be a <redirect>, but was <200>

7 tests, 10 assertions, 2 failures, 0 errors, 0 skips
$
```

Boom! This time we have "`2 failures`{.literal}". The error happens in
the "`should create user`{.literal}" and the
"`should update user`{.literal}". The explanation for this is in our
validation. The example data created by the scaffold generator went
through in the first **rake test** (without validation). The errors only
occurred the second time (with validation).

This example data is created as *fixtures* in YAML format in the
directory `test/fixtures/`{.filename}. Let's have a look at the example
data for `User`{.classname} in the file
`test/fixtures/users.yml`{.filename}:

``` {.programlisting}
one:
  login_name: MyString
  first_name: MyString
  last_name: MyString
  birthday: 2013-07-17

two:
  login_name: MyString
  first_name: MyString
  last_name: MyString
  birthday: 2013-07-17
```

There are two example records there that do not fulfil the requirements
of our validation. The `login_name`{.methodname} should have a length of
at least 10. Let's change the `login_name`{.code} in
`test/fixtures/users.yml`{.filename} accordingly:

``` {.programlisting}
one:
  login_name: MyString12
  first_name: MyString
  last_name: MyString
  birthday: 2013-07-17

two:
  login_name: MyString12
  first_name: MyString
  last_name: MyString
  birthday: 2013-07-17
```

Now, a **rake test** completes without any errors again:

``` {.screen}
$ rake test
Run options: --seed 2058

### Running tests:

.......

Finished tests in 0.150927s, 46.3800 tests/s, 86.1344 assertions/s.

7 tests, 13 assertions, 0 failures, 0 errors, 0 skips
$
```

We now know that valid data has to be contained in the
`test/fixtures/users.yml`{.filename} so that the standard test created
via scaffold will succeed. But nothing more. We now change the
`test/fixtures/users.yml`{.filename} to a minimum (for example, we do
not need a `first_name`{.code}):

``` {.programlisting}
one:
  login_name: MyString12
  last_name: Obama

two:
  login_name: MyString12
  last_name: Bush
```

To be on the safe side, let's do another **rake test** after making our
changes (you really can't do that often enough):

``` {.screen}
$ rake test
Run options: --seed 1554

### Running tests:

.......

Finished tests in 0.141682s, 49.4064 tests/s, 91.7548 assertions/s.

7 tests, 13 assertions, 0 failures, 0 errors, 0 skips
$
```

#### Important

All fixtures are loaded into the database when a test is started. You
need to keep this in mind for your test, especially if you use
`uniqueness`{.methodname} in your validation.

### Functional Tests

Let's take a closer look at the point where the original errors
occurred:

``` {.screen}
  1) Failure:
UsersControllerTest#test_should_create_user [/Users/stefan/webshop/test/controllers/users_controller_test.rb:20]:
"User.count" didn't change by 1.
Expected: 3
  Actual: 2

  2) Failure:
UsersControllerTest#test_should_update_user [/Users/stefan/webshop/test/controllers/users_controller_test.rb:39]:
Expected response to be a <redirect>, but was <200>
```

In the `UsersControllerTest`{.code} the User could not be created nor
changed. The controller tests are located in the directory
`test/functional/`{.filename}. Let's now take a good look at the file
`test/controllers/users_controller_test.rb`{.filename}

``` {.programlisting}
require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { birthday: @user.birthday, first_name: @user.first_name, last_name: @user.last_name, login_name: @user.login_name }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { birthday: @user.birthday, first_name: @user.first_name, last_name: @user.last_name, login_name: @user.login_name }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
```

At the beginning, we find a `setup`{.code} instruction:

``` {.programlisting}
setup do
  @user = users(:one)
end
```

These three lines of code mean that for the start of each individual
test, an instance `@user`{.varname} with the data of the item
`one`{.code} from the file `test/fixtures/users.yml`{.filename} is
created. `setup`{.methodname} is a predefined callback that - if present
- is started by Rails before each test. The opposite of
`setup`{.methodname} is `teardown`{.methodname}. A
`teardown`{.methodname} - if present - is called automatically after
each test.

#### Note

For every test (in other words, at each run of **rake test**), a fresh
and therefore empty test database is created automatically. This is a
different database than the one that you access by default via **rails
console** (that is the development database). The databases are defined
in the configuration file `config/database.yml`{.filename}. If you want
to do debugging, you can access the test database with **rails console
test**.

This functional test then tests various web page functions. First,
accessing the index page:

``` {.programlisting}
test "should get index" do
  get :index
  assert_response :success
  assert_not_nil assigns(:users)
end
```

The command `get :index`{.code} accesses the page `/users`{.uri}.
`assert_response :success`{.code} means that the page was delivered. The
line `assert_not_nil assigns(:users)`{.code} ensures that the controller
does not pass the instance variable `@users`{.varname} to the view with
the value `nil`{.code} (`setup`{.methodname} ensures that there is
already an entry in the database).

#### Note

The symbol `:users`{.varname} is used here to make sure that
`@users`{.varname} in the controller class to be tested is used, not
`@users`{.varname} in the test class itself.

Let's look more closely at the two problems from earlier. First,
`should create user`{.code}:

``` {.programlisting}
test "should create user" do
  assert_difference('User.count') do
    post :create, user: { birthday: @user.birthday, first_name: @user.first_name, last_name: @user.last_name, login_name: @user.login_name }
  end

  assert_redirected_to user_path(assigns(:user))
end
```

The block `assert_difference('User.count') do ... end`{.code} expects a
change by the code contained within it. `User.count`{.code} after should
result in +1.

The last line
`assert_redirected_to       user_path(assigns(:user))`{.code} checks if
after the newly created record the redirection to the corresponding view
`show`{.code} occurs.

The second error occurred with `should update       user`{.code}:

``` {.programlisting}
test "should update user" do
  patch :update, id: @user, user: { birthday: @user.birthday, first_name: @user.first_name, last_name: @user.last_name, login_name: @user.login_name }
  assert_redirected_to user_path(assigns(:user))
end
```

Here, the record with the `id`{.code} of the `@user`{.varname} record
was supposed to be updated with the attributes of the `@user`{.varname}
record. Then, the `show`{.code} view for this record was again supposed
to be displayed. Logically, this test could not work either, because a)
the `@user`{.varname} record did not exist in the database and b) it
could not be updated as it was not valid.

Without commenting each individual functional test line by line, it is
becoming clear what these tests do: they execute real queries to the Web
interface (or actually to the controllers) and so they can be used for
testing the controllers.

#### Tip

With **rake test:functionals** you can also run just the functional
tests in the directory `test/functional/`{.filename}.

``` {.screen}
$ rake test:functionals
Run options: --seed 59879

### Running tests:

.......

Finished tests in 0.152887s, 45.7854 tests/s, 85.0301 assertions/s.

7 tests, 13 assertions, 0 failures, 0 errors, 0 skips
$
```

### Unit Tests

For testing the validations that we have entered in
`app/models/user.rb`{.filename}, units tests are more suitable. Unlike
the functional tests, these test only the model, not the controller's
work.

#### Tip

With **rake test**, all tests present in the Rails project are executed.
With **rake test:units**, only the unit tests in the directory
`test/models/`{.filename} are executed.

The unit tests are located in the directory `test/models/`{.filename}.
But a look into the file `test/models/user_test.rb`{.filename} is rather
sobering:

``` {.programlisting}
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
```

By default, scaffold only writes a commented-out dummy test. That is why
**rake test:units** runs through without any content:

``` {.screen}
$ rake test:units
Run options: --seed 30150

### Running tests:



Finished tests in 0.002333s, 0.0000 tests/s, 0.0000 assertions/s.

0 tests, 0 assertions, 0 failures, 0 errors, 0 skips
$
```

A unit test always consists of the following structure:

``` {.programlisting}
test "an assertion" do
  assert something_is_true_or_false
end
```

The word `assert`{.code} already indicates that we are dealing with an
assertion in this context. If this assertion is `true`{.code}, the test
will complete and all is well. If this assertion is `false`{.code}, the
test fails and we have an error in the program (you can specify the
output of the error as string at the end of the assert line).

#### Note

If you have a look around at
<http://guides.rubyonrails.org/testing.html> then you will see that
there are some other `assert`{.code} variations. Here are a few
examples:

-   `assert( boolean`{.code}, *`[msg]`* )
-   `assert_equal( obj1`{.code}, *`obj2`*, *`[msg]`* )
-   `assert_not_equal( obj1`{.code}, *`obj2`*, *`[msg]`* )
-   `assert_same( obj1`{.code}, *`obj2`*, *`[msg]`* )
-   `assert_not_same( obj1`{.code}, *`obj2`*, *`[msg]`* )
-   `assert_nil( obj`{.code}, *`[msg]`* )
-   `assert_not_nil( obj`{.code}, *`[msg]`* )
-   `assert_match( regexp`{.code}, *`string`*, *`[msg]`* )
-   `assert_no_match( regexp`{.code}, *`string`*, *`[msg]`* )

Let's breathe some life into the first test in the
`test/unit/user_test.rb`{.filename}:

``` {.programlisting}
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'a user with no attributes is not valid' do
    user = User.new
    assert !user.save, 'Saved a user with no attributes.'
  end
end
```

This test checks if a newly created `User`{.classname} that does not
contain any data is valid (it should not). As `assert`{.code} only
reacts to `true`{.code}, I placed a"`!`{.code}" before
`User.new.valid?`{.code} to turn the `false`{.code} into a
`true`{.code}, as an empty user cannot be valid.

So a **rake test:units** then completes immediately:

``` {.screen}
$ rake test:units
Run options: --seed 43622

### Running tests:

.

Finished tests in 0.051971s, 19.2415 tests/s, 19.2415 assertions/s.

1 tests, 1 assertions, 0 failures, 0 errors, 0 skips
$
```

Now we integrate two asserts in a test to check if the two fixture
entries in the `test/fixtures/users.yml`{.filename} are really valid:

``` {.programlisting}
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'an empty user is not valid' do
    assert !User.new.valid?, 'Saved an empty user.'
  end

  test "the two fixture users are valid" do
    assert User.new(last_name: users(:one).last_name, login_name: users(:one).login_name ).valid?, 'First fixture is not valid.'
    assert User.new(last_name: users(:two).last_name, login_name: users(:two).login_name ).valid?, 'Second fixture is not valid.'
  end
end
```

Then once more a **rake test:units**:

``` {.screen}
$ rake test:units
Run options: --seed 10228

### Running tests:

..

Finished tests in 0.054056s, 36.9987 tests/s, 55.4980 assertions/s.

2 tests, 3 assertions, 0 failures, 0 errors, 0 skips
$
```

### Fixtures

With *fixtures* you can generate example data for tests. The default
format for this is YAML. The files for this can be found in the
directory `test/fixtures/`{.filename} and are automatically created with
**rails generate scaffold**. But of course you can also define your own
files. All fixtures are loaded anew into the test database by default
with every test.

#### Note

Examples for alternative formats (e.g. CSV) can be found at
<http://api.rubyonrails.org/classes/ActiveRecord/Fixtures.html>.

## Static Fixtures

The simplest variant for fixtures is static data. The fixture for
`User`{.varname} used in [the section called “Example for a User in a
Web Shop”](#testing_beispiel_webshop "Example for a User in a Web Shop")
statically looks as follows:

``` {.programlisting}
one:
  login_name: barak.obama
  last_name: Obama

two:
  login_name: george.w.bush
  last_name: Bush
```

You simple write the data in YAML format into the corresponding file.

## Fixtures with ERB

Static YAML fixtures are sometimes too unintelligent. In these cases,
you can work with ERB (see [the section called “Programming in an erb
File”](#erb-programmieren "Programming in an erb File")).

If we want to dynamically enter today's day 20 years ago for the
birthdays, then we can simply do it with ERB in
`test/fixtures/users.yml`{.filename}

``` {.programlisting}
one:
  login_name: barak.obama
  last_name: Obama
  birthday: <%= 20.years.ago.to_s(:db) %>

two:
  login_name: george.w.bush
  last_name: Bush
  birthday: <%= 20.years.ago.to_s(:db) %>
```

## Integration Tests

Integration tests are tests that work like functional tests but can go
over several controllers and additionally analyze the content of a
generated view. So you can use them to recreate complex workflows within
the Rails application. As an example, we will write an integration test
that tries to create a new user via the Web GUI, but omits the
`login_name`{.varname} and consequently gets corresponding flash error
messages.

A **rake generate scaffold** generates unit and functional tests, but
not integration tests. You can either do this manually in the directory
`test/integration/`{.filename} or more comfortably with **rails generate
integration\_test**. So let's create an integration test:

``` {.screen}
$ rails generate integration_test invalid_new_user_workflow
      invoke  test_unit
      create    test/integration/invalid_new_user_workflow_test.rb
$
```

We now populate this file
`test/integration/invalid_new_user_workflow_test.rb`{.filename} with the
following test:

``` {.programlisting}
require 'test_helper'

class InvalidNewUserWorkflowTest < ActionDispatch::IntegrationTest
  fixtures :all

  test 'try to create a new empty user and check for flash error messages' do
    get '/users/new'
    assert_response :success

    post_via_redirect "/users", user: {:last_name => users(:one).last_name}
    assert_equal '/users', path
    assert_select 'li', "Login name can&#39;t be blank"
    assert_select 'li', "Login name is too short (minimum is 10 characters)"
  end
end
```

The magic of the integration test lies amongst others in the method
`post_via_redirect,`{.methodname} with which you can carry on after a
post in the test. This method is only available within an integration
test.

All integration tests can be executed with **rake test:integration**.
Let's have a go:

``` {.screen}
$ rake test:integration
Run options: --seed 61457

### Running tests:

.

Finished tests in 0.146213s, 6.8393 tests/s, 27.3573 assertions/s.

1 tests, 4 assertions, 0 failures, 0 errors, 0 skips
$
```

The example clearly shows that you can program much without manually
using a web browser to try it out. Once you have written a test for the
corresponding workflow, you can rely in future on the fact that it will
run through and you don't have to try it out manually in the browser as
well.

### rake stats

With **rake stats** you get an overview of your Rails project. For our
example, it looks like this:

``` {.screen}
$ rake stats
+----------------------+-------+-------+---------+---------+-----+-------+
| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
+----------------------+-------+-------+---------+---------+-----+-------+
| Controllers          |    79 |    53 |       2 |       9 |   4 |     3 |
| Helpers              |     4 |     4 |       0 |       0 |   0 |     0 |
| Models               |     8 |     7 |       1 |       0 |   0 |     0 |
| Mailers              |     0 |     0 |       0 |       0 |   0 |     0 |
| Javascripts          |    19 |     0 |       0 |       0 |   0 |     0 |
| Libraries            |     0 |     0 |       0 |       0 |   0 |     0 |
| Controller tests     |    49 |    39 |       1 |       0 |   0 |     0 |
| Helper tests         |     4 |     3 |       1 |       0 |   0 |     0 |
| Model tests          |    13 |    11 |       1 |       0 |   0 |     0 |
| Mailer tests         |     0 |     0 |       0 |       0 |   0 |     0 |
| Integration tests    |    15 |    12 |       1 |       0 |   0 |     0 |
+----------------------+-------+-------+---------+---------+-----+-------+
| Total                |   191 |   129 |       7 |       9 |   1 |    12 |
+----------------------+-------+-------+---------+---------+-----+-------+
  Code LOC: 64     Test LOC: 65     Code to Test Ratio: 1:1.0

$
```

In this project, we have a total of 64 LOC (Lines Of Code) in the
controllers, helpers and models. Plus we have a total of 65 LOC for
tests. This gives us a test relation of 1:1.0, which should be the
principal objective. Logically, this does not say anything about the
quality of tests.

## More on Testing

The most important link on the topic testing is surely the URL
<http://guides.rubyonrails.org/testing.html>. There you will also find
several good examples on this topic. Otherwise, Railscasts
(`http://railscasts.com/episodes?utf8=%E2%9C%93&search=test`{.uri})
offers a few good screencasts on this topic.

No other topic is the subject of much discussion in the Rails community
as the topic testing. There are very many alternative test tools. One
very popular one is RSpec (see <http://rspec.info/>). I am deliberately
not going to discuss these alternatives here, because this book is
mainly about helping you understand Rails, not the thousands of extra
tools with which you can build your personal Rails development
environment.
