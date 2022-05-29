import UIKit
import SnapKit

//table view of searching movies
class SearchTableViewController: UIViewController {
    
    //movie list when searching
    private var movieSearchListTableView: UITableView!
    
    let searchTableViewCellName = "MovieTableViewCell"
    
    private var networkService = NetworkService()
    
    private var movieListModel = MovieListModel(results: [])
    
    private var searchTextField: UITextField!

    init(movieList: MovieListModel, searchTextEndEditing: UITextField) {
        self.movieListModel = movieList
        self.searchTextField = searchTextEndEditing
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildTableSearchingListView()
        addSearchingListConstraints()
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
        return movieListModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: searchTableViewCellName, for: indexPath) as? SearchTableViewCell
        else {
            fatalError()
        }
        
        let movieModel = movieListModel.results[indexPath.row]
        
        cell.set(movie: movieModel)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell
        let selectedMovie = currentCell.getMovie()
        
        let vc = MovieDetailsViewController(movie: selectedMovie)
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
        
        searchTextField.endEditing(true)
    }
}

extension SearchTableViewController: UITableViewDelegate {
}
