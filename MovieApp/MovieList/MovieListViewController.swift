import UIKit
import SnapKit

//
class MovieListViewController: UIViewController {
    
    //search bar components
    private var searchBarView: UIView!
    private var searchBarMagnifierImage: UIImageView!
    private var searchBarTextField: UITextField!
    private var searchBarXButton: UIButton!
    private var searchBarCancelButton: UIButton!
    
    //view controllers
    private var mainViewController = MainTableViewController() //when we open this view controller
    private var searchViewController = SearchTableViewController() //when searching

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        buildConstraints()
    }
    
    private func buildViews() {
        view.backgroundColor = .white
        
        buildSearchBarNotInFocus()
    }
    
    private func buildConstraints() {
        buildSearchBarNotInFocusConstraints()
    }
    
    private func buildSearchBarNotInFocus() {
        searchBarView = UIView()
        searchBarView.backgroundColor = styleConstants.appColors.backgroundGrey
        searchBarView.layer.cornerRadius = 10
        view.addSubview(searchBarView)
        
        searchBarMagnifierImage = UIImageView()
        searchBarMagnifierImage.image = UIImage(systemName: "magnifyingglass")
        searchBarView.tintColor = styleConstants.appColors.darkGray
        searchBarView.addSubview(searchBarMagnifierImage)
        
        searchBarTextField = UITextField()
        
        let font = UIFont(name: "Verdana", size: 16)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font!,
            .foregroundColor: styleConstants.appColors.textLightGray
        ]
        let attributedSearchText = NSAttributedString(string: "Search", attributes: attributes)

        searchBarTextField.attributedPlaceholder = attributedSearchText
        searchBarTextField.delegate = self
        searchBarView.addSubview(searchBarTextField)
        
        addChildVC(mainViewController)
    }
    
    private func buildSearchBarInFocus() {
        searchBarCancelButton = UIButton()
        let cancelFont = UIFont(name: "Verdana", size: 16)
        let cancelAttributes: [NSAttributedString.Key: Any] = [
            .font: cancelFont!,
            .foregroundColor: styleConstants.appColors.darkGray
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
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(styleConstants.movieListVCLengths.spaceLength)
            $0.height.equalTo(styleConstants.movieListVCLengths.searchBarHeight)
        })
        
        searchBarMagnifierImage.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(styleConstants.movieListVCLengths.spaceLengthSmall)
            $0.centerY.equalTo(searchBarView.snp.centerY)
            $0.width.equalTo(styleConstants.movieListVCLengths.magnifierImageWidth)
        })
        
        searchBarTextField.snp.makeConstraints({
            $0.top.bottom.trailing.equalToSuperview().inset(styleConstants.movieListVCLengths.spaceLengthSmall)
            $0.leading.equalTo(searchBarMagnifierImage.snp.trailing).offset(styleConstants.movieListVCLengths.spaceLengthSmall)
        })
        
        buildMainMovieListConstraints()
    }

    private func buildSearchBarInFocusConstraints() {
        searchBarView.snp.remakeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(styleConstants.movieListVCLengths.spaceLength)
            $0.trailing.equalTo(searchBarCancelButton.snp.leading).offset(-styleConstants.movieListVCLengths.spaceLength)
            $0.height.equalTo(styleConstants.movieListVCLengths.searchBarHeight)
        })
        
        searchBarCancelButton.snp.makeConstraints({
            $0.centerY.equalTo(searchBarView.snp.centerY)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(styleConstants.movieListVCLengths.spaceLength)
            $0.width.equalTo(styleConstants.movieListVCLengths.cancelButtonWidth)
        })
    }
    
    private func buildSearchBarTypingConstraints() {
        searchBarXButton.snp.makeConstraints({
            $0.trailing.equalToSuperview().inset(styleConstants.movieListVCLengths.spaceLengthSmall)
            $0.centerY.equalTo(searchBarView.snp.centerY)
            $0.width.height.equalTo(styleConstants.movieListVCLengths.xImageDimensions)
        })
        
        searchBarTextField.snp.remakeConstraints({
            $0.top.bottom.equalToSuperview().inset(styleConstants.movieListVCLengths.spaceLengthSmall)
            $0.trailing.equalTo(searchBarXButton.snp.leading).offset(-styleConstants.movieListVCLengths.spaceLengthSmall)
            $0.leading.equalTo(searchBarMagnifierImage.snp.trailing).offset(styleConstants.movieListVCLengths.spaceLengthSmall)
        })
    }
    
    private func buildSearchListConstraints() {
        searchViewController.view.snp.makeConstraints({
            $0.top.equalTo(searchBarView.snp.bottom).offset(styleConstants.movieListVCLengths.spaceUnderSearchBar-styleConstants.movieTableViewCellLengths.spaceLengthMedium)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
    
    private func buildMainMovieListConstraints() {
        mainViewController.view.snp.makeConstraints({
            $0.top.equalTo(searchBarView.snp.bottom).offset(styleConstants.mainTableViewCellLengths.spaceLengthMedium)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(styleConstants.movieListVCLengths.spaceLength)
        })
    }
    
    @objc private func cancelSearch() {
        searchBarXButton.removeFromSuperview()
        searchBarCancelButton.removeFromSuperview()
        
        let font = UIFont(name: "Verdana", size: 16)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font!,
            .foregroundColor: styleConstants.appColors.textLightGray
        ]
        let attributedSearchText = NSAttributedString(string: "Search", attributes: attributes)

        searchBarTextField.text!.removeAll()
        searchBarTextField.attributedPlaceholder = attributedSearchText
        searchBarTextField.resignFirstResponder()
        
        removeChildVC(searchViewController)
        
        cancelSearchConstraints()
        
        addChildVC(mainViewController)
        buildMainMovieListConstraints()
        
    }
    
    private func cancelSearchConstraints() {
        searchBarView.snp.remakeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(styleConstants.movieListVCLengths.spaceLength)
            $0.height.equalTo(styleConstants.movieListVCLengths.searchBarHeight)
        })
        
        searchBarTextField.snp.remakeConstraints({
            $0.top.bottom.trailing.equalToSuperview().inset(styleConstants.movieListVCLengths.spaceLengthSmall)
            $0.leading.equalTo(searchBarMagnifierImage.snp.trailing).offset(styleConstants.movieListVCLengths.spaceLengthSmall)
        })
    }
    
    @objc func xButtonPressed() {
        searchBarTextField.text!.removeAll()
    }
}

extension MovieListViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        
        buildSearchBarInFocus()
        buildSearchBarInFocusConstraints()
        
        removeChildVC(mainViewController)
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        buildSearchBarTyping()
        buildSearchBarTypingConstraints()
        print("TextField did begin editing method called")

        addChildVC(searchViewController)
        buildSearchListConstraints()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
        child.removeFromParent()
        child.view.removeFromSuperview()
    }
}

