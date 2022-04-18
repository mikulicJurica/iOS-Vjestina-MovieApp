import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: CollectionViewCell.self)

    private var cellView: UIView!
    private var movieImageView: UIImageView!
    private var favouritesButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

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
        cellView.layer.cornerRadius = styleConstants.collectionViewCellLengths.cellEdgeRadius
        cellView.clipsToBounds = true
        addSubview(cellView)

        movieImageView = UIImageView()
        movieImageView.contentMode = UIView.ContentMode.scaleAspectFill
        movieImageView.clipsToBounds = true
        cellView.addSubview(movieImageView)
        
        favouritesButton = UIButton()
        favouritesButton.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(scale: .medium)), for: .normal)
        favouritesButton.backgroundColor = styleConstants.appColors.darkGrayOpaque
        favouritesButton.layer.cornerRadius = CGFloat(styleConstants.collectionViewCellLengths.favouritesButtonSize/2.0)
        favouritesButton.tintColor = UIColor.white
        cellView.addSubview(favouritesButton)
    }

    func addConstraints() {
        cellView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        movieImageView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        favouritesButton.snp.makeConstraints({
            $0.leading.top.equalToSuperview().inset(styleConstants.collectionViewCellLengths.favouritesButtonOffset)
            $0.width.height.equalTo(styleConstants.collectionViewCellLengths.favouritesButtonSize)
        })
    }
    
    func set(movieImageUrl: String) {
        guard let imageURL = URL(string: movieImageUrl) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
}
