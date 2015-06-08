<!-- README.md is generated from README.Rmd. Please edit that file -->
d3wordcloud
-----------

d3wordcloud is a wrapper for the Word Cloud Layout by Jason Davies.

How it works?!
--------------

The main function `d3wordcloud` needs only `words` and `freqs`. Just
like the old good wordcloud package.

Someone said to *customize*?
----------------------------

There are a list of parameter for make your word cloud like you
like/want:

-   `padding`: The separation between words. Defaul value is `0`.
-   `scale`:. The scale acording the `freq` parameter. Options are
    `linear`, `sqrt` and `log`. Defaul value is `linear`.
-   `font`:. The font use on the words. Defaul value is `Impact`.
-   `spiral`: The way to construct the wordcloud. Options are
    `archimedean` and `rectangular`. Defaul value is `archimedean`.
-   `rotate.min`: Minimum angle for (random) rotation. Defaul value is
    `-30`.
-   `rotate.max`: Maximum angle for (random) rotation. Defaul value is
    `30`.

Recommendations
---------------

-   Always have the [latest version of
    packages](https://github.com/ramnathv/htmlwidgets/issues/100).

Demo
----

Check [here](http://r-shiny-apps.jkunst.com/d3wordcloud/).

An old demo gif:

![shinyappdemo](extras/d2wordcloud_demo.gif)

References
----------

-   [Word Cloud Layout](http://www.jasondavies.com/wordcloud) by [Jason
    Davies](http://www.jasondavies.com).

Similar packages
----------------

-   Yep I repeated myself (this is NOTDRY). There is a package with this
    functionality: ([link](https://github.com/adymimos/rWordCloud)).
