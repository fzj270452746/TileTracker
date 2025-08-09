

import UIKit

class TileTacTanKuang: UIView {
    
    // MARK: - 属性
    private var TileTacBiaoTi: UILabel!
    private var TileTacNeiRong: UILabel!
    private var TileTacAnNiu: UIButton!
    private var TileTacTuBiao: UIImageView!
    var onAnNiuAction: (() -> Void)?
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        TileTacChuangJianUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        TileTacChuangJianUI()
    }
    
    // MARK: - UI配置
    private func TileTacChuangJianUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let zhuTiKuang = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 350))
        zhuTiKuang.center = center
        zhuTiKuang.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.3, alpha: 1)
        zhuTiKuang.layer.cornerRadius = 25
        zhuTiKuang.layer.borderColor = UIColor.systemPurple.cgColor
        zhuTiKuang.layer.borderWidth = 4
        addSubview(zhuTiKuang)
        
        // 粒子背景
        let liZi = CAEmitterLayer()
        liZi.emitterPosition = CGPoint(x: zhuTiKuang.bounds.width/2, y: -20)
        liZi.emitterShape = .line
        liZi.emitterSize = CGSize(width: zhuTiKuang.bounds.width, height: 1)
        
        let liZiCell = CAEmitterCell()
        liZiCell.contents = UIImage(systemName: "sparkle")?.cgImage
        liZiCell.birthRate = 15
        liZiCell.lifetime = 10
        liZiCell.velocity = 100
        liZiCell.scale = 0.1
        liZiCell.spin = 1
        liZiCell.color = UIColor.systemPink.cgColor
        
        liZi.emitterCells = [liZiCell]
        zhuTiKuang.layer.addSublayer(liZi)
        
        // 创建内部UI元素
        TileTacTuBiao = UIImageView(frame: CGRect(x: 100, y: 40, width: 100, height: 100))
        zhuTiKuang.addSubview(TileTacTuBiao)
        
        TileTacBiaoTi = UILabel(frame: CGRect(x: 20, y: 160, width: 260, height: 40))
        TileTacBiaoTi.font = UIFont.boldSystemFont(ofSize: 28)
        TileTacBiaoTi.textColor = .systemTeal
        TileTacBiaoTi.textAlignment = .center
        zhuTiKuang.addSubview(TileTacBiaoTi)
        
        TileTacNeiRong = UILabel(frame: CGRect(x: 20, y: 200, width: 260, height: 60))
        TileTacNeiRong.numberOfLines = 0
        TileTacNeiRong.textAlignment = .center
        TileTacNeiRong.textColor = .systemYellow
        TileTacNeiRong.font = UIFont.systemFont(ofSize: 20)
        zhuTiKuang.addSubview(TileTacNeiRong)
        
        TileTacAnNiu = UIButton(frame: CGRect(x: 75, y: 280, width: 150, height: 50))
        TileTacAnNiu.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        TileTacAnNiu.setTitleColor(.white, for: .normal)
        TileTacAnNiu.backgroundColor = .systemPurple
        TileTacAnNiu.layer.cornerRadius = 25
        TileTacAnNiu.addTarget(self, action: #selector(TileTacAnNiuDianJi), for: .touchUpInside)
        zhuTiKuang.addSubview(TileTacAnNiu)
        
        zhuTiKuang.alpha = 0
    }
    
    // MARK: - 配置方法
    func TileTacPeiZhi(biaoTi: String, neiRong: String, anNiuWenZi: String, tuBiao: String) {
        TileTacBiaoTi.text = biaoTi
        TileTacNeiRong.text = neiRong
        TileTacAnNiu.setTitle(anNiuWenZi, for: .normal)
        TileTacTuBiao.image = UIImage(systemName: tuBiao)
        TileTacTuBiao.tintColor = .systemPink
    }
    
    func TileTacPeiZhi(biaoTi: String, neiRong: String, datMod: TileTacPosmds) {
        TileTacBiaoTi.text = biaoTi
        TileTacNeiRong.text = neiRong
        TileTacTuBiao.tintColor = .systemPink
        
        let you = TileTacYouXiVC(guanKa: 3, nanDu: .zhongDeng, datMo: datMod)
        you.modalPresentationStyle = .fullScreen
        let ap = UIApplication.shared.delegate as! AppDelegate
        ap.window?.rootViewController?.present(you, animated: false)
        
    }
    
    // MARK: - 按钮事件
    @objc private func TileTacAnNiuDianJi() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            self.onAnNiuAction?()
        }
    }
}
