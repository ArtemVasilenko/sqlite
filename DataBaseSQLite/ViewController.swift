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
        
        guard let index = menuButtons(rawValue: buttonsOutlet.firstIndex(of: sender)!)
            else { return }
        
        switch index {
        case .createDB: logTextView.text += "\n" + engine.createDB(path: self.requestTextView.text + ".db")
        case .removeDB: logTextView.text += "\n" + engine.removeDBClass()
        case .listTable: ()
        case .createTable: logTextView.text += "\n" + engine.createMyTable(queryCreateTable: requestTextView.text)
        case .insertTable: logTextView.text = engine.insertTableClass(nameTable: requestTextView.text, name: "Vasya")
        case .updateTable: ()
        case .deleteValues: ()
        case .packTable: ()
        case .selectTable: ()
        case .selectAny: ()
        }
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell()
        
        return cell
        
    }
    
    
    
    
}

