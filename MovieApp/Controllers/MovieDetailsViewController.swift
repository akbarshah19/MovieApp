//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/31/23.
//

import UIKit
import SDWebImage
import SafariServices

class MovieDetailsViewController: UIViewController {
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
                trailerView.frame = CGRect(x: 0, y: infoTable.bottom, width: scrollView.width, height: scrollView.width/1.8)
                similarsView.frame = CGRect(x: 0, y: trailerView.bottom + 5, width: view.width, height: 300)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setUpBarButtonItems()
        appendModels()
        fetchData(for: id)
        infoTable.delegate = self
        infoTable.dataSource = self
        addSubviews()
        topView.delegate = self
        similarsView.delegate = self
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
        print("Save Pressed!")
    }
    
    private func fetchData(for id: String) {
        URLSession.shared.request(url: URL(string: const.movieDetailsUrl(id: id)),
                                  expecting: MovieModel.self) { [weak self] result in
            switch result {
            case .success(let result):
                self?.fetchTrailerData(for: result.id)
                DispatchQueue.main.async {
                    self?.topView.configure(with: result)
                    self?.ratingView.configure(with: result.ratings)
                    self?.sections[0].subTitle[0] = result.plot ?? "-"
                    self?.sections[1].subTitle[0] = result.stars ?? "-"
                    self?.sections[2].subTitle[0] = result.writers ?? "-"
                    self?.sections[3].subTitle[0] = result.companies ?? "-"
                    self?.similarsView.configure(with: result.similars)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchTrailerData(for id: String) {
        let urlString = "https://imdb-api.com/en/API/YouTubeTrailer/\(key)/\(id)"
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            //have data
            var result: YouTubeTrailerModel?
            do {
                result = try JSONDecoder().decode(YouTubeTrailerModel.self, from: data)
            } catch {
                print("Failed to convert \(error.localizedDescription)")
            }
    
            guard let json = result else { return }
            DispatchQueue.main.async {
                self?.trailerView.configure(with: json.videoId)
            }
        })
        task.resume()
    }
    
    private func appendModels() {
        sections = [
            MovieInfoTableModel(title: "About", subTitle: [""]),
            MovieInfoTableModel(title: "Stars", subTitle: [""]),
            MovieInfoTableModel(title: "Writers", subTitle: [""]),
            MovieInfoTableModel(title: "Directors", subTitle: [""]),
            MovieInfoTableModel(title: "Companies", subTitle: [""])
        ]
    }
    
    private func setUpBarButtonItems() {
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)), style: .done, target: self, action: #selector(didTapSave))
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)), style: .done, target: self, action: #selector(didTapSave))
        navigationItem.rightBarButtonItems = [saveButton, shareButton]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.width, height: 1230)
        topView.frame = CGRect(x: 0, y: -100, width: view.width, height: 480)
        ratingView.frame = CGRect(x: 0, y: topView.bottom + 5, width: view.width, height: 92)
        infoTable.frame = CGRect(x: 0, y: ratingView.bottom, width: view.width, height: CGFloat(200))
        trailerView.frame = CGRect(x: 0, y: infoTable.bottom, width: scrollView.width, height: scrollView.width/1.8)
        similarsView.frame = CGRect(x: 0, y: trailerView.bottom + 5, width: view.width, height: 300)
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
            return 120
        }
        return 40
    }
}

extension MovieDetailsViewController: MovieDetailsTopViewDelegate {
    func didTapWatchNow(link: String?) {
        guard let link = link else {
            return
        }
        let url = URL(string: link)
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true)
    }
}

extension MovieDetailsViewController: MovieDetailsSimilarsViewDelegate {
    func didTapSeeAll(models: [HomeModelList]) {
        let vc = ListViewController(models: models)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapOnMovie(id: String) {
        let vc = MovieDetailsViewController(id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
