import Foundation

final class ExploreViewModel {
    
    private let networkManager = ApiManager()
    var topics: [Topic] = []
    var allphotosBySlug: [TopicPhoto] = []
    var onRandomPhotoUpdated:((_ url: URL, _ owner: String ) -> Void)?
    var onTopicUpdated:(([TopicForCollectionView])-> Void)?
    var photos:[Photo] = []
    var onDataUpdatedPhoto:(() -> Void)?
    var onLoadingStateChange:((Bool) -> Void)?
    var onError:((Error) -> Void)?
    var isLoading = false
    var currentPage = 1
    
    
    //MARK: Have to comment func loadTopics() due to 50 request per 1 hour
//    func loadTopics() {
//        networkManager.getResponseTopic { [weak self] topic, error in
//            guard let topic = topic else { return }
//            DispatchQueue.main.async {
//                self?.topics = topic
//                self?.fetchPhotos(topics: topic)
//            }
//        }
//    }
//    
//    func fetchPhotos(topics: [Topic]) {
//        var newTopics: [TopicForCollectionView] = []
//        for topic in topics {
//            
//            networkManager.getResponsePhotoBySlug(slug: topic.slug) { photos, error in
//                guard let firstPhoto = photos?.first,
//                      let smallPhoto = firstPhoto.urls?.small else {
//                    return
//                }
//                let newTopic = TopicForCollectionView(title: topic.title, imageUrl: smallPhoto)
//                newTopics.append(newTopic)
//                
//                DispatchQueue.main.async {
//                    self.onTopicUpdated?(newTopics)
//                }
//            }
//        }
//    }
    
    func loadRandomPhoto() {
        networkManager.getRequestRandomPhoto { [weak self] photo, error in
            guard let urlForPhoto = photo?.urls?.regular,
                  let urlPhoto = URL(string: urlForPhoto) else {
                print(error ?? "no load")
                return
            }
            
            guard let urlForUser = photo?.user?.name else {
                print(error ?? "no owner")
                return
            }
            print(urlForPhoto)
            print(urlForUser)
            DispatchQueue.main.async {
                self?.onRandomPhotoUpdated?(urlPhoto, urlForUser)
            }
        }
    }
    
    func loadLatestPhoto() {
        isLoading = true
        self.onLoadingStateChange?(true)
        
        networkManager.getListPhoto(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            DispatchQueue.main.async {
                switch result {
                case .success(let newPhoto):
                    self.photos.append(contentsOf: newPhoto)
                    self.onDataUpdatedPhoto?()
                case .failure(let error):
                    self.onError?(error)
                }
            }
        }
    }
    
    func loadInitialPhoto() {
        currentPage = 1
        loadLatestPhoto()
    }
    
    func loadMorePhoto() {
        guard !isLoading else {
            return
        }
        currentPage += 1
        loadLatestPhoto()
    }
    
}
