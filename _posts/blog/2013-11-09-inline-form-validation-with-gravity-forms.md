---
layout: post
title: "Inline form validation with gravity forms"
date: 2013-09-11
tags: Tutorial
categories: blog
---
At work we recently launched this awesome new site for [Kallo][1] where (among other things) I attempted to add inline form validation to the somewhat clunky Gravity Forms interface.

[1]: http://www.kallo.com

When you submit a form with validation errors (such as required fields not being filled in), Gravity Forms provides useful class hooks like `.gfield_error` and `.gfield_contains_required` which can be styled to provide visual feedback to the user. However, I always disliked the fact that on corrected my mistakes, the shouty error messages and bright red text would still remain.

This little jQuery snippet does a bit of the old class-name-switchero to provide user-friendly feedback based on whether inputs are valid or not. If you're not using [Gravity Forms][2], you could modify the classes accordingly for similar behaviour. For a warning about browser compatibility and how to work around it, keep reading below...

[2]: http://www.gravityforms.com/

{% highlight javascript %}
// if an invalid form field has been made valid,
// remove the shouty error highlighting - if a valid
// required field has been made invalid, start shouting

$('input, textarea, select').on('change', function(){
    var $input     = $(this);
    var isRequired = $input.parents('.gfield').is('.gfield_contains_required');
    var isValid    = $input.is(':valid');

    if ( isRequired && isValid ) {
        $input.parents('.gfield').removeClass('gfield_error');
        $input.parent().next('.validation_message').slideUp();
    }

}).blur(function(){
    var $input     = $(this);
    var isRequired = $input.parents('.gfield').is('.gfield_contains_required');
    var isInValid  = $input.is(':invalid');
    var isEmpty    = $input.val() === '';

    if ( isRequired && ( isInValid || isEmpty ) ) {
        $input.parents('.gfield').addClass('gfield_error');
        $input.parent().next('.validation_message').slideDown();
    }
});
{% endhighlight %}

<small>Here it is a <a href="https://gist.github.com/guyroutledge/6497479">a Github gist</a></small> 
Here we create a couple of conditions like `isRequired` or `isValid` by making use some CSS3 pseudo classes and/or checking the Gravity Forms hooks. You can also use these in the CSS:

{% highlight scss %}
input,
input:valid,
select,
select:valid,
textarea,
textarea:valid {
    /* normal styles & valid input styles */
}
input:invalid,
select:invalid,
textarea:invalid {
    /* invalid input styles */
}
{% endhighlight %}

By grouping these styles together, the inline validation turning on and off works a treat.

## Browser compatibility

This was all working great in Chrome (and other modern browsers) but failed miserably in IE9 and below. I had completely forgotten that [IE9 doesn't support these pseudo selectors][3] and as they were part of a comma separated list, none of the styles (valid or otherwise) applied correctly.

[3]: http://www.impressivewebs.com/css3-support-ie9/

Fortunately, using a bit of Sass, this problem was easy to overcome whilst reducing the potential for lots of nasty duplication.

{% highlight scss %}
@mixin valid-form-styles {
    /* normal & valid form styles */
}
@mixin invalid-form-styles {
    /* invalid form styles */
}
input,
select,
textarea {
    @include valid-form-styles;
}
input:valid,
select:valid,
textarea:valid {
    @include valid-form-styles;
}
input:invalid,
select:invalid,
textarea:invalid {
    @include invalid-form-styles;
}
{% endhighlight %}

Browsers that don't understand a selector, ignore it. If an unknown selector occurs in a comma-separated block, the whole block gets ignored. Splitting the concern here enables us to have a single place to update the valid/invalid style declarations (which is nice and DRY) and means that non-supporting browsers don't interfere with our best-laid plans for good user feedback. Progressive enhancement at it's best!
