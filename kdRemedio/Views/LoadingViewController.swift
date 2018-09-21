import Lottie
import UIKit

class LoadingViewController: UIViewController {

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  init() {
    super.init(nibName: nil, bundle: nil)
    window.windowLevel = CGFloat.greatestFiniteMagnitude
    window.isHidden = false
    window.rootViewController = self

    NotificationCenter.default.addObserver(self, selector: #selector(removeFromStack), name: .removeLoadingViewController, object: nil)
  }

  @objc func removeFromStack() {
    getLOTView()?.stop()
    UIView.animate(withDuration: 0.4, animations: {
      self.window.alpha = 0
    }, completion: { hasFinished in
      if hasFinished {
        self.window.rootViewController = nil
        self.window.resignKey()
        self.window.removeFromSuperview()
      }
    })
  }

  func getLOTView() -> LOTAnimationView? {
    return view.subviews.first { view -> Bool in
      return view is LOTAnimationView
      } as? LOTAnimationView
  }

  private let window = LoadingWindow()

  override func loadView() {
    let view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = UIColor.clear

    //blurEffect
    let blurEffect = UIBlurEffect(style: .regular)
    let blurredEffectView = UIVisualEffectView(effect: blurEffect)
    blurredEffectView.frame = view.bounds
    blurredEffectView.alpha = 0.6
    view.addSubview(blurredEffectView)

    let loadingView = LOTAnimationView(name: "healthtap_spinner")
    let frame = CGRect(x: view.center.x, y: view.center.y, width: 300, height: 300)
    loadingView.frame = frame
    loadingView.center = view.center
    view.addSubview(loadingView)
//    loadingView.translatesAutoresizingMaskIntoConstraints = false
//    loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//    loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//    loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
//    loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50).isActive = true
    loadingView.loopAnimation = true
    loadingView.play()

    self.view = view
    window.view = view
  }
}

private class LoadingWindow: UIWindow {

  var view: UIView?

  init() {
    super.init(frame: UIScreen.main.bounds)
    backgroundColor = nil
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  fileprivate override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    guard let view = view else { return false }
    let viewPoint = convert(point, to: view)
    return view.point(inside: viewPoint, with: event)
  }
}
