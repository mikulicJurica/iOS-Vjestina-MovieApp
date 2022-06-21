import UIKit
import SnapKit
import MovieAppData

class MainTableViewCell: UITableViewCell {
    
    private var cellView: UIView!
    
    private var moviesGroup: UILabel!
    
    private var buttonFiltersStackView: UIStackView!
    private var buttonList: [UIButton]!
    
    //scroll view variables
    private var scrollView: UIScrollView!
    private var contentScrollView: UIView!
    
    private var collectionView: UICollectionView!
    
    private var movieGroups = MovieGroups.allCases
    private var movieGroup: MovieGroups!
    
    private var movieListModel: [Movie]!
    private var allGenresDatabase: [MovieGenre] = []
    
    private var moviesRepository = MoviesRepository()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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
        buttonFiltersStackView.spacing = 15
        
        buttonList = [UIButton()]
        
        scrollView = UIScrollView()
        cellView.addSubview(scrollView)
        contentScrollView = UIView()
        scrollView.addSubview(contentScrollView)
        scrollView.bounces = false
        
        contentScrollView.addSubview(buttonFiltersStackView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
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
        
        scrollView.snp.makeConstraints({
            $0.top.equalTo(moviesGroup.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        })
        
        contentScrollView.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        })
        
        buttonFiltersStackView.snp.makeConstraints({
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview()
        })
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(StyleConstants.MainTableViewCellLengths.spaceLengthBottom)
            $0.height.equalTo(StyleConstants.CollectionViewCellLengths.collectionCellHeight)
        }
    }
    
    func set(inputGroup: MovieGroups) {
        movieGroup = inputGroup
        
        moviesRepository.getAllGenres(completion: { genres in
            DispatchQueue.main.async {
                self.allGenresDatabase = genres!
                
                let buttonFont = UIFont(name: "Verdana", size: 16)
                let buttonAttributes: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: StyleConstants.AppColors.textLightGray]
                let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
                
                for i in (0...genres!.count - 1) {
                    let tmpButton = UIButton()
                    if (i == 0) {
                        let buttonAttributedText = NSAttributedString(string: genres![i].name!, attributes: buttonAttributesBlack)
                        tmpButton.setAttributedTitle(buttonAttributedText, for: .normal)
                        tmpButton.tag = (i + 1)
                        tmpButton.addTarget(self, action: #selector(self.buttonFilterTap(sender:)), for: .touchUpInside)
                        self.buttonList.append(tmpButton)
                        self.buttonFiltersStackView.addArrangedSubview(tmpButton)
                    }
                    else {
                        let buttonAttributedText = NSAttributedString(string: genres![i].name!, attributes: buttonAttributes)
                        tmpButton.setAttributedTitle(buttonAttributedText, for: .normal)
                        tmpButton.tag = (i + 1)
                        tmpButton.addTarget(self, action: #selector(self.buttonFilterTap(sender:)), for: .touchUpInside)
                        self.buttonList.append(tmpButton)
                        self.buttonFiltersStackView.addArrangedSubview(tmpButton)
                    }
                }
                
                let listName: String!
                let labelName: String!
                
                switch inputGroup {
                case .popular:
                    listName = MovieGroups.popular.rawValue
                    labelName = "What's popular"
                case .trending:
                    listName = MovieGroups.trending.rawValue
                    labelName = "Trending"
                case .topRated:
                    listName = MovieGroups.topRated.rawValue
                    labelName = "Top Rated"
                case .recommendations:
                    listName = MovieGroups.recommendations.rawValue
                    labelName = "Recommendations"
                }
                
                self.moviesRepository.getMovieList(groupName: listName, completion: { movieList in
                    var tmpMovieList: [Movie] = []
                    for movie in movieList! {
                        let tmpMovieGenres = movie.genreIds
                        for movieGenreId in tmpMovieGenres! {
                            if (movieGenreId == self.allGenresDatabase.first!.id) {
                                tmpMovieList.append(movie)
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.movieListModel = tmpMovieList
                        self.collectionView.dataSource = self
                        self.moviesGroup.text = labelName
                    }
                })
                
            }
        })
    }
    
    public func osvjezi() {
        collectionView.reloadData()
        print("osvjezi")
    }
    
    @objc private func buttonFilterTap(sender: UIButton) {
        
        print(movieGroup.rawValue)
        
        let buttonFont = UIFont(name: "Verdana", size: 16)
        let buttonAttributes: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: StyleConstants.AppColors.textLightGray]
        let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
        
        
        self.moviesRepository.getMovieList(groupName: movieGroup.rawValue, completion: { movieList in
            var tmpMovieList: [Movie] = []
            for movie in movieList! {
                let tmpMovieGenres = movie.genreIds
                for movieGenreId in tmpMovieGenres! {
                    if (movieGenreId == self.allGenresDatabase[sender.tag - 1].id) {
                        tmpMovieList.append(movie)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.movieListModel = tmpMovieList
                self.collectionView.reloadData()
                
                for i in (1...self.buttonList.count - 1) {
                    if (i == sender.tag) {
                        let buttonAttributedText = NSAttributedString(string: (self.buttonList[i].titleLabel?.text)!, attributes: buttonAttributesBlack)
                        self.buttonList[i].setAttributedTitle(buttonAttributedText, for: .normal)
                    }
                    else {
                        let buttonAttributedText = NSAttributedString(string: (self.buttonList[i].titleLabel?.text)!, attributes: buttonAttributes)
                        self.buttonList[i].setAttributedTitle(buttonAttributedText, for: .normal)
                    }
                }
            }
        })
    }
}

extension MainTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        let selectedMovie = currentCell.getMovie()
        
        let vc = MovieDetailsViewController(movie: selectedMovie)

        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
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
        return movieListModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell
        else {
            fatalError()
        }
        
        cell.set(movie: movieListModel[indexPath.row])
        return cell
    }
}
