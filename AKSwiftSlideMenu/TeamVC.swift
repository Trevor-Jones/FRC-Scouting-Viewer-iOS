import UIKit

class TeamVC: BaseViewController, SlidingContainerViewControllerDelegate {
    
    @IBOutlet weak var teamViewNavBar: UINavigationItem!
    var teamName:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        Teams.updateTeam(teamNumber: Teams.selectedTeam)
        teamName = "\(Teams.teams[Teams.selectedTeam].name!)"
        teamViewNavBar.title = teamName
        print(Teams.teams[Teams.selectedTeam].linesCrossed.count)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var statisticsVC : UIViewController
        
        // Jank way to check if data is present
        // If there is no data for the number of lines crossed then use a different vc
        if Teams.teams[Teams.selectedTeam].linesCrossed.count == 0 {
            statisticsVC = self.storyboard!.instantiateViewController(withIdentifier: "NoDataVC")
        } else {
            statisticsVC = self.storyboard!.instantiateViewController(withIdentifier: "StatisticsVC")
        }
        let matchesVC : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "MatchesVC")
        
        
        let slidingContainerViewController = SlidingContainerViewController (
            parent: self,
            contentViewControllers: [statisticsVC, matchesVC],
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
