# JavaScript

## Introduction

The focus of this chapter is not on explaining JavaScript. The aim is to
show you as a Rails programmer how you can integrate JavaScript in a
Rails application. Correspondingly, the chapters do not explain
JavaScript in detail. I am assuming that you can read and understand
JavaScript. If not, it may be better to skip this chapter. You can
happily get by without JavaScript.

## jQuery

By default, Rails 4 uses the jQuery Javascript library
(`http://jquery.com/`{.uri}). If you do not require this library, you
should delete the following items from the file
`app/assets/javascripts/application.js`{.filename} within the asset
pipeline (see [Chapter 12, *Asset
Pipeline*](#asset_pipeline "Chapter 12. Asset Pipeline")):

``` {.programlisting}
//= require jquery
//= require jquery_ujs
```

With jQuery, you can implement animations and Ajax interactions on your
web page relatively easily.

You will find a good introduction to this topic in the jQuery
documentation at `http://learn.jquery.com/`{.uri}

### CoffeeScript

For many Rails developers, CoffeeScript is the best thing invented since
the introduction of sliced bread. CoffeeScript is a simple programming
language that is converted to JavaScript via the asset pipeline. I am
going to use JavaScript and CoffeeScript in this chapter. If you would
like to know more about CoffeeScript, please look at the CoffeeScript
documentation at `http://coffeescript.org/`{.uri} and as so often there
is also an excellent Railscast on CoffeeScript available at
`http://railscasts.com/episodes/267-coffeescript-basics.`{.uri}

### JavaScript Helpers

For using JavaScript in the view, there are some useful helpers
available.

### javascript\_tag

The easiest way of using JavaScript in a view is
via`javascript_tag`{.code}.

With the following line in the view, you can execute an alert when the
page is accessed:

``` {.programlisting}
<%= javascript_tag "alert('Just an example.')" %>
```

The HTML code generated is this:

``` {.programlisting}
<script type="text/javascript">
//<![CDATA[
alert('Just an example.')
//]]>
</script>
```

### link\_to\_function

The helper `link_to_function`{.code} creates a link whose
`onclick`{.code} handler executes a JavaScript.

Again, here is a example for an alert. The ERB code in the view looks
like this:

``` {.programlisting}
<%= link_to_function "trigger alert", "alert('Just an example.')" %>
```

The generated HTML code:

``` {.programlisting}
<a href="#" onclick="alert('Just an example.'); return false;">trigger alert</a>
```

### button\_to\_function

The helper `button_to_function`{.code} creates a button whose
`onclick`{.code} handler executes a JavaScript.

Once more the example with the alert. The ERB code in the view looks
like this:

``` {.programlisting}
<%= button_to_function "trigger alert", "alert('Just an example.')" %>
```

The generated HTML code:

``` {.programlisting}
<input onclick="alert('Just an example.');" type="button" value="trigger alert" />
```

### Example

The easiest way of explaining how you go about programming with
JavaScript and the asset pipeline in a Rails project is by using a
little example. As always, the main focus is not on creating an
amazingly meaningful application. ;-)

## Changing Form Depending on Input

Let's build a room reservation where you can book a single or double
room and then have to enter either one or two guest names in the same
form. The basic structure:

``` {.screen}
$ rails new hotel
  [...]
$ cd hotel
$ rails generate scaffold reservation start:date end:date room_type:string guest_name1 guest_name2
  [...]
$ rake db:migrate
  [...]
$ rails server
  [...]
```

With this setup we will get a very spartanic
`http://0.0.0.0:3000/reservations/new`{.uri}

Insert hotel_zimmer_basic_form.png
Hotel Room Basic Form

That is not userfriendly. The aim is to display the following page when
you go to `http://0.0.0.0:3000/reservations/new`{.uri}:

Insert hotel_einzelzimmer_form.png
Hotel SingleRoom Form

As soon as the user selects a double room instead of a single, we want a
second name field to appear:

Insert hotel_doppelzimmer_form.png
Hotel DoubleRoom Form

So I am changing two things in the
`app/views/reservations/_form.html.erb`{.filename}:

-   Set the `room_type`{.varname} via a dropdown box.
    `<%= f.select :room_type,             options_for_select(['single room', 'double room'])             %>`{.code}
-   In the div element around the second name, I set an ID
    'second\_name'.
    `<div class="field"             id='second_name'>`{.code}

Here is the whole new code for
`app/views/reservations/_form.html.erb`{.filename}

``` {.programlisting}
<%= form_for(@reservation) do |f| %>
  <% if @reservation.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@reservation.errors.count, "error") %> prohibited this reservation from being saved:</h2>

      <ul>
      <% @reservation.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= f.label :start %><br>
    <%= f.date_select :start %>
  </div>
  <div class="field">
    <%= f.label :end %><br>
    <%= f.date_select :end %>
  </div>
  <div class="field">
    <%= f.label :room_type %><br>
    <%= f.select :room_type, options_for_select(['single room', 'double room']) %>
  </div>
  <div class="field">
    <%= f.label :guest_name1 %><br>
    <%= f.text_field :guest_name1 %>
  </div>
  <div class="field" id='second_name'>
    <%= f.label :guest_name2 %><br>
    <%= f.text_field :guest_name2 %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
```

In the file `app/assets/javascripts/reservations.js.coffee`{.filename} I
define the CoffeeScript code that toggles the element with the ID
`second_name`{.varname} between visible (`show`{.code}) or invisible
(`hide`{.code}) depending on the content of
`reservation_room_type`{.varname}:

``` {.programlisting}
ready = ->
  $('#second_name').hide()
  $('#reservation_room_type').change ->
    room_type = $('#reservation_room_type :selected').text()
    if room_type == 'single room'
      $('#second_name').hide()
    else
      $('#second_name').show()

$(document).ready(ready)
$(document).on('page:load', ready)
```

### Note

In reality, you would surely integrate the guest names in a 1:n
has\_many association, but in this example we just want to demonstrate
how you can change the content of a form via JavaScript.
