import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController {
    
    //top bar variables
    private var topBarView: UIView!
    private var imageTitleView: UIImageView!
    private var backButtonTop: UIButton!
    
    //scroll view variables
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var exampleLabel: UILabel!
    
    //movie details top view section
    private var movieDetailsTopView: UIView!
    private var userScoreLabel: UILabel!
    private var userScore: UILabel!
    private var movieTitle: UILabel!
    private var movieDate: UILabel!
    private var movieDescription: UILabel!
    private var movieLength: UILabel!
    private var favouritesButtonView: UIView!
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
    
    //bottom bar variables
    private var bottomBarStackView: UIStackView!
    private var recentsButton: UIButton!
    private var HOMEButton: UIButton!
    private var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        addConstraints()
    }

    private func buildViews() {
        view.backgroundColor = UIColor.white
        
        topBar()
        scrollViewFunc()
        bottomBar()
        appBottomBar()
    }
    
    private func addConstraints() {
        topBarConstraints()
        scrollViewConstraints()
        bottomBarConstraints()
        appBottomBarConstraints()
    }
    
    private func topBar() {
        
        topBarView = UIView()
        topBarView.backgroundColor = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        view.addSubview(topBarView)
        
        
        imageTitleView = UIImageView(image: UIImage(named: "topTitle.pdf"))
        imageTitleView.contentMode = UIView.ContentMode.scaleAspectFill
        imageTitleView.clipsToBounds = true
        topBarView.addSubview(imageTitleView)
        
        
        backButtonTop = UIButton()
        backButtonTop.setBackgroundImage(UIImage(named: "back.pdf"), for: .normal)
        backButtonTop.addTarget(self, action: #selector(backButtonTopPressed), for: .touchUpInside)
        topBarView.addSubview(backButtonTop)
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
        exampleLabel.numberOfLines = 0
        
        contentView.addSubview(movieDetailsTop())
        contentView.addSubview(overviewSection())
        contentView.addSubview(peopleSection())
        contentView.addSubview(exampleLabel)
    }
    
    private func movieDetailsTop() -> UIView {
        
        movieDetailsTopView = UIView()
        
        let image = UIImage(named: "iron_man.jpg")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 303)
        imageView.contentMode = .top
        imageView.clipsToBounds = true

        imageView.image = image!.resizeTopAlignedToFill(newWidth: imageView.frame.width)
        
        movieDetailsTopView.addSubview(imageView)
        
        let imageGradient = UIImage(named: "gradient.pdf")
        let imageGradientView = UIImageView(image: imageGradient)
        imageGradientView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 303)
        imageGradientView.contentMode = .top
        imageGradientView.clipsToBounds = true

        imageGradientView.image = imageGradient!.resizeTopAlignedToFill(newWidth: imageGradientView.frame.width)
        
        movieDetailsTopView.addSubview(imageGradientView)

        userScoreLabel = UILabel()
        userScoreLabel.textColor = UIColor.white
        userScoreLabel.font = UIFont(name: "Verdana-Bold", size: 14)
        userScoreLabel.text = "User Score"
        movieDetailsTopView.addSubview(userScoreLabel)
        
        movieTitle = UILabel()
        movieTitle.textColor = UIColor.white
        movieTitle.font = UIFont(name: "Verdana-Bold", size: 24)
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
        
        favouritesButtonView = UIView()
        favouritesButtonView.backgroundColor = UIColor(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        favouritesButtonView.layer.cornerRadius = 32.0/2.0
        movieDetailsTopView.addSubview(favouritesButtonView)
        
        favouritesButton = UIButton()
        favouritesButton.setImage(UIImage(systemName: "star"), for: .normal)
        favouritesButton.tintColor = UIColor.white
        favouritesButtonView.addSubview(favouritesButton)
        
        
        //percentage view
        percentageView = UIView()
        
        let angle = -(.pi/2)+(76.0/100.0)*(.pi*2)
            
        let path1 = UIBezierPath(arcCenter: percentageView.center, radius: 19.5, startAngle: angle, endAngle: -.pi/2, clockwise: true)
        let path2 = UIBezierPath(arcCenter: percentageView.center, radius: 19.5, startAngle: -.pi/2, endAngle: angle, clockwise: true)
        
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = path1.cgPath
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.lineWidth = 3
        shapeLayer1.strokeColor = UIColor(red: 32.0/255.0, green: 69.0/255.0, blue: 41.0/255.0, alpha: 1.0).cgColor
        
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = path2.cgPath
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.lineWidth = 3
        shapeLayer2.strokeColor = UIColor(red: 33.0/255.0, green: 208.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        
        percentageView.layer.addSublayer(shapeLayer1)
        percentageView.layer.addSublayer(shapeLayer2)
        
        percentageLabel = UILabel()
        percentageLabel.textColor = UIColor.white
        percentageLabel.font = UIFont(name: "Verdana", size: 15)
        percentageLabel.text = "76"//String(percentage)
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
        overviewLabel.textColor = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        overviewLabel.font = UIFont(name: "Verdana-Bold", size: 20)
        overviewLabel.text = "Overview"
        overviewSectionView.addSubview(overviewLabel)
        
        overviewDescriptionLabel = UILabel()
        overviewDescriptionLabel.textColor = UIColor.black
        overviewDescriptionLabel.font = UIFont(name: "Verdana", size: 14)
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

        upperStackView.addArrangedSubview(makePersonView(personName: "Don Heck", personJob: "Characters"))
        upperStackView.addArrangedSubview(makePersonView(personName: "Jack Kirby", personJob: "Characters"))
        upperStackView.addArrangedSubview(makePersonView(personName: "Jon Favreau", personJob: "Director"))

        lowerStackView.addArrangedSubview(makePersonView(personName: "Don Heck", personJob: "Screenplay"))
        lowerStackView.addArrangedSubview(makePersonView(personName: "Jack Marcum", personJob: "Screenplay"))
        lowerStackView.addArrangedSubview(makePersonView(personName: "Matt Holloway", personJob: "Screenplay"))
        
        return overviewPeopleView
    }
    
    private func bottomBar() {
        
        bottomBarStackView = UIStackView()
        bottomBarStackView.axis = .horizontal
        bottomBarStackView.alignment = .fill
        bottomBarStackView.distribution = .fillEqually
        bottomBarStackView.spacing = 0
        
        view.addSubview(bottomBarStackView)
        
        let recentsButtonView = UIView()
        recentsButton = UIButton()
        recentsButton.setBackgroundImage(UIImage(named: "recents.pdf"), for: .normal)
        recentsButtonView.addSubview(recentsButton)
        
        let HOMEButtonView = UIView()
        HOMEButton = UIButton()
        HOMEButton.setBackgroundImage(UIImage(named: "home.pdf"), for: .normal)
        HOMEButtonView.addSubview(HOMEButton)
        
        let backButtonView = UIView()
        backButton = UIButton()
        backButton.setBackgroundImage(UIImage(named: "back_bottom.pdf"), for: .normal)
        backButtonView.addSubview(backButton)
        
        bottomBarStackView.addArrangedSubview(recentsButtonView)
        bottomBarStackView.addArrangedSubview(HOMEButtonView)
        bottomBarStackView.addArrangedSubview(backButtonView)
    }
    
    private func appBottomBar() {
        
        appBottomBarView = UIView()
        
        view.addSubview(appBottomBarView)
        
        homeButtonView = UIView()
        
        homeButton = UIButton()
        homeButton.setBackgroundImage(UIImage(named: "home_app_pressed.pdf"), for: .normal)
        homeButtonView.addSubview(homeButton)
        
        homeButtonTitle = UILabel()
        homeButtonTitle.textColor = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        homeButtonTitle.font = UIFont(name: "Verdana-Bold", size: 10)
        homeButtonTitle.text = "Home"
        homeButtonView.addSubview(homeButtonTitle)
        
        favoritesButtonView = UIView()
        
        favoritesButton = UIButton()
        favoritesButton.setBackgroundImage(UIImage(named: "favorites.pdf"), for: .normal)
        favoritesButtonView.addSubview(favoritesButton)
        
        favoritesButtonTitle = UILabel()
        favoritesButtonTitle.textColor = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        favoritesButtonTitle.font = UIFont(name: "Verdana", size: 10)
        favoritesButtonTitle.text = "Favorites"
        favoritesButtonView.addSubview(favoritesButtonTitle)

        appBottomBarView.addSubview(favoritesButtonView)
        appBottomBarView.addSubview(homeButtonView)
    }
    
    private func topBarConstraints() {
        
        topBarView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(80)
        })
        
        imageTitleView.snp.makeConstraints({
            $0.centerX.equalTo(topBarView)
            $0.bottom.equalTo(topBarView).inset(6)
        })
        
        backButtonTop.snp.makeConstraints({
            $0.leading.equalTo(topBarView).inset(16)
            $0.bottom.equalTo(topBarView).inset(18.1)
        })
    }
    
    private func scrollViewConstraints() {
        scrollView.snp.makeConstraints({
            $0.top.equalTo(topBarView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(appBottomBarView.snp.top)
        })
        
        contentView.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        })
        
        movieDetailsTopConstraints()
        overviewSectionConstraints()
        peopleSectionConstraint()
        
        exampleLabel.snp.makeConstraints({
            $0.top.equalTo(overviewPeopleView.snp.bottom).inset(-400)
            $0.bottom.leading.trailing.equalToSuperview()
        })
    }
    
    private func movieDetailsTopConstraints() {
        
        movieDetailsTopView.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(303)
        })
        
        userScoreLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(71)
            $0.top.equalToSuperview().inset(122)
        })
        
        movieTitle.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(159)
        })
        
        movieDate.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(196)
        })
        
        movieDescription.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview().inset(67)
        })
        
        movieLength.snp.makeConstraints({
            $0.leading.equalTo(movieDescription.snp.trailing).offset(14)
            $0.bottom.equalToSuperview().inset(67)
        })
        
        favouritesButtonView.snp.makeConstraints({
            $0.width.height.equalTo(32)
            $0.leading.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview().inset(20)
        })
        
        favouritesButton.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(15)
            $0.height.equalTo(15)
        })
        
        percentageView.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(21+21)
            $0.top.equalToSuperview().inset(108+21)
            $0.width.height.equalTo(21)
        })
        
        percentageLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(-13)
            $0.top.equalToSuperview().inset(-10)
        })
        
        percentageSign.snp.makeConstraints({
            $0.leading.equalTo(percentageLabel.snp.trailing)
            $0.bottom.equalTo(percentageLabel).offset(-1.5)
        })
    }
    
    private func overviewSectionConstraints() {
        overviewSectionView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(movieDetailsTopView.snp.bottom)
            $0.bottom.equalTo(overviewDescriptionLabel.snp.bottom)
        })
        
        overviewLabel.snp.makeConstraints({
            $0.leading.equalTo(overviewSectionView).inset(18)
            $0.top.equalTo(overviewSectionView).inset(20)
        })

        overviewDescriptionLabel.snp.makeConstraints({
            $0.leading.equalTo(overviewSectionView).inset(16)
            $0.trailing.equalTo(overviewSectionView).inset(27)
            $0.top.equalTo(overviewLabel.snp.bottom).offset(8)
        })
    }
    
    private func peopleSectionConstraint() {
        overviewPeopleView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(overviewSectionView.snp.bottom)
            $0.height.equalTo(128)
        })

        upperStackView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview().inset(128/2)
        })

        lowerStackView.snp.makeConstraints({
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(upperStackView.snp.bottom).offset(26)
        })
    }
    
    private func bottomBarConstraints() {
        bottomBarStackView.snp.makeConstraints({
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(42)
        })
        
        recentsButton.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
        
        HOMEButton.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
        
        backButton.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
    }
    
    private func appBottomBarConstraints() {
        appBottomBarView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomBarStackView.snp.top)
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
    
    private func makePersonView(personName: String, personJob: String) -> UIView {
        let personView = UIView()
        
        let personNameLabel = UILabel()
        personNameLabel.textColor = .black
        personNameLabel.font = UIFont(name: "Verdana-Bold", size: 14)
        personNameLabel.text = personName
        personView.addSubview(personNameLabel)

        let personJobLabel = UILabel()
        personJobLabel.textColor = .black
        personJobLabel.font = UIFont(name: "Verdana", size: 14)
        personJobLabel.text = personJob
        personView.addSubview(personJobLabel)
        
        personNameLabel.snp.makeConstraints({
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-19.6/2)
        })
        
        personJobLabel.snp.makeConstraints({
            $0.leading.equalTo(personNameLabel.snp.leading)
            $0.centerY.equalToSuperview().offset(19.6/2)
        })
        
        return personView
    }
    
    
    
    
    @objc private func backButtonTopPressed() {
        print("Idi natrag.")
    }
}

extension UIImage {
    func resizeTopAlignedToFill(newWidth: CGFloat) -> UIImage? {
        let newHeight = size.height * newWidth / size.width

        let newSize = CGSize(width: newWidth, height: newHeight)

        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}