//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 30.03.2023.
// TODO: Movie elementleri için tv elementleri için ayrı fonksiyonlar yaz setupTitle setupName gibi. En sonunda observable ve enum yaz fonksiyon içerisine parametre alıp hangi fonksiyonu çağırması gerektiğini söyle setupAllView gibi bütün fonksiyonları çağıran tek bir fonksiyon olsun

// TODO: Release date runtime genres gibi şeyleri attribute text şeklinde ekle iki taraf için de birer attribute oluştur. Örneğin sol taraf bold sarı gibi sonra onları direkt attribute et.

import UIKit
import Kingfisher

class MovieDetailView : UIViewController {
    
    // ViewModel Identifiers
    private var viewModel : MovieDetailViewModel
    
    init(with viewModel : MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    // Variable Identifiers
    private lazy var backButtonImage : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    private lazy var backButton : UIButton = UIButton(type: .custom)
    private lazy var rateCount : UILabel = UILabel()
    private lazy var titleLabel : UILabel = UILabel()
    private lazy var overviewHeader : UILabel = UILabel()
    private lazy var overviewLabel : UILabel = UILabel()
    private lazy var releaseDateLabel : UILabel = UILabel()
    private lazy var genresLabel : UILabel = UILabel()
    
    private lazy var movieBackdrop : UIImageView = UIImageView()
    private lazy var scrollView : UIScrollView = UIScrollView()
    private lazy var contentView : UIView = UIView()
    private lazy var starView : UIStackView = UIStackView()
    private lazy var starCount : Int = 1
    
    private var viewType: Observable<MainVCViewType> = Observable(.movie)
    
    private lazy var genresTableView : UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100), style: .plain)
    
    var testArray : [String]?
    var testString : String?
    
    var movieid : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.getMovieDetails()
        setupViews(viewType: .movie)
        print("Genre: \(testArray)")
        testString = testArray?.joined(separator: ", ")
    }
    
    
    private func bind() {
        
        viewModel.movieDetails.bind { [weak self] _ in
            self?.titleLabel.text = self?.viewModel.getText(type: .title)
            self?.overviewLabel.text = self?.viewModel.movieDetails.value?.overview
//            self?.testString = self?.viewModel.genreArray.value?.joined(separator: ", ")
            self?.testArray?.append(contentsOf: self?.viewModel.genreArray.value ?? [])
//            self?.releaseDateLabel.text = self?.viewModel.genreArray.value?.joined(separator: ", ")
//            self?.releaseDateLabel.text = "Release Date: \(self?.viewModel.movieDetails.value?.releaseDate!)"
            let attributeText = NSMutableAttributedString(string: "Release Date: ")
            attributeText.append(NSAttributedString(string: self?.viewModel.getText(type: .releaseDate) ?? ""))
            self?.releaseDateLabel.attributedText = attributeText
            self?.rateCount.text = self?.viewModel.getText(type: .rateCounts)
            
            self?.releaseDateLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget tristique velit. Pellentesque fringilla nec est ac sollicitudin. Quisque ac interdum leo, at facilisis elit. Nunc congue orci consequat lacus bibendum, id imperdiet ipsum hendrerit. Nullam lectus felis, imperdiet sit amet purus id, vehicula semper purus. Phasellus ipsum mi, vestibulum vulputate urna in, luctus faucibus leo. Cras ante tortor, commodo eu sem hendrerit, ullamcorper efficitur tortor. Suspendisse rutrum quis leo nec commodo. Integer eget mattis orci. Sed in malesuada eros, a sagittis nulla. Curabitur euismod lectus sodales tristique ultricies. Aenean placerat ante libero, vitae maximus augue consequat sed. Phasellus enim justo, fermentum ac cursus at, consectetur feugiat erat. Proin iaculis, neque eu feugiat tristique, ex sapien semper quam, at pretium erat velit vitae augue. Maecenas sollicitudin accumsan pretium.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget tristique velit. Pellentesque fringilla nec est ac sollicitudin. Quisque ac interdum leo, at facilisis elit. Nunc congue orci consequat lacus bibendum, id imperdiet ipsum hendrerit. Nullam lectus felis, imperdiet sit amet purus id, vehicula semper purus. Phasellus ipsum mi, vestibulum vulputate urna in, luctus faucibus leo. Cras ante tortor, commodo eu sem hendrerit, ullamcorper efficitur tortor. Suspendisse rutrum quis leo nec commodo. Integer eget mattis orci. Sed in malesuada eros, a sagittis nulla. Curabitur euismod lectus sodales tristique ultricies. Aenean placerat ante libero, vitae maximus augue consequat sed. Phasellus enim justo, fermentum ac cursus at, consectetur feugiat erat. Proin iaculis, neque eu feugiat tristique, ex sapien semper quam, at pretium erat velit vitae augue. Maecenas sollicitudin accumsan pretium."
            
            self?.testArray?.append(contentsOf: (self?.viewModel.getGenreArray())!)
            print(self?.testArray?.count)
            
        }
    }
    
}
extension MovieDetailView {
    
    func setupViews(viewType type: MainVCViewType) {
        
        switch type{
            
        case .tv:
            ()
        case .movie:
            ()
        }
        
        setupBackButton()
        setupScrollView()
        setupImage()
        setupRate()
        setupTitle()
        setupGenres()
        setupReleaseDate()
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        backButton.layer.zPosition = 2.0
        view.bringSubviewToFront(backButton)
        backButton.setImage(UIImage(named: "previous"), for: .normal)
        backButton.isUserInteractionEnabled = true
        backButton.isEnabled = true
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    @objc func backButtonTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        print("Button")
    }
    
    func setupScrollView() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.80).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset.top = 350
        scrollView.contentInset.bottom = 100
        scrollView.layer.zPosition = 1.5
        scrollView.layer.insertSublayer(gradientLayer, at: 0)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.insertSublayer(gradientLayer, at: 0)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        scrollView.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
           
    }
    
    func setupImage(){
        view.addSubview(movieBackdrop)
        movieBackdrop.translatesAutoresizingMaskIntoConstraints = false
        
        let url = URL(string: "https://image.tmdb.org/t/p/original/7WUHnWGx5OO145IRxPDUkQSh4C7.jpg")
        movieBackdrop.contentMode = .scaleAspectFill
        movieBackdrop.kf.setImage(with: url)

        NSLayoutConstraint.activate([
            movieBackdrop.topAnchor.constraint(equalTo: view.topAnchor),
            movieBackdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieBackdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieBackdrop.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/1.5)
        ])
    }
    
    func setupRate() {

        starView = drawStars(withRating: 3)
        contentView.addSubview(starView)
        starView.translatesAutoresizingMaskIntoConstraints = false
        // Rate Constraints
        starView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        starView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = false
        starView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = false
        starView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
        contentView.addSubview(rateCount)
        rateCount.translatesAutoresizingMaskIntoConstraints = false
        rateCount.font = .systemFont(ofSize: 18)
        rateCount.textColor = .white
        rateCount.numberOfLines = 1
        rateCount.sizeToFit()
        
        NSLayoutConstraint.activate([
            rateCount.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rateCount.leadingAnchor.constraint(equalTo: starView.trailingAnchor,constant: 5)
        ])
        
    }
    
    func setupTitle() {
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.baselineAdjustment = .alignBaselines
        titleLabel.contentMode = .left
        titleLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: starView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            titleLabel.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func setupReleaseDate() {
        contentView.addSubview(releaseDateLabel)
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        releaseDateLabel.textAlignment = .left
        releaseDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        releaseDateLabel.textColor = .white
        releaseDateLabel.numberOfLines = 0
        releaseDateLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: genresTableView.bottomAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            releaseDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    func setupGenres() {
        //TODO: array.joined(Seperator: )
        self.genresTableView.delegate = self
        self.genresTableView.dataSource = self
        self.genresTableView.register(UITableViewCell.self, forCellReuseIdentifier: "GenresTableView")
        contentView.addSubview(genresTableView)
        genresTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }
    
    func setupRuntime() {
        //TODO: TV için episode runtime
    }
    
    func setupSummary() {
        //TODO: Plot Summary diye bir header eklemen lazım
    }
    
    func setupProducers() {
        //TODO: Movie için eğer image nil değilse bir tanesini göster
    }
    
    func setupPlatforms() {
        //TODO: TV için moviedeki gibi aynı
    }
    
    func setupDirectors() {
        //TODO: Cast için kullanacağın collectionview cell'ini burada kullan
    }
    
    func setupCast() {
        //TODO: collectionview ile oyuncuları getir
    }
    func setupSimilar() {
        //TODO: anasayfada kullandığın detay cell'ini burada kullan collectionview oluştur.
    }
    
    func createStarsView(withRating rating: Int) -> UIView {
        let starsView = UIView()
        starsView.translatesAutoresizingMaskIntoConstraints = false
        starsView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        starsView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let starSize = CGSize(width: 20, height: 20)
        for i in 1...5 {
            let starImageView = UIImageView(image: i <= rating ? UIImage(named: "yellow_star") : UIImage(named: "blue_star"))
            starImageView.contentMode = .scaleAspectFit
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            
            let leadingConstraint = i == 1 ?
            starImageView.leadingAnchor.constraint(equalTo: starsView.leadingAnchor) :
            starImageView.leadingAnchor.constraint(equalTo: starsView.subviews[i-2].trailingAnchor, constant: 4)
            leadingConstraint.isActive = true
            
            starsView.addSubview(starImageView)
        }
        return starsView
    }
    
    func drawStars(withRating rating: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4.0
        
        for i in 1...5 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            
            if i <= rating {
                imageView.image = UIImage(named: "yellow_star")
            } else {
                imageView.image = UIImage(named: "blue_star")
            }
            
            stackView.addArrangedSubview(imageView)
        }
        
        return stackView
    }
    
    
}

extension MovieDetailView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getGenreArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        // Hücre içerisine bir UIView ekleme
        let myView = UIView(frame: CGRect(x: 20, y: 10, width: cell.frame.width - 40, height: 50))
        myView.backgroundColor = .gray
        myView.layer.cornerRadius = 12
        cell.contentView.addSubview(myView)
        
        // UIView içerisine bir UILabel ekleme
        let myLabel = UILabel(frame: CGRect(x: 10, y: 10, width: myView.frame.width - 20, height: 30))
        
        myLabel.text = viewModel.getGenreArray()[indexPath.row]
        
        myLabel.textAlignment = .center
        myView.addSubview(myLabel)
        
        return cell
    }
    
    
}
