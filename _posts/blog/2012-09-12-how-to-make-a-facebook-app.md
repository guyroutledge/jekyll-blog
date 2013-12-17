---
layout: post
title: "How to make a Facebook app"
date: 2012-09-12
tags: Tutorial
categories: blog
---
For reasons better known to myself (and those, I'm not even sure of), I don't really like Facebook. I think it has something to do with me being more of a "stand-back-and-listen" kinda guy rather than a "look-at-me" kinda guy but quite frankly, it's probably because I don't have many friends.

Anyway, pushing that rapidly aside, I do occasionally have to interact with Facebook for client work. And recently that has been in the form of a few Facebook Apps. However, the setup of them has always been a bit frustrating and fraught with Googling for code snippets to make things work so I thought I'd make a little reference of how to get up and running.

## Canvas but not `<canvas>`

Your Facebook app is not really anything that needs to be developed specially as it's really just an `<iframe>` in a Facebook wrapper. It's referred to as the *canvas page* in the world of Facebook apps - the [Facebook Developer docs][1] couldn't put it better:

[1]: http://developers.facebook.com/docs/guides/canvas/

> A Canvas Page is quite literally a blank canvas within Facebook on which to run your app. You populate the Canvas Page by providing a Canvas URL that contains the HTML, JavaScript and CSS that make up your app.

Unfortunately, the rest of the docs can be a bit of a challenge to trawl through... However, the fact that the app is just an iframe means that you can build it and run it on your own site and also have the same thing (same functionality, same codebase, same assets etc.) run on Facebook and have all that social media marketing along for the ride.

The aim of this article is to walk through the steps to get an existing app, game, competition from or whatever from your site to a Facebook app in a hassle free way. So let's dive in.

## Getting Started

### Step 1.

Login to Facebook with your developer account and go to <https://developers.facebook.com/apps> and click the "Create New App" button in the top right of the page.

![Create new App][2]
[2]: /images/facebook-create-app.png

### Step 2.

Give your app a name

![Give your app a name][3]
[3]: /images/facebook-app-name.png

### Step 3.

Fill in a whole load of details. The next screen is where you configure your app. This will be automatically given an App ID and App Secret which you'll need later.

<figure>
<img src="/images/Google-ChromeScreenSnapz008.jpg">
<figcaption>Make a note of your App ID and App Secret for later</figcaption> 
</figure> 

There are a lot of different ways that your app can interact with Facebook from "Native iOS" to "Websites with Facebook Login" but we're interested in "App on Facebook" and "Page Tab" which will appear in the header of your Facebook page's timeline. The important detail in both these cases is the "Canvas URL". This is the URL for the iframe - ie. this is the URL of your existing "app". For the secure canvas URL just use `https://` instead of `http://`.

[4]: /images/Google-ChromeScreenSnapz008.jpg

It's often useful to append a query string to the URL with something like `?template=fb` or `?facebook-iframe` or such like. This will provide a hook for making styling tweaks to the app later on. This is often needed to make things fit into the narrow dimensions of the facebook canvas (limited to 810px!). Of course, if your existing app is built in a responsive, fluid kinda way, you'll be all set.

Most of the details are self explanatory and you can go back and change them at any time by editing the settings. I tend to go for a fixed canvas width (which can be a maximum of 760px to fit within the Facebook canvas) and a fluid height and choose a wide page tab.

### Step 4.

Ok, now it gets a bit weird, but bear with me.

In order to Publish your app (so that you can view it and test it etc.) you need to browse to a special URL that includes your App ID and the URI of your existing app on your website. That sounds pretty confusing but here it is:

    https://www.facebook.com/dialog/pagetab?app_id=YOUR_APP_ID&next=YOUR_APP_URI

So that might look something like this:

    https://www.facebook.com/dialog/pagetab?app_id=123456789012345&next=http://guyroutledge.co.uk/app.php?template=fb

When you browse to this url you should get a lovely Facebook popup that looks something like this:

![publish your page tab][5]
[5]: /images/Google-ChromeScreenSnapz009.jpg

If your developer account is linked to multiple pages or client's pages, you have the option of selecting which one to add your app to. In this instance, you would want to add it to your development page whereas when you have finished development and testing, you follow the same procedure to add the app to your live page (or client's page).

Click Add.

### Step 5.

All being well and good, your app should have been published and added to your selected page. Now, for more confusion (or at least confusion for a non-Facebook user).

In order to start testing your app, you need to go find it. So, log into Facebook (if you're not already) and click the Home button in the top right corner. Then from the left sidebar click the page that you attached your app to in Step 4. Sorry, I've had to blur them out for privacy. #sadface

![click home][6]
[6]: /images/facebook-click-home.png

![select your page][7]
[7]: /images/Google-ChromeScreenSnapz003.png

You should arrive at a typical Facebook timeline page featuring a header and series of thumbnails beneath it - these are the page tabs. If you have more than four, your most recent addition will not be visible. Select the dropdown arrow to the right and swap the app you just published with one of the first four for ease of access.

![these are the page tabs][8]
[8]: /images/Google-ChromeScreenSnapz010.jpg

Clicking on this tab will take you to the Facebook Canvas page and your app will be displayed within it in an iframe. Hopefully.

### Step 6.

Profit.

That's it. You're all done. You may want to make some tweaks to the styling of you app to get it displaying optimally within the narrow viewport. If you want/need to do that, keep reading...

## Facebook specific styles

This bit is easy peasey.

If you added some kind of query string to your canvas URL like `?template=fb` or `?facebook-iframe` then you can use that as a styling hook. First of all, you'll need a bit of PHP to add a `.facebook-app` (or similar) class to your app's markup.

{% highlight php %}
<?php 
$class = ''; 
if ( stripos($_SERVER['REQUEST_URI'], 'facebook-iframe') ) : 
    $class = 'facebook-app'; 
endif; ?>
<div class="app <?php echo $class ?>">
{% endhighlight %}

Then in your CSS:

{% highlight css %}
/* <div class="facebook-app"></div> */
.facebook-app {
    /* facebook specific styles here*/
}
{% endhighlight %}

## The Ole "Like Wall" Trick

This has started to be a pretty common request with Facebook Apps - where the client wants the user to "Like" them before they can get to the real app.

This is also pretty straightforward but does require a bit of extra work. Firstly, you'll need the [PHP Facebook SDK][9] which is like a mini library of functions for programming interactions with Facebook. As a *front-end* developer, most of this goes straight over my head and I can't guarantee that this is the best, simplest, most efficient way of doing this, but it worked for me...!

[9]: http://developers.facebook.com/docs/reference/php/

### Step 1.

Include the SDK in your project

{% highlight php %}
<?php
require_once('path/to/facebook-sdk.php');
?>
{% endhighlight %}

### Step 2.

Grab your App ID and App Secret from the setup phase and add them to this snippet which you need to add to your app code:

{% highlight php %}
<?php 
/* Initialize app interactivity by passing the App ID and App Secret used in setup */
$facebook = new Facebook(array(
    'appId' => "148125265327665",
    'secret' => "a72526d5d9d6977457b1c0f4ef078890",
    'cookie' => true
));
?>
{% endhighlight %}

### Step 3.

Facebook does a lot of it's magic based on the status of something called a `signed_request`. To determine if the user has "Liked Us" we need to parse the signed request; if it returns false, we serve up the Like Wall, if it returns true, we have access to details about the Like status of the page and we serve them the code to display the app.

{% highlight php %}
<?php 
/* Store a reference to the Signed Request so we can determine if the page has been liked
and the user can proceed to the promo entry page */

$signed_request = $facebook->getSignedRequest();

function parsePageSignedRequest() {
    if ( isset($_REQUEST['signed_request']) ) {
        $encoded_sig = null;
        $payload = null;
        list($encoded_sig, $payload) = explode('.', $_REQUEST['signed_request'], 2);
        $sig = base64_decode(strtr($encoded_sig, '-_', '+/'));
        $data = json_decode(base64_decode(strtr($payload, '-_', '+/'), true));
        return $data;
    }
    return false;
}
?>
{% endhighlight %}

Now we know the status of our user, let's apply a bit of logic.

{% highlight php %}
<?php
if ( $signed_request = parsePageSignedRequest() ) :
    if ( $signed_request->page->liked ) : 

        /* Facebook specific version of the promotion for users who have 'Liked' the page */

    else : 

        /* If the user has not yet 'Liked' the page, display this content */

    endif;
endif;
?>
{% endhighlight %}

Here we determine whether the user has "Liked" the page. If they have, we give them what they're after. If not, we show them a "Like Us to continue" message.

The Facebook canvas page has a button at the top right for liking the app but you can also embed a proper "Like" button within the app itself.

### Step 4.

Go get the code for a "Like" button. You can get one here: <http://developers.facebook.com/docs/reference/plugins/like/>. Fill in the details and chose the button style that you like (get it..? *Sigh*). Make sure to grab the HTML5 version not the iframe version in the code popup window. Set the URL to like to the URL of your Facebook page tab app.

![Like button code][10]
[10]: /images/Google-ChromeScreenSnapz011.png

Copy and paste the generated code and add it to the "Like Us" page. Something like this:

{% highlight html %}
<div class="fb-like" data-href="http://www.facebook.com/pages/YOUR_PAGE_TAB" data-send="false" data-layout="button_count" data-width="60" data-show-faces="false"></div>
{% endhighlight %}

You'll also need to include the Facebook Javascript SDK in your page and call FB.init() otherwise your Like button may not display.

{% highlight html %}
<script>
/* Load the Facebook JS SDK */
(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_GB/all.js#xfbml=1&appId=YOUR_APP_ID";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk')); 
</script>

<script src="http://connect.facebook.net/en_US/all.js"></script>
<script>
    FB.init({
        appId : YOUR_APP_ID,
        status : true, // check login status
        cookie : true, // enable cookies to allow the server to access the session
        xfbml : true // parse XFBML
    });
</script>
{% endhighlight %}

All being well, you should now have a "Like Us" splash page with a "Like" button embedded in it.

### Step 5.

So, everything is looking good. But you might find that if you visit your app and click the like button, nothing happens until you refresh the page. Next time the page loads, the logic fires, determines that you now have "Liked" the app and directs you through to the real deal.

In order to force past the Like Wall we can add a `$force` variable to the request.

{% highlight php %}
<?php
$force = !empty($_REQUEST['force']); ?>
{% endhighlight %}

And then use this in our Like logic:

{% highlight php %}
<?php
if ( $force || $signed_request = parsePageSignedRequest() ) :
    if ( $force || $signed_request->page->liked ) : ?>
{% endhighlight %}

We can now cause the iframe to reload and force past the Like wall on click:

{% highlight javascript %}
$('.like-button').click(function(){
    window.location.href = '/?template=fb&force=1';
});
{% endhighlight %}

And you're done. Go grab a beer.

## Final Thoughts

So, there you have it, a really simple way to take some app-like functionality from your existing website and make it available on Facebook, wrapped up in that all too familiar blue and white wrapper. Wonderful. 

Even as a non-Facebook user, I can see the benefit of putting your content in multiple places and growing your user base through people who like your company and content.

However, I think there is something that doesn't sit well with me about making your users "Like" you before they can play a game or enter a competition or whatever - if you have a good product or good content, people will probably "Like" you anyway so doing it this way feels a bit forced to me. Also, they may like you just to play and then you end up with a database of people who don't *really* like you at all. But I think the real issue with this whole concept is that by duplicating your content and pushing people to interact with it on Facebook, you reduce the chance that people will view more content on your website: if they're on your site already, it's much easier for you to coax them to another part of it; if they are on Facebook, aimlessly passing time, they're less likely to follow a link to your website and more likely to go and look at silly pictures of people they barely know. Sorry, I'm getting cynical again. I'll stop now.

