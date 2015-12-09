


import UIKit

class HWStatusToolSQ: NSObject {
    
    static let sharedManager = HWStatusToolSQ()

    static var db: FMDatabase?
    //MARK: - 懒加载

    override class func initialize(){
        // 1.打开数据库
        let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        let path = documentPath.stringByAppendingPathComponent("jian.sqlite")

        // 2.创表
        // 创建FMDatabaseQueue对象会自动打开数据库,如果数据库不存在会创建数据库
        // 后续的所有数据库操作都是通过dbQueue来调用
        db = FMDatabase(path: path)
        db?.open()
        let sql:String = "CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY, status blob NOT NULL, idstr text NOT NULL);"
        db?.executeUpdate(sql, withArgumentsInArray: nil)

    }
    
    
    ///*****✅获取本地路径*******************
   static func HouQuBenDiLJ(){
        
        ///*****✅1，Home目录**整个应用程序各文档所在的目录
        //获取程序的Home目录
        let homeDirectory1 = NSHomeDirectory()
        print("*\(homeDirectory1)\r\n")
        
        ///*****✅2，Documnets目录 ./Documents用户文档目录，苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
        ///方法1
        let documentPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask, true)
        let documnetPath = documentPaths[0] as String
        
        ///方法2
        // let ducumentPath2 = NSHomeDirectory() + "/Documents"
        print("*****\(documnetPath)\r\n")
        
        
        ///*****✅ 3，Library目录  ./Library这个目录下有两个子目录：Caches 和 Preferences
        //Library/Preferences目录，包含应用程序的偏好设置文件。不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好。
        //Library/Caches目录，主要存放缓存文件，iTunes不会备份此目录，此目录下文件不会再应用退出时删除
        
        ///Library目录－方法1
        let libraryPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory,
            NSSearchPathDomainMask.UserDomainMask, true)
        let libraryPath = libraryPaths[0] as String
        print("*****\(libraryPath)\r\n")
        ///Library目录－方法2
        let libraryPath2 = NSHomeDirectory() + "/Library"
        print("*****\(libraryPath2)\r\n")
        
        ///Cache目录－方法1
        let cachePaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory,
            NSSearchPathDomainMask.UserDomainMask, true)
        let cachePath = cachePaths[0] as String
        print("*****\(cachePath)\r\n")
        ///Cache目录－方法2
        //let cachePath2 = NSHomeDirectory() + "/Library/Caches"
        
    }
    
    
    static func statusesWithParams(params:NSDictionary) ->NSArray?{
        self.HouQuBenDiLJ()
        // 根据请求参数生成对应的查询SQL语句
        var sql:NSString = ""
      
        if let sinceId = params["since_id"] {
            print("*根据请求参数生成对应的查询SQL语句*\(sinceId)")
            //sql = NSString(format: "SELECT * FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;", sinceId as! NSNumber)
        sql = "SELECT * FROM t_status WHERE idstr > \(sinceId) ORDER BY idstr DESC LIMIT 2;"
            
            
        } else if let maxId = (params["max_id"]) {
            sql = "SELECT * FROM t_status WHERE idstr <= \(maxId) ORDER BY idstr DESC LIMIT 2;"
        } else {
            sql = "SELECT * FROM t_status ORDER BY idstr DESC LIMIT 2;"
        }
        
        // 执行SQL
        let set: FMResultSet  =  db!.executeQuery(sql as String, withArgumentsInArray: nil)
        let statuses: NSMutableArray = NSMutableArray()
        while set.next() {
            let statusData: NSData  = set.objectForColumnName("status") as! NSData
    
            let status: NSDictionary  = NSKeyedUnarchiver.unarchiveObjectWithData(statusData) as! NSDictionary
            statuses.addObject(status)
        }
        return statuses;
    }
   
    
    /**
     把整个数组存入数据库 外加一个索引
     
    */
    static func saveStatuses(statuses:NSArray){
        // 要将一个对象存进数据库的blob字段,最好先转为NSData
        // 一个对象要遵守NSCoding协议,实现协议中相应的方法,才能转成NSData
        for status in statuses {
            // NSDictionary --> NSData
        let status = status as! NSDictionary
        let statusData: NSData  = NSKeyedArchiver.archivedDataWithRootObject(status)
            //print("*****\(statusData)")
            
        let sql:String = "INSERT INTO t_status(status , idstr) VALUES (?, ?);"
        db?.executeUpdate(sql, withArgumentsInArray: [statusData,status["idstr"]!])
            //MARK: - 下面方法无法写入数据库
        //db?.executeUpdate("INSERT INTO t_status(status , idstr) VALUES (\(statusData), \(status["idstr"]!));", withArgumentsInArray: [])
 
            
        }
        
        
    }
    
    
    
    
    
    

    
}
