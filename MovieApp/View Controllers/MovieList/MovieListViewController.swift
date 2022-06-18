import UIKit
import SnapKit

class MovieListViewController: UIViewController {
    
    //search bar components
    private var searchBarView: UIView!
    private var searchBarMagnifierImage: UIImageView!
    private var searchBarTextField: UITextField!
    private var searchBarXButton: UIButton!
    private var searchBarCancelButton: UIButton!
    private var searchingState: Bool!
    private var typingState: Bool!
    
    //view controllers
    private var mainTableViewController = MainTableViewController() //when we open this view controller
    private var searchTableViewController: SearchTableViewController! //when we are searching for movies
    
    private var networkService = NetworkService()
    
    private var moviesRepository = MoviesRepository()
    
    //network check
    private let networkMonitor = NetworkMonitor()
    
    private var allMoviesDatabase: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesRepository.appLaunch(firstAppLaunchCompletion: { isDone in
            if (isDone) {
                print("BuildViews")
                
                //otkomentiraj
                DispatchQueue.main.async {
                    self.buildViews()
                    self.buildConstraints()
                }
                
                
                self.moviesRepository.getAllMoviesFromDatabase(completion: { movieArray in
                    self.allMoviesDatabase = movieArray!
                    print(self.allMoviesDatabase.count)
                    //print(self.allMoviesDatabase.first?.genreIds)
                })
            }
        })
        
//        self.moviesRepository.getAllMoviesFromDatabase(completion: { movieArray in
//            self.allMoviesDatabase = movieArray!
//        })
        
        searchingState = false
        typingState = false
    }
    
    private func buildViews() {
        view.backgroundColor = .white
        buildNavigationView()
        buildSearchBarNotInFocus()
    }
    
    private func buildConstraints() {
        buildSearchBarNotInFocusConstraints()
    }
    
    private func buildNavigationView() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "topTitle"))
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = StyleConstants.AppColors.darkGray
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    private func buildSearchBarNotInFocus() {
        searchBarView = UIView()
        searchBarView.backgroundColor = StyleConstants.AppColors.backgroundGrey
        searchBarView.layer.cornerRadius = 10
        view.addSubview(searchBarView)
        
        searchBarMagnifierImage = UIImageView()
        searchBarMagnifierImage.image = UIImage(systemName: "magnifyingglass")
        searchBarView.tintColor = StyleConstants.AppColors.darkGray
        searchBarView.addSubview(searchBarMagnifierImage)
        
        searchBarTextField = UITextField()
        
        let font = UIFont(name: "Verdana", size: 16)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font!,
            .foregroundColor: StyleConstants.AppColors.textLightGray
        ]
        let attributedSearchText = NSAttributedString(string: "Search", attributes: attributes)

        searchBarTextField.attributedPlaceholder = attributedSearchText
        searchBarTextField.delegate = self
        searchBarView.addSubview(searchBarTextField)
        
        addChildVC(mainTableViewController)
    }
    
    private func buildSearchBarInFocus() {
        searchBarCancelButton = UIButton()
        let cancelFont = UIFont(name: "Verdana", size: 16)
        let cancelAttributes: [NSAttributedString.Key: Any] = [
            .font: cancelFont!,
            .foregroundColor: StyleConstants.AppColors.darkGray
        ]
        let cancelAttributedText = NSAttributedString(string: "Cancel", attributes: cancelAttributes)
        searchBarCancelButton.setAttributedTitle(cancelAttributedText, for: .normal)
        
        searchBarCancelButton.addTarget(self, action: #selector(cancelSearch), for: .touchUpInside)
        
        view.addSubview(searchBarCancelButton)
    }
    
    private func buildSearchBarTyping() {
        searchBarXButton = UIButton()
        searchBarXButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        
        searchBarXButton.addTarget(self, action: #selector(xButtonPressed), for: .touchUpInside)
        
        searchBarView.addSubview(searchBarXButton)
    }
    
    private func buildSearchBarNotInFocusConstraints() {
        searchBarView.snp.makeConstraints({
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(StyleConstants.MovieListVCLengths.spaceLength)
            $0.height.equalTo(StyleConstants.MovieListVCLengths.searchBarHeight)
        })
        
        searchBarMagnifierImage.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(StyleConstants.MovieListVCLengths.spaceLengthSmall)
            $0.centerY.equalTo(searchBarView.snp.centerY)
            $0.width.equalTo(StyleConstants.MovieListVCLengths.magnifierImageWidth)
        })
        
        searchBarTextField.snp.makeConstraints({
            $0.top.bottom.trailing.equalToSuperview().inset(StyleConstants.MovieListVCLengths.spaceLengthSmall)
            $0.leading.equalTo(searchBarMagnifierImage.snp.trailing).offset(StyleConstants.MovieListVCLengths.spaceLengthSmall)
        })
        
        buildMainMovieListConstraints()
    }

    private func buildSearchBarInFocusConstraints() {
        searchBarView.snp.remakeConstraints({
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(StyleConstants.MovieListVCLengths.spaceLength)
            $0.trailing.equalTo(searchBarCancelButton.snp.leading).offset(-StyleConstants.MovieListVCLengths.spaceLength)
            $0.height.equalTo(StyleConstants.MovieListVCLengths.searchBarHeight)
        })
        
        searchBarCancelButton.snp.makeConstraints({
            $0.centerY.equalTo(searchBarView.snp.centerY)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(StyleConstants.MovieListVCLengths.spaceLength)
            $0.width.equalTo(StyleConstants.MovieListVCLengths.cancelButtonWidth)
        })
    }
    
    private func buildSearchBarTypingConstraints() {
        searchBarXButton.snp.makeConstraints({
            $0.trailing.equalToSuperview().inset(StyleConstants.MovieListVCLengths.spaceLengthSmall)
            $0.centerY.equalTo(searchBarView.snp.centerY)
            $0.width.height.equalTo(StyleConstants.MovieListVCLengths.xImageDimensions)
        })
        
        searchBarTextField.snp.remakeConstraints({
            $0.top.bottom.equalToSuperview().inset(StyleConstants.MovieListVCLengths.spaceLengthSmall)
            $0.trailing.equalTo(searchBarXButton.snp.leading).offset(-StyleConstants.MovieListVCLengths.spaceLengthSmall)
            $0.leading.equalTo(searchBarMagnifierImage.snp.trailing).offset(StyleConstants.MovieListVCLengths.spaceLengthSmall)
        })
    }
    
    private func buildSearchListConstraints() {
        searchTableViewController.view.snp.makeConstraints({
            $0.top.equalTo(searchBarView.snp.bottom).offset(StyleConstants.MovieListVCLengths.spaceUnderSearchBar-StyleConstants.MovieTableViewCellLengths.spaceLengthMedium)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
    
    private func buildMainMovieListConstraints() {
        mainTableViewController.view.snp.makeConstraints({
            $0.top.equalTo(searchBarView.snp.bottom).offset(StyleConstants.MainTableViewCellLengths.spaceLengthMedium)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(StyleConstants.MovieListVCLengths.spaceLength)
        })
    }
    
    @objc private func cancelSearch() {
        searchingState = false
        typingState = false
        
        searchBarXButton.removeFromSuperview()
        searchBarCancelButton.removeFromSuperview()
        
        let font = UIFont(name: "Verdana", size: 16)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font!,
            .foregroundColor: StyleConstants.AppColors.textLightGray
        ]
        let attributedSearchText = NSAttributedString(string: "Search", attributes: attributes)

        searchBarTextField.text!.removeAll()
        searchBarTextField.attributedPlaceholder = attributedSearchText
        searchBarTextField.resignFirstResponder()
        
        if (searchTableViewController != nil) {
            removeChildVC(searchTableViewController)
        }
        
        cancelSearchConstraints()
        
        addChildVC(mainTableViewController)
        buildMainMovieListConstraints()
        
    }
    
    private func cancelSearchConstraints() {
        searchBarView.snp.remakeConstraints({
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(StyleConstants.MovieListVCLengths.spaceLength)
            $0.height.equalTo(StyleConstants.MovieListVCLengths.searchBarHeight)
        })
        
        searchBarTextField.snp.remakeConstraints({
            $0.top.bottom.trailing.equalToSuperview().inset(StyleConstants.MovieListVCLengths.spaceLengthSmall)
            $0.leading.equalTo(searchBarMagnifierImage.snp.trailing).offset(StyleConstants.MovieListVCLengths.spaceLengthSmall)
        })
    }
    
    @objc func xButtonPressed() {
        searchBarTextField.text!.removeAll()
    }
}

extension MovieListViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (searchingState == false) {
            buildSearchBarInFocus()
            buildSearchBarInFocusConstraints()
            
            removeChildVC(mainTableViewController)
            
            if (searchTableViewController != nil) {
                removeChildVC(searchTableViewController)
            }
            
            searchingState = true
            return true
            
        } else {
            if (searchTableViewController != nil) {
                removeChildVC(searchTableViewController)
            }
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (typingState == false) {
            buildSearchBarTyping()
            buildSearchBarTypingConstraints()
            
//            if (searchTableViewController != nil) {
//                print("removed searchtableview")
//                removeChildVC(searchTableViewController)
//            }
            
            typingState = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBarTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (searchingState == true) {
            
            self.searchTableViewController = SearchTableViewController(searchTextFieldText: textField.text!, searchTextEndEditing: self.searchBarTextField)
            self.addChildVC(self.searchTableViewController)
            self.buildSearchListConstraints()
            
        }
    }
}

extension UIViewController {
    func addChildVC(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func removeChildVC(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
