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
 1. [General Reference on Xcode (very useful)](http://help.apple.com/xcode/mac/8.0)
 2. [Configuring a Segue in Storyboard - Apple](http://help.apple.com/xcode/mac/8.0/#/deve5fc2eb19)
 3. [Using Segues (lots of great info here)](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html)
 4. [Navigation Controller Implementation - tuts+ (helpful reference and example)](https://code.tutsplus.com/tutorials/ios-from-scratch-with-swift-navigation-controllers-and-view-controller-hierarchies--cms-25462)
 2. (Reading on UISearchBar)
 3. (Reading on Equatable/Comparable)
 4. (Reading on Protocols)
 5. (Reading on basic animations)
  
---

### 1. Adding a new `UIViewController` to Display a `Movie`

#### Storyboard Changes **(Use iPhone 6s for your simulation)**
1. Drag in a `UIViewController` into `Main.storyboard` from the *Objects Library* in the *Utilities Pane* and place it next to the `MovieTableViewController`
2. Select the prototype cell (make sure you have the actual `MovieTableViewCell` selected) and Control-Drag to the new `UIViewController`
3. On the outlet menu that pops up, select "Selection Segue > Show"
  - Note: The "Accessory Selection" is that action to perform when adding an "accessory view." An example of an accessory view is the `>` (called a "chevron") you see all the way to the right on a cell in the Mail or Messages app on an iPhone. 
  - The "Selection" type of segue refers to the action to take when the cell itself is tapped/selected.
4. Select the segue object in storyboard (the -> arrow), and in the *Attribute Inspector*, set it's identifier to `MovieDetailViewSegue`
5. Drag in a `UIImageView` into the view controller, giving it the following attributes:
  - `8pt` margins at the top, left, and right
  - A height of `240pt`
  - _Before adding these constraints, make sure the checkmark box for "Constrain to margins" is selected_
  - Switch the image view's `Content Mode` to `Aspect Fit`
5. Drag in 5 `UILabel`s below the `UIImageView` in a vertical row
  - Label them (in order): `Genre`, `Cast`, `Location`, `Summary` and `Summary Text`
  - Set their fonts to `Roboto Regular - 17pt`, except for `Summary Text` which will be `Roboto-Light - 14pt`
  - Set the number of lines for `Summary Text` to 0
6. Select **all** of the `UILabel`s at once, but holding down the Command (⌘) Key while clicking on them
  - Select *Pin* and set it to **8pt margins**, also making sure that the checkmark for "Constrain to margins" is selected
  - Set the *Vertical Content Hugging Priority* to 1000 for all labels except `Summary Text`. Instead, set the *Vertical Compression Resistance* of `Summary Text` to 1000
  - Your view controller should resemble: (add screen shot)

#### Storyboard linking
1. Add a new file named `MovieDetailViewController` that subclasses `UIViewController` and place it in the correct folder and Xcode group
2. In `Main.storyboard` change the custom class of the view controller we just created to be `MovieDetailViewController`
3. Create outlets for each of the labels and the imageView. Name them:
  - `moviePosterImageView`, `genreLabel`, `castLabel`, `locationLabel`, `summaryLabel`, and `summaryFullTextLabel`
4. Additionally, give `MovieDetailViewController` an instance variable of type `Movie`:
  - `internal var selectedMovie: Movie!`
  - You'll see in a bit why we'll need this

#### Preparing for Segue
A `UINavigationController` is unique in that it manages its own navigation stack. A navigation stack is a hierarchy of view controllers. You can think of each view controller being a card in a stack of cards and when you **push** a view controller onto the stack, you're putting a new card on top of the _stack_ of cards. When you **pop** a view controller, you're taking a card off the top of the _stack_. It important to know that all view controllers currently on the stack can be accessed through the navigation controller, and thus exist in memory. 

The `prepare(for:sender:)` method is where we get things ready for displaying a new view controller that has been set up with a segue object in storyboard. For right now, we're just going to make sure that the segue is working in general and that we *push* to our `MovieDetailViewController` and then are able to *pop* back to our `MovieTableViewController`.

As mentioned in the documentation for [`prepare(for:sender:)`](https://developer.apple.com/reference/appkit/nssegueperforming/1409583-performsegue), the `sender` parameter refers to the object that has requested the segue. In our case, the sender is expected to be a `MovieTableviewCell`. But because the `sender` could be `Any?`, we should do a check to confirm our assumptions. Moreover, we'll need the cell to determine which movie cell was tapped.

```swift
  // 1. check sender for the cell that was tapped
        if let tappedMovieCell: MovieTableViewCell = sender as? MovieTableViewCell {
        
        }
```

The `segue` object is an instance of `NSStoryboardSegue`, which has an instance property of `indentifier` that refers to the identifier string we gave to the segue earlier in `Main.storyboard` (we used `MovieDetailViewSegue`). In order to make sure that we have the correct segue (a storyboard can have many, many segues), we need to check that the identifier matches one that we expect:

```swift
          // 1. check sender for the cell that was tapped
        if let tappedMovieCell: MovieTableViewCell = sender as? MovieTableViewCell {
         
            // 2. check for the right storyboard segue
            if segue.identifier == "MovieDetailViewSegue" {
                
            }
        }
```

While generally you should avoid force unwrapping, in this instance because we're certain of both the sender and the storyboard segue we can say with some certainty that the `segue.destination` is going to be a `MovieDetailViewController`:

`let movieDetailViewController: MovieDetailViewController = segue.destination as! MovieDetailViewController`

Ok, so we have the tapped cell (`sender`) and we have the instance of `MovieDetailViewController` (`segue.destination`), but how do we get the `Movie` object that corresponds to the cell we selected? We _could_ get the `movieTitleLabel.text` property, then iterrate over our entire `movieData` array, locating the Movie object with the same title. Though, another solution is to get the index of the cell, and using that, derive the movie by the same set of functions we used in `cellForRow` to separate out our data into different sections. Both would work, but we're going to use the latter:

```swift
let movieDetailViewController: MovieDetailViewController = segue.destination as! MovieDetailViewController
                let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedMovieCell)!
                guard let genre = Genre.init(rawValue: cellIndexPath.section),
                    let data = byGenre(genre) else {
                        return
                }
                
                let selectedMovie: Movie = data[cellIndexPath.row]
                movieDetailViewController.selectedMovie = selectedMovie
                
                movieDetailViewController.moviePosterImageView.image = UIImage(named: selectedMovie.poster)
                movieDetailViewController.genreLabel.text = selectedMovie.genre
                movieDetailViewController.castLabel.text = "Cast: "
                movieDetailViewController.locationLabel.text = selectedMovie.locations.joined(separator: ", ")
                movieDetailViewController.summaryFullTextLabel.text = selectedMovie.summary
                // we'll need to return to our cast of Actors in a moment
                
```

Go ahead and run the poject at this point to see if the data gets passed along properly...

`fatal error: unexpectedly found nil while unwrapping an Optional value`

> Discuss & Debug: Why are we getting force unwrapping errors? 

#### Updating `MovieDetailViewController` with a `Movie`




