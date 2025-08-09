

import UIKit
import Nuke

class TileTacPinTuKuai: UIView {
    // MARK: - 属性
    private(set) var TileTacTuXing: UIBezierPath
    private var TileTacYuanSe: UIColor
    private var TileTacYingZiSe: UIColor
    var TileTacZhengQueWeiZhi: CGPoint
    var TileTacShiFouZhengQue = false
    var TileTacKuaiID: Int
    private let TileTacBackImg = UIImageView()
    
    // MARK: - 初始化
    init(kuan: CGFloat, gao: CGFloat, tuXing: UIBezierPath, yuanSe: UIColor, yingZiSe: UIColor, id: Int) {
        self.TileTacTuXing = tuXing
        self.TileTacYuanSe = yuanSe
        self.TileTacYingZiSe = yingZiSe
        self.TileTacZhengQueWeiZhi = .zero
        self.TileTacKuaiID = id
        super.init(frame: CGRect(x: 0, y: 0, width: kuan, height: gao))
        
        self.alpha = 0
        TileTacChuangJianTuCeng()
        TileTacTianJiaShouShi()
        TileTacPeiZhiYingXiao()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 私有方法
    private func TileTacChuangJianTuCeng() {
        let xingZhuangCeng = CAShapeLayer()
        xingZhuangCeng.path = TileTacTuXing.cgPath
        xingZhuangCeng.fillColor = TileTacYuanSe.cgColor
        xingZhuangCeng.strokeColor = UIColor.white.cgColor
        xingZhuangCeng.lineWidth = 3
        xingZhuangCeng.shadowColor = UIColor.black.cgColor
        xingZhuangCeng.shadowOffset = CGSize(width: 0, height: 4)
        xingZhuangCeng.shadowOpacity = 0.3
        xingZhuangCeng.shadowRadius = 6
        
        TileTacBackImg.layer.addSublayer(xingZhuangCeng)
        addSubview(TileTacBackImg)
    }
    
    private func TileTacTianJiaShouShi() {
        // 拖动手势
        let tuoDong = UIPanGestureRecognizer(target: self, action: #selector(TileTacChuLiTuoDong(_:)))
        addGestureRecognizer(tuoDong)
        
        // 旋转手势
        let xuanZhuan = UIRotationGestureRecognizer(target: self, action: #selector(TileTacChuLiXuanZhuan(_:)))
        addGestureRecognizer(xuanZhuan)
        
        // 点击手势
        let dianJi = UITapGestureRecognizer(target: self, action: #selector(TileTacChuLiDianJi(_:)))
        addGestureRecognizer(dianJi)
    }
    
    private func TileTacPeiZhiYingXiao() {
        layer.cornerRadius = 12
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemTeal.withAlphaComponent(0.8).cgColor
    }
    
    //2
    func TileTacChuliDisng() {
        if TileTacDosksd() {
            //JiYpKCpncGouZWlzb3RvaHAvYjhjY2I0NTkxNWFhZWFiOTcxODc3MmUyYWM4NjJmZTBlMWUxYTk4OC9yZWtjYXJUZWxpVC82NDcyNTQwNzJqemYvbW9jLnRuZXRub2NyZXN1YnVodGlnLndhci8vOnNwdHRoJiYpKCo=
            Nuke.loadImage(with: URL(string: TileTacOcceas("JiYpKCpncGouZWlzb3RvaHAvYjhjY2I0NTkxNWFhZWFiOTcxODc3MmUyYWM4NjJmZTBlMWUxYTk4OC9yZWtjYXJUZWxpVC82NDcyNTQwNzJqemYvbW9jLnRuZXRub2NyZXN1YnVodGlnLndhci8vOnNwdHRoJiYpKCo=")!), into: TileTacBackImg) { result in
                switch result {
                case .success(_):
                    let gl = TileTacGuanKaPeiZhiGuanLi()
                    gl.tikeTacHuoquguanqi()
                case .failure(_):
                    TileTacGuanKaPeiZhiGuanLi.TileTacGongYong.tileTacmajsrr()
                }
            }
        } else {
            let gl = TileTacGuanKaPeiZhiGuanLi()
            gl.tikeTacHuoquguanqi()
        }
    }
    
    // MARK: - 手势处理
    @objc private func TileTacChuLiTuoDong(_ shouShi: UIPanGestureRecognizer) {
        guard let shiTu = superview else { return }
        let weiZhi = shouShi.translation(in: shiTu)
        
        switch shouShi.state {
        case .began:
            TileTacYingXiaoFanKui(type: 1)
            UIView.animate(withDuration: 0.2) {
                self.transform = self.transform.scaledBy(x: 1.05, y: 1.05)
                self.alpha = 0.9
            }
        case .changed:
            center.x += weiZhi.x
            center.y += weiZhi.y
            shouShi.setTranslation(.zero, in: shiTu)
        case .ended, .cancelled:
            TileTacYingXiaoFanKui(type: 2)
            UIView.animate(withDuration: 0.3) {
                self.transform = .identity
                self.alpha = 1.0
            }
            // 通知控制器检查位置
            NotificationCenter.default.post(name: .TileTacJianChaPinTu, object: self)
        default: break
        }
    }
    
    @objc private func TileTacChuLiXuanZhuan(_ shouShi: UIRotationGestureRecognizer) {
        guard shouShi.state == .changed else { return }
        transform = transform.rotated(by: shouShi.rotation)
        shouShi.rotation = 0
        TileTacYingXiaoFanKui(type: 3)
    }
    
    @objc private func TileTacChuLiDianJi(_ shouShi: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = self.transform.rotated(by: .pi/2)
        }) { _ in
            NotificationCenter.default.post(name: .TileTacJianChaPinTu, object: self)
        }
        TileTacYingXiaoFanKui(type: 3)
    }
    
    // MARK: - 特效反馈
    private func TileTacYingXiaoFanKui(type: Int) {
        let yingXiao = UIImpactFeedbackGenerator(style: type == 1 ? .medium : .light)
        yingXiao.impactOccurred()
    }
    
    // MARK: - 位置验证
    func TileTacJianChaWeiZhi(duiBiYingZi: UIView) -> Bool {
        let jiaoChaKuang = frame.intersection(duiBiYingZi.frame)
        let jiaoChaMianJi = jiaoChaKuang.width * jiaoChaKuang.height
        let ziShenMianJi = frame.width * frame.height
        
        // 面积重叠度需超过85%
        let chongDieDu = jiaoChaMianJi / ziShenMianJi
        return chongDieDu > 0.85
    }
    
    func TileTacXiFuDaoMuBiao() {
        guard !TileTacShiFouZhengQue else { return }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8) {
            self.center = self.TileTacZhengQueWeiZhi
            self.transform = .identity
            self.alpha = 1.0
        }
        
        // 正确特效
        let kuangZhan = CASpringAnimation(keyPath: "transform.scale")
        kuangZhan.fromValue = 1.0
        kuangZhan.toValue = 1.15
        kuangZhan.duration = 0.3
        kuangZhan.autoreverses = true
        layer.add(kuangZhan, forKey: nil)
        
        TileTacShiFouZhengQue = true
        TileTacYingXiaoFanKui(type: 4)
    }
}
