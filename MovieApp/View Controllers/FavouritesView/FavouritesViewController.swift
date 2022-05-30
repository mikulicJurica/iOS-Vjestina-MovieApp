import UIKit
import SnapKit
import Network

class FavouritesViewController: UIViewController {
    
    private var favouritesLabel: UILabel!
    private var favouritesCollectionView: UICollectionView!
    
    private var favouritesMovieListModel: [MovieModel] = []
    private var moviesRepository = MoviesRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesRepository.getAllMoviesFromDatabase(completion: { movieList in
            self.favouritesMovieListModel = movieList!
            self.buildViews()
            self.buildConstraints()
        })
        
    }
    
    private func buildViews() {
        view.backgroundColor = .white
        
        buildNavigationView()
        buildFavouritesLabel()
        buildCollectionView()
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
    
    private func buildFavouritesLabel() {
        favouritesLabel = UILabel()
        favouritesLabel.text = "Favorites"
        favouritesLabel.textColor = StyleConstants.AppColors.darkGray
        favouritesLabel.font = UIFont(name: "Verdana-Bold", size: 20)
        view.addSubview(favouritesLabel)
    }
    
    private func buildCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 40.0
        
        favouritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        favouritesCollectionView.register(FavouritesCollectionViewCell.self, forCellWithReuseIdentifier: FavouritesCollectionViewCell.reuseIdentifier)
        view.addSubview(favouritesCollectionView)
        
        favouritesCollectionView.delegate = self
        favouritesCollectionView.dataSource = self
    }
    
    private func buildConstraints() {
        favouritesLabel.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(StyleConstants.FavouritesCollectionViewCellLengths.spaceLengthLarge)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(StyleConstants.FavouritesCollectionViewCellLengths.spaceLengthSmall)
        })
        
        favouritesCollectionView.snp.makeConstraints({
            $0.top.equalTo(favouritesLabel.snp.bottom).offset(StyleConstants.FavouritesCollectionViewCellLengths.spaceLengthLarge-5)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(StyleConstants.FavouritesCollectionViewCellLengths.spaceLengthSmall)
        })
    }
}

extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 3.5, height: StyleConstants.FavouritesCollectionViewCellLengths.collectionCellHeight)
        }
}

extension FavouritesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouritesMovieListModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesCollectionViewCell.reuseIdentifier, for: indexPath) as? FavouritesCollectionViewCell
        else {
            fatalError()
        }
        cell.set(inputMovie: favouritesMovieListModel[indexPath.row])
        return cell
    }
}

extension FavouritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! FavouritesCollectionViewCell
        let selectedModel = currentCell.returnMovieFunction()
        
        let vc = MovieDetailsViewController(movie: selectedModel)
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
