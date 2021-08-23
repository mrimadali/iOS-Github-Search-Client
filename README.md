# iOS-Github-Search-Client
iOS  - Github Repository Search Client Using Swift Programming language.

# Instructions
# Dependencies
This Project uses the Swift Package Manager for its dependencies.

<i>(What is Swift Package Manager? The Swift Package Manager is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.)
Add a Swift Package Dependency<br>
To add a package dependency to your Xcode project, select File > Swift Packages > Add Package Dependency and enter its repository URL. You can also navigate to your target’s General pane, and in the “Frameworks, Libraries, and Embedded Content” section, click the + button, select Add Other, and choose Add Package Dependency.</i></br></br>
The app uses three dependencies:-


1. **Kingfisher**:  A lightweight and pure Swift implemented library for downloading and caching image from the web.

2. **Loaf**:  A simple framework for easy iOS Toasts (to show Error messages)

3. **SwiftyJSON**: SwiftyJSON makes it easy to deal with JSON data in Swift

# Pages

The app has two pages:-

1. **Repo Search**: It searches using the keyowrd entered by user, Once a keyword is entered, it searches the repository on Github using the API (api.github.com)
2. **Repo details**: It shows meta data about the selected repo, such as, Repo name, owner, creation date, description etc.,

# Pagination

It uses UITableView - UITableViewDataSourcePrefetching protocol, You use a prefetch data source object in conjunction with your table view’s data source to begin loading data for cells before the tableView(_:cellForRowAt:) data source method is called.

<i>func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])</i>


# Software Requirements:-
1. Xcode 12 or later &<br>
2. iOS 13 or later
