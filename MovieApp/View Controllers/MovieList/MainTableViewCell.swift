import UIKit
import SnapKit

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
    
    private var networkService = NetworkService()
    
    private var movieListModel = MovieListModel(results: [])

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
            $0.height.equalTo(30)//za sad
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
        
        networkService.getGenreList(completionHandler: {(result: Result<GenreListModel, RequestError>) in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    let buttonFont = UIFont(name: "Verdana", size: 16)
                    let buttonAttributes: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: StyleConstants.AppColors.textLightGray]
                    let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
                    
                    for i in (0...value.genres.count - 1) {
                        let tmpButton = UIButton()
                        if (i == 0) {
                            let buttonAttributedText = NSAttributedString(string: value.genres[i].name, attributes: buttonAttributesBlack)
                            tmpButton.setAttributedTitle(buttonAttributedText, for: .normal)
                            tmpButton.tag = (i + 1)
                            tmpButton.addTarget(self, action: #selector(self.buttonFilterTap(sender:)), for: .touchUpInside)
                            self.buttonList.append(tmpButton)
                            self.buttonFiltersStackView.addArrangedSubview(tmpButton)
                        }
                        else {
                            let buttonAttributedText = NSAttributedString(string: value.genres[i].name, attributes: buttonAttributes)
                            tmpButton.setAttributedTitle(buttonAttributedText, for: .normal)
                            tmpButton.tag = (i + 1)
                            tmpButton.addTarget(self, action: #selector(self.buttonFilterTap(sender:)), for: .touchUpInside)
                            self.buttonList.append(tmpButton)
                            self.buttonFiltersStackView.addArrangedSubview(tmpButton)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        })
        
        let urlListName: String!
        let labelName: String!
        
        switch inputGroup {
        case .popular:
            urlListName = "popular"
            labelName = "What's popular"
        case .trending:
            urlListName = "trending"
            labelName = "Trending"
        case .topRated:
            urlListName = "top_rated"
            labelName = "Top Rated"
        case .recommendations:
            urlListName = "recommendations"
            labelName = "Recommendations"
        }
        
        networkService.getMovieList(listName: urlListName, completionHandler: { (result: Result<MovieListModel, RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let value):
                DispatchQueue.main.async {
                    self.movieListModel = value
                    self.collectionView.dataSource = self
                    self.moviesGroup.text = labelName
                }
            }
        })
    }
    
    @objc private func buttonFilterTap(sender: UIButton) {
        let buttonFont = UIFont(name: "Verdana", size: 16)
        let buttonAttributes: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: StyleConstants.AppColors.textLightGray]
        let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
        
        for i in (1...buttonList.count - 1) {
            if (i == sender.tag) {
                let buttonAttributedText = NSAttributedString(string: (buttonList[i].titleLabel?.text)!, attributes: buttonAttributesBlack)
                buttonList[i].setAttributedTitle(buttonAttributedText, for: .normal)
            }
            else {
                let buttonAttributedText = NSAttributedString(string: (buttonList[i].titleLabel?.text)!, attributes: buttonAttributes)
                buttonList[i].setAttributedTitle(buttonAttributedText, for: .normal)
            }
        }
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
