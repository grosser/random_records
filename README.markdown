Database (e.g. MySql) :order=>'rand()' is slow.  

Solution
--------
<table cellpadding=4>
<tr><th>Method</th><th align="left">Speed</th><th>Randomness</th><th>Duplicates</th></tr>
<tr><td>1 cluster from random offset</td><td>fast</td><td>somewhat</td><td>no</td></tr>
<tr><td>X times 1 record from random offset</td><td>slow for large X</td><td>total</td><td>possible</td></tr>
<tr><td>n clusters of m record from random offset</td><td>fast</td><td>good</td><td>possible</td></tr>
</table>

INSTALL
=======
 - As Rails plugin: ` script/plugin install git://github.com/grosser/random_records.git `
 - As gem: ` sudo gem install random_records `



USAGE
=====

###Find many in single random cluster (no duplicates)
    Model.random(1) == [Model(id:322)]
    Model.random(3) == [Model(id:113),Model(id:112),Model(id:114)]
    Model.with_valid_email.random(3) == [Model(id:114),Model(id:112),Model(id:113)]

###Find many in many random clusters
The smaller the slower (each cluster = 1 request)  
May include duplicates so use `.uniq` on results.
    Model.random(3, :cluster_size=>1) == [Model(id:112),Model(id:98),Model(id:214)]

###Find one random
    Model.random == Model(id:234)
    Model.with_valid_email.random == Model(id:123)

TODO
====
 - prevent duplicates when finding in clusters (searching 9 of 10 -> many requests or tracking which offsets where already fetched)
 
AUTHOR
======
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...  