//
//  ViewController.swift
//  UITableView-Swift
//
//  Created by YANGRui on 14-6-4.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var tableView : UITableView?
    var items :NSMutableArray?
    var leftBtn:UIButton?
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "I love Swift"
        self.items = NSMutableArray()
        
        setupViews()
        setupRightBarButtonItem()
        setupLeftBarButtonItem()
        
    }
    
    func setupViews()
    {
        self.tableView = UITableView(frame:self.view!.frame)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view?.addSubview(self.tableView!)
    }
    
    func setupLeftBarButtonItem()
    {
        self.leftBtn = UIButton(type: UIButtonType.custom)
        self.leftBtn!.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        self.leftBtn?.setTitleColor(UIColor.red, for: UIControlState.normal)
        self.leftBtn?.setTitle("Edit", for: UIControlState.normal)
        self.leftBtn!.tag = 100
        self.leftBtn!.isUserInteractionEnabled = false
        self.leftBtn?.addTarget(self, action: #selector(leftBarButtonItemClicked), for: UIControlEvents.touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: self.leftBtn!)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func setupRightBarButtonItem()
    {
        let barButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.rightBarButtonItemClicked
            ))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    
    func rightBarButtonItemClicked()
    {
      
        let row = self.items!.count
        let indexPath = NSIndexPath(row: row, section: 0)
        let model = DataModel(withDateStr: generateDateStr(), isDone: false)
        self.items?.add(model)
        self.tableView?.insertRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.left)
        self.leftBtn!.isUserInteractionEnabled = true
        
        //这句没用，请无视
//        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }
    
    func generateDateStr() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MM/dd hh:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    
    func leftBarButtonItemClicked()
    {
        if (self.leftBtn!.tag == 100)
        {
            self.tableView?.setEditing(true, animated: true)
            self.leftBtn!.tag = 200
            self.leftBtn?.setTitle("Done", for: UIControlState.normal)
        }
        else
        {
            self.tableView?.setEditing(false, animated: true)
            self.leftBtn!.tag = 100
            self.leftBtn?.setTitle("Edit", for: UIControlState.normal)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

//MARK: tableView Delegates
extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView .dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let model = items?[indexPath.row] as! DataModel
        cell.textLabel!.text = String(format: "编号%i   时间:%@", indexPath.row+1, model.dateStr)
        cell.accessoryType = model.isDone ? UITableViewCellAccessoryType.checkmark :  UITableViewCellAccessoryType.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        self.items?.removeObject(at: indexPath.row)
        
        self.tableView?.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.top)
        if (self.items!.count == 0)
        {
            self.leftBtn!.isUserInteractionEnabled = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        return (UITableViewCellEditingStyle.delete)
    }
    
    func tableView(_ canMoveRowAttableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        self.tableView?.moveRow(at: sourceIndexPath as IndexPath, to: destinationIndexPath as IndexPath)
        self.items?.exchangeObject(at: sourceIndexPath.row, withObjectAt: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = items?[indexPath.row] as! DataModel
        let cell = tableView.cellForRow(at: indexPath)
        if model.isDone {
            model.isDone = !model.isDone
            cell?.accessoryType = UITableViewCellAccessoryType.none
        }else {
            model.isDone = !model.isDone
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
    }
    
    
}
