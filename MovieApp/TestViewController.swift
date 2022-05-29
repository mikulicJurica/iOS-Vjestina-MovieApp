import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    private var moviesRepository = MoviesRepository()
    
    private var gumb: UIButton!
    private var gumbDva: UIButton!
    private var labela: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        addConstraints()
    }

    private func buildViews() {
        view.backgroundColor = .white
        
        gumb = UIButton()
        gumb.backgroundColor = .red
        gumb.addTarget(self, action: #selector(stisni), for: .touchUpInside)
        
        gumbDva = UIButton()
        gumbDva.backgroundColor = .blue
        gumbDva.addTarget(self, action: #selector(stisniDva), for: .touchUpInside)
        
        labela = UILabel()
        
        view.addSubview(gumb)
        view.addSubview(gumbDva)
        view.addSubview(labela)
    }
    
    @objc func stisni() {
        
        moviesRepository.relationships()
//        moviesRepository.allMoviesFromNetworkToDatabase()
//        moviesRepository.getMoviesFromDatabase()
//        moviesRepository.getMovieTop()
    }
    
    @objc func stisniDva() {
    }
    
    private func addConstraints() {
        gumbConstraints()
    }
    
    private func gumbConstraints() {
        gumb.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.height.width.equalTo(200)
        })
        
        gumbDva.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.height.width.equalTo(200)
        })
        
        labela.snp.makeConstraints({
            $0.bottom.width.equalToSuperview()
            $0.height.equalTo(100)
        })
    }
}
