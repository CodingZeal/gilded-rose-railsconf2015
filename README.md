# The Gilded Rose Kata

This is a version of the Gilded Rose kata with some initial setup for
[Randy Coulman](http://randycoulman.com/)'s
[Getting a Handle on Legacy Code workshop](http://railsconf.com/program/labs#prop_1024)
at [RailsConf 2015](http://railsconf.com) and other variants presented in other venues.

To prepare for the workshop, you can use a pre-configured workstation on [nitrous.io](https://www.nitrous.io/) by clicking on the Nitrous Quickstart button.  You will need to create a free account on nitrous.io to use this option.

[![Nitrous Quickstart](https://nitrous-image-icons.s3.amazonaws.com/quickstart.svg)](https://www.nitrous.io/quickstart)

If you prefer to work on your own workstation, clone and/or fork this repository and then run `bundle`.

Once you've done that, you can do the following:

* Run Minitest tests with `bundle exec rake test`
* Run RSpec specs with `bundle exec rake spec`
* Run [flog](https://github.com/seattlerb/flog) against the code with `bundle exec rake flog`

Both Minitest tests and RSpec specs will automatically generate
[Simplecov](https://github.com/colszowka/simplecov) coverage information.

This kata starts from the version found at https://github.com/professor/GildedRose.

There are other versions of this kata for Ruby, as well as versions for other languages.

The original versions of this kata do not have an explicit license that I can find.  This
repo uses the MIT licenses for its additions and contributions.

The original README from https://github.com/professor/GildedRose follows below.


# Original README

Hi and welcome to team Gilded Rose.

As you know, we are a small inn with a prime location in a prominent city ran
by a friendly innkeeper named Allison.  We also buy and sell only the finest
goods. Unfortunately, our goods are constantly degrading in quality as they
approach their sell by date.

We have a system in place that updates our inventory for us. It was developed
by a no-nonsense type named Leeroy, who has moved on to new adventures. Your
task is to add the new feature to our system so that we can begin selling a
new category of items.

First an introduction to our system:

  - All items have a SellIn value which denotes the number of days we have to
    sell the item

  - All items have a Quality value which denotes how valuable the item is

  - At the end of each day our system lowers both values for every item

Pretty simple, right? Well this is where it gets interesting:

  - Once the sell by date has passed, Quality degrades twice as fast

  - The Quality of an item is never negative

  - "Aged Brie" actually increases in Quality the older it gets

  - The Quality of an item is never more than 50

  - "Sulfuras", being a legendary item, never has to be sold or decreases in
    Quality

  - "Backstage passes", like aged brie, increases in Quality as its SellIn
    value approaches; Quality increases by 2 when there are 10 days or less
    and by 3 when there are 5 days or less but Quality drops to 0 after the
    concert

We have recently signed a supplier of conjured items. This requires an update
to our system:

  - "Conjured" items degrade in Quality twice as fast as normal items

Feel free to make any changes to the UpdateQuality method and add any new code
as long as everything still works correctly. However, do not alter the Item
class or Items property as those belong to the goblin in the corner who will
insta-rage and one-shot you as he doesn't believe in shared code ownership
(you can make the UpdateQuality method and Items property static if you like,
we'll cover for you).

Just for clarification, an item can never have its Quality increase above 50,
however "Sulfuras" is a legendary item and as such its Quality is 80 and it
never alters.

Source: <http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/>
