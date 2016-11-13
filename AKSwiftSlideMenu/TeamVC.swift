import UIKit

class TeamVC: BaseViewController, SlidingContainerViewControllerDelegate {
    
    @IBOutlet weak var teamViewNavBar: UINavigationItem!
    var teamName:String!
    var teamIndex:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        teamName = "\(Teams.teams[teamIndex].name!)"
        teamViewNavBar.title = teamName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc1 = viewControllerWithColorAndTitle(UIColor.white, title: "First View Controller")
        let vc2 = viewControllerWithColorAndTitle(UIColor.white, title: "Second View Controller")
        
        
        let slidingContainerViewController = SlidingContainerViewController (
            parent: self,
            contentViewControllers: [vc1, vc2],
            titles: ["Statistics", "Matches"])
        
        view.addSubview(slidingContainerViewController.view)
        
        slidingContainerViewController.sliderView.appearance.outerPadding = 0
        slidingContainerViewController.sliderView.appearance.innerPadding = 50
        slidingContainerViewController.sliderView.appearance.fixedWidth = true
        slidingContainerViewController.setCurrentViewControllerAtIndex(0)
    }
    
    func viewControllerWithColorAndTitle (_ color: UIColor, title: String) -> UIViewController {
        
        let vc = UIViewController ()
        vc.view.backgroundColor = color
        
        let label = UILabel (frame: vc.view.frame)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont (name: "HelveticaNeue-Light", size: 25)
        label.text = title
        
        label.sizeToFit()
        label.center = view.center
        
        vc.view.addSubview(label)
        
        return vc
    }
    
    
    // MARK: SlidingContainerViewControllerDelegate
    
    func slidingContainerViewControllerDidShowSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidHideSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidMoveToViewController(_ slidingContainerViewController: SlidingContainerViewController, viewController: UIViewController) {
        
    }
    
    func slidingContainerViewControllerDidMoveToViewControllerAtIndex(_ slidingContainerViewController: SlidingContainerViewController, index: Int) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
