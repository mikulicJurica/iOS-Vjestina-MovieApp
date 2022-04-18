import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    private var cellView: UIView!
    
    private var moviesGroup: UILabel!
    private var buttonFiltersStackView: UIStackView!
    
    private var buttonArray0: UIButton!
    private var buttonArray1: UIButton!
    private var buttonArray2: UIButton!
    private var buttonArray3: UIButton!
    
    private var collectionView: UICollectionView!
    
    private let groupEnums = MovieGroup.allCases

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
        moviesGroup.textColor = styleConstants.appColors.darkGray
        moviesGroup.font = UIFont(name: "Verdana-Bold", size: 20)
        cellView.addSubview(moviesGroup)
        
        buttonFiltersStackView = UIStackView()
        buttonFiltersStackView.axis = .horizontal
        buttonFiltersStackView.alignment = .fill
        buttonFiltersStackView.distribution = .fillEqually
        buttonFiltersStackView.spacing = 0
        
        cellView.addSubview(buttonFiltersStackView)
        
        buttonArray0 = UIButton()
        buttonArray1 = UIButton()
        buttonArray2 = UIButton()
        buttonArray3 = UIButton()
        
        buttonArray0.addTarget(self, action: #selector(buttonPressed0), for: .touchUpInside)
        buttonArray1.addTarget(self, action: #selector(buttonPressed1), for: .touchUpInside)
        buttonArray2.addTarget(self, action: #selector(buttonPressed2), for: .touchUpInside)
        buttonArray3.addTarget(self, action: #selector(buttonPressed3), for: .touchUpInside)
        
        buttonFiltersStackView.addArrangedSubview(buttonArray0)
        buttonFiltersStackView.addArrangedSubview(buttonArray1)
        buttonFiltersStackView.addArrangedSubview(buttonArray2)
        buttonFiltersStackView.addArrangedSubview(buttonArray3)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cellView.addSubview(collectionView)
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        cellView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func buildCellConstraints() {
        cellView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(styleConstants.mainTableViewCellLengths.spaceLengthMedium/2)
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
            $0.bottom.equalToSuperview().inset(styleConstants.mainTableViewCellLengths.spaceLengthBottom)
            $0.height.equalTo(styleConstants.collectionViewCellLengths.collectionCellHeight)
        }
    }
    
    func set(inputGroup: MovieGroup) {
        let buttonFont = UIFont(name: "Verdana", size: 16)
        let buttonAttributes: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: styleConstants.appColors.textLightGray]
        let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
        
        switch inputGroup {
        case .popular:
            
            var buttonAttributedText = NSAttributedString(string: "Streaming", attributes: buttonAttributesBlack)
            buttonArray0.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "On Tv", attributes: buttonAttributes)
            buttonArray1.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "For Rent", attributes: buttonAttributes)
            buttonArray2.setAttributedTitle(buttonAttributedText, for: .normal)
            
            let buttonFont3 = UIFont(name: "Verdana", size: 14)
            let buttonAttributes3: [NSAttributedString.Key: Any] = [.font: buttonFont3!, .foregroundColor: styleConstants.appColors.textLightGray]
            buttonAttributedText = NSAttributedString(string: "In Theaters", attributes: buttonAttributes3)
            buttonArray3.setAttributedTitle(buttonAttributedText, for: .normal)
            
            moviesGroup.text = "What's popular"
        case .freeToWatch:
            
            var buttonAttributedText = NSAttributedString(string: "Drama", attributes: buttonAttributesBlack)
            buttonArray0.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "Thriller", attributes: buttonAttributes)
            buttonArray1.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "Horror", attributes: buttonAttributes)
            buttonArray2.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "Comedy", attributes: buttonAttributes)
            buttonArray3.setAttributedTitle(buttonAttributedText, for: .normal)
            
            moviesGroup.text = "Free To Watch"
        case .trending:
            
            var buttonAttributedText = NSAttributedString(string: "Day", attributes: buttonAttributesBlack)
            buttonArray0.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "Week", attributes: buttonAttributes)
            buttonArray1.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "Month", attributes: buttonAttributes)
            buttonArray2.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "All Time", attributes: buttonAttributes)
            buttonArray3.setAttributedTitle(buttonAttributedText, for: .normal)
            
            moviesGroup.text = "Trending"
        case .topRated:
            
            var buttonAttributedText = NSAttributedString(string: "Day", attributes: buttonAttributesBlack)
            buttonArray0.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "Week", attributes: buttonAttributes)
            buttonArray1.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "Month", attributes: buttonAttributes)
            buttonArray2.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "All Time", attributes: buttonAttributes)
            buttonArray3.setAttributedTitle(buttonAttributedText, for: .normal)
            
            moviesGroup.text = "Top Rated"
        case .upcoming:
            
            var buttonAttributedText = NSAttributedString(string: "Drama", attributes: buttonAttributesBlack)
            buttonArray0.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "Thriller", attributes: buttonAttributes)
            buttonArray1.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "Horror", attributes: buttonAttributes)
            buttonArray2.setAttributedTitle(buttonAttributedText, for: .normal)
            buttonAttributedText = NSAttributedString(string: "Comedy", attributes: buttonAttributes)
            buttonArray3.setAttributedTitle(buttonAttributedText, for: .normal)
            
            moviesGroup.text = "Upcoming"
        }
    }
    
    @objc private func buttonPressed0(sender: UIButton) {
        let buttonFont = UIFont(name: "Verdana", size: 16)
        let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
        let buttonAttributedText = NSAttributedString(string: (sender.titleLabel?.text)!, attributes: buttonAttributesBlack)
        sender.setAttributedTitle(buttonAttributedText, for: .normal)
        
        let buttonAttributesGrey: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: styleConstants.appColors.textLightGray]
        
        let buttonAttributedTextGrey1 = NSAttributedString(string: (buttonArray1.titleLabel?.text)!, attributes: buttonAttributesGrey)
        buttonArray1.setAttributedTitle(buttonAttributedTextGrey1, for: .normal)
        
        let buttonAttributedTextGrey2 = NSAttributedString(string: (buttonArray2.titleLabel?.text)!, attributes: buttonAttributesGrey)
        buttonArray2.setAttributedTitle(buttonAttributedTextGrey2, for: .normal)
        
        if buttonArray3.titleLabel?.text == "In Theaters" {
            let buttonFontSmall = UIFont(name: "Verdana", size: 14)
            let buttonAttributesGraySmall: [NSAttributedString.Key: Any] = [.font: buttonFontSmall!, .foregroundColor: styleConstants.appColors.textLightGray]
            let buttonAttributedTextGrey3 = NSAttributedString(string: (buttonArray3.titleLabel?.text)!, attributes: buttonAttributesGraySmall)
            buttonArray3.setAttributedTitle(buttonAttributedTextGrey3, for: .normal)
        }
        else {
            let buttonFontSmall = UIFont(name: "Verdana", size: 16)
            let buttonAttributesGraySmall: [NSAttributedString.Key: Any] = [.font: buttonFontSmall!, .foregroundColor: styleConstants.appColors.textLightGray]
            let buttonAttributedTextGrey3 = NSAttributedString(string: (buttonArray3.titleLabel?.text)!, attributes: buttonAttributesGraySmall)
            buttonArray3.setAttributedTitle(buttonAttributedTextGrey3, for: .normal)
        }
    }
    
    @objc private func buttonPressed1(sender: UIButton) {
        let buttonFont = UIFont(name: "Verdana", size: 16)
        let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
        let buttonAttributedText = NSAttributedString(string: (sender.titleLabel?.text)!, attributes: buttonAttributesBlack)
        sender.setAttributedTitle(buttonAttributedText, for: .normal)
        
        let buttonAttributesGrey: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: styleConstants.appColors.textLightGray]
        
        let buttonAttributedTextGrey0 = NSAttributedString(string: (buttonArray0.titleLabel?.text)!, attributes: buttonAttributesGrey)
        buttonArray0.setAttributedTitle(buttonAttributedTextGrey0, for: .normal)
        
        let buttonAttributedTextGrey2 = NSAttributedString(string: (buttonArray2.titleLabel?.text)!, attributes: buttonAttributesGrey)
        buttonArray2.setAttributedTitle(buttonAttributedTextGrey2, for: .normal)
        
        if buttonArray3.titleLabel?.text == "In Theaters" {
            let buttonFontSmall = UIFont(name: "Verdana", size: 14)
            let buttonAttributesGraySmall: [NSAttributedString.Key: Any] = [.font: buttonFontSmall!, .foregroundColor: styleConstants.appColors.textLightGray]
            let buttonAttributedTextGrey3 = NSAttributedString(string: (buttonArray3.titleLabel?.text)!, attributes: buttonAttributesGraySmall)
            buttonArray3.setAttributedTitle(buttonAttributedTextGrey3, for: .normal)
        }
        else {
            let buttonFontSmall = UIFont(name: "Verdana", size: 16)
            let buttonAttributesGraySmall: [NSAttributedString.Key: Any] = [.font: buttonFontSmall!, .foregroundColor: styleConstants.appColors.textLightGray]
            let buttonAttributedTextGrey3 = NSAttributedString(string: (buttonArray3.titleLabel?.text)!, attributes: buttonAttributesGraySmall)
            buttonArray3.setAttributedTitle(buttonAttributedTextGrey3, for: .normal)
        }
    }
    
    @objc private func buttonPressed2(sender: UIButton) {
        let buttonFont = UIFont(name: "Verdana", size: 16)
        let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
        let buttonAttributedText = NSAttributedString(string: (sender.titleLabel?.text)!, attributes: buttonAttributesBlack)
        sender.setAttributedTitle(buttonAttributedText, for: .normal)
        
        let buttonAttributesGrey: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: styleConstants.appColors.textLightGray]
        
        let buttonAttributedTextGrey1 = NSAttributedString(string: (buttonArray1.titleLabel?.text)!, attributes: buttonAttributesGrey)
        buttonArray1.setAttributedTitle(buttonAttributedTextGrey1, for: .normal)
        
        let buttonAttributedTextGrey0 = NSAttributedString(string: (buttonArray0.titleLabel?.text)!, attributes: buttonAttributesGrey)
        buttonArray0.setAttributedTitle(buttonAttributedTextGrey0, for: .normal)
        
        if buttonArray3.titleLabel?.text == "In Theaters" {
            let buttonFontSmall = UIFont(name: "Verdana", size: 14)
            let buttonAttributesGraySmall: [NSAttributedString.Key: Any] = [.font: buttonFontSmall!, .foregroundColor: styleConstants.appColors.textLightGray]
            let buttonAttributedTextGrey3 = NSAttributedString(string: (buttonArray3.titleLabel?.text)!, attributes: buttonAttributesGraySmall)
            buttonArray3.setAttributedTitle(buttonAttributedTextGrey3, for: .normal)
        }
        else {
            let buttonFontSmall = UIFont(name: "Verdana", size: 16)
            let buttonAttributesGraySmall: [NSAttributedString.Key: Any] = [.font: buttonFontSmall!, .foregroundColor: styleConstants.appColors.textLightGray]
            let buttonAttributedTextGrey3 = NSAttributedString(string: (buttonArray3.titleLabel?.text)!, attributes: buttonAttributesGraySmall)
            buttonArray3.setAttributedTitle(buttonAttributedTextGrey3, for: .normal)
        }
    }
    
    @objc private func buttonPressed3(sender: UIButton) {
        let buttonFont = UIFont(name: "Verdana", size: 16)
        
        if buttonArray3.titleLabel?.text == "In Theaters" {
            let buttonFontSmall = UIFont(name: "Verdana", size: 14)
            let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFontSmall!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
            let buttonAttributedText = NSAttributedString(string: (sender.titleLabel?.text)!, attributes: buttonAttributesBlack)
            sender.setAttributedTitle(buttonAttributedText, for: .normal)
        }
        else {
            let buttonAttributesBlack: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.thick.rawValue]
            let buttonAttributedText = NSAttributedString(string: (sender.titleLabel?.text)!, attributes: buttonAttributesBlack)
            sender.setAttributedTitle(buttonAttributedText, for: .normal)
        }
        
        let buttonAttributesGrey: [NSAttributedString.Key: Any] = [.font: buttonFont!, .foregroundColor: styleConstants.appColors.textLightGray]
        
        let buttonAttributedTextGrey1 = NSAttributedString(string: (buttonArray1.titleLabel?.text)!, attributes: buttonAttributesGrey)
        buttonArray1.setAttributedTitle(buttonAttributedTextGrey1, for: .normal)
        
        let buttonAttributedTextGrey2 = NSAttributedString(string: (buttonArray2.titleLabel?.text)!, attributes: buttonAttributesGrey)
        buttonArray2.setAttributedTitle(buttonAttributedTextGrey2, for: .normal)
        
        let buttonAttributedTextGrey0 = NSAttributedString(string: (buttonArray0.titleLabel?.text)!, attributes: buttonAttributesGrey)
        buttonArray0.setAttributedTitle(buttonAttributedTextGrey0, for: .normal)
    }
}

extension MainTableViewCell: UICollectionViewDelegate {

}

extension MainTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: styleConstants.collectionViewCellLengths.collectionCellWidth, height: collectionView.frame.height)
    }
}

extension MainTableViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getNumberOfAllMovies()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell
        else {
            fatalError()
        }

        let imageURLInput = getAllMovieData()[indexPath.row].imageUrl
        cell.set(movieImageUrl: imageURLInput)
        return cell
    }

}
