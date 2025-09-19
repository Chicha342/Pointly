import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var filename: String
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        DispatchQueue.global().async {
            let animation = LottieAnimation.named(filename)
            DispatchQueue.main.async {
                animationView.animation = animation
                animationView.loopMode = loopMode
                animationView.contentMode = .scaleAspectFit
                animationView.play()
            }
        }
        
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
