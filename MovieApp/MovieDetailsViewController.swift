import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController {
    
    //scroll view variables
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var exampleLabel: UILabel!
    
    //movie details top view section
    private var movieDetailsTopView: UIView!
    private var imageMovieView: UIImageView!
    private var imageGradientView: UIImageView!
    private var userScoreLabel: UILabel!
    private var userScore: UILabel!
    private var movieTitle: UILabel!
    private var movieDate: UILabel!
    private var movieDescription: UILabel!
    private var movieLength: UILabel!
    private var favouritesButton: UIButton!
    private var percentageView: UIView!
    private var percentageLabel: UILabel!
    private var percentageSign: UILabel!
    
    //overview section
    private var overviewSectionView: UIView!
    private var overviewLabel: UILabel!
    private var overviewDescriptionLabel: UILabel!
    
    //overview people section
    private var overviewPeopleView: UIView!
    private var upperStackView: UIStackView!
    private var lowerStackView: UIStackView!
    
    //app bottom bar variables
    private var appBottomBarView: UIView!
    private var homeButtonView: UIView!
    private var homeButton: UIButton!
    private var homeButtonTitle: UILabel!
    private var favoritesButtonView: UIView!
    private var favoritesButton: UIButton!
    private var favoritesButtonTitle: UILabel!
    
    //style
    private let movieDetailsTopViewHeight: Float = 400.0
    private let baseLength: Float = 18.0
    private let favouritesButtonSize: Float = 32.0
    private let percentageViewSize: Float = 21.0
    private let textElementSpaceSize: Float = 15.0
    
    //movie model
    ///////////////////////////private var movieModel: MovieModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /////////////////////movieModel = MovieModel()
        
        buildViews()
        addConstraints()
    }

    private func buildViews() {
        view.backgroundColor = .white
        
        scrollViewFunc()
        appBottomBar()
    }
    
    private func addConstraints() {
        scrollViewConstraints()
        appBottomBarConstraints()
    }
    
    private func scrollViewFunc() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        scrollView.bounces = false
        
        
        //provjera scroll-a
        exampleLabel = UILabel()
        exampleLabel.text = "START---------------------------------------PROVJERA SCROLLA-------------------------------------------END"
        //exampleLabel.numberOfLines = 0
        
        contentView.addSubview(movieDetailsTop())
        contentView.addSubview(overviewSection())
        contentView.addSubview(peopleSection())
        contentView.addSubview(exampleLabel)
    }
    
    private func movieDetailsTop() -> UIView {
        
        movieDetailsTopView = UIView()
        
        imageMovieView = UIImageView(image: UIImage(named: "iron_man"))
        imageMovieView.contentMode = UIView.ContentMode.scaleAspectFill
        imageMovieView.clipsToBounds = true
        movieDetailsTopView.addSubview(imageMovieView)
        
        imageGradientView = UIImageView(image: UIImage(named: "gradient"))
        imageGradientView.contentMode = UIView.ContentMode.scaleAspectFill
        imageGradientView.clipsToBounds = true
        movieDetailsTopView.addSubview(imageGradientView)

        userScoreLabel = UILabel()
        userScoreLabel.textColor = UIColor.white
        userScoreLabel.font = UIFont(name: "Verdana-Bold", size: 14)
        userScoreLabel.text = "User Score"
        movieDetailsTopView.addSubview(userScoreLabel)
        
        movieTitle = UILabel()
        movieTitle.textColor = UIColor.white
        movieTitle.font = UIFont(name: "Verdana-Bold", size: 24)
        //movieTitle.text = movieModel.movieName
        movieTitle.text = "Iron man (2008)"
        movieDetailsTopView.addSubview(movieTitle)
        
        movieDate = UILabel()
        movieDate.textColor = UIColor.white
        movieDate.font = UIFont(name: "Verdana", size: 14)
        movieDate.text = "05/02/2008 (US)"
        movieDetailsTopView.addSubview(movieDate)
        
        movieDescription = UILabel()
        movieDescription.textColor = UIColor.white
        movieDescription.font = UIFont(name: "Verdana", size: 14)
        movieDescription.text = "Action, Science Fiction, Adventure"
        movieDetailsTopView.addSubview(movieDescription)
        
        movieLength = UILabel()
        movieLength.textColor = UIColor.white
        movieLength.font = UIFont(name: "Verdana-Bold", size: 14)
        movieLength.text = "2h 6m"
        movieDetailsTopView.addSubview(movieLength)
        
        favouritesButton = UIButton()
        favouritesButton.setImage(UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(scale: .small)), for: .normal)
        favouritesButton.backgroundColor = styleConstants.appColors.appBlack
        favouritesButton.addTarget(self, action: #selector(favouritesButtonTap), for: .touchUpInside)
        favouritesButton.layer.cornerRadius = CGFloat(favouritesButtonSize/2.0)
        favouritesButton.tintColor = UIColor.white
        movieDetailsTopView.addSubview(favouritesButton)
        
        
        //percentage view
        percentageView = UIView()
        
        let angle = -(.pi/2)+(76.0/100.0)*(.pi*2)
            
        let path1 = UIBezierPath(arcCenter: percentageView.center, radius: 19.5, startAngle: angle, endAngle: -.pi/2, clockwise: true)
        let path2 = UIBezierPath(arcCenter: percentageView.center, radius: 19.5, startAngle: -.pi/2, endAngle: angle, clockwise: true)
        
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = path1.cgPath
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.lineWidth = 3
        shapeLayer1.strokeColor = styleConstants.appColors.darkGreen.cgColor
        
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = path2.cgPath
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.lineWidth = 3
        shapeLayer2.strokeColor = styleConstants.appColors.lightGreen.cgColor
        
        percentageView.layer.addSublayer(shapeLayer1)
        percentageView.layer.addSublayer(shapeLayer2)
        
        percentageLabel = UILabel()
        percentageLabel.textColor = UIColor.white
        percentageLabel.font = UIFont(name: "Verdana", size: 15)
        percentageLabel.text = "76" //String(percentage)
        percentageView.addSubview(percentageLabel)
        
        percentageSign = UILabel()
        percentageSign.textColor = UIColor.white
        percentageSign.font = UIFont(name: "Verdana", size: 9)
        percentageSign.text = "%"
        percentageView.addSubview(percentageSign)
        
        movieDetailsTopView.addSubview(percentageView)
        
        return movieDetailsTopView
    }
    
    private func overviewSection() -> UIView {
        overviewSectionView = UIView()
        
        overviewLabel = UILabel()
        overviewLabel.textColor = styleConstants.appColors.darkGray
        overviewLabel.font = UIFont(name: "FONTSPRINGDEMO-ProximaNovaExtraboldRegular", size: 20)
        overviewLabel.text = "Overview"
        overviewSectionView.addSubview(overviewLabel)
        
        overviewDescriptionLabel = UILabel()
        overviewDescriptionLabel.textColor = UIColor.black
        overviewDescriptionLabel.font = UIFont(name: "FONTSPRINGDEMO-ProximaNovaRegular", size: 14)
        overviewDescriptionLabel.text = "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil."
        overviewDescriptionLabel.numberOfLines = 0
        
        overviewSectionView.addSubview(overviewDescriptionLabel)
        
        return overviewSectionView
    }
    
    private func peopleSection() -> UIView {
        overviewPeopleView = UIView()
        
        upperStackView = UIStackView()
        upperStackView.axis = .horizontal
        upperStackView.alignment = .fill
        upperStackView.distribution = .fillEqually
        upperStackView.spacing = 5
        
        lowerStackView = UIStackView()
        lowerStackView.axis = .horizontal
        lowerStackView.alignment = .fill
        lowerStackView.distribution = .fillEqually
        lowerStackView.spacing = 5
        
        overviewPeopleView.addSubview(upperStackView)
        overviewPeopleView.addSubview(lowerStackView)
        
//        for i in 1...2 {
//            for i in 1...3 {
//                let person = personView(personName: "Don Heck", personJob: "Characters")
//              // statements
//            }
//        }
        
        var person = personView(personName: "Don Heck", personJob: "Characters")
        upperStackView.addArrangedSubview(person.makePersonView())
        
        person = personView(personName: "Jack Kirby", personJob: "Characters")
        upperStackView.addArrangedSubview(person.makePersonView())
        
        person = personView(personName: "Jon Favreau", personJob: "Director")
        upperStackView.addArrangedSubview(person.makePersonView())

        
        person = personView(personName: "Don Heck", personJob: "Screenplay")
        lowerStackView.addArrangedSubview(person.makePersonView())
        
        person = personView(personName: "Jack Marcum", personJob: "Screenplay")
        lowerStackView.addArrangedSubview(person.makePersonView())
        
        person = personView(personName: "Matt Holloway", personJob: "Screenplay")
        lowerStackView.addArrangedSubview(person.makePersonView())
        
        return overviewPeopleView
    }
    
    private func appBottomBar() {
        
        appBottomBarView = UIView()
        
        view.addSubview(appBottomBarView)
        
        homeButtonView = UIView()
        
        homeButton = UIButton()
        homeButton.setBackgroundImage(UIImage(named: "home_app_pressed.pdf"), for: .normal)
        homeButtonView.addSubview(homeButton)
        
        homeButtonTitle = UILabel()
        homeButtonTitle.textColor = styleConstants.appColors.darkGray
        homeButtonTitle.font = UIFont(name: "Verdana-Bold", size: 10)
        homeButtonTitle.text = "Home"
        homeButtonView.addSubview(homeButtonTitle)
        
        favoritesButtonView = UIView()
        
        favoritesButton = UIButton()
        favoritesButton.setBackgroundImage(UIImage(named: "favorites.pdf"), for: .normal)
        favoritesButtonView.addSubview(favoritesButton)
        
        favoritesButtonTitle = UILabel()
        favoritesButtonTitle.textColor = styleConstants.appColors.darkGray
        favoritesButtonTitle.font = UIFont(name: "Verdana", size: 10)
        favoritesButtonTitle.text = "Favorites"
        favoritesButtonView.addSubview(favoritesButtonTitle)

        appBottomBarView.addSubview(favoritesButtonView)
        appBottomBarView.addSubview(homeButtonView)
    }
    
    private func scrollViewConstraints() {
        scrollView.snp.makeConstraints({
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(appBottomBarView.snp.top)
        })
        
        contentView.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        })
        
        movieDetailsTopConstraints()
        overviewSectionConstraints()
        peopleSectionConstraint()
        
        
        // samo za probu
        exampleLabel.snp.makeConstraints({
            $0.top.equalTo(overviewPeopleView.snp.bottom).inset(-400)
            $0.bottom.leading.trailing.equalToSuperview()
        })
    }
    
    private func movieDetailsTopConstraints() {
        
        movieDetailsTopView.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(movieDetailsTopViewHeight)
        })
        
        imageMovieView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        imageGradientView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        favouritesButton.snp.makeConstraints({
            $0.width.height.equalTo(favouritesButtonSize)
            $0.leading.bottom.equalToSuperview().inset(baseLength)
        })
        
        movieLength.snp.makeConstraints({
            $0.trailing.equalToSuperview().inset(60)
            $0.bottom.equalTo(favouritesButton.snp.top).offset(-textElementSpaceSize)
        })
        
        movieDescription.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(baseLength)
            $0.trailing.equalTo(movieLength.snp.leading).offset(-textElementSpaceSize/2)
            $0.bottom.equalTo(favouritesButton.snp.top).offset(-textElementSpaceSize)
        })
        
        movieDate.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(baseLength)
            $0.bottom.equalTo(movieDescription.snp.top).offset(-textElementSpaceSize/5)
        })

        movieTitle.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(baseLength)
            $0.bottom.equalTo(movieDate.snp.top).offset(-textElementSpaceSize/2)
        })
        
        percentageView.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(baseLength+percentageViewSize)
            $0.bottom.equalTo(movieTitle.snp.top).offset(-textElementSpaceSize)
            $0.width.height.equalTo(percentageViewSize)
        })
        
        percentageLabel.snp.makeConstraints({
            $0.centerX.equalTo(percentageView.snp.leading).offset(-percentageViewSize/4)
            $0.centerY.equalToSuperview().offset(-percentageViewSize/2)
        })
        
        percentageSign.snp.makeConstraints({
            $0.leading.equalTo(percentageLabel.snp.trailing)
            $0.bottom.equalTo(percentageLabel.snp.bottom).offset(-percentageViewSize/15)
        })
        
        userScoreLabel.snp.makeConstraints({
            $0.leading.equalTo(percentageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(percentageLabel.snp.centerY)
        })
    }
    
    private func overviewSectionConstraints() {
        overviewSectionView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(movieDetailsTopView.snp.bottom)
            $0.bottom.equalTo(overviewDescriptionLabel.snp.bottom)
        })
        
        overviewLabel.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview().inset(baseLength)
        })

        overviewDescriptionLabel.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(baseLength)
            $0.top.equalTo(overviewLabel.snp.bottom).offset(9)
        })
    }
    
    private func peopleSectionConstraint() {
        overviewPeopleView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(baseLength)
            $0.top.equalTo(overviewSectionView.snp.bottom).offset(baseLength)
        })

        upperStackView.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview()
        })

        lowerStackView.snp.makeConstraints({
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(upperStackView.snp.bottom).offset(26)
        })
    }
    
    private func appBottomBarConstraints() {
        appBottomBarView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(56)
        })
        
        homeButtonView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(-(94/2)-20)
        })
        
        homeButton.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset((-8.56/2) - (16.57/2))
        })
        
        homeButtonTitle.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(8.56/2 + 5)
        })
        
        favoritesButtonView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset((94/2)+20)
        })
        
        favoritesButton.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset((-9/2) - (14/2))
        })
        
        favoritesButtonTitle.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(9/2 + 5)
        })
    }
    
    @objc private func favouritesButtonTap() {
        print("TAP!")
    }
}
