import XCTest
import Cuckoo
import Quick
import Nimble
import RxSwift
import RxTest
@testable import News_App

class FavoritesChangeTest: QuickSpec {
    
    override func spec() {
        describe("Favorites status change test"){
            let mockedRealmManager = MockRealmManager()
            var fakeArticle = Article(title: "TestTitle", description: "TestDesc", urlToImage: "Nema", isFavorite: false)
            beforeSuite {
                Cuckoo.stub(mockedRealmManager){ mock in
                                        
                }
            }
        }
        
        
        
    }
    
}
