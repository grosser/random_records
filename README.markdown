PROBLEM
=======
 - database :order=>'random' is slow
 - active record has no random build in

SOLUTION
========
 - Simplified: grab x records from offset rand(count)

INSTALL
=======
`script/plugin install git://github.com/grosser/random_records.git`

USAGE
=====

    Model.random(1) == [Model(id:322)]
    Model.random(3) == [Model(id:112),Model(id:113),Model(id:114)]
    Model.with_valid_email.random(3) == [Model(id:112),Model(id:113),Model(id:114)]

    #finds records in random clusters (the smaller the slower)
    Model.random(3, :cluster_size=>1) == [Model(id:112),Model(id:98),Model(id:214)]

    Model.random == Model(id:234)
 
AUTHOR
======
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...  