import Foundation

class UBSManager {

  private static var instance = UBSManager()
  private var list: UBSList = UBSList(list: [])

  static func setList(list: UBSList) {
    instance.list = list
  }

  static func getList() -> UBSList {
    return instance.list
  }
}
