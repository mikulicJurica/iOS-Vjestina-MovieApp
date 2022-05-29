import UIKit
import SnapKit

class FavouritesCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: FavouritesCollectionViewCell.self)
    
    private var cellView: UIView!
    private var movieImageView: UIImageView!
    private var favouritesButton: UIButton!
    
    private var cellMovie: MovieModel!
    
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
    
    func set(inputMovie: MovieModel) {
        cellMovie = inputMovie
        
        let imageUrl = "https://image.tmdb.org/t/p/original" + cellMovie.posterPath
        guard let url = URL(string: imageUrl) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }

            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
    
    func returnMovieFunction() -> MovieModel {
        return cellMovie
    }
}
