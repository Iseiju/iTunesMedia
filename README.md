# iTunesMedia
An iOS app that shows a list of Movies with a "Star" content, obtained from an iTunes Search.

https://itunes.apple.com/search?term=star&country=au&media=movie

# UI and Design
For the UI and Design, I went with a standard table list in the Main screen, another screen for the detailed view which shows the description of an item, and a Favorites screen to show Movies that were marked as favorites from the Main screen.

The icons used have been sourced here: 
https://icon-library.com/icon/media-icon-png-23.html,
https://fonts.google.com/icons?selected=Material+Icons

### Dark Mode

I've added Dark Mode support in the app by setting the attributes of the views to base on the device's current appearance.

### iPad Support

Variation of constraints were also added via storyboards so UI elements in the screen would adjust accordingly for iPad view.

# Architecture: RxMVVM-C
My architectural pattern of choice is RxMVVM-C and the choice was made over the standard MVC pattern of Apple.

Since Apple's MVC tends to get bloated as the project grows, 
it's much harder to maintain a codebase wherein the Views are heavily dependent on both Controllers and a Models,
thus having no clear distinction in the responsibilities of who controls the UI logic.

By implementing MVVM to this app, the ViewModel becomes the middleman between the Model and the View. 
It populates the UI elements of a View with the necessary data and it also interacts with the Model to set up the data.
This results in a more clearer distinction in the responsibilities. 

### RxSwift

I've also implemented RxSwift to the overall architectural pattern for biding my ViewModels to my TableView.
By binding the ViewModels to the TableView, the app can listen and adapt to any changes made to the cells and its data.

### Navigation
In this app, the Coordinator (C) handles the navigation in between controllers/screens.

It also handles custom delegates and conforms to them such as in the case of `MainCoordinator` conforming to `MainControllerDelegate`, 
which houses the necessary parameters for transitioning to the next screen.

This is my preferred method of transition to other controllers rather than through segues because of its flexibility, configurability, and reusability of screens.

Please see `MainCoordinator.swift` and `MainController.swift` for reference.

# Persistence
For persistence, I went with Realm as my preferred persistence stack since it's very straightforward when it comes to implementation and usage.

The app stores the response (`Media`) and also updates it for every successful network call (`func getMedia()`)
The stored data will then be called and be used if the network call should fail.

A `Favorite` model has been included as well, to keep track of Movies that were marked as favorite via their respective `id`. Objects that will be added to the favorite list will be checked first if it's already existing in the persistence layer. If yes, then remove the object, if no, object will be added to the list.

`Favorite` model conforms to Object for persistence use, while `Media` model conforms to both `Object` and `Codable` which is needed for Realm and coding/decoding respectively.

Please see `Model.swift`, `Favorite.swift` and `MainViewModel.swift` for reference.
