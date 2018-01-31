# Description

Dashing widget to display a random cute picture from http://reddit.com/r/aww

The display of the widget is heavily based on the Image widget, however it does not prepend the src with 'assets' which allows for external images.

# Settings

You can set a placeholder image in the event that reddit is down, or otherwise unresponse.  This is set at the top of random_aww.rb as follows:

    placeholder = '/assets/nyantocat.gif'

This can be an image in /assets/images, or a full path to a remotely hosted image.

# Usage

To use this widget, copy random_aww.html, random_aww.coffee, and random_aww.scss into the /widgets/random_aww directory. Put the random_aww.rb file in your /jobs folder.

To include the widget in a dashboard, add the following snippet to the dashboard layout file:

    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="aww" data-view="RandomAww"></div>
    </li>

# Preview

![Preview](http://i.imgur.com/23pkDiz.png)