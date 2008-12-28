PROBLEM
=======
 - database :order=>'random' is slow
 - active record has no random build in

SOLUTION
========
 - count all records
 - grab x records from rand(offset)

INSTALL
=======
`script/plugin install git://github.com/grosser/random_records.git`

USAGE
=====

    Model.random(3) == [Model(id:112),Model(id:113),Model(id:114)]
    Model.random(1) == [Model(id:322)]
    Model.random == Model(id:234)
 
AUTHOR
======
Michael Grosser  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...  