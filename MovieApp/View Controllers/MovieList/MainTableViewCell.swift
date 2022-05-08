import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    private var cellView: UIView!
    
    private var moviesGroup: UILabel!
    private var buttonFiltersStackView: UIStackView!
    
    private var button0: UIButton!
    private var button1: UIButton!
    private var button2: UIButton!
    
    private var collectionView: UICollectionView!
    
    private var networkService = NetworkService()
    
    private var movieListModel: MovieListModel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        networkService.delegate = self

        buildCell()
        buildCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildCell() {
        cellView = UIView()
        addSubview(cellView)
        
        moviesGroup = UILabel()
        moviesGroup.textColor = StyleConstants.AppColors.darkGray
        moviesGroup.font = UIFont(name: "Verdana-Bold", size: 20)
        cellView.addSubview(moviesGroup)
        
        buttonFiltersStackView = UIStackView()
        buttonFiltersStackView.axis = .horizontal
        buttonFiltersStackView.alignment = .leading
        buttonFiltersStackView.distribution = .fillEqually
        buttonFiltersStackView.spacing = 0
        
        cellView.addSubview(buttonFiltersStackView)
        
        button0 = UIButton()
        button1 = UIButton()
        button2 = UIButton()
        
        button0.addTarget(self, action: #selector(buttonPressed0), for: .touchUpInside)
        button1.addTarget(self, action: #selector(buttonPressed1), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonPressed2), for: .touchUpInside)
        
        buttonFiltersStackView.addArrangedSubview(button0)
        buttonFiltersStackView.addArrangedSubview(button1)
        buttonFiltersStackView.addArrangedSubview(button2)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cellView.addSubview(collectionView)
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        cellView.addSubview(collectionView)
        
        
        collectionView.delegate = self
    }
    
    private func buildCellConstraints() {
        cellView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(StyleConstants.MainTableViewCellLengths.spaceLengthMedium/2)
        })
        
        moviesGroup.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview()
        })
        
        buttonFiltersStackView.snp.makeConstraints({
            $0.top.equalTo(moviesGroup.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)//za sad
        })
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(StyleConstants.MainTableViewCellLengths.spaceLengthBottom)
            $0.height.equalTo(StyleConstants.CollectionViewCellLengths.collectionCellHeight)
        }
    }
    
    func set(inputGroup: MovieGroups) {
        
        let buttonFont = UIFont(name: "Verdana", size: 16)
        let buttonAttributes: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: StyleConstants.AppColors.textLightGray]
        let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
        
        
        networkService.getGenreList()
        
        var buttonAttributedText = NSAttributedString(string: "Action", attributes: buttonAttributesBlack)
        button0.setAttributedTitle(buttonAttributedText, for: .normal)
        buttonAttributedText = NSAttributedString(string: "Adventure", attributes: buttonAttributes)
        button1.setAttributedTitle(buttonAttributedText, for: .normal)
        buttonAttributedText = NSAttributedString(string: "Animation", attributes: buttonAttributes)
        button2.setAttributedTitle(buttonAttributedText, for: .normal)
        
        switch inputGroup {
        case .popular:
            
            networkService.getMovieList(listName: "popular")
            moviesGroup.text = "What's popular"
            
        case .trending:
            
            networkService.getMovieList(listName: "trending")
            moviesGroup.text = "Trending"
            
        case .topRated:
            
            networkService.getMovieList(listName: "top_rated")
            moviesGroup.text = "Top Rated"
            
        case .recommendations:
            
            networkService.getMovieList(listName: "recommendations")
            moviesGroup.text = "Recommendations"
            
        }
    }
    
    @objc private func buttonPressed0(sender: UIButton) {
        let buttonFont = UIFont(name: "Verdana", size: 16)
        let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
        let buttonAttributedText = NSAttributedString(string: (sender.titleLabel?.text)!, attributes: buttonAttributesBlack)
        sender.setAttributedTitle(buttonAttributedText, for: .normal)
        
        let buttonAttributesGrey: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: StyleConstants.AppColors.textLightGray]
        
        let buttonAttributedTextGrey1 = NSAttributedString(string: (button1.titleLabel?.text)!, attributes: buttonAttributesGrey)
        button1.setAttributedTitle(buttonAttributedTextGrey1, for: .normal)
        
        let buttonAttributedTextGrey2 = NSAttributedString(string: (button2.titleLabel?.text)!, attributes: buttonAttributesGrey)
        button2.setAttributedTitle(buttonAttributedTextGrey2, for: .normal)
    }
    
    @objc private func buttonPressed1(sender: UIButton) {
        let buttonFont = UIFont(name: "Verdana", size: 16)
        let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
        let buttonAttributedText = NSAttributedString(string: (sender.titleLabel?.text)!, attributes: buttonAttributesBlack)
        sender.setAttributedTitle(buttonAttributedText, for: .normal)
        
        let buttonAttributesGrey: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: StyleConstants.AppColors.textLightGray]
        
        let buttonAttributedTextGrey0 = NSAttributedString(string: (button0.titleLabel?.text)!, attributes: buttonAttributesGrey)
        button0.setAttributedTitle(buttonAttributedTextGrey0, for: .normal)
        
        let buttonAttributedTextGrey2 = NSAttributedString(string: (button2.titleLabel?.text)!, attributes: buttonAttributesGrey)
        button2.setAttributedTitle(buttonAttributedTextGrey2, for: .normal)
    }
    
    @objc private func buttonPressed2(sender: UIButton) {
        let buttonFont = UIFont(name: "Verdana", size: 16)
        let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
        let buttonAttributedText = NSAttributedString(string: (sender.titleLabel?.text)!, attributes: buttonAttributesBlack)
        sender.setAttributedTitle(buttonAttributedText, for: .normal)
        
        let buttonAttributesGrey: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: StyleConstants.AppColors.textLightGray]
        
        let buttonAttributedTextGrey1 = NSAttributedString(string: (button1.titleLabel?.text)!, attributes: buttonAttributesGrey)
        button1.setAttributedTitle(buttonAttributedTextGrey1, for: .normal)
        
        let buttonAttributedTextGrey0 = NSAttributedString(string: (button0.titleLabel?.text)!, attributes: buttonAttributesGrey)
        button0.setAttributedTitle(buttonAttributedTextGrey0, for: .normal)
    }
}

extension MainTableViewCell: UICollectionViewDelegate {

}

extension MainTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: StyleConstants.CollectionViewCellLengths.collectionCellWidth, height: collectionView.frame.height)
    }
}

extension MainTableViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListModel.results.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell
        else {
            fatalError()
        }
        
        cell.set(movie: movieListModel.results[indexPath.row])
        return cell
    }

}

extension MainTableViewCell: NetworkServiceProtocol {
    func getGenreListSuccess(genreList: GenreListModel) {
        //print(genreList.genres[3].name)
    }
    
    func getMovieListSuccess(movieList: MovieListModel) {
        
        movieListModel = movieList
        
        collectionView.dataSource = self
    }
    
    func getMovieSuccess(movie: MovieModel) {
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
