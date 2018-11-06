//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 4 colors.
  struct color {
    /// Color `darkCandyAppleRed`.
    static let darkCandyAppleRed = Rswift.ColorResource(bundle: R.hostingBundle, name: "darkCandyAppleRed")
    /// Color `mayaBlue`.
    static let mayaBlue = Rswift.ColorResource(bundle: R.hostingBundle, name: "mayaBlue")
    /// Color `offWhite`.
    static let offWhite = Rswift.ColorResource(bundle: R.hostingBundle, name: "offWhite")
    /// Color `philippineYellow`.
    static let philippineYellow = Rswift.ColorResource(bundle: R.hostingBundle, name: "philippineYellow")
    
    /// `UIColor(named: "darkCandyAppleRed", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func darkCandyAppleRed(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.darkCandyAppleRed, compatibleWith: traitCollection)
    }
    
    /// `UIColor(named: "mayaBlue", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func mayaBlue(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.mayaBlue, compatibleWith: traitCollection)
    }
    
    /// `UIColor(named: "offWhite", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func offWhite(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.offWhite, compatibleWith: traitCollection)
    }
    
    /// `UIColor(named: "philippineYellow", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func philippineYellow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.philippineYellow, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `.swiftlint.yml`.
    static let swiftlintYml = Rswift.FileResource(bundle: R.hostingBundle, name: ".swiftlint", pathExtension: "yml")
    /// Resource file `healthtap_spinner.json`.
    static let healthtap_spinnerJson = Rswift.FileResource(bundle: R.hostingBundle, name: "healthtap_spinner", pathExtension: "json")
    
    /// `bundle.url(forResource: ".swiftlint", withExtension: "yml")`
    static func swiftlintYml(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.swiftlintYml
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "healthtap_spinner", withExtension: "json")`
    static func healthtap_spinnerJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.healthtap_spinnerJson
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `splash`.
    static let splash = Rswift.ImageResource(bundle: R.hostingBundle, name: "splash")
    
    /// `UIImage(named: "splash", bundle: ..., traitCollection: ...)`
    static func splash(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.splash, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 0 reuse identifiers.
  struct reuseIdentifier {
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "splash.jpg") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'splash.jpg' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let historic = StoryboardViewControllerResource<HistoricTableViewController>(identifier: "historic")
      let medicineSearch = StoryboardViewControllerResource<MedicineSearchTableViewController>(identifier: "medicineSearch")
      let medicineSelection = StoryboardViewControllerResource<UBSSelectionTableViewController>(identifier: "medicineSelection")
      let name = "Main"
      let reservation = StoryboardViewControllerResource<ReservationViewController>(identifier: "reservation")
      let ubsSelection = StoryboardViewControllerResource<UBSMedicineSelectionTableViewController>(identifier: "ubsSelection")
      
      func historic(_: Void = ()) -> HistoricTableViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: historic)
      }
      
      func medicineSearch(_: Void = ()) -> MedicineSearchTableViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: medicineSearch)
      }
      
      func medicineSelection(_: Void = ()) -> UBSSelectionTableViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: medicineSelection)
      }
      
      func reservation(_: Void = ()) -> ReservationViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: reservation)
      }
      
      func ubsSelection(_: Void = ()) -> UBSMedicineSelectionTableViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: ubsSelection)
      }
      
      static func validate() throws {
        if _R.storyboard.main().medicineSearch() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'medicineSearch' could not be loaded from storyboard 'Main' as 'MedicineSearchTableViewController'.") }
        if _R.storyboard.main().reservation() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'reservation' could not be loaded from storyboard 'Main' as 'ReservationViewController'.") }
        if _R.storyboard.main().medicineSelection() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'medicineSelection' could not be loaded from storyboard 'Main' as 'UBSSelectionTableViewController'.") }
        if _R.storyboard.main().historic() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'historic' could not be loaded from storyboard 'Main' as 'HistoricTableViewController'.") }
        if _R.storyboard.main().ubsSelection() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'ubsSelection' could not be loaded from storyboard 'Main' as 'UBSMedicineSelectionTableViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
