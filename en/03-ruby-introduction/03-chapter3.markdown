# Ruby Introduction

This book requires basic knowledge of HTML, plus the reader - you, in
other words - should also have a basic understanding of programming.

A couple of years ago I made the mistake of trying to understand Ruby on
Rails without knowing anything about Ruby. Ruby just looked so simple,
so I didn't give it another thought. But because I did not have a basic
understanding of Ruby, I was not able to understand Rails properly. So I
kept shunting it into a virtual corner and carried on working with PHP
instead. One can only feel the magic of Rails after understanding the
basics of Ruby.

The inventor of Ruby, Yukihiro Matsumoto, states in his book “*The Ruby
Programming Language*”^[[1](#ftn.idp1281296)]^ that:

“It is easy to program in Ruby, but Ruby is not a simple language.”

This chapter is a tightrope walk between oversimplification and a degree
of detail that is unnecessary for a Rails newbie. After all, the
objective is not becoming a Ruby guru, but understanding Ruby on Rails.
I am going to elaborate on the most important points. The rest is then
up to you. If you would like to know more about Ruby, then I recommend
the book "The Ruby Programming Language" by David Flanagan and Yukihiro
Matsumoto.

Because Ruby version 2.0 is the way to go we use it. Please take care to
update your current Ruby if you are running older versions. The command
**ruby -v** will print the current running Ruby version:

``` {.screen}
$ ruby -v
ruby 2.0.0p247 (2013-06-27 revision 41674) [x86_64-darwin12.4.0]
$
```

### Warning

The beginning of this chaper is going to be a bit boring. Bear with me.
It is worth it.

## Hello World

Ruby is a scripting language. So it is not compiled and then executed,
but read by an interpreter and then processed line by line.

A simple Ruby program `hello-world.rb`{.filename} consist of the
following line:

``` {.programlisting}
puts 'Hello World!'
```

Use your favorite editor to open a new file with the filename
`hello-world.rb`{.filename} and insert the above line into it. You can
then execute this Ruby program in the command line as follows:

``` {.screen}
$ ruby hello-world.rb
Hello World!
$
```

A program line in a Ruby program does not have to end with a semicolon.
The Ruby interpreter is even so intelligent that is recognizes if a
program line was split over two or more lines for the sake of
readability. I will spare you the corresponding examples and am only
mentioning this so you don't say or think later, "is it okay like this?"

Indenting code is also not necessary. But it does make it much easier to
read for human beings!

## puts and print

If you go looking for examples on Ruby on the Internet, you will find
two typical ways of printing text on the screen:

-   `puts`{.code} Prints a string, followed by a newline.
-   `print`{.code} Prints a string (without newline). If the string
    itself contains a newline, this will be printed as normal.

Example program (an extension of the program
`hello-world.rb`{.filename}):

``` {.programlisting}
puts 'Hello World!'
puts
puts '------------'
print 'Hello World!'
print
puts '------------'
```

On the screen, you will see this:

``` {.screen}
$ ruby hello-world.rb
Hello World!

------------
Hello World!------------
$
```

## Comments

A comment in a Ruby program starts with a `#`{.code}-sign and ends with
a newline. As an example, I can add a comment to the
`hello-world.rb`{.filename} above:

``` {.programlisting}
## Program for displaying "Hello World!"
## by Stefan Wintermeyer

puts 'Hello World!'
```

A comment can also follow a program line:

``` {.programlisting}
## Program for displaying "Hello World!"
## by Stefan Wintermeyer

puts 'Hello World!'  # output
```

A `#`{.code}-sign within strings in inverted commas is not treated as
the start of a comment. Example program:

``` {.programlisting}
## Example program
## by Stefan Wintermeyer

puts 'Hello World!'
puts '############'
puts
puts '1#2#3#4#5#6#'  # Comment on this
```

On the screen, you will see this:

``` {.screen}
$ ruby hello-world.rb
Hello World!
############

1#2#3#4#5#6#
$
```

# Help via ri

When programming, you do not always have a Ruby handbook available.
Fortunately, the Ruby developers thought of this and provided a built-in
help feature in form of the program `ri`{.literal} (of course only if
you have installed the documentation). ri is the abbreviation for
“**R**uby **I**ndex”. The output gets opend in a so called pager (z.B.
**less**). The parameter *`-T`* sets the output directly to stdout.

This is a typical chicken and egg situation. How can I explain the Ruby
help feature, if we are only just getting started with Ruby? So I am
going to jump ahead a little and show you how you can search for
information on the class `String`{.classname}:

``` {.screen}
$ ri String
String < Object

------------------------------------------------------------------------------
Includes:
Comparable (from ruby site)

(from ruby site)
------------------------------------------------------------------------------


Rake extension methods for String.

A String object holds and manipulates an arbitrary sequence of bytes,
typically representing characters. String objects may be created using
String::new or as literals.

Because of aliasing issues, users of strings should be aware of the methods
that modify the contents of a String object.  Typically, methods with
names ending in ``!'' modify their receiver, while those without a ``!''
return a new String.  However, there are exceptions, such as
String#[]=.
------------------------------------------------------------------------------
[...]
$
```

If we are looking for information on a specific method (chicken-egg!),
then we can also use `ri`{.literal}. Let's take `gsub`{.methodname} as
an example. This is a method for replacing parts of a
`String`{.classname} (that is useful now and again).

``` {.screen}
$ ri String.size
= String.size

(from ruby site)
------------------------------------------------------------------------------
  str.size     -> integer

------------------------------------------------------------------------------

Returns the character length of str.

$
```

The program **ri** always prints the output in the pager program defined
by the shell (for example **less**). You can also use the command option
**-T** to output everything directly to STDOUT. In the book I am going
to be using both variations.

## irb

irb stands for “**I**nteractive **R**u**b**y” and is a kind of sandbox
where you can play around with Ruby at your leisure. irb is launched by
entering **irb** on the shell and ends if you enter **exit**.

An example is worth a thousand words:

``` {.screen}
$ irb --simple-prompt
>> puts 'Hello World!'
Hello World!
=> nil
>> exit
$
```

### Note

I use **irb --simple-prompt** to generate shorter lines which make it
easier to read this book on mobile devises.

In this chapter, we develop many examples within irb. It is so
wonderfully quick and easy.

## Comments in irb

Having comments within `irb`{.literal} would obviously rarely make sense
because code developed in `irb`{.literal} is more or less code for the
bin. But within this book, we occasionally use comments even in
`irb`{.literal} to make things clearer. You can copy these comments
along with everything else and insert them into the `irb`{.literal}
without any problems, or you can simply omit them.

## Ruby is Object-Oriented

Ruby only knows objects. Everything is an object (sounds almost like
Zen). Every object is an instance of a class. You can find out the class
of an object via the method `.class`{.methodname}.

An object in Ruby is encapsulated and can only be reached from the
outside via the methods of the corresponding object. What does this
mean? I cannot change any property of an object directly from the
outside. The corresponding object has to offer a method with which I can
do so.

### Note

Please do not panic if you have no idea what a class and an object is. I
won't tell anyone and you can still work with it just fine without
worrying too much. This topic alone could fill whole volumes. Roughly
speaking, an object is a container for something and a method changes
something in that container.

Please go on reading and have a look at the examples. The puzzle will
gradually get clearer.

## Methods

In other programming languages, the terms you would use for Ruby methods
would be: functions, procedures, subroutines and of course methods.

### Note

Here we go with the oversimplification. We can not compare non-Object
oriented programming languages with OO onces. Plus there are two kinds
of methods (class methods and instance methods). At this point, I do not
want to make it too complicated and am simply ignoring this "fine"
distinctions for now.

At this point you start looking for a good example, but all you can
think of are silly ones. The problem is the premisse that we are only
allowed to use knowledge that has already been described previously in
this book.

So let's assume that we use the following code sequence repeatedly - for
whatever reason:

``` {.screen}
$ irb --simple-prompt
>> puts 'Hello World!'
Hello World!
=> nil
>> puts 'Hello World!'
Hello World!
=> nil
>> puts 'Hello World!'
Hello World!
=> nil
>> exit
$
```

So we want to output the string “Hello World!” three times in a row. As
this makes our daily work routine much longer, we are now going to
define a method (with the meaningless name `three_times`{.methodname}),
with which this can all be done in one go.

### Important

Names of methods are always written in lower case.

``` {.screen}
$ irb --simple-prompt
>> def three_times
>>   puts 'Hello World!'
>>   puts 'Hello World!'
>>   puts 'Hello World!'
>> end
=> nil
>> three_times
Hello World!
Hello World!
Hello World!
=> nil
>> exit
$
```

When defining a method, you can define required parameters and use them
within the method. This enables us to create a method to which we pass a
string as parameter and we can then output it three times.

``` {.screen}
$ irb --simple-prompt
>> def three_times(value)
>>   puts value
>>   puts value
>>   puts value
>> end
=> nil
>> three_times('Hello World!')
Hello World!
Hello World!
Hello World!
=> nil
>>
```

Incidentally, you can omit the brackets when calling the method.

``` {.screen}
>> three_times 'Hello World!'
Hello World!
Hello World!
Hello World!
=> nil
>>
```

### Tip

Ruby gurus and would-be gurus are going to turn up their noses on the
subject of “unnecessary” brackets in your programs and will probably
pepper you with more or less stupid comments with comparisons to Java
and other programming languages.

There is one simple rule in the Ruby community: the fewer brackets, the
cooler you are! `;-)`{.literal}

But you won't get a medal for using fewer brackets. Decide for yourself
what makes you happy.

If you do not specify a parameter with the above method, you will get
the error message:
“`wrong number of arguments (0 for       1)`{.literal}”:

``` {.screen}
>> three_times
ArgumentError: wrong number of arguments (0 for 1)
 from (irb):1:in `three_times'
 from (irb):7
 from /Users/xyz/.rvm/rubies/ruby-2.0.0-p247/bin/irb:16:in `<main>'
>> exit
$
```

You can give the variable `value`{.varname} a default value and then you
can also call the method without parameter:

``` {.screen}
$ irb --simple-prompt
>> def three_times(value = 'blue')
>>   puts value
>>   puts value
>>   puts value
>> end
=> nil
>> three_times('Hello World!')
Hello World!
Hello World!
Hello World!
=> nil
>> three_times
blue
blue
blue
=> nil
>> exit
$
```

## Classes

A class is a collection of methods. The name of a class always starts
with an upper case letter. Let's assume that the method belongs to the
new class `This_and_that`{.classname}. It would then be defined as
follows in a Ruby program:

``` {.programlisting}
class This_and_that
  def three_times
    puts 'Hello World!'
    puts 'Hello World!'
    puts 'Hello World!'
  end
end
```

Let's play it through in `irb`{.literal}:

``` {.screen}
$ irb --simple-prompt
>> class This_and_that
>>   def three_times
>>     puts 'Hello World!'
>>     puts 'Hello World!'
>>     puts 'Hello World!'
>>   end
>> end
=> nil
>>
```

Now we try to call the method `three_times`{.methodname}:

``` {.screen}
>> This_and_that.three_times
NoMethodError: undefined method `three_times' for This_and_that:Class
 from (irb):8
 from /Users/xyz/.rvm/rubies/ruby-2.0.0-p247/bin/irb:16:in `<main>'
>>
```

This results in an error message, because `This_and_that`{.classname} is
a class and not an instance. As we are working with instance methods, it
only works if we have first created a new object (a new instance) of the
class `This_and_that`{.classname} with the class method
`new`{.methodname}:

``` {.screen}
>> abc = This_and_that.new
=> #<This_and_that:0x007f819412c768>
>> abc.three_times
Hello World!
Hello World!
Hello World!
=> nil
>> exit
$
```

I will explain the difference between instance and class methods in more
detail in [the section called “Class Methods and Instance
Methods”](#class_methods_vs_instance_methods "Class Methods and Instance Methods").
Another chicken and egg problem.

# Private Methods

Quite often it makes sense to only call a method within its own class or
own instance. Such methods are referred to as private methods (as
opposed to public methods), and they are listed below the keyword
`private`{.literal} within a class.

irb example:

``` {.screen}
$ irb --simple-prompt
>> class Example
>>   def a
>>     puts 'a'
>>   end
>>   private
>>   def b
>>     puts 'b'
>>   end
>> end
=> nil
>> test = Example.new
=> #<Example:0x007ff1e10756b8>
>> test.a
a
=> nil
>> test.b
NoMethodError: private method `b' called for #<Example:0x007ff1e10756b8>
 from (irb):12
 from /Users/xyz/.rvm/rubies/ruby-2.0.0-p247/bin/irb:16:in `<main>'
>> exit
$
```

# Method initialize()

If a new instance is created (by calling the method `new`{.methodname}),
the method that is processed first and automatically is the method
`initialize`{.methodname}. The method is automatically a private method,
even if it not listed explicitly under `private`{.literal}.

irb example:

``` {.screen}
$ irb --simple-prompt
>> class Room
>>   def initialize
>>     puts 'abc'
>>   end
>> end
=> nil
>> kitchen = Room.new
abc
=> #<Room:0x007faec50402d8>
>> exit
$
```

The instance `kitchen`{.code} is created with `Room.new`{.code} and the
method `initialize`{.methodname} is processed automatically.

The method `new`{.methodname} accepts the parameters specified for the
method `initialize`{.methodname}:

``` {.screen}
$ irb --simple-prompt
>> class Example
>>   def initialize(value)
>>     puts value
>>   end
>> end
=> nil
>> test = Example.new('Hello World!')
Hello World!
=> #<Example:0x007fa9f98ba240>
>> exit
$
```

## return

puts is nice to demonstrate an example in this book but normally you
need a way to return the result of something. The `return`{.code}
statement can be used for that:

``` {.screen}
$ irb --simple-prompt
>> def area_of_a_cirle(radius)
>>   pi = 3.14
>>   area = pi * radius * radius
>>   return area
>> end
=> nil
>> area_of_a_cirle(10)
=> 314.0
>> exit
$
```

But it wouldn't be Ruby if you couldn't do it shorter. You can simply
skip return:

``` {.screen}
$ irb --simple-prompt
>> def area_of_a_cirle(radius)
>>   pi = 3.14
>>   area = pi * radius * radius
>>   area
>> end
=> nil
>> area_of_a_cirle(10)
=> 314.0
>> exit
$
```

You can actually even skip the last line because Ruby returns the value
of the last expression as a default:

``` {.screen}
$ irb --simple-prompt
>> def area_of_a_cirle(radius)
>>   pi = 3.14
>>   area = pi * radius * radius
>> end
=> nil
>> area_of_a_cirle(10)
=> 314.0
>> exit
$
```

`return`{.code} is sometimes useful to make a method easier to read. But
you don't have to use it in case you feel more comfortable with out.

## Inheritance

A class can inherit from another class. When defining the class, the
parent class must be added with a `<`{.literal} (smaller than) sign:

``` {.programlisting}
class Example < ParentClass
```

Rails makes use of this approach very frequently (otherwise I would not
be bothering you with it).

In the following example, we define the class `Abc`{.classname} and
which contains the methods `a`{.methodname}, `b`{.methodname} and
`c`{.methodname}. Then we define a class `Abcd`{.classname} and let it
inherit the class `Abc`{.classname} and add a new method
`d`{.methodname}. The new instances `example1`{.varname} and
`example2`{.varname} are created with the Class-Methods new and show
that `example2`{.varname} has access to the methods `a`{.methodname},
`b`{.methodname}, `c`{.methodname} and `d`{.methodname} but
`example1`{.varname} only to `a`{.methodname}, `b`{.methodname} and
`c`{.methodname}.

``` {.screen}
$ irb --simple-prompt
>> class Abc
>>   def a
>>     'a'
>>   end
>>   def b
>>     'b'
>>   end
>>   def c
>>     'c'
>>   end
>> end
=> nil
>> class Abcd < Abc
>>   def d
>>     'd'
>>   end
>> end
=> nil
>> example1 = Abc.new
=> #<Abc:0x007fb463023928>
>> example2 = Abcd.new
=> #<Abcd:0x007fb46302f020>
>> example2.d
=> "d"
>> example2.a
=> "a"
>> example1.d
NoMethodError: undefined method `d' for #<Abc:0x007fb463023928>
 from (irb):21
 from /Users/xyz/.rvm/rubies/ruby-2.0.0-p247/bin/irb:16:in `<main>'
>> example1.a
=> "a"
>> exit
$
```

## Tip

It is important to read the Error-Messages. They tell you what happend
and where to search for the problem. In this example Ruby said that
there is an
`` undefined method `d' for             #<Abc:0x007fb463023928> ``{.code}.
With that information you know that the Class Abc is missing the method
d which you were trying to use.

# Class Methods and Instance Methods

There are two important kinds of methods: class methods and instance
methods.

You now already know what a class it. And an instance of such a class is
created via the class method `new`{.methodname}. A class method can only
be called in connection with the class (for example, the method
`new`{.methodname} is a class method). An instance method is a method
that only works with an instance. So you cannot apply the method
`new`{.methodname} to an instance.

Let's first try to call an instance method as class method:

``` {.screen}
$ irb --simple-prompt
>> class Knowledge
>>   def pi
>>     3.14
>>   end
>> end
=> nil
>> Knowledge.pi
NoMethodError: undefined method `pi' for Knowledge:Class
 from (irb):6
 from /Users/xyz/.rvm/rubies/ruby-2.0.0-p247/bin/irb:16:in `<main>'
>>
```

So that does not work. Well, then let's create a new instance of the
class and try again:

``` {.screen}
>> example = Knowledge.new
=> #<Knowledge:0x007fd81b0866f0>
>> example.pi
=> 3.14
>> exit
$
```

Now we just need to find out how to define a class method. Hardcore
Rails gurus would now whisk you away into the depths of the source code
and pick out examples from the ActiveRecord. I will spare you this and
show an abstract example:

``` {.screen}
$ irb --simple-prompt
>> class Knowledge
>>   def self.pi
>>     3.14
>>   end
>> end
=> nil
>> Knowledge.pi
=> 3.14
>>
```

And the proof to the contrary:

``` {.screen}
>> example = Knowledge.new
=> #<Knowledge:0x007fb339078d90>
>> example.pi
NoMethodError: undefined method `pi' for #<Knowledge:0x007fb339078d90>
 from (irb):8
 from /Users/xyz/.rvm/rubies/ruby-2.0.0-p247/bin/irb:16:in `<main>'
>> exit
$
```

There are different notations for defining class methods. The two most
common ones are:

-   `self.xyz`{.code}

    ``` {.programlisting}
    # Variant 1
    # with self.xyz
    #
    class Knowledge
      def self.pi
        3.14
      end
    end
    ```

-   `class << self`{.code}

    ``` {.programlisting}
    # Variant 2
    # with class << self
    #
    class Knowledge
      class << self
        def pi
          3.14
        end
      end
    end
    ```

The result is always the same.

Of course you can use the same methodname for a class and an instance
method. Obviously that doesn't make any code easier to understand. Here
is an example with `pi`{.methodname} as a class and an instance method:

``` {.screen}
$ irb --simple-prompt
>> class Knowledge
>>   def pi
>>     3.14
>>   end
>>   def self.pi
>>     3.14159265359
>>   end
>> end
=> nil
>> Knowledge.pi
=> 3.14159265359
>> example = Knowledge.new
=> #<Knowledge:0x007f8ccc8786a0>
>> example.pi
=> 3.14
>> exit
$
```

## List of All Instance Methods

You can read out all defined methods for a class with the method
`instance_methods`{.methodname}. We try it out with the class
`This_and_that`{.classname} (first we create it once again in the irb):

``` {.screen}
$ irb --simple-prompt
>> class Knowledge
>>   def pi
>>     3.14
>>   end
>> end
=> nil
>> Knowledge.instance_methods
=> [:pi, :nil?, :===, :=~, :!~, :eql?, :hash, :<=>, :class, :singleton_class, :clone, :dup, :initialize_dup, :initialize_clone, :taint, :tainted?, :untaint, :untrust, :untrusted?, :trust, :freeze, :frozen?, :to_s, :inspect, :methods, :singleton_methods, :protected_methods, :private_methods, :public_methods, :instance_variables, :instance_variable_get, :instance_variable_set, :instance_variable_defined?, :instance_of?, :kind_of?, :is_a?, :tap, :send, :public_send, :respond_to?, :respond_to_missing?, :extend, :display, :method, :public_method, :define_singleton_method, :object_id, :to_enum, :enum_for, :==, :equal?, :!, :!=, :instance_eval, :instance_exec, :__send__, :__id__]
>>
```

But that is much more than we have defined! Why? It's because Ruby gives
every new class a basic set of methods by default. If we only want to
list the methods that we have defined, then we can do it like this:

``` {.screen}
>> Knowledge.instance_methods(false)
=> [:pi]
>> exit
$
```

## Variables

You already know that everything in Ruby is an object. So a variable
must also be an object.

## Naming Conventions

Normal variables are written in lower case. Constants start with an
upper case letter.

### Important

A constant can also be overwritten with a new value in Ruby (but you
will get a warning message). So please do not rely on the constancy of a
constant.

You are on the safe side if you are using only ASCII symbols. But with
Ruby 1.9 and the right encoding, you could also use special characters
(for example German umlauts) more or less without any problems in a
variable name. But if you want to be polite towards other programmers
who probably do not have those characters directly available on their
keyboards, it is better to use only pure ASCII.

## Strings

Let's experiment a little bit in the `irb`{.literal}. The method
`.class`{.methodname} tells us which class we are dealing with.

``` {.screen}
$ irb --simple-prompt
>> a = 'First test'
=> "First test"
>> a.class
=> String
```

That was easy. As you can see, Ruby “automagically” creates an object of
the class `String`{.classname}. We could also do this by explicitly
calling the method `new`{.methodname}:

``` {.screen}
>> b = String.new('Second test')
=> "Second test"
>> b.class
=> String
```

If we call `String.new`{.code} without a parameter, this also creates an
object of the class `String`{.classname}. But it is an empty String:

``` {.screen}
>> c = String.new
=> ""
>> c.class
=> String
>> exit
$
```

## Single and Double Quotations Marks

## Note

Please note: if we mention single or double quotation marks in the
context of strings, we do not mean typographically correct curly
quotation marks (see
`http://en.wikipedia.org/wiki/Quotation_mark`{.uri}), but the ASCII
symbols referred to as *apostrophe* (`'`{.literal}) or *quotation mark*
(`"`{.literal}).

Strings can be defined either in single quotes or double quotes. There
is a special feature for the double quotes: you can integrate
expressions with the construct `#{}`{.code}. The result is then
automatically inserted in the corresponding place in the string.

Example:

``` {.screen}
$ irb --simple-prompt
>> a = 'blue'
=> "blue"
>> b = "Color: #{a}"
=> "Color: blue"
>> b.class
=> String
>> exit
$
```

If the result of the expression is not a string, Ruby tries to apply the
method `to_s`{.methodname} in order to convert the value of the object
into a string.

## Integers

## Fixnum and Bignum

`Fixnum`{.classname} and `Bignum`{.classname} are `Integer`{.classname}
classes. A `Fixnum`{.classname} is an `Integer`{.classname} that can be
saved in a “Word”.^[[2](#ftn.idp2247056)]^If a `Fixnum`{.classname} gets
bigger, it automatically becomes a `Bignum`{.classname}. Here is an
example where a becomes larger and by that becomes a
`Bignum`{.classname}.

``` {.screen}
$ irb --simple-prompt
>> 20.class
=> Fixnum
>> a = 20
=> 20
>> a.class
=> Fixnum
>> a = a * 5555555555
=> 111111111100
>> a.class
=> Fixnum
>> a = a * 5555555555
=> 617283950493827160500
>> a.class
=> Bignum
>> exit
$
```

## Floats

`Float`{.classname} is a class for real numbers (“floating point
numbers”). The decimal separator is a point (not a comma, as in some
European countries).

``` {.screen}
$ irb --simple-prompt
>> a = 20.424
=> 20.424
>> a.class
=> Float
>> 42.2.class
=> Float
>> exit
$
```

## Simple Calculations

Calculating with integers and floats is so easy that you can describe
everything with just a few lines of code in the `irb`{.literal}:

``` {.screen}
$ irb --simple-prompt
>> a = 10
=> 10
>> b = 23
=> 23
>> a + b
=> 33
>> (a + b).class
=> Fixnum
>> c = a + b
=> 33
>> c.class
=> Fixnum
>> d = 3.14
=> 3.14
>> e = a + d
=> 13.14
>> e.class
=> Float
>> a * b
=> 230
>> (a * b).class
=> Fixnum
>> (a * b * d).class
=> Float
>> exit
$
```

# Boolean Values and nil

For boolean values (`true`{.code} and `false`{.code}) and for
`nil`{.code} (no value) there are separate classes:

``` {.screen}
$ irb --simple-prompt
>> true.class
=> TrueClass
>> false.class
=> FalseClass
>> nil.class
=> NilClass
>> exit
$
```

`nil`{.literal} (no value ^[[3](#ftn.idp2283568)]^) is, by the way, the
contraction of the Latin word *nihil* (nothing ^[[4](#ftn.idp2285664)]^)
or, if you look at it in terms of programming history, the term derives
from “*not in list*” from the legacy of the programming language Lisp
(the name is an acronym of *List Processing*).

## Scope of Variables

Variables have a different scope (or “reach”) within the Ruby
application and therefore also within a Ruby on Rails application.

### Important

You need to keep this scope in mind while programming. Otherwise you can
end up with odd effects.

## Local Variables (aaa or \_aaa)

Local variables either start with a lower case letter or an underscore
(`_`{.literal}). Their scope is limited to the current environment (for
example the current method). The follwing example defines two methods
which use the same local variable radius. Because they are local they
don't interact with each other:

``` {.screen}
$ irb --simple-prompt
>> def area(radius)
>>   3.14 * radius * radius
>> end
=> nil
>> def circumference(radius)
>>   2 * 3.14 * radius
>> end
=> nil
>> area(10)
=> 314.0
>> circumference(1)
=> 6.28
>> exit
$
```

## Global Variables (\$aaa)

A global variable starts with a `$`{.literal}-sign and is accessible in
the entire programm. Example:

``` {.screen}
$ irb --simple-prompt
>> $value = 10
=> 10
>> puts $value
10
=> nil
>> def example
>>   $value = 20
>> end
=> nil
>> puts $value
10
=> nil
>> example
=> 20
>> puts $value
20
=> nil
>> exit
$
```

Global variables are used very rarely.

## Instance Variables (@aaa)

Instance variables (“**A**ttributes”, hence the `@`{.literal}) only
apply within a class, but everywhere in it – a mini version of global
variables, so to speak. Unlike global variables, you will find instance
variables all over the place in a Rails application. Let's tackle them
in form of an example program with the name `color.rb`{.filename}:

``` {.programlisting}
class Wall
  def initialize
    @color = 'white'
  end

  def color
    @color
  end

  def paint_it(value)
    @color = value
  end
end

my_wall = Wall.new
puts my_wall.color

my_wall.paint_it('red')
puts my_wall.color
```

If you start this program, the following output will appear:

``` {.screen}
$ ruby color.rb
white
red
$
```

In the method `initialize`{.methodname} we set the instance variable
`@color`{.varname} to the value “white”. The method
`paint_it(value)`{.methodname} changes this instance variable.

With the method `color`{.methodname} we can access the value of
`@color`{.varname} outside of the instance. This kind of method is
called a setter method.

## Methods Once Again

In order to keep the amount of chicken and egg problems in this chapter
at a manageable level, we need to go back to the topic Methods and
combine what we have learned so far.

# Getters and Setters

As instance variables (“attributes”) only exist within the relevant
instance, you always need to write a “getter” method for exporting such
a variable. If we define a class `Room`{.classname} that has the
instance variables `@doors`{.varname} and `@windows`{.varname} (for the
number of doors and windows in the room), then we can create the getter
methods `doors`{.methodname} und `windows`{.methodname} (example program
`room.rb`{.filename}):

``` {.programlisting}
class Room
  def initialize
    @doors  = 1
    @windows = 1
  end

  def doors
    @doors
  end

  def windows
    @windows
  end
end

kitchen = Room.new

puts "D: #{kitchen.doors}"
puts "W: #{kitchen.windows}"
```

The execution of the program:

``` {.screen}
$ ruby room.rb
D: 1
W: 1
$
```

As this scenario – wanting to simply return a value in identical form –
is so common, there is already a ready-made getter method for it with
the name `attr_reader`{.methodname}, which you would apply as follows in
the program `room.rb`{.filename}:

``` {.programlisting}
class Room
  def initialize
    @doors  = 1
    @windows = 1
  end

  attr_reader :doors, :windows
end

kitchen = Room.new

puts "D: #{kitchen.doors}"
puts "W: #{kitchen.windows}"
```

`attr_reader`{.methodname} is a method which is called on the
`Room`{.classname} class. That is the reason why we use Symbols (e.g.
:doors and :windows) instead of variables (e.g. @doors and @windows) as
parameter.

## Note

`attr_reader`{.methodname} is a good example for meta programming in
Ruby. When working with Rails, you will frequently come across meta
programming and be grateful for how it works automagically.

If you want to change the number of doors or windows from the outside,
you need a “setter” method. It can be implemented as follows:

``` {.programlisting}
class Room
  def initialize
    @doors  = 1
    @windows = 1
  end

  attr_reader :doors, :windows

  def doors=(value)
    @doors = value
  end

  def windows=(value)
    @windows = value
  end
end

kitchen = Room.new

kitchen.windows = 2

puts "D: #{kitchen.doors}"
puts "W: #{kitchen.windows}"
```

The corresponding output is this:

``` {.screen}
$ ruby room.rb
D: 1
W: 2
$
```

As you can probably imagine, there is of course also a ready-made and
easier way of doing this. Via the setter method
`attr_writer`{.methodname} you can simplify the code of
`room.rb`{.filename} further:

``` {.programlisting}
class Room
  def initialize
    @doors  = 1
    @windows = 1
  end

  attr_reader :doors, :windows
  attr_writer :doors, :windows
end

kitchen = Room.new

kitchen.windows = 2

puts "D: #{kitchen.doors}"
puts "W: #{kitchen.windows}"
```

And (who would have thought!) there is even a method
`attr_accessor`{.methodname} that combines getters and setters. The code
for `room.rb`{.filename} would then look like this:

``` {.screen}
class Room
  def initialize
    @doors  = 1
    @windows = 1
  end

  attr_accessor :doors, :windows
end


kitchen = Room.new

kitchen.windows = 2

puts "D: #{kitchen.doors}"
puts "W: #{kitchen.windows}"
```

## Built-In Methods for String

Most classes already come with a bundle of very useful methods. These
methods are always written after the relevant object, separated by a
point.

Here are a few examples for methods of the class `String`{.classname}.

``` {.screen}
$ irb --simple-prompt
>> a = 'A dog'
=> "A dog"
>> a.class
=> String
>> a.size
=> 5
>> a.downcase
=> "a dog"
>> a.upcase
=> "A DOG"
>> a.reverse
=> "god A"
>> exit
$
```

With `instance_methods(false)`{.methodname} you can get a list of the
build in methods:

``` {.screen}
$ irb --simple-prompt
>> String.instance_methods(false)
=> [:<=>, :==, :===, :eql?, :hash, :casecmp, :+, :*, :%, :[], :[]=, :insert, :length, :size, :bytesize, :empty?, :=~, :match, :succ, :succ!, :next, :next!, :upto, :index, :rindex, :replace, :clear, :chr, :getbyte, :setbyte, :byteslice, :to_i, :to_f, :to_s, :to_str, :inspect, :dump, :upcase, :downcase, :capitalize, :swapcase, :upcase!, :downcase!, :capitalize!, :swapcase!, :hex, :oct, :split, :lines, :bytes, :chars, :codepoints, :reverse, :reverse!, :concat, :<<, :prepend, :crypt, :intern, :to_sym, :ord, :include?, :start_with?, :end_with?, :scan, :ljust, :rjust, :center, :sub, :gsub, :chop, :chomp, :strip, :lstrip, :rstrip, :sub!, :gsub!, :chop!, :chomp!, :strip!, :lstrip!, :rstrip!, :tr, :tr_s, :delete, :squeeze, :count, :tr!, :tr_s!, :delete!, :squeeze!, :each_line, :each_byte, :each_char, :each_codepoint, :sum, :slice, :slice!, :partition, :rpartition, :encoding, :force_encoding, :valid_encoding?, :ascii_only?, :unpack, :encode, :encode!, :to_r, :to_c]
>> exit
$
```

If you are not sure what one of these methods does you can use **ri** to
look it up:

``` {.screen}
$ ri -T String.size
String.size

(from ruby site)
------------------------------------------------------------------------------
  str.length   -> integer
  str.size     -> integer


------------------------------------------------------------------------------

Returns the character length of str.


$
```

## Method Chaining

You may not think of it straight away, but once you have got used to
working with Ruby, then it makes perfect sense (and is perfectly
logical) to chain different methods.

``` {.screen}
$ irb --simple-prompt
>> a = 'A dog'
=> "A dog"
>> a.upcase.reverse
=> "GOD A"
>> exit
$
```

## Converting from One to the Other: Casting

There is a whole range of useful instance methods for converting
(“casting”) objects from one class to another. First, let's use the
method `.to_s`{.methodname} to convert a `Fixnum`{.classname} to a
`String`{.classname}.

``` {.screen}
$ irb --simple-prompt
>> a = 10
=> 10
>> a.class
=> Fixnum
>> b = a.to_s
=> "10"
>> b.class
=> String
>> exit
$
```

### Note

Incidentally, that is exactly what `puts`{.code} does if you use
`puts`{.code} to output a `Fixnum`{.classname} or a `Float`{.classname}
(for non-strings, it simply implicitly adds the method
`.to_s`{.methodname} and outputs the result).

Now we use the method `.to_i`{.methodname} to change a
`Float`{.classname} to a `Fixnum`{.classname}.

``` {.screen}
$ irb --simple-prompt
>> c = 10.0
=> 10.0
>> c.class
=> Float
>> d = c.to_i
=> 10
>> d.class
=> Fixnum
>> exit
$
```

# Method to\_s for Your Own Classes

You should always integrate a method `to_s`{.methodname}for your own
custom classes, even if it is just for the sake of easier debugging.
Then you can simply output a corresponding object via `puts`{.code}
(`puts`{.code} automatically outputs an object via the method
`to_s`{.methodname}).

Here is an example:

``` {.screen}
$ irb --simple-prompt
>> class Person
>>   def initialize(first_name, last_name)
>>     @first_name = first_name
>>     @last_name = last_name
>>   end
>>   def to_s
>>     "#{@first_name} #{@last_name}"
>>   end
>> end
=> nil
>> sw = Person.new('Stefan', 'Wintermeyer')
=> Stefan Wintermeyer
>> puts sw
Stefan Wintermeyer
=> nil
>> exit
$
```

# Is “+” a Method?

Why is there also a plus symbol in the list of methods for
`String`{.classname}? Let's find out by looking it up in `ri`{.literal}:

``` {.screen}
$ ri -T String.+
String.+

(from ruby site)
------------------------------------------------------------------------------
  str + other_str   -> new_str


------------------------------------------------------------------------------

Concatenation---Returns a new String containing other_str
concatenated to str.

  "Hello from " + self.to_s   #=> "Hello from main"


$
```

hmmm … Let's see what it says for `Fixnum`{.classname}:

``` {.screen}
$ ri -T Fixnum.+
Fixnum.+

(from ruby site)
------------------------------------------------------------------------------
  fix + numeric  ->  numeric_result


------------------------------------------------------------------------------

Performs addition: the class of the resulting object depends on the class of
numeric and on the magnitude of the result.


$
```

Let's have a go and play around with this in `irb`{.literal}. So we
should be able to add the `+`{.methodname} to an object, just as any
other method, separated by a dot and add the second number in brackets
as parameter:

``` {.screen}
$ irb --simple-prompt
>> 10 + 10
=> 20
>> 10+10
=> 20
>> 10.+10
=> 20
>> 10.+(10)
=> 20
>> exit
$
```

Aha! The plus symbol is indeed a method, and this method takes the next
value as parameter. Really we should put this value in brackets, but
thanks to Ruby's well thought-out syntax this is not necessary.

## Can I Overwrite the Method +?

Yes, you can overwrite any method. Logically, this does not make much
sense for methods such as `+`{.methodname}, unless you want to drive
your fellow programmers mad. I am going to show you a little demo in
`irb`{.literal} so you will believe me.

The aim is overwriting the method `+`{.methodname} for
`Fixnum`{.classname}. We want the result of every addition to be the
number 42.

``` {.screen}
$ irb --simple-prompt
>> 10 + 10
=> 20
>> class Fixnum
>>   def +(name, *args, &blk)
>>     42
>>   end
>> end
=> nil
>> 10 + 10
=> 42
>> exit
$
```

First we perform a normal addition. Than we redefine the method
`+`{.methodname} for the class `Fixnum`{.classname}, and after that we
do the calculation again. But this time, with different results.

## if-Condition

An abstract `if`{.literal}-condition looks like this:

``` {.programlisting}
if expression
  program
end
```

The program between the expression and `end`{.code} is executed if the
result of the expression is not `false`{.literal} and not
`nil`{.literal}.

### Note

You can also use a `then`{.code} after the expression:

``` {.programlisting}
if expression then
  program
end
```

The construct for a simple `if`{.literal}-branch in a Ruby program looks
like the following example program:

``` {.programlisting}
a = 10

if a == 10
  puts 'a is 10'
end
```

### Note

The '==' is used to compare two values. Please don't mix it up with the
single '='.

You can try an *expression* really well in `irb`{.literal}:

``` {.screen}
$ irb --simple-prompt
>> a = 10
=> 10
>> a == 10
=> true
>> exit
$
```

## Shorthand

A frequently used shorthand notation of an `if`{.literal}-condition can
be found in the following code:

``` {.programlisting}
a = 10

## long version
##
if a == 10 then
  puts 'a is 10'
end

## short version
##
puts 'a is 10' if a == 10
```

## else

You can probably imagine how this works, but for the sake of
completeness, here is a little example:

``` {.programlisting}
a = 10

if a == 10 then
  puts 'a is 10'
else
  puts 'a is not 10'
end
```

## elsif

Again, most programmers will know what this is all about. Example:

``` {.programlisting}
a = 10

if a == 10 then
  puts 'a is 10'
elsif a == 20 then
  puts 'a is 20'
end
```

## Loops

There are different ways of implementing loops in Ruby. The iterator
variation is used particularly often in the Rails environment.

## while and until

An abstract while loop looks like this:

``` {.programlisting}
while expression do
  program
end
```

### Note

The `do`{.code} that follows the `expression`{.code} is optional. Often
you will also see this:

``` {.programlisting}
while expression
  program
end
```

Here is a practical `irb`{.literal} example:

``` {.screen}
$ irb --simple-prompt
>> i = 0
=> 0
>> while i < 3 do
?>   puts i
>>   i = i + 1
>> end
0
1
2
=> nil
>> exit
$
```

Until loops are built similarly:

``` {.programlisting}
until expression
  program
end
```

Again, here is the corresponding `irb`{.literal} example:

``` {.screen}
$ irb --simple-prompt
>> i = 5
=> 5
>> until i == 0
>>   i = i - 1
>>   puts i
>> end
4
3
2
1
0
=> nil
>> exit
$
```

## Blocks and Iterators

“Block” and “iterator” are some of the favorite words of many Ruby
programmers. Now I am going to show you why.

In the loop

``` {.programlisting}
5.times { |i| puts i }
```

`i`{.varname} is the iterator and `puts i`{.code} is the block.

You can also express the whole thing in the following syntax:

``` {.programlisting}
5.times do |i|
  puts i
end
```

## Iterators

Iterators are just a specific type of method. As you probably know, the
word “*iterate*” means to repeat something. For example, the class
`Fixnum`{.classname} has the iterator `times`{.methodname}. Let's see
what help `ri`{.literal} offers us:

``` {.screen}
$ ri -T Fixnum.times
Fixnum.times

(from ruby site)
Implementation from Integer
------------------------------------------------------------------------------
  int.times {|i| block }  ->  self
  int.times               ->  an_enumerator


------------------------------------------------------------------------------

Iterates block int times, passing in values from zero to int -
1.

If no block is given, an enumerator is returned instead.

  5.times do |i|
    print i, " "
  end

produces:

  0 1 2 3 4


$
```

And it also gives a nice example that we are going to try out in irb:

``` {.screen}
$ irb --simple-prompt
>> 5.times do |i|
?>   puts i
>> end
0
1
2
3
4
=> 5
>> exit
$
```

There is also a single-line notation for small blocks:

``` {.screen}
$ irb --simple-prompt
>> 5.times { |i| puts i }
0
1
2
3
4
=> 5
>> exit
$
```

By the way, an iterator does not necessarily have to pass a variable to
the block:

``` {.screen}
$ irb --simple-prompt
>> 5.times { puts 'example' }
example
example
example
example
example
=> 5
>> exit
$
```

## Blocks

A block is the code that is triggered by an iterator. In the block, you
have access to the local variable(s) passed by the iterator.

## Method upto

Apart from `times`{.methodname} there is also the method
`upto`{.methodname}, for easily implementing a loop. `ri`{.literal}
offers a nice example for this, too:

``` {.screen}
$ ri -T Fixnum.upto
Fixnum.upto

(from ruby site)
Implementation from Integer
------------------------------------------------------------------------------
  int.upto(limit) {|i| block }  ->  self
  int.upto(limit)               ->  an_enumerator


------------------------------------------------------------------------------

Iterates block, passing in integer values from int up to and
including limit.

If no block is given, an enumerator is returned instead.

  5.upto(10) { |i| print i, " " }

produces:

  5 6 7 8 9 10


$
```

## Arrays and Hashes

As in many programming languages, *arrays* and *hashes* are popular
structures in Ruby for storing data.

## Arrays

An array is a list of objects. Let's play around in `irb:`{.literal}

``` {.screen}
$ irb --simple-prompt
>> a = [1,2,3,4,5]
=> [1, 2, 3, 4, 5]
>> a.class
=> Array
>> exit
$
```

That is simple and easy to understand.

Let's see if it also works with strings in the array:

``` {.screen}
$ irb --simple-prompt
>> a = ['Test', 'Banana', 'blue']
=> ["Test", "Banana", "blue"]
>> a.class
=> Array
>> a[1]
=> "Banana"
>> a[1].class
=> String
>> exit
$
```

That also works.

So all that's missing now is an array with a mixture of both. Obviously
that will work, too, because the array stores objects and it does not
matter which kind of objects they are (i.e. `String`{.classname},
`Fixnum`{.classname}, `Float`{.classname}, …). But a little test can't
hurt:

``` {.screen}
$ irb --simple-prompt
>> a = [1, 2.2, 'House', nil]
=> [1, 2.2, "House", nil]
>> a.class
=> Array
>> a[0]
=> 1
>> a[0].class
=> Fixnum
>> a[2]
=> "House"
>> a[2].class
=> String
>> exit
$
```

Next, let's have a look at what the `ri`{.literal} help page says for
`Array`{.classname}:

``` {.screen}
$ ri -T Array
Array < Object

------------------------------------------------------------------------------
Includes:
Enumerable (from ruby site)

(from ruby site)
------------------------------------------------------------------------------
Arrays are ordered, integer-indexed collections of any object. Array indexing
starts at 0, as in C or Java.  A negative index is assumed to be relative to
the end of the array---that is, an index of -1 indicates the last element of
the array, -2 is the next to last element in the array, and so on.
------------------------------------------------------------------------------
Class methods:

  []
  new
  try_convert

Instance methods:

  &
  *
  +
  -
  <<

[...]

$
```

As you can see, arrays can also be created via the method
`new`{.methodname} (like any class). Individual new elements can then be
added at the end of an array via the method `<<`{.methodname}. Here is
the corresponding example:

``` {.screen}
$ irb --simple-prompt
>> a = Array.new
=> []
>> a << 'first item'
=> ["first item"]
>> a << 'second item'
=> ["first item", "second item"]
>> exit
$
```

## Iterator each

You can work your way through an array piece by piece via the method
`each`{.methodname}. Example:

``` {.screen}
$ irb --simple-prompt
>> cart = ['eggs', 'butter']
=> ["eggs", "butter"]
>> cart.each do |item|
?>   puts item
>> end
eggs
butter
=> ["eggs", "butter"]
>> exit
$
```

Once more, `ri`{.literal} provides help and an example in case you
forget how to use `each`{.methodname}:

``` {.screen}
$ ri -T Array.each
Array.each

(from ruby site)
------------------------------------------------------------------------------
  ary.each {|item| block }   -> ary
  ary.each                   -> an_enumerator


------------------------------------------------------------------------------

Calls block once for each element in self, passing that element
as a parameter.

If no block is given, an enumerator is returned instead.

  a = [ "a", "b", "c" ]
  a.each {|x| print x, " -- " }

produces:

  a -- b -- c --


$
```

## Hashes

A “*Hash*” is a list of *key/value pairs*. Here is an example with
strings as keys:

``` {.screen}
$ irb --simple-prompt
>> prices = { 'egg' => 0.1, 'butter' => 0.99 }
=> {"egg"=>0.1, "butter"=>0.99}
>> prices['egg']
=> 0.1
>> prices.count
=> 2
>> exit
$
```

Of course, hashes can store not just strings as objects in the values,
but - as with arrays - also classes that you define yourself (see [the
section called “Arrays”](#ruby_array "Arrays")).

# Symbols

*Symbols* are a strange concept and difficult to explain. But they are
very useful and used frequently, amongst others with hashes. Normally,
variables always create new objects:

``` {.screen}
$ irb --simple-prompt
>> a = 'Example 1'
=> "Example 1"
>> a.object_id
=> 70260036330560
>> a = 'Example 2'
=> "Example 2"
>> a.object_id
=> 70260036391520
>> exit
$
```

In both cases, we have the variable `a`{.varname}, but object ID is
different. We could carry on in this way indefinitely. Each time, it
would generate a different object ID and therefore a new object. In
principle, this is no big deal and entirely logical in terms of object
orientation. But it is also rather a waste of memory space.

A symbol is defined by a colon before the name and cannot store any
values itself, but it always has the same object ID, so it is very well
suited to be a *key*:

``` {.screen}
$ irb --simple-prompt
>> :a.class
=> Symbol
>> :a.object_id
=> 413928
>> exit
$
```

Let's do another little experiment to make the difference clearer. We
use a string object with the content “`white`{.literal}” three times in
a row and then the symbol `:white`{.literal} three times in a row. For
`"white"`{.literal}, a new object is created each time. For the symbol
`:white`{.literal}, only the first time:

``` {.screen}
$ irb --simple-prompt
>> 'white'.object_id
=> 70209583052020
>> 'white'.object_id
=> 70209583082240
>> 'white'.object_id
=> 70209583088920
>> :white.object_id
=> 413928
>> :white.object_id
=> 413928
>> :white.object_id
=> 413928
>> exit
$
```

Using symbols as key for hashes is much more memory efficient:

``` {.screen}
$ irb --simple-prompt
>> colors = { black: '#000000', white: '#FFFFFFFF' }
=> {:black=>"#000000", :white=>"#FFFFFFFF"}
>> puts colors[:white]
##FFFFFFFF
=> nil
>> exit
$
```

You will frequently see symbols in Rails. If you want to find out more
about symbols, go to the help page about the class `Symbol`{.classname}
via **ri Symbol**.

## Iterator each

With the method `each`{.methodname} you can work your way through a
`Hash`{.classname} step by step. Example:

``` {.screen}
$ irb --simple-prompt
>> colors = { black: '#000000', white: '#FFFFFFFF' }
=> {:black=>"#000000", :white=>"#FFFFFFFF"}
>> colors.each do |key,value|
?>   puts "#{key} #{value}"
>> end
black #000000
white #FFFFFFFF
=> {:black=>"#000000", :white=>"#FFFFFFFF"}
>> exit
$
```

Again, **ri** offers help and an example, in case you cannot remember
one day how to use `each`{.methodname}:

``` {.screen}
$ ri -T Hash.each
Hash.each

(from ruby site)
------------------------------------------------------------------------------
  hsh.each      {| key, value | block } -> hsh
  hsh.each_pair {| key, value | block } -> hsh
  hsh.each                              -> an_enumerator
  hsh.each_pair                         -> an_enumerator


------------------------------------------------------------------------------

Calls block once for each key in hsh, passing the key-value pair
as parameters.

If no block is given, an enumerator is returned instead.

  h = { "a" => 100, "b" => 200 }
  h.each {|key, value| puts "#{key} is #{value}" }

produces:

  a is 100
  b is 200


$
```

## Miscellaneous

## Range

The class `Range`{.classname} represents an interval. The start and end
points of the interval are defined enclosed in normal brackets and
separated by two dots in between them. Here is an example in which we
use a range like an iterator with `each`{.methodname}:

``` {.screen}
$ irb --simple-prompt
>> (0..3)
=> 0..3
>> (0..3).class
=> Range
>> (0..3).each do |i|
?>   puts i
>> end
0
1
2
3
=> 0..3
>>
```

Via the method `to_a`{.methodname} you can generate an array from a
`Range`{.classname}:

``` {.screen}
>> (0..3).to_a
=> [0, 1, 2, 3]
>>
```

A range can be generated from objects of any type. Important is only
that the objects can be compared via `<=>`{.methodname} and use the
method `succ`{.methodname} for counting on to the next value. So you can
also use Range to represent letters:

``` {.screen}
>> ('a'..'h').to_a
=> ["a", "b", "c", "d", "e", "f", "g", "h"]
>>
```

As alternative notation, you may sometimes come across
`Range.new()`{.methodname}. In this case, the start and end points are
not separated by two dots, but by a comma. This is what it looks like:

``` {.screen}
>> (0..3) == Range.new(0,3)
=> true
>> exit
$
```

\
 \* \* \* \* \*

^[[1](#idp1281296)]^The book is highly recommended for anyone who wants
to understand Ruby. David Flanagan did great work together with Yukihiro
Matsumoto (a.k.a. Matz).

^[[2](#idp2247056)]^If you do not know what a “Word” is: never mind.

^[[3](#idp2283568)]^`http://en.wikipedia.org/wiki/Nil`{.uri}

^[[4](#idp2285664)]^`http://www.thefreedictionary.com/nil`{.uri}
