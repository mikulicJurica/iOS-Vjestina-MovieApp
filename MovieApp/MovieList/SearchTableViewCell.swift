import UIKit
import SnapKit

//cell when we searching movies
class SearchTableViewCell: UITableViewCell {
    
    //elements of cell
    private var cellView: UIView!
    private var shadowView: UIView!
    private var movieImageView: UIImageView!
    private var movieNameLabel: UILabel!
    private var movieDescriptionLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildMovieCell()
        buildMovieCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildMovieCell() {
        shadowView = UIView()
        shadowView.backgroundColor = .white
        shadowView.layer.cornerRadius = styleConstants.movieTableViewCellLengths.cellEdgeRadius
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOffset = .zero
        addSubview(shadowView)
        
        cellView = UIView()
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = styleConstants.movieTableViewCellLengths.cellEdgeRadius
        cellView.clipsToBounds = true
        addSubview(cellView)
        
        movieImageView = UIImageView()
        movieImageView.contentMode = UIView.ContentMode.scaleAspectFill
        movieImageView.clipsToBounds = true
        cellView.addSubview(movieImageView)
        
        movieNameLabel = UILabel()
        movieNameLabel.textColor = UIColor.black
        movieNameLabel.font = UIFont(name: "Verdana-Bold", size: 16)
        cellView.addSubview(movieNameLabel)
        
        movieDescriptionLabel = UILabel()
        movieDescriptionLabel.textColor = styleConstants.appColors.textLightGray
        movieDescriptionLabel.font = UIFont(name: "Verdana", size: 14)
        movieDescriptionLabel.numberOfLines = 0
        cellView.addSubview(movieDescriptionLabel)
    }
    
    private func buildMovieCellConstraints() {
        shadowView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(styleConstants.movieTableViewCellLengths.spaceLengthLarge)
            $0.top.bottom.equalToSuperview().inset(styleConstants.movieTableViewCellLengths.spaceLengthSmall/2 + 2)
        })
        
        cellView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(styleConstants.movieTableViewCellLengths.spaceLengthLarge)
            $0.top.bottom.equalToSuperview().inset(styleConstants.movieTableViewCellLengths.spaceLengthSmall/2 + 2)
        })
        
        movieImageView.snp.makeConstraints({
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(styleConstants.movieTableViewCellLengths.movieImageWidth)
        })
        
        movieNameLabel.snp.makeConstraints({
            $0.leading.equalTo(movieImageView.snp.trailing).offset(styleConstants.movieTableViewCellLengths.spaceLengthMedium)
            $0.top.equalToSuperview().inset(styleConstants.movieTableViewCellLengths.spaceLengthSmall)
            $0.trailing.equalToSuperview()
        })

        movieDescriptionLabel.snp.makeConstraints({
            $0.leading.equalTo(movieImageView.snp.trailing).offset(styleConstants.movieTableViewCellLengths.spaceLengthMedium)
            $0.top.equalTo(movieNameLabel.snp.bottom).offset(styleConstants.movieTableViewCellLengths.spaceLengthMedium/3)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(styleConstants.movieTableViewCellLengths.spaceLengthSmall)
        })
    }
    
    func set(movieName: String, movieDescription: String, movieImageUrl: String) {
        
        guard let imageURL = URL(string: movieImageUrl) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.movieImageView.image = image
                self.movieNameLabel.text = movieName
                self.movieDescriptionLabel.text = movieDescription
            }
        }
    }
}
