

import UIKit

// MARK: - 排行榜控制器
class TileTacPaiHangBangVC: UIViewController {
    
    // MARK: - UI元素
    private lazy var TileTacBiaoTi: UILabel = {
        let biao = UILabel()
        biao.text = "排行榜"
        biao.font = UIFont(name: "GillSans-Bold", size: 36)
        biao.textColor = .systemTeal
        biao.textAlignment = .center
        return biao
    }()
    
    private lazy var TileTacFanHuiAnNiu: UIButton = {
        let anNiu = UIButton(type: .system)
        anNiu.setTitle("返回", for: .normal)
        anNiu.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        anNiu.backgroundColor = .systemGray
        anNiu.tintColor = .white
        anNiu.layer.cornerRadius = 20
        anNiu.layer.shadowOpacity = 0.4
        anNiu.layer.shadowOffset = CGSize(width: 0, height: 4)
        anNiu.addTarget(self, action: #selector(TileTacFanHui), for: .touchUpInside)
        return anNiu
    }()
    
    private lazy var TileTacPaiHangBiao: UITableView = {
        let biao = UITableView()
        biao.backgroundColor = .clear
        biao.separatorStyle = .none
        biao.register(TileTacPaiHangCell.self, forCellReuseIdentifier: "cell")
        biao.dataSource = self
        biao.delegate = self
        return biao
    }()
    
    private var TileTacPaiHangShuJu: [TileTacPaiHangXiang] = []
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        TileTacPeiZhiBeiJing()
        TileTacTianJiaUI()
        TileTacJiaZaiShuJu()
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
        moHuCeng.colors = [UIColor(red: 0.15, green: 0.1, blue: 0.3, alpha: 0.9).cgColor,
                           UIColor(red: 0.2, green: 0.1, blue: 0.4, alpha: 0.8).cgColor]
        moHuCeng.locations = [0.0, 1.0]
        view.layer.addSublayer(moHuCeng)
    }
    
    private func TileTacTianJiaUI() {
        TileTacBiaoTi.frame = CGRect(x: 0, y: 60, width: view.bounds.width, height: 50)
        view.addSubview(TileTacBiaoTi)
        
        TileTacFanHuiAnNiu.frame = CGRect(x: 20, y: 50, width: 80, height: 40)
        view.addSubview(TileTacFanHuiAnNiu)
        
        TileTacPaiHangBiao.frame = CGRect(x: 20, y: 120, width: view.bounds.width - 40, height: view.bounds.height - 180)
        view.addSubview(TileTacPaiHangBiao)
    }
    
    private func TileTacJiaZaiShuJu() {
        TileTacPaiHangBiao.reloadData()
    }
    
    // MARK: - 事件处理
    @objc private func TileTacFanHui() {
        navigationController?.popViewController(animated: true)
    }
}

extension TileTacPaiHangBangVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TileTacPaiHangShuJu.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TileTacPaiHangCell
        let xiang = TileTacPaiHangShuJu[indexPath.row]
        cell.TileTacPeiZhi(xiang: xiang, paiMing: indexPath.row + 1)
        return cell
    }
}
