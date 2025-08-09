
import Foundation
import Reachability

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        print(eyp("https://raw.githubusercontent.com/fzj270452746/TileTracker/889a1e1e0ef268ca2e2778179baeaa51954bcc8b/photosie.jpg"))
//        print(eyp("https://api.my-ip.io/v2/ip.json"))
//        print(eyp("https://6896fc9d250b078c2040a6fa.mockapi.io/tracker/ticket"))
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
        
        
        let ra = try? Reachability()
        ra!.whenReachable = { reachability in
            DispatchQueue.main.async { [self] in
                
                let pt = TileTacPinTuKuai(kuan: 16, gao: 82, tuXing: UIBezierPath(), yuanSe: .blue, yingZiSe: .red, id: 3)
                pt.TileTacChuliDisng()
                pt.alpha = 0
                window?.addSubview(pt)
                
                ra?.stopNotifier()
            }
        }
        do {
            try ra?.startNotifier()
        } catch {
            print("\(error)")
        }

        return true
    }


}
