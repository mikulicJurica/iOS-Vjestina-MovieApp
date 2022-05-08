import UIKit
import SnapKit

protocol MovieDetailsSelectionDelegate {
    func didSelectMovie(selectedMovie: MovieModel)
}

class CollectionViewCell: UICollectionViewCell {
    
    var selectionDelegate: MovieDetailsSelectionDelegate!
    
    static let reuseIdentifier = String(describing: CollectionViewCell.self)

    private var cellView: UIView!
    private var cellButton: UIButton!
    private var movieImageView: UIImageView!
    private var favouritesButton: UIButton!
    
    private var cellMovie: MovieModel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        selectionDelegate = MovieListViewController()

        buildViews()
        addConstraints()
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
        
        cellButton = UIButton()
        cellButton.backgroundColor = .clear
        cellButton.addTarget(self, action: #selector(goToMovieDetails), for: .touchUpInside)
        cellView.addSubview(cellButton)

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

    func addConstraints() {
        cellView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        cellButton.snp.makeConstraints({
            $0.top.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        })
        
        movieImageView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        favouritesButton.snp.makeConstraints({
            $0.leading.top.equalToSuperview().inset(StyleConstants.CollectionViewCellLengths.favouritesButtonOffset)
            $0.width.height.equalTo(StyleConstants.CollectionViewCellLengths.favouritesButtonSize)
        })
    }
    
    func set(movie: MovieModel) {
        
        cellMovie = movie
        
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
    
    @objc private func goToMovieDetails() {
        selectionDelegate.didSelectMovie(selectedMovie: cellMovie)
    }
}
