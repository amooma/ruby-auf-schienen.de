# Ruby on Rails 4.1 Install How-to

This chapter's installation methods are intended for a development systems.
If you are looking for instructions on installing a web server in the
production system, please have a look at [Chapter 16, *Web Server in
Production Mode*](#rails_production_webserver "Chapter 16. Web Server in
Production Mode").

Both types of installations are very different.

## RVM

There are a couple of different ways to install Ruby. My favorite choice
is RVM. There are two main reasons for installing a Ruby on Rails system
with RVM (Ruby Version Manager):

-   In case you don't have root privileges on the system. In that case,
    you have no other option.
-   You want to run several Rails systems that are separated cleanly,
    and perhaps also separate Ruby versions. This can be easily done
    with RVM on the Linux system. Then you can run Ruby 2.0.0 with Rails
    3.2 and in parallel Ruby 2.1.0 with Rails 4.1 on the same computer.

Detailled information about RVM can be found on the RVM homepage at
`https://rvm.io/`{.uri}.

## Debian 7.4 (Wheezy)

This description assumes that you have a freshly installed Debian GNU/Linux
7.4 (Wheezy). You will find an ISO image for the installation at
`http://www.debian.org`{.uri}. I recommend the approximately 250 MB net
installation CD image. For instructions on how to install Debian-GNU/Linux,
please go to `http://www.debian.org/distrib/netinst`{.uri}.

If you have root rights on the target system, you can use the following
commands to ensure that all required programs for a successful
installation of RVM are available. If you do not have root rights, you
have to either hope that your admin has already installed everything you
need, or send them a quick e-mail with the corresponding lines.

First, an update of the package lists:

``` {.screen}
root@debian:~# aptitude update
[...]
root@debian:~#
```

To install RVM you need to have access to a couple of Linux tools.
Chances are good that you already have them installed. But to be sure you
should run the following command:

``` {.screen}
root@debian:~# aptitude -y install aptitude -y install curl
patch bzip2 gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev
libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev
libncurses5-dev automake libtool bison pkg-config libffi-dev
[...]
root@debian:~#
```

Now is a good time to log out as root:

``` {.screen}
root@debian:~# exit
logout
```

Log in with your normal user account (in our case, it's the user
`xyz`{.literal}) and open a Terminal.

RVM, Ruby, and Ruby on Rails can now be installed for the user `xyz`:

``` {.screen}
xyz@debian:~$ curl -sSL https://get.rvm.io | bash -s stable
[...]
xyz@debian:~$ source /home/xyz/.rvm/scripts/rvm
[...]
xyz@debian:~$ rvm install 2.1
[...]
xyz@debian:~$ gem install rails --version '~> 4.1.0'
[...]
xyz@debian:~$
```

Congrats. RVM, Ruby 2.1 and Rails 4.1 are now installed.

## Mac OS X 10.9 ##

Before you start installing Ruby on Rails, you must install the *latest*
Apple Xcode tools on your system. The easiest way is via the Mac App
Store (search for "xcode") or via the website
`https://developer.apple.com/xcode/`{.uri}. Please make sure to install
all the command line tools.

Log in with your normal user account (in our case, it's the user
`xyz`{.literal}) and open a Terminal.

RVM, Ruby, and Ruby on Rails can now be installed for the user `xyz`:

``` {.screen}
$ curl -sSL https://get.rvm.io | bash -s stable
[...]
$ source /Users/xyz/.rvm/scripts/rvm
[...]
$ rvm install 2.1
[...]
$ gem install rails --version '~> 4.1.0'
[...]
$
```

Congrats. RVM, Ruby 2.1 and Rails 4.1 are now installed.

## Windows

At `http://railsinstaller.org/`{.uri} there is a simple, all-inclusive
Ruby on Rails installer for Windows for Ruby and Rails.
Optionally, you can also install SSH and Git.

## After the Installation?

If you have never worked with Ruby before, you should first read
[Chapter 2, *Ruby Basics*](#ruby-grundlagen "Chapter 2. Ruby Basics").
If you are already a Ruby master and want to move on to Rails now, then
I recommend reading [Chapter 3, *First Steps with
Rails*](#erste_schritte_mit_rails "Chapter 3. First Steps with Rails").
