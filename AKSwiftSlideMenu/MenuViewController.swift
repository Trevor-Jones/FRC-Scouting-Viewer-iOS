//
//  MenuViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    /**
    *  Array to display menu options
    */
    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
    *  Search bar for searching through teams
    */
    @IBOutlet weak var searchBar: UISearchBar!
    
    /**
    *  Transparent button to hide menu
    */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
    *  Array containing menu options
    */
    var teamArray = [String]()
    var filteredTeamArray = [String]()
    
    var isActive : Bool = false
    
    /**
    *  Menu button which was tapped to display the menu
    */
    var btnMenu : UIButton!
    
    /**
    *  Delegate of the MenuVC
    */
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.tableFooterView = UIView()
        searchBar.delegate = self
        tblMenuOptions.delegate = self
        tblMenuOptions.dataSource = self
        tblMenuOptions.contentOffset = CGPoint(x: 0, y: 44)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    
    func updateArrayMenuOptions(){
        teamArray = ["955 CV Robotics","1983","4488","2471"]
        tblMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        //let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        
        //imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        if(isActive){
            lblTitle.text = filteredTeamArray[indexPath.row]
        } else {
            lblTitle.text = teamArray[indexPath.row]
        }
        
        return cell
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isActive = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isActive = false
        tblMenuOptions.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isActive = true
        filteredTeamArray = teamArray.filter { team in
            return team.lowercased().contains((searchBar.text?.lowercased())!)
        }
        
        tblMenuOptions.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        if isActive {
            return filteredTeamArray.count
        }
        return teamArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredTeamArray = teamArray.filter { team in
            return team.lowercased().contains(searchText.lowercased())
        }
        
        tblMenuOptions.reloadData()
    }
}
