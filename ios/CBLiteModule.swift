import CouchbaseLiteSwift

@objc(Cblite)
class Cblite: NSObject {
    private var _TAG = "CBLite"
    var TAG: String {
        get { return _TAG }
    }
    
    @objc
    func CreateOrOpenDatabase(_ dbname: String,
                              config: [String:Any],
                              OnSuccessCallback: RCTResponseSenderBlock,
                              OnErrorCallback: RCTResponseSenderBlock) {
        var databaseArgs = DatabaseArgs()
        do {
            if !dbname.isEmpty {
                if config.count > 0 {
                    databaseArgs = DatabaseArgs(dbname: dbname, databaseConfig: config)
                } else {
                    databaseArgs = DatabaseArgs(dbname: dbname)
                }
                let response = try DatabaseManager.shared.openOrCreateDatabase(args: databaseArgs)
                if response == ResponseStrings.DBExists || response == ResponseStrings.SuccessCode {
                    OnSuccessCallback([response])
                } else {
                    let error = response;
                    OnErrorCallback([error])
                }
            } else {
                let error = ResponseStrings.MissingargsDBN;
                OnErrorCallback([error])
            }
        } catch let error {
            let error = ResponseStrings.ExceptionDB + error.localizedDescription;
            OnErrorCallback([error])
        }
    }
    
    @objc
    func closeDatabase(_ dbname: String,
                       OnSuccessCallback:RCTResponseSenderBlock,
                       OnErrorCallback: RCTResponseSenderBlock) {
        do {
            if !dbname.isEmpty {
                let response = try DatabaseManager.shared.closeDatabase(dbName: dbname)
                if response == ResponseStrings.SuccessCode {
                    OnSuccessCallback([response])
                } else {
                    let error = response;
                    OnErrorCallback([error])
                }
            } else {
                let error = ResponseStrings.MissingargsDBN;
                OnErrorCallback([error])
            }
        } catch let error {
            let error = ResponseStrings.ExceptionDBclose + error.localizedDescription;
            OnErrorCallback([error])
        }
    }
    
    @objc
    func deleteDatabase(_ dbname: String)->String {
        do {
            if !dbname.isEmpty {
                return (try DatabaseManager.shared.deleteDatabase(dbName: dbname));
                
            } else {
                let error = ResponseStrings.MissingargsDBN;
                return error;
            }
        } catch let error {
            let error = ResponseStrings.ExceptionDBdelete + error.localizedDescription;
            return error;
        }
    }
    
    @objc
    func purgeDocument(_ dbname: String,
                        docid: String,
                       OnSuccessCallback:RCTResponseSenderBlock,
                       OnErrorCallback: RCTResponseSenderBlock) {
        do {
            var documentArgs = DocumentArgs()
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                OnErrorCallback([error])
            } else if docid.isEmpty {
                let error = ResponseStrings.MissingargsDCID;
                OnErrorCallback([error])
            } else {
                documentArgs = DocumentArgs(dbname: dbname, docid: docid)
                let response = try DatabaseManager.shared.purgeDocument(documentArgs: documentArgs)
                if !response.isEmpty {
                    if response == ResponseStrings.SuccessCode {
                        OnSuccessCallback([response])
                    } else {
                        let error = response;
                        OnErrorCallback([error])
                    }
                }
            }
        } catch let error {
            let error = ResponseStrings.Exception + error.localizedDescription
            OnErrorCallback([error])
        }
    }
    
    @objc
    func copyDatabase(_ currentdbname: String,
                      newDBName: String,
                      currentConfig: [String:Any],
                      newConfig: [String:Any],
                      OnSuccessCallback:RCTResponseSenderBlock,
                      OnErrorCallback: RCTResponseSenderBlock) {
        do {
            let currentDatabaseArgs = DatabaseArgs(dbname: currentdbname, databaseConfig: currentConfig)
            let newDatabaseArgs = DatabaseArgs(dbname: newDBName, databaseConfig: newConfig)
            
            if currentdbname.isEmpty {
                let error = ResponseStrings.Missingargs + "Current Database Name";
                OnErrorCallback([error])
            } else if newDBName.isEmpty {
                let error = ResponseStrings.Missingargs + "New Database Name"
                OnErrorCallback([error]);
            } else if currentConfig.count < 1 {
                let error = ResponseStrings.Missingargs + "Current Database Config";
                OnErrorCallback([error])
            } else if newConfig.count < 1 {
                let error = ResponseStrings.Missingargs + "New Database Config";
                OnErrorCallback([error])
            } else {
                let response = try DatabaseManager.shared.copyDatabase(cargs: currentDatabaseArgs, nargs: newDatabaseArgs)
                if response == ResponseStrings.SuccessCode {
                    OnSuccessCallback([response])
                } else {
                    let error = response;
                    OnErrorCallback([error])
                }
            }
        } catch let error {
            let error = ResponseStrings.ExceptionDBcopy + error.localizedDescription;
            OnErrorCallback([error])
        }
    }
    
    @objc
    func databaseExists(_ dbname: String,
                        config: [String:Any])->String {
        if !dbname.isEmpty {
            var databaseArgs = DatabaseArgs()
            if config.count > 0 {
                databaseArgs = DatabaseArgs(dbname: dbname, databaseConfig: config)
            } else {
                databaseArgs = DatabaseArgs(dbname: dbname)
            }
            return (DatabaseManager.shared.databaseExists(args: databaseArgs))
        } else {
            let error = ResponseStrings.MissingargsDBN;
            return error;
        }
    }
    
    @objc
    func deleteDocument(_ dbname: String,
                        docid: String,
                       OnSuccessCallback:RCTResponseSenderBlock,
                       OnErrorCallback: RCTResponseSenderBlock) {
        do {
            var documentArgs = DocumentArgs()
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                OnErrorCallback([error])
            } else if docid.isEmpty {
                let error = ResponseStrings.MissingargsDCID;
                OnErrorCallback([error])
            } else {
                documentArgs = DocumentArgs(dbname: dbname, docid: docid)
                let response = try DatabaseManager.shared.deleteDocument(documentArgs: documentArgs)
                if !response.isEmpty {
                    if response == ResponseStrings.SuccessCode {
                        OnSuccessCallback([response])
                    } else {
                        let error = response;
                        OnErrorCallback([error])
                    }
                }
            }
        } catch let error {
            let error = ResponseStrings.Exception + error.localizedDescription
            OnErrorCallback([error])
        }
    }
    
    @objc
    func getDocument(_ dbname: String,
                     docid: String,
                     OnSuccessCallback:RCTResponseSenderBlock,
                     OnErrorCallback: RCTResponseSenderBlock) {
        do {
            var documentArgs = DocumentArgs()
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                OnErrorCallback([error])
            } else if docid.isEmpty {
                let error = ResponseStrings.MissingargsDCID;
                OnErrorCallback([error])
            } else {
                documentArgs = DocumentArgs(dbname: dbname, docid: docid)
                if let response = try DatabaseManager.shared.getDocument(args: documentArgs) {
                    if !response.isEmpty {
                        if response != ResponseStrings.DBnotfound && response != ResponseStrings.Docnotfound {
                            OnSuccessCallback([response])
                        } else {
                            let error = response;
                            OnErrorCallback([error])
                        }
                    } else {
                        let error = ResponseStrings.NullDoc;
                        OnErrorCallback([error])
                    }
                }
            }
        } catch let error {
            let error = ResponseStrings.ExceptionDOCGet + error.localizedDescription;
            OnErrorCallback([error])
        }
    }
    
    @objc
    func setDocument(_ dbname: String,
                     docid: String,
                     data: String,
                     OnSuccessCallback:RCTResponseSenderBlock,
                     OnErrorCallback: RCTResponseSenderBlock) {
        var documentArgs = DocumentArgs()
        if dbname.isEmpty {
            let error = ResponseStrings.MissingargsDBN;
            OnErrorCallback([error])
        } else if docid.isEmpty {
            let error = ResponseStrings.MissingargsDCID;
            OnErrorCallback([error])
        } else if data.isEmpty {
            let error = ResponseStrings.MissingargsDCData;
            OnErrorCallback([error])
        } else {
            documentArgs = DocumentArgs(dbname: dbname, docid: docid, data: data)
            let response = DatabaseManager.shared.setDocument(args: documentArgs)
            if !response.isEmpty {
                if response == ResponseStrings.SuccessCode {
                    OnSuccessCallback([response])
                } else {
                    let error = response;
                    OnErrorCallback([error])
                }
            } else {
                let error = ResponseStrings.ExceptionDOC;
                OnErrorCallback([error])
            }
        }
    }
    
    @objc
    func setBlob(_ dbname: String,
                 type: String,
                 docObject: String)->String {
        if dbname.isEmpty {
            let error = ResponseStrings.MissingargsDBN;
            return error;
        } else if type.isEmpty {
            let error = ResponseStrings.Missingargs + "Content Type";
            return error;
        } else if docObject.isEmpty {
            let error = ResponseStrings.Missingargs + "Blob Data";
            return error;
        } else {
            do {
                return (try DatabaseManager.shared.setBlob(dbname: dbname,
                                                   type: type,
                                                   blobdata: docObject))
            } catch let error {
                let error = ResponseStrings.ExceptionBLOB + error.localizedDescription;
                return error;
            }
        }
    }
    
    @objc
    func getBlob(_ dbname: String,
                 key: String,
                 OnSuccessCallback:RCTResponseSenderBlock,
                 OnErrorCallback: RCTResponseSenderBlock) {
        if dbname.isEmpty {
            let error = ResponseStrings.MissingargsDBN;
            OnErrorCallback([error])
        } else {
            do {
                let response = try DatabaseManager.shared.getBlob(dbname: dbname,
                                                                  key: key)
                if response != ResponseStrings.DBnotfound && response != ResponseStrings.invalidblob && response != ResponseStrings.Blobnotfound {
                    OnSuccessCallback([response])
                } else {
                    let error = response;
                    OnErrorCallback([error])
                }
            } catch let error {
                let error = ResponseStrings.ExceptionBLOBget + error.localizedDescription;
                OnErrorCallback([error])
            }
        }
    }
    
    @objc
    func createValueIndex(_ dbname: String, indexName: String, indexExpressions: [String])->String {
        do {
        if dbname.isEmpty {
            let error = ResponseStrings.MissingargsDBN;
            return error;
        } else if indexName.isEmpty {
            let error = ResponseStrings.MissingargsIN;
            return error;
        } else if indexExpressions.count < 1 {
            let error = ResponseStrings.MissingargsINEX;
            return error;
        } else {
            var parsedIndexExpressions = [String]()
            indexExpressions.forEach { index in
                parsedIndexExpressions.append(index)
            }
            let vargs = IndexArgs()
            vargs.ValueIndexArgs(dbName: dbname, indexName: indexName, indexExpressions: parsedIndexExpressions)
            let result = try DatabaseManager.shared.createValueIndex(args: vargs)
            return (result)
        }
        } catch let error {
            let error = ResponseStrings.Exception + error.localizedDescription;
            return error;
        }
    }
    
    @objc
    func createFTSIndex(_ dbname: String, indexName: String, options: [String:Any], indexExpressions: [String])-> String{
        do {
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                return error;
            } else if indexName.isEmpty {
                let error = ResponseStrings.MissingargsIN;
                return error;
            } else if indexExpressions.count < 1 {
                let error = ResponseStrings.MissingargsINEX;
                return error;
            } else if options.count < 1 || !options.keys.contains("ignoreAccents") || !options.keys.contains("language"){
                let error = "Options must not be empty. It must have 'ignoreAccents' and 'language' as elements."
                return error;
            } else {
                var iAccents = false
                var lang = ""
                if let ignoreAccents = options["ignoreAccents"] as? Bool {
                    iAccents = ignoreAccents
                } else {
                    let error = "'ignoreAccents'must be a 'boolean'";
                    return error;
                }
                if let language = options["language"] as? String {
                    lang = language
                } else {
                    let error = "'language'must be a 'string'";
                    return error;
                }
                var parsedIndexExpressions = [String]()
                indexExpressions.forEach { index in
                    parsedIndexExpressions.append(index)
                }
                let fargs = IndexArgs()
                fargs.FTSIndexArgs(dbName: dbname, indexName: indexName, ignoreAccents: iAccents, language: lang, indexExpressions: parsedIndexExpressions)
                let result = try DatabaseManager.shared.createValueIndex(args: fargs)
                return (result)
                
            }
        } catch let error {
            let error = ResponseStrings.Exception + error.localizedDescription;
            return error;
        }
    }
    
    @objc
    func deleteIndex(_ dbname: String, indexName: String)->String{
        do {
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                return error;
            } else if indexName.isEmpty {
                let error = ResponseStrings.MissingargsIN;
                return error;
            } else {
                let fargs = IndexArgs()
                fargs.DeleteIndexArgs(dbName: dbname, indexName: indexName)
                let result = try DatabaseManager.shared.deleteIndex(args: fargs)
                return (result)
            }
        } catch let error {
            let error = ResponseStrings.Exception + error.localizedDescription;
            return error;
        }
    }
    
    @objc
    func addDatabaseChangeListener(_ dbname: String, listener: String) -> String {
        if dbname.isEmpty {
            let error = ResponseStrings.MissingargsDBN;
            return error;
        } else if listener.isEmpty {
            let error = ResponseStrings.Missingargs + "JSListener";
            return error;
        } else {
            let result = DatabaseManager.shared.registerForDatabaseChanges(dbname: dbname, jsListener: listener)
            if result == ResponseStrings.SuccessCode {
                return result;
            } else {
                let error = result;
                return error
            }
        }
    }
    
    @objc
    func removeDatabaseChangeListener(_ dbname: String)->String{
        if dbname.isEmpty {
            let error = ResponseStrings.MissingargsDBN;
            return error;
        } else {
            let result = DatabaseManager.shared.deregisterForDatabaseChanges(dbname: dbname)
            if result == ResponseStrings.SuccessCode {
                return (result);
            } else {
                let error = result;
                return error;
            }
        }
    }
    
    @objc
    func enableConsoleLogging(_ domain: String, logLevel: String)->String {
        if logLevel.isEmpty {
            let error = ResponseStrings.Missingargs+"logLevel";
            return error;
        } else {
            let result = DatabaseManager.shared.enableLogging(domain: domain, logLevel: logLevel)
            if result == ResponseStrings.SuccessCode {
                return (ResponseStrings.SuccessCode);
            } else {
                let error = ResponseStrings.ExceptionEnableLogging;
                return error;
            }
        }
    }
    
    @objc
    func createQuery(_ dbname: String, query: String)->String {
        do {
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                return error;
            } else if query.isEmpty {
                let error = ResponseStrings.Missingargs+"Query";
                return error;
            } else {
                let qArgs = QueryArgs(dbName: dbname, query: query)
                let result = try DatabaseManager.shared.createQuery(args: qArgs)
                if result != ResponseStrings.DBnotfound
                    && result != ResponseStrings.NoArgs
                    && result != ResponseStrings.ExceptionInvalidQuery
                    && result != ResponseStrings.invaliddata {
                    return (result);
                } else {
                    let error = result;
                    return error;
                }
            }
        } catch let error {
            let error = ResponseStrings.ExceptionQuery+error.localizedDescription;
            return error;
        }
    }
    
    @objc
    func query(_ dbname: String, query: String, OnSuccessCallback:RCTResponseSenderBlock, OnErrorCallback: RCTResponseSenderBlock) {
        do {
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                OnErrorCallback([error])
            } else if query.isEmpty {
                let error = ResponseStrings.Missingargs + "Query";
                OnErrorCallback([error])
            } else {
                let qArgs = QueryArgs(dbName: dbname, query: query)
                let result = try DatabaseManager.shared.queryDb(args: qArgs)
                if result != ResponseStrings.DBnotfound
                    && result != ResponseStrings.NoArgs
                    && result != ResponseStrings.ExceptionInvalidQuery
                    && result != ResponseStrings.invaliddata {
                    OnSuccessCallback([result])
                } else {
                    let error = result;
                    OnErrorCallback([error])
                }
            }
        } catch let error {
            let error = ResponseStrings.ExceptionQuery+error.localizedDescription;
            OnErrorCallback([error])
        }
    }
    
    @objc
    func queryWithChangeListener(_ dbname: String, query: String, listener: String)->String {
        do {
        if dbname.isEmpty {
            let error = ResponseStrings.MissingargsDBN;
            return error;
        } else if query.isEmpty {
            let error = ResponseStrings.Missingargs+"Query";
            return error;
        } else if listener.isEmpty {
            let error = ResponseStrings.Missingargs+"JSListener";
            return error;
        } else {
            let result = try DatabaseManager.shared.registerForQueryChanges(dbname: dbname, query: query, jsListener: listener)
            return (result);
        }
        } catch let error {
            let error = ResponseStrings.Exception + error.localizedDescription;
            return error;
        }
    }
    
    @objc
    func removeQueryChangeListener(_ dbname: String, query: String)->String {
        do {
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                return error;
            } else if query.isEmpty {
                let error = ResponseStrings.Missingargs+"Query";
                return error;
            } else {
                let result = try DatabaseManager.shared.deregisterForQueryChanges(dbname: dbname, queryString: query)
                return (result);
            }
        } catch let error {
            let error = ResponseStrings.Exception + error.localizedDescription;
            return error;
        }
    }
    
    
    @objc
    func createReplicator(_ dbname:String, replicatorConfig:[String:Any]) -> String   {
      
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN
                return error;
            } else if replicatorConfig.isEmpty {
                let error = ResponseStrings.Missingargs+"Replicator Config"
                return error;
            } else {
                let result = DatabaseManager.shared.createReplicator(dbname: dbname, replicatorConfig: replicatorConfig)
                return (result);
            }
       
    }
    
    @objc
    func replicatorStart(_ dbname:String,rid:String) -> String  {
        do {
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                return error;
            } else if rid.isEmpty {
                let error = ResponseStrings.Missingargs+"Replicator ID";
                return error;
            } else {
                let result = try DatabaseManager.shared.replicatorStart(dbname: dbname, id: rid)
                return (result);
            }
        } catch let error {
            let error = ResponseStrings.Exception + error.localizedDescription;
            return error;
        }
    }
    
    @objc
    func replicatorStop(_ dbname:String,rid:String) -> String  {
        do {
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                return error;
            } else if rid.isEmpty {
                let error = ResponseStrings.Missingargs+"Replicator ID";
                return error;
            } else {
                let result = try DatabaseManager.shared.replicatorStop(dbname: dbname, id: rid)
                return (result);
            }
        } catch let error {
            let error = ResponseStrings.Exception + error.localizedDescription;
            return error;
        }
    }
    
    @objc
    func replicationRemoveChangeListener(_ dbname:String,rid:String) -> String  {
        do {
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                return error;
            } else if rid.isEmpty {
                let error = ResponseStrings.Missingargs+"Replicator ID";
                return error;
            } else {
                let result = try DatabaseManager.shared.replicationRemoveChangeListener(dbname: dbname, id: rid)
                return (result);
            }
        } catch let error {
            let error = ResponseStrings.Exception + error.localizedDescription;
            return error;
        }
    }
    
    
    @objc
    func replicationAddChangeListener(_ dbname:String,rid:String,listner:String) -> String  {
        do {
            if dbname.isEmpty {
                let error = ResponseStrings.MissingargsDBN;
                return error;
            } else if rid.isEmpty {
                let error = ResponseStrings.Missingargs+"Replicator ID";
                return error;
            } else {
                let result = try DatabaseManager.shared.replicationAddChangeListener(dbname: dbname, id: rid, listner:listner)
                return (result);
            }
        } catch let error {
            let error = ResponseStrings.Exception + error.localizedDescription;
            return error;
        }
    }
    
    
    
    
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
