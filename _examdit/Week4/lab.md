 OOP1.4 Lab
====================

Overview
--------------------

The goal of this lab is to use `blocks` to load some data from the web and display it onscreen.
I have provided a [zip file here](https://github.com/zdavison/DIT.OOP1/raw/master/Week4/AFNetworking.zip) that will provide you the necessary networking library `AFNetworking` we will use to get started.

Goals
--------------------
Your code should provide the following features:

- A button you can press to load the contents of the following URL: http://ip.jsontest.com/
- A label that will then display the contents **when the request has completed**.

Required Understanding
--------------------
Blocks. AFNetworking documentation.

Hints
--------------------
- You will need to read the documentation for `AFNetworking`, found [here](https://github.com/AFNetworking/AFNetworking).
- The method you are looking for is `GET:parameters:success:failure:` on the `AFHTTPRequestOperationManager` class. There is example code in the documentation.
- You will need to `#import "AFNetworking.h"` to use it.
- The `responseObject` you receive will be an `NSDictionary` instance containing a key "ip". Set this to the contents of your UILabel. To make your `responseObject` an instance of NSDictionary, you can **cast** it by doing the following: `NSDictionary *dictionary = (NSDictionary*)responseObject;`

Bonus
--------------------


Submission
--------------------
Please create a [GitHub](https://github.com/) account and `push` your code to a repository named `OOP1` under a folder called `Lab4`. Send me the URL for this repository. (email: `zac@getdrop.com`) Please include your real name with the URL if it is not already displayed on [GitHub](https://github.com/).


