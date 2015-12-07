//
/// HWStatusCell.swift
/// 4j成才-微博
//
/// Created by 蒋进 on 15/11/29.
/// Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWStatusCell: UITableViewCell {
///*****✅cell中设置--模型类的尺寸Frame模型的----set方法赋值并且设置尺寸.
    /**
    1.元素--2模型的set方法(模型赋值元素的尺寸)--3init初始化添加元素到cell中--
    cell的初始化方法，一个cell只会调用一次
    一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
    
    
    */
    //原创微博 /
    //原创微博整体 /
    var originalView: UIView?
    //头像 /
    var iconView:HWIconView?
    //会员图标 /
    var vipView:UIImageView?
    
    /** 配图 */
    var photosView:HWStatusPhotosView?
    
    //昵称 /
    var nameLabel:UILabel?
    //时间 /
    var timeLabel:UILabel?
    //来源 /
    var sourceLabel:UILabel?
    //正文 /
    var contentLabel:UILabel?
    
    
    //MARK: -  转发微博
    /** 转发微博整体 */
    var retweetView:UIView!
    /** 转发微博正文 + 昵称 */
    var retweetContentLabel:UILabel!
    /** 转发配图 */
    var retweetPhotosView:HWStatusPhotosView!
    /** 工具条 */
    var toolbar:HWStatusToolbar!
    


    
    
    
    
    
    var statusFrame: HWStatusFrame? {
        didSet{

            let status: HWStatus = statusFrame!.status!;
            let user: HWUser  = status.user!
                
                /** 原创微博整体 */
                self.originalView!.frame = statusFrame!.originalViewF!;
                
                /** 头像 */
                self.iconView!.frame = statusFrame!.iconViewF!;
                self.iconView!.user = user;

                /** 会员图标 */
                if (user.isVip == true) {
                    self.vipView!.hidden = false
                    
                    self.vipView!.frame = statusFrame!.vipViewF!;
                    print("***%%%%%%%%%%**\(user.mbrank.integerValue)")
                    let vipName = "common_icon_membership_level\(user.mbrank.integerValue)"
                    self.vipView!.image = UIImage(named: vipName as String)
                    //self.vipView!.image = user.vipImage
                    self.nameLabel!.textColor = UIColor.orangeColor()
                } else {
                    self.nameLabel!.textColor = UIColor.blackColor()
                    self.vipView!.hidden = true
                }
        
            
            /** 配图 */
            if(status.pic_urls != nil && status.pic_urls!.count>0){
                self.photosView!.frame=statusFrame!.photosViewF!
                self.photosView!.photos=status.pic_urls
                self.photosView!.hidden=false
            }else{
                self.photosView!.hidden=true
            }

            //MARK: 💗status.created_at会调用get方法获得时间的尺寸
                /** 昵称 */
                self.nameLabel!.text = user.name as String
                self.nameLabel!.frame = statusFrame!.nameLabelF!
                
                /** 时间 *////*****✅需要重新计算尺寸
            //MARK: status.created_at会调用get方法获得时间的尺寸
             /** 时间 */
            let time:NSString=(status.created_at as? String)!
            let timeX:CGFloat=statusFrame!.nameLabelF!.origin.x
            let timeY:CGFloat=CGRectGetMaxY(statusFrame!.nameLabelF!) + HWStatusCellBorderW
            let timeSize:CGSize=time.sizeWithFont(HWStatusCellTimeFont, maxW: CGFloat.max)
            self.timeLabel!.frame=CGRectMake(timeX, timeY, timeSize.width, timeSize.height)
            self.timeLabel!.text=time as String
            
            /** 来源 */
            let sourceX:CGFloat=CGRectGetMaxX(self.timeLabel!.frame) + HWStatusCellBorderW
            let sourceY:CGFloat=timeY
            let sourceSize=(status.source! as NSString).sizeWithFont(HWStatusCellSourceFont, maxW: CGFloat.max)
            self.sourceLabel!.frame=CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height)
            self.sourceLabel!.text=status.source as String

  
                /** 正文 */
                self.contentLabel!.text = status.text as? String
                self.contentLabel!.frame = statusFrame!.contentLabelF!
            
            /** 被转发的微博 */
            
            if(status.retweeted_status != nil){
                let retweeted_status:HWStatus=status.retweeted_status!
                let retweeted_status_user:HWUser=retweeted_status.user!
                
                self.retweetView.hidden=false
                
                /** 被转发的微博整体 */
                self.retweetView.frame=statusFrame!.retweetViewF!
                
                /** 被转发的微博正文 */
                let retweetContent="@\(retweeted_status_user.name):\(retweeted_status.text!)"
          
                self.retweetContentLabel.text = retweetContent
                
                self.retweetContentLabel.frame=statusFrame!.retweetContentLabelF!
                
                /** 被转发的微博配图 */
                if(retweeted_status.pic_urls!.count>0){

                    self.retweetPhotosView.frame=statusFrame!.retweetPhotosViewF!
                    self.retweetPhotosView.photos=retweeted_status.pic_urls
                    self.retweetPhotosView.hidden=false
                }else{
                    self.retweetPhotosView.hidden=true
                }
            }else{
                self.retweetView.hidden=true
            }
            
            /** 工具条 */
            self.toolbar.frame=statusFrame!.toolbarF!
            self.toolbar.status=status

            }


        
        }
        
  
    
    static func cellWithTableView(tableView:UITableView)-> HWStatusCell{
        
        let ID:String = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(ID as String) as? HWStatusCell
        
        if cell == nil {
            cell = HWStatusCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID as String)
        }
        return cell!
    }
    
    
    
    /*
      cell的初始化方法，一个cell只会调用一次
      一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
    */
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor=UIColor.clearColor()
        // 点击cell的时候不要变色
        self.selectionStyle=UITableViewCellSelectionStyle.None
        // 初始化原创微博
        self.setupOriginal()
        
        // 初始化转发微博
        self.setupRetweet()
        
        // 初始化工具条
        self.setupToolbar()
    }
 

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//    
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
    


    /**
     * 初始化工具条
     */
    func setupToolbar()
    {
        let toolbar: HWStatusToolbar  = HWStatusToolbar()
        self.contentView.addSubview(toolbar)
        self.toolbar = toolbar;
    }
    
    
    /**
     * 初始化转发微博
     */
    //MARK:  初始化转发微博
    func setupRetweet(){
        
        
        /** 转发微博整体 */
        let retweetView=UIView()
        retweetView.backgroundColor = UIColor.RGB(247, 247, 247, 1.0)
           
        self.contentView.addSubview(retweetView)
        self.retweetView=retweetView
        
        /** 转发微博正文 + 昵称 */
        let retweetContentLabel=UILabel()
        retweetContentLabel.numberOfLines=0
        retweetContentLabel.font=HWStatusCellRetweetContentFont
        retweetView.addSubview(retweetContentLabel)
        self.retweetContentLabel=retweetContentLabel
        
        /** 转发微博配图 */
        let retweetPhotosView=HWStatusPhotosView()
        retweetView.addSubview(retweetPhotosView)
        self.retweetPhotosView=retweetPhotosView
        

    }
    
    
    
    
    
    
    
    
    
    /**
     * 初始化原创微博
     */
    func setupOriginal(){
        //原创微博整体 /
        let originalView: UIView  = UIView()
        self.contentView.addSubview(originalView)
        self.originalView = originalView;
        
        //头像 /
        let iconView: HWIconView  = HWIconView(frame: CGRect.zero)
        originalView.addSubview(iconView)
        self.iconView = iconView;
        
        //会员图标 /
        let vipView: UIImageView  = UIImageView()
        vipView.contentMode = UIViewContentMode.Center;
        originalView.addSubview(vipView)
        self.vipView = vipView;
        
        /** 配图 */
        let photosView=HWStatusPhotosView()
        originalView.addSubview(photosView)
        self.photosView=photosView
        

        
        //昵称 /
        let nameLabel: UILabel = UILabel()
        nameLabel.font = HWStatusCellNameFont;
        originalView.addSubview(nameLabel)
        self.nameLabel = nameLabel;
        
        //时间 /
        let timeLabel: UILabel  = UILabel()
        timeLabel.font = HWStatusCellTimeFont;
        timeLabel.textColor=UIColor.orangeColor()
        originalView.addSubview(timeLabel)
        self.timeLabel = timeLabel;
        
        //来源 /
        let sourceLabel: UILabel  = UILabel()
        sourceLabel.font = HWStatusCellSourceFont;
        originalView.addSubview(sourceLabel)
        self.sourceLabel = sourceLabel;
        
        //正文 /
        let contentLabel: UILabel  = UILabel()
        contentLabel.font = HWStatusCellContentFont;
        contentLabel.numberOfLines = 0;
        originalView.addSubview(contentLabel)
        self.contentLabel = contentLabel;
    }
    
    
    
    
    
    


    override func awakeFromNib() {
        super.awakeFromNib()
        ///Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        ///Configure the view for the selected state
    }

}
