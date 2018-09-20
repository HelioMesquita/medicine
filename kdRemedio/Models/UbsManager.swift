import Foundation

class UbsManager {

  private static var instance = UbsManager()
  private var list: UbsList = UbsList(list: [])

  static func setList(list: UbsList) {
    instance.list = list
  }

  static func getList() -> UbsList {
    return instance.list
  }
}
