import UIKit
import SnapKit
import MovieAppData

//table view of searching movies
class SearchTableViewController: UIViewController {
    
    //movie list when searching
    private var movieSearchListTableView: UITableView!
    
    let searchTableViewCellName = "MovieTableViewCell"
    
    
    private let movies = Movies.all()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        buildTableSearchingListView()
        addSearchingListConstraints()
    }
    
    func reloadListMovies() {
        
        movieSearchListTableView.reloadData()
    }
    
    private func buildTableSearchingListView() {
        movieSearchListTableView = UITableView()
        view.addSubview(movieSearchListTableView)
        
        //setup table view
        movieSearchListTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: searchTableViewCellName)
        movieSearchListTableView.rowHeight = StyleConstants.MovieTableViewCellLengths.movieCellHeight
        movieSearchListTableView.separatorColor = .clear
        movieSearchListTableView.delegate = self
        movieSearchListTableView.dataSource = self
    }

    private func addSearchingListConstraints() {
        movieSearchListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SearchTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: searchTableViewCellName, for: indexPath) as? SearchTableViewCell
        else {
            fatalError()
        }
        
        let movieTmp = movies[indexPath.row]
        
        cell.set(movieName: movieTmp.title, movieDescription: movieTmp.description, movieImageUrl: movieTmp.imageUrl)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension SearchTableViewController: UITableViewDelegate {
}
