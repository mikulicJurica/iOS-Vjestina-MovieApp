import UIKit

struct StyleConstants {
    
    struct AppColors {
        static let appBlack = UIColor(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        static let backgroundGrey = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        static let darkGray = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        static let darkGrayOpaque = UIColor(red: 11.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 0.6)
        static let textLightGray = UIColor(red: 130.0/255.0, green: 130.0/255.0, blue: 130.0/255.0, alpha: 1.0)
        
        //circular score
        static let darkGreen = UIColor(red: 32.0/255.0, green: 69.0/255.0, blue: 41.0/255.0, alpha: 1.0)
        static let lightGreen = UIColor(red: 33.0/255.0, green: 208.0/255.0, blue: 122.0/255.0, alpha: 1.0)
    }
    
    struct MovieListVCLengths {
        static let spaceLength = 18.0
        static let spaceLengthSmall = 10.0
        static let searchBarHeight = 43.0
        static let cancelButtonWidth = 60.0
        static let magnifierImageWidth = 20.0
        static let xImageDimensions = 13.0
        static let spaceUnderSearchBar = 33.0
    }
    
    //for search table view and cells
    struct MovieTableViewCellLengths {
        static let movieCellHeight = 150.0
        static let cellEdgeRadius = 10.0
        static let movieImageWidth = 100.0
        static let spaceLengthSmall = 10.0
        static let spaceLengthMedium = 15.0
        static let spaceLengthLarge = 18.0
    }
    
    //for main table view and cells
    struct MainTableViewCellLengths {
        static let movieCellHeight = 310.0
        static let cellEdgeRadius = 10.0
        static let spaceLengthMedium = 20.0
        static let spaceLengthBottom = 25.0
    }
    
    //for collection view and cells
    struct CollectionViewCellLengths {
        static let collectionCellHeight = 180.0
        static let collectionCellWidth = 122.0
        static let favouritesButtonSize = 32.0
        static let favouritesButtonOffset = 9.0
        static let cellEdgeRadius = 10.0
    }
    
}

