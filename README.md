<!-- README.md is generated from README.Rmd. Please edit that file -->
d3wordcloud
===========

[![travis-status](https://api.travis-ci.org/jbkunst/d3wordcloud.svg)](https://travis-ci.org/jbkunst/d3wordcloud)
[![version](http://www.r-pkg.org/badges/version/d3wordcloud)](http://www.r-pkg.org/pkg/d3wordcloud)
[![downloads](http://cranlogs.r-pkg.org/badges/d3wordcloud)](http://www.r-pkg.org/pkg/d3wordcloud)

What is it?
-----------

d3wordcloud is a wrapper for the [Word Cloud
Layout](http://www.jasondavies.com/wordcloud) by [Jason
Davies](http://www.jasondavies.com) based on
[htmlwidgets](https://github.com/ramnathv/htmlwidgets).

How it works?!
--------------

The main function `d3wordcloud` needs only `words` and `freqs`. Just
like the old good wordcloud package. See demo
[here](http://r-shiny-apps.jkunst.com/d3wordcloud/).

    library("d3wordcloud")
    words <- c("I", "love", "this", "package", "but", "I", "don't", "like", "use", "wordclouds")
    freqs <- sample(seq(length(words)))

    d3wordcloud(words, freqs)

How can you get it?
-------------------

I know! you already know how to install it

    devtools::install_github("jbkunst/d3wordcloud")

Parameters
----------

There are parameter for make your word cloud like you like/want:

-   `words`: The words
-   `freqs`: Their frequencies
-   `padding`: The separation between words. Default value is `0`.
-   `colors`: The color for wordcloud, if the length of words, and
    colors are the same, then each word will have its own color, in
    other case a grandien between the colors is generated (the order is
    important here).
-   `size.scale`: The scale to use for scale the words sizes (`freqs`).
    Options are `linear`, `sqrt` and `log`. Default value is `linear`.
-   `color.scale`: The scale to use for scale the colors according to
    sizes (`freqs`). Options are `linear`, `sqrt` and `log`. Default
    value is `linear`.
-   `font`: The font to use in thw the word cloud. Default value is
    `Open Sans`.
-   `spiral`: The way to construct the wordcloud. Options are
    `archimedean` and `rectangular`. Default value is `archimedean`.
-   `rotate.min`: Minimum angle for (random) rotation. Default value is
    `-30`.
-   `rotate.max`: Maximum angle for (random) rotation. Default value is
    `30`.

You can see this parameter in action here
<http://rpubs.com/jbkunst/100416>.

Demo
----

Check here <https://jbkunst.shinyapps.io/d3wordcloud>.

Sometimes I exceed the hours on the basic plan in shiniapps.io. You can
always can view here: <http://rpubs.com/jbkunst/100416>.

An old demo gif:

![shinyappdemo](extras/d2wordcloud_demo.gif)

References
----------

-   [Word Cloud Layout](http://www.jasondavies.com/wordcloud) by [Jason
    Davies](http://www.jasondavies.com).

Similar packages
----------------

-   [rWordCloud](https://github.com/adymimos/rWordCloud). A package with
    similar functionalities.

Recommendations
---------------

-   Always have the [latest version of
    packages](https://github.com/ramnathv/htmlwidgets/issues/100).
