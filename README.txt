Kickstarter challenge notes

====Design & Architecture===

I knew I couldn't rely on SpriteKit to do this project, so I immediately brushed up on my MVC, UIKit and Interface Builder knowledge before beginning. For the Model I made a singleton LCData class which interfaces with the json file provided and gives relevant data structures like arrays and dictionaries to the views. I decided on a single UIView project which I built out to an eventual 3 views: a ListView which was the entry point for my project, a DetailView which showed the details of the project, and a PledgeView which was the submission form. I also included a NavigationController.

The ListView and DetailView are both just UITableViews. I designed custom UITableCells for the former, which in retrospect were completely unnecessary as I couldn't extend any of the functionality but I'm glad to have learned how to do so. For the latter I used sections and Accessability Labels to keep track of the content. The PledgeView is a plain UIView with buttons, labels, and UITextFields. 

I had planned on incorporating ReactiveCocoa to show changes to backers, pledge amount, and % funded on the DetailView page upon a successful pledge but this proved too ambitious. In the end the Model/View is never updated again upon a successful pledge so this is the biggest limitation of this project.


====Time Breakdown===

Total time spent: ~40hrs

-Learning how to deserialize JSON into NSData objects (1 hr)

-Extracting data from JSON file and writing relevant functions in the LCData class (3 hrs)

-reading & learning to use Interface Builder and Storyboard  (18 hrs)

-UITextfield and trying to capture data.... (2 hrs)
	-first responder & UITextDelegate

-implementation of all submission field checks (4 hrs)
	-implementation of Luhn's algorithm

-UIAlertController & error reporting code (3 hrs)

-Adding ReactiveCocoa (5 hrs)
	-This was never properly implemented, but I worked on it in a different branch which can be viewed

-Fixing UI/debugging (2 hrs)

-go through and try to refactor code (1 hr)
	-lazy instantiation
	-modularity

====Challenges & Additional Thoughts====

By far my biggest challenge was relearning Storyboard and Interface Builder for Xcode 6 to connect models to views. Since I don't use this framework at all in SpriteKit, all of this was quite new for me:
	-creating initial list view 
		-connect data to UITableViewCells
	-creating detail list view (static content)
	-connecting list view to detail
		-segues
	-connecting everything via Navigation View controller
	-Autolayout manager and constraints gave me a pretty hard time

If I had more time I would consider these fixes:
	-make listView have responsive cells so that multiple lines do not get truncated but rather grow to take up multiple lines and adjusts the cell's height dynamically
	-add Images
	-use alternative to Accessibility Labels in submitView (unsafe, relies on hard-coding various strings)
	-Learn more about how to implement function pointers/use performWithSelector to iterate through functions to avoid code bloat

I would integrate these third party libraries & frameworks:
	-PureLayout 
		-this would allow more control over UI elements through code
	-ReactiveCocoa & the MVVC model
		-upon a successful submission, this should update the "pledged" and "backers" number on the detailView.
		-I started doing this in another branch, but could not sucessfully get my project to run without crashing. I did get started on making a DetailViewModel for DetailViewController.

====Resources Consulted====
-Apple Documentation

-http://stackoverflow.com/questions/11465579/how-to-set-up-uitableview-within-a-uiviewcontroller-created-on-a-xib-file

-http://www.appcoda.com/self-sizing-cells/

-http://stackoverflow.com/questions/575055/how-to-build-a-nsarray-or-nsmutablearray-of-class-methods-in-objective-c

-http://stackoverflow.com/questions/4158646/most-efficient-way-to-iterate-over-all-the-chars-in-an-nsstring

-https://github.com/Machx/MVVM-IOS-Example

-http://www.sprynthesis.com/2014/12/06/reactivecocoa-mvvm-introduction/
