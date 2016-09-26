# C4Q Movie Reel 

### (AC3.2-Tableviews_Part_3: **Segues and Protocols Basics**)

---

### Time to Reel it In

Reel good took our latest protocol and presented it to their board of investors as the cornerstone of their mobile initiative. The extra work we put behind the design of the app must have really sold it, because Reel Good now needs one more set of changes before they take the app into beta. 

For the next [MVP](https://www.quora.com/What-is-a-minimum-viable-product/answer/Suren-Samarchyan?srid=dpgi), Reel Good needs these next things:

1. Tapping on a movie should bring up a full screen view with the full details of that movie
2. They want a search bar to be able to filter out the movies in the table view
3. Somewhere in the app there should be an "About" section (they've left it up to us to decide)

At our sprint planning meeting, our engineering team had to cut Reel Good short at this point because they had many, many more featuers. We had to remind Reel Good that while these are "only three" things, they represent a significant development challenge and time commitment. As is common in the field, being able to translate features into development time is going to be a critical skill that comes with time and experience. But this intangible skill is what will set you apart from a careless developer and a skillful one. 

After the meeting with Reel Good, we sat down with our engineering team and sketched out the necessary requirements of this next task and broke them down:

1. We're going to have to implement addition protocol methods in `UITableviewDelegate` to be able to handle tap detection
2. We have to create a new custom view controller (and views in our storyboard) to present a full screen version of the movie data
  3. We need to make sure that navigation works to go to and from one of these view controllers.
  4. The proper movie data has to be transferred, so we need to do some data handling
5. Adding in a search bar means, not only adding new storyboard elements to our tableview, it also means implementing a number of new functions in order to support "live" search filtering
  6. Less obvious, we'll need to think of how to redesign our models to make this search easier. 
7. And "About" screen means we'll potentially need a few things:
  8. A new `UIView` and/or `UIViewController` to present the info
  9. Planning what action or button will display this view
  10. Deciding how this view will be dismissed
  
So you can see, translatting features into actual programming work is very important in the initial stages of development to get an understanding of truly everything that needs to be done. And even then, there absolutely will be unforseen problems that you will encounter. But that's just part of the fun of programming :)

---
### Goals
1. Implement a `UISearchBar` along with it's delegate methods defined in `UISearchBarDelegate`
2. Create a new custom `UIViewController` to display a single `Movie` object's data
3. Understand segues in storyboard to transition between view controllers
4. Understand the `Equatable` and `Comparable` protocols and implement them in our `Movie` model
5. Create a basic view animation to display our "About" page
6. Better understand the role of protocols in Swift.

By the end of this lesson, you will have a fully-functioning, basic data app with search functionality that will look great on any iPhone screen. 

---

### Readings


---





