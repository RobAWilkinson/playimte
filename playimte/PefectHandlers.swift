import PerfectLib
let DB_PATH = PerfectServer.staticPerfectServer.homeDir() + serverSQLiteDBs + "PWSDB"

// This function is required. The Perfect framework expects to find this function
// to do initialization
public func PerfectServerModuleInit() {
    print("hit thi")
    // Install the built-in routing handler.
    // This is required by Perfect to initialize everything
    Routing.Handler.registerGlobally()
    
    // register a route for gettings posts
    Routing.Routes["GET", "/posts"] = { _ in
        return GetPostHandler()
    }
    
    // register a route for creating a new post
    Routing.Routes["POST", "/posts"] = { _ in
        return PostHandler()
    }
    do {
        let sqlite = try SQLite(DB_PATH)
        try sqlite.execute("CREATE TABLE IF NOT EXISTS pws (id INTEGER PRIMARY KEY, content STRING)")
    } catch {
        print("Failure creating database at " + DB_PATH)
    }
}

class GetPostHandler: RequestHandler {
    func handleRequest(request: WebRequest, response: WebResponse) {
        print("hit it")
        response.appendBodyString("get posts")
        response.requestCompletedCallback()
    }
}

class PostHandler: RequestHandler {
    func handleRequest(request: WebRequest, response: WebResponse) {
        response.appendBodyString("creating post")
        response.requestCompletedCallback()
    }
}

func scrapeImdb() {
    
}