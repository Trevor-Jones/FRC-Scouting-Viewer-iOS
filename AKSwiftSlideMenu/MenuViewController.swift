//
//  MenuViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func onSlideMenuButtonPressed(_ sender : UIButton)
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
    
    var selectedName : String = ""
    
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
        updateArrayMenuOptions()
        
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
    }
    
    func updateArrayMenuOptions(){
        teamArray = []
        var name : String = ""
        
        for i in 0..<Teams.teams.count {
            name = "\(Teams.teams[i].number!) \(Teams.teams[i].name!)"
            self.teamArray.append(name)
        }
        
        self.tblMenuOptions.reloadData()
        print(self.teamArray)
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        button.tag = 0
        delegate?.onSlideMenuButtonPressed(button)
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
        filteredTeamArray = teamArray
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
        btn.tag = 10
        if isActive {
            selectedName = filteredTeamArray[indexPath.row]
            
            for i in 0..<teamArray.count {
                if filteredTeamArray[indexPath.row] == teamArray[i] {
                    Teams.selectedTeam = i
                }
            }
        } else {
            selectedName = teamArray[indexPath.row]
            Teams.selectedTeam = indexPath.row
        }
        delegate?.onSlideMenuButtonPressed(btn)
        
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
