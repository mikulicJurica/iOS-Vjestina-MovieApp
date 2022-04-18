import UIKit
import SnapKit
import MovieAppData

//table view of searching movies
class SearchTableViewController: UIViewController {
    
    //movie list when searching
    private var movieSearchListTableView: UITableView!
    
    let searchTableViewCellName = "MovieTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        buildTableSearchingListView()
        addSearchingListConstraints()
    }
    
    func reloadListMovies() {
        //updating list......
        
        movieSearchListTableView.reloadData()
    }
    
    private func buildTableSearchingListView() {
        movieSearchListTableView = UITableView()
        view.addSubview(movieSearchListTableView)
        
        //setup table view
        movieSearchListTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: searchTableViewCellName)
        movieSearchListTableView.rowHeight = styleConstants.movieTableViewCellLengths.movieCellHeight
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
        return getNumberOfAllMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: searchTableViewCellName, for: indexPath) as? SearchTableViewCell
        else {
            fatalError()
        }
        
        let nameInput = getAllMovieData()[indexPath.row].title
        let descriptionInput = getAllMovieData()[indexPath.row].description
        let imageURLInput = getAllMovieData()[indexPath.row].imageUrl
        
        cell.set(movieName: nameInput, movieDescription: descriptionInput, movieImageUrl: imageURLInput)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension SearchTableViewController: UITableViewDelegate {
}
