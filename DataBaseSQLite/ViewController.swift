import UIKit

class ViewController: UIViewController {
    
    let engine = Engine()
    
    
    @IBOutlet var buttonsOutlet: [UIButton]!
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var myTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTextView.text = ""
        logTextView.text = ""
    }
    
    @IBAction func buttonsDbAtions(_ sender: UIButton) {
        
        
        //        guard let index = menuButtons(rawValue: buttonsOutlet.firstIndex(of: sender)!)
        //            else { return }
        
        logTextView.text = Engine.myEngine.choiceCommand(index: buttonsOutlet.firstIndex(of: sender)!, text: requestTextView.text, vc: self) + "\n" + logTextView.text
        
        myTable.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyData.arrTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = MyData.arrTable[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

