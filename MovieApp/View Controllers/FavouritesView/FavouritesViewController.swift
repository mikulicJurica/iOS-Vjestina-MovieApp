import UIKit

class FavouritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        buildConstraints()
    }
    
    private func buildViews() {
        view.backgroundColor = .white
        buildNavigationView()
    }
    
    private func buildConstraints() {
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
}
