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
    private var favouritesImageFill: UIImageView!
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
    
    //style
    private var animationConstraint: CGFloat!
    private let movieDetailsTopViewHeight: Float = 400.0
    private let baseLength: Float = 18.0
    private let favouritesButtonSize: Float = 32.0
    private let favouritesImageFillSize: Float = 16.0
    private let favouritesImageNormalSize: Float = 0.4
    private let percentageViewSize: Float = 21.0
    private let textElementSpaceSize: Float = 15.0
    
    private var movie: Movie!
    
    private var moviesRepository = MoviesRepository()
    
    convenience init(movie: Movie) {
        self.init()
        self.movie = movie
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animationConstraint = view.frame.width
        
        movieTitle.snp.remakeConstraints({
            $0.centerX.equalToSuperview().offset(animationConstraint)
            $0.bottom.equalTo(movieDate.snp.top).offset(-textElementSpaceSize/2)
        })
        
        movieDate.snp.remakeConstraints({
            $0.centerX.equalToSuperview().offset(animationConstraint)
            $0.bottom.equalTo(movieDescription.snp.top).offset(-textElementSpaceSize/5)
        })
        
        movieDescription.snp.remakeConstraints({
            $0.centerX.equalToSuperview().offset(animationConstraint)
            $0.bottom.equalTo(favouritesButton.snp.top).offset(-textElementSpaceSize)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.movieTitle.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview().inset(self.baseLength)
                $0.bottom.equalTo(self.movieDate.snp.top).offset(-self.textElementSpaceSize/2)
            }
            
            self.view.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveLinear, animations: {
            self.movieDate.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview().inset(self.baseLength)
                $0.bottom.equalTo(self.movieDescription.snp.top).offset(-self.textElementSpaceSize/5)
            }
            
            self.view.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 1, delay: 0.75, options: .curveEaseInOut, animations: {
            self.movieDescription.snp.remakeConstraints {
                $0.leading.equalToSuperview().inset(self.baseLength)
                $0.trailing.equalTo(self.movieLength.snp.leading).offset(-self.textElementSpaceSize/2)
                $0.bottom.equalTo(self.favouritesButton.snp.top).offset(-self.textElementSpaceSize)
            }

            self.view.layoutIfNeeded()
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        addConstraints()
    }

    private func buildViews() {
        view.backgroundColor = .white
        
        TopBottomNavigationView()
        scrollViewFunc()
    }
    
    private func addConstraints() {
        scrollViewConstraints()
    }
    
    private func TopBottomNavigationView() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "topTitle"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(goBack))
    }
    
    @objc private func goBack() {
        UIApplication.topViewController()?.navigationController?.popViewController(animated: true)
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
        let yearStringArr = movie.releaseDate!.components(separatedBy: "-")
        let yearString = yearStringArr[0]
        let monthString = yearStringArr[1]
        let dayString = yearStringArr[2]
        
        movieDetailsTopView = UIView()
        
        let imageUrl = "https://image.tmdb.org/t/p/original" + movie.posterPath!
        
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        
        if (data != nil) {
            imageMovieView = UIImageView(image: UIImage(data: data!))
        }
        else {
            imageMovieView = UIImageView(image: UIImage(named: "nopicture"))
        }
        
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
        movieTitle.text = "\(movie.title ?? "none") (\(yearString))"
        movieDetailsTopView.addSubview(movieTitle)
        
        movieDate = UILabel()
        movieDate.textColor = UIColor.white
        movieDate.font = UIFont(name: "Verdana", size: 14)
        movieDate.text = "\(dayString)/\(monthString)/\(yearString) (US)"
        movieDetailsTopView.addSubview(movieDate)
        
        movieDescription = UILabel()
        movieDescription.textColor = UIColor.white
        movieDescription.font = UIFont(name: "Verdana", size: 14)
        movieDetailsTopView.addSubview(movieDescription)
        let tmpMovieGenres = movie.genreIds
        var movieGenresString = ""
        moviesRepository.getAllGenres(completion: { genres in
            for genreDatabase in genres! {
                for genreMovie in tmpMovieGenres! {
                    if (genreDatabase.id == genreMovie) {
                        movieGenresString += genreDatabase.name!
                        movieGenresString += ", "
                    }
                }
            }
            movieGenresString.removeLast(2)
        })
        movieDescription.text = movieGenresString
        
        
        movieLength = UILabel()
        movieLength.textColor = UIColor.white
        movieLength.font = UIFont(name: "Verdana-Bold", size: 14)
        let tmpTuple = minutesToHoursAndMinutes(100)
        movieLength.text = "\(tmpTuple.hours)h \(tmpTuple.leftMinutes)m"
        movieDetailsTopView.addSubview(movieLength)
        
        favouritesButton = UIButton()
        favouritesButton.backgroundColor = StyleConstants.AppColors.appBlack
        favouritesButton.layer.cornerRadius = CGFloat(favouritesButtonSize/2.0)
        favouritesButton.tintColor = UIColor.white
        favouritesButton.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(scale: .default)), for: .normal)
        favouritesButton.addTarget(self, action: #selector(changeFavoriteState), for: .touchUpInside)
        
        favouritesImageFill = UIImageView(image: UIImage(named: "favorites"))
        favouritesImageFill.contentMode = UIView.ContentMode.scaleAspectFill
        favouritesButton.addSubview(favouritesImageFill)
        
        if (movie.favorite) {
            makeFavoriteToFill()
        }
        else {
            makeFavoriteToNormal()
        }
        movieDetailsTopView.addSubview(favouritesButton)
        
        //percentage view
        percentageView = UIView()
        let userScore = movie.voteAverage * 10
        let angle = -(.pi/2)+(userScore/100.0)*(.pi*2)
            
        let path1 = UIBezierPath(arcCenter: percentageView.center, radius: 19.5, startAngle: CGFloat(angle), endAngle: -.pi/2, clockwise: true)
        let path2 = UIBezierPath(arcCenter: percentageView.center, radius: 19.5, startAngle: -.pi/2, endAngle: CGFloat(angle), clockwise: true)
        
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = path1.cgPath
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.lineWidth = 3
        shapeLayer1.strokeColor = StyleConstants.AppColors.darkGreen.cgColor
        
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = path2.cgPath
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.lineWidth = 3
        shapeLayer2.strokeColor = StyleConstants.AppColors.lightGreen.cgColor
        
        percentageView.layer.addSublayer(shapeLayer1)
        percentageView.layer.addSublayer(shapeLayer2)
        
        percentageLabel = UILabel()
        percentageLabel.textColor = UIColor.white
        percentageLabel.font = UIFont(name: "Verdana", size: 15)
        percentageLabel.text = String(Int(userScore))
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
        overviewLabel.textColor = StyleConstants.AppColors.darkGray
        overviewLabel.font = UIFont(name: "FONTSPRINGDEMO-ProximaNovaExtraboldRegular", size: 20)
        overviewLabel.text = "Overview"
        overviewSectionView.addSubview(overviewLabel)
        
        overviewDescriptionLabel = UILabel()
        overviewDescriptionLabel.textColor = UIColor.black
        overviewDescriptionLabel.font = UIFont(name: "FONTSPRINGDEMO-ProximaNovaRegular", size: 14)
        overviewDescriptionLabel.text = movie.overview
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
    
    private func scrollViewConstraints() {
        scrollView.snp.makeConstraints({
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
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
        
//        favouritesImageFill.snp.makeConstraints({
//            $0.width.height.equalTo(favouritesImageFillSize)
//            $0.center.equalToSuperview()
//        })
        
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
    
    func minutesToHoursAndMinutes(_ minutes: Int) -> (hours: Int , leftMinutes: Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    @objc private func changeFavoriteState() {
        moviesRepository.changeFavoriteMovieState(inputMovie: movie, completion: { isDone in
            if (isDone) {
                if (movie.favorite) {
                    movie.favorite = false
                    UIView.animate(withDuration: 0.5, animations: {
                        self.remakeFavoriteToNormal()
                        self.view.layoutIfNeeded()
                    })
                }
                else {
                    movie.favorite = true
                    UIView.animate(withDuration: 0.5, animations: {
                        self.remakeFavoriteToFill()
                        self.view.layoutIfNeeded()
                    })
                }
            }
        })
    }
    
    private func makeFavoriteToFill() {
        favouritesImageFill.layer.opacity = 1
        favouritesImageFill.snp.makeConstraints({
            $0.width.height.equalTo(favouritesImageFillSize)
            $0.center.equalToSuperview()
        })
    }
    
    private func makeFavoriteToNormal() {
        favouritesImageFill.snp.makeConstraints({
            $0.width.height.equalTo(favouritesImageNormalSize)
            $0.center.equalToSuperview()
        })
        favouritesImageFill.layer.opacity = 0
    }
    
    private func remakeFavoriteToFill() {
        favouritesImageFill.layer.opacity = 1
        favouritesImageFill.snp.remakeConstraints({
            $0.width.height.equalTo(favouritesImageFillSize)
            $0.center.equalToSuperview()
        })
    }
    
    private func remakeFavoriteToNormal() {
        favouritesImageFill.snp.remakeConstraints({
            $0.width.height.equalTo(favouritesImageNormalSize)
            $0.center.equalToSuperview()
        })
        favouritesImageFill.layer.opacity = 0
    }
}
