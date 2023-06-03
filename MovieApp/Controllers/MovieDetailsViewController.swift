//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/31/23.
//

import UIKit
import youtube_ios_player_helper
import SDWebImage

class MovieDetailsViewController: UIViewController, YTPlayerViewDelegate {
    let const = Constants()
    let id: String
    
    init(_ id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private var topView = MovieDetailsTopView()
    private var ratingView = MovieDetailsRatingView()
    
    private var infoTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(MovieDetailsInfoTableViewCell.self, forCellReuseIdentifier: MovieDetailsInfoTableViewCell.identifier)
        table.isScrollEnabled = false
        table.layer.borderWidth = 1
        table.layer.borderColor = UIColor.red.cgColor
        return table
    }()
    
    private var trailerView = MovieDetailsTrailerView()
    private var similarsView = MovieDetailsSimilarsView()
    
    var openedCount = 0
    private var sections = [MovieInfoTableModel]() {
        didSet {
            openedCount = 0
            for i in sections {
                if i.isOpened {
                    openedCount += 1
                }
                scrollView.contentSize.height = CGFloat(1230 + 200*openedCount)
                infoTable.frame = CGRect(x: 0, y: ratingView.bottom + 5, width: view.width, height: CGFloat(200 + openedCount*200))
                trailerView.frame = CGRect(x: scrollView.left + 16, y: infoTable.bottom + 15, width: scrollView.width - 32, height: scrollView.width/2)
                similarsView.frame = CGRect(x: 0, y: trailerView.bottom + 10, width: view.width, height: 300)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark",
                                                                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 20,
                                                                                                                          weight: .regular)),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
//        fetchData(for: id)
        trailerView.trailerPlayer.load(withVideoId: "Jvurpf91omw")
        
        appendModels()
        addSubviews()
        infoTable.delegate = self
        infoTable.dataSource = self
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(topView)
        scrollView.addSubview(ratingView)
        scrollView.addSubview(infoTable)
        scrollView.addSubview(trailerView)
        scrollView.addSubview(similarsView)
    }
    
    @objc private func didTapSave() {
        
    }
    
    private func fetchData(for id: String) {
        URLSession.shared.request(url: URL(string: const.movieDetailsUrl(id: id)),
                                  expecting: MovieModel.self) { [weak self] result in
            switch result {
            case .success(let result):
                print(result)
                DispatchQueue.main.async {
//                    self?.model = model
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func appendModels() {
        sections = [
            MovieInfoTableModel(title: "About", subTitle: [""]),
            MovieInfoTableModel(title: "Stars", subTitle: [""]),
            MovieInfoTableModel(title: "Writers", subTitle: [""]),
            MovieInfoTableModel(title: "Directors", subTitle: [""]),
            MovieInfoTableModel(title: "Companies", subTitle: [""])
        ]
        
        let model = [HomeModelList(id: "123", image:
                         "https://m.media-amazon.com/images/M/MV5BMDgxOTdjMzYtZGQxMS00ZTAzLWI4Y2UtMTQzN2VlYjYyZWRiXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_Ratio0.6716_AL_.jpg"),
                     HomeModelList(id: "123", image: "https://m.media-amazon.com/images/M/MV5BMDgxOTdjMzYtZGQxMS00ZTAzLWI4Y2UtMTQzN2VlYjYyZWRiXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_Ratio0.6716_AL_.jpg"),
                     HomeModelList(id: "123", image: "https://m.media-amazon.com/images/M/MV5BMDgxOTdjMzYtZGQxMS00ZTAzLWI4Y2UtMTQzN2VlYjYyZWRiXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_Ratio0.6716_AL_.jpg"),
                     ]
        similarsView.configure(models: model)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.width, height: 1230)
        topView.frame = CGRect(x: 0, y: -100, width: view.width, height: 480)
        ratingView.frame = CGRect(x: 5, y: topView.bottom + 5, width: view.width - 10, height: 92)
        infoTable.frame = CGRect(x: 0, y: ratingView.bottom + 5, width: view.width, height: CGFloat(200))
        trailerView.frame = CGRect(x: 0, y: infoTable.bottom + 15, width: scrollView.width, height: scrollView.width/2)
        similarsView.frame = CGRect(x: 0, y: trailerView.bottom + 10, width: view.width, height: 300)
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = sections[section]
        
        if sec.isOpened {
            return sec.subTitle.count + 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = sections[indexPath.section].title
            cell.backgroundColor = .secondarySystemBackground
            cell.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
            if !sections[indexPath.section].isOpened {
                let expandCollapseImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
                expandCollapseImage.image = UIImage(systemName: "chevron.down")
                cell.accessoryView = expandCollapseImage
                return cell
            } else {
                let expandCollapseImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
                expandCollapseImage.image = UIImage(systemName: "chevron.up")
                cell.accessoryView = expandCollapseImage
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsInfoTableViewCell.identifier,
                                                     for: indexPath) as! MovieDetailsInfoTableViewCell
            cell.textView.text = sections[indexPath.section].subTitle[indexPath.row - 1]
            cell.backgroundColor = .systemBackground
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        infoTable.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
        infoTable.reloadSections([indexPath.section], with: .none)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 0 {
            return 200
        }
        return 40
    }
}
