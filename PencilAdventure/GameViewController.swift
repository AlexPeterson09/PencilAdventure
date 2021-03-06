import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        }
    
    @IBAction func startGame(sender : AnyObject) {
        //load game scene
        let gameScene = GameScene(size: CGSize(width: view.frame.width, height: view.frame.height))
        let skView = self.view as SKView
        skView.presentScene(gameScene)
        
        // Hide the start button
        startGameButton.hidden = true
        }
}