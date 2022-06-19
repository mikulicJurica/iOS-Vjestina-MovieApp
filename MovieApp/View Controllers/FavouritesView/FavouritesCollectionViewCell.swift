import UIKit
import SnapKit

class FavouritesCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: FavouritesCollectionViewCell.self)
    
    private var cellView: UIView!
    private var movieImageView: UIImageView!
    private var favouritesButton: UIButton!
    private var favouritesImageFill: UIImageView!
    
    private let favouritesImageFillSize: Float = 14.0
    private let favouritesImageNormalSize: Float = 0.4
    
    private var cellMovie: Movie!
    
    private var moviesRepository = MoviesRepository()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        layer.backgroundColor = UIColor.white.cgColor
        
        cellView = UIView()
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = StyleConstants.CollectionViewCellLengths.cellEdgeRadius
        cellView.clipsToBounds = true
        addSubview(cellView)

        movieImageView = UIImageView()
        movieImageView.contentMode = UIView.ContentMode.scaleAspectFill
        movieImageView.clipsToBounds = true
        cellView.addSubview(movieImageView)
        
        favouritesButton = UIButton()
        favouritesButton.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(scale: .medium)), for: .normal)
        favouritesButton.backgroundColor = StyleConstants.AppColors.darkGrayOpaque
        favouritesButton.layer.cornerRadius = CGFloat(StyleConstants.CollectionViewCellLengths.favouritesButtonSize/2.0)
        favouritesButton.tintColor = UIColor.white
        favouritesButton.addTarget(self, action: #selector(changeFavoriteState), for: .touchUpInside)
        
        favouritesImageFill = UIImageView(image: UIImage(named: "favorites"))
        favouritesImageFill.layer.opacity = 0
        favouritesImageFill.contentMode = UIView.ContentMode.scaleAspectFill
        favouritesButton.addSubview(favouritesImageFill)
        cellView.addSubview(favouritesButton)
    }

    func buildConstraints() {
        cellView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        movieImageView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        favouritesButton.snp.makeConstraints({
            $0.leading.top.equalToSuperview().inset(StyleConstants.CollectionViewCellLengths.favouritesButtonOffset)
            $0.width.height.equalTo(StyleConstants.CollectionViewCellLengths.favouritesButtonSize)
        })
    }
    
    func set(inputMovie: Movie) {
        cellMovie = inputMovie
        
        let imageUrl = "https://image.tmdb.org/t/p/original" + cellMovie.posterPath!
        guard let url = URL(string: imageUrl) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }

            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.movieImageView.image = image
                
                if (self.cellMovie.favorite) {
                    self.makeFavoriteToFill()
                }
                else {
                    self.makeFavoriteToNormal()
                }
            }
        }
    }
    
    func returnMovieFunction() -> Movie {
        return cellMovie
    }
    
    @objc private func changeFavoriteState() {
        moviesRepository.changeFavoriteMovieState(inputMovie: cellMovie, completion: { isDone in
            if (isDone) {
                if (cellMovie.favorite) {
                    cellMovie.favorite = false
                    UIView.animate(withDuration: 0.5, animations: {
                        self.remakeFavoriteToNormal()
                        self.cellView.layoutIfNeeded()
                    })
                }
                else {
                    cellMovie.favorite = true
                    UIView.animate(withDuration: 0.5, animations: {
                        self.remakeFavoriteToFill()
                        self.cellView.layoutIfNeeded()
                    })
                }
            }
        })
    }
    
    private func makeFavoriteToFill() {
        favouritesImageFill.layer.opacity = 1
        favouritesImageFill.snp.makeConstraints({
            $0.width.height.equalTo(favouritesImageFillSize)
            $0.center.equalToSuperview()
        })
    }
    
    private func makeFavoriteToNormal() {
        favouritesImageFill.snp.makeConstraints({
            $0.width.height.equalTo(favouritesImageNormalSize)
            $0.center.equalToSuperview()
        })
        favouritesImageFill.layer.opacity = 0
    }
    
    private func remakeFavoriteToFill() {
        favouritesImageFill.layer.opacity = 1
        favouritesImageFill.snp.remakeConstraints({
            $0.width.height.equalTo(favouritesImageFillSize)
            $0.center.equalToSuperview()
        })
    }
    
    private func remakeFavoriteToNormal() {
        favouritesImageFill.snp.remakeConstraints({
            $0.width.height.equalTo(favouritesImageNormalSize)
            $0.center.equalToSuperview()
        })
        favouritesImageFill.layer.opacity = 0
    }
}
