# Overview
A reference implementation of a [React Native Module](https://reactnative.dev/docs/native-modules-intro) for couchbase lite on iOS and Android.

**:NOTE:** The plugin is not officially supported by Couchbase and there are no guarantees that the APIs exported by the module are up to date with the latest version of Couchbase Lite. The module implementation is available as an open source reference implementation for developers to use as a starting point and contribute as needed

React Native Modules allow mobile apps written in React Native to access native platform APIs. The sample module exports a relevant subset of native Couchbase Lite API functionality and makes it available to React native JS apps. You can extend this module to expose otherAPIs per [module development guide](https://reactnative.dev/docs/native-modules-ios).

**LICENSE**: The source code for the plugin is Apache-licensed, as specified in LICENSE. However, the usage of Couchbase Lite will be guided by the terms and conditions specified in Couchbase's Enterprise or Community License agreements respectively

## Repo Folders

* The "_index.tsx_" file in the "_src_" folder contains the functions exported to JS world. The "_ios_" and "_android_" folders contain the corresponding implementation for iOS and Android platforms respectively. Although the underlying implementation of the APIs is platform specific, note that the JS API definitions are common. So you can share the App UI logic across Android and iOS

* The "_ios_" folder contains the React Native module implementation for iOS version of Couchbase Lite. Apps written in iOS must use this plugin.

* The "_android_" folder contains the React Native module implementation for Android version of Couchbase Lite. Apps written in Android must use this plugin.

## Sample App

A React Native app that demonstrates core database, CRUD, query and sync functions of Couchbase Lite using the plugin is available [here](). 


## Exported APIs

The following is a list of APIs (and features) exported by the react-native plugin. See the description of Couchbase Lite Native [API Specifications](https://docs.couchbase.com/mobile/3.0.0-beta02/couchbase-lite-android/com/couchbase/lite/package-summary.html) for an authoritative description of the API functionality.

**NOTE**: The plugin isn't a simple API passthrough. The plugin implements a Data Manager pattern and includes additional bookkeeping logic for managing and tracking open databases, replicators, listeners etc on behalf of the app. This avoids the need for the apps to implement all that bookkeeping logic. It is not required that you implement the plugin this way but it will simplify your app so you can focus on the apps UI and control logic. Also, by pushing these tasks into the plugin, app developers do not have to reimplement that logic for every app.

| API methods | Native Class |
| :---: | :---: |
| CreateOrOpenDatabase (with specified Configuration) | Database |
| closeDatabase | Database |
| deleteDatabase | Database |
| copyDatabase | Database |
| databaseExists | Database |
| addDatabaseChangeListener | Database |
| removeDatabaseChangeListener | Database |
| setDocument (With JSON OBJECT) | MutableDocument |
| getDocument | MutableDocument |
| deleteDocument | MutableDocument |
| purgeDocument | MutableDocument |
| setBlob | Database |
| getBlob  | Database |
| createValueIndex  | Database |
| createFTSIndex  | Database |
| deleteIndex  | Database |
| query  | Query |
| queryWithChangeListener  | Query |
| removeQueryChangeListener  | Query |
| enableConsoleLogging  | Database |
| createReplicator  | Replicator |
| replicatorStart  | Replicator |
| replicatorStop  | Replicator |
| replicationAddChangeListener  | Replicator |
| replicationRemoveChangeListener  | Replicator |

## Getting Started

We will look at the steps to integrate and use the react native module within a sample React Native app. The instructions assume some familiarity with [React Native app development](https://reactnative.dev/docs/environment-setup). You will do something similar when integrating into your own app. 

**iOS**: 

- Follow the instructions outlined in the README within the iOS folder on steps to integrate and use the Couchbase Lite RN module within a sample React Native iOS app.

**Android**: 

- Follow the instructions outlined in the README within the Android folder on steps to integrate and use the Couchbase Lite RN module within a sample React Native Android app.

## Usage

Here are a few examples of using the native module within your app

To use the module, you must declare the plugin at the on top of your `app.js` file.

```
import * as CBL from 'react-native-cblite';
```

### Create Database
```
let config = {
    encryptionKey: "{{ENCRYPTION_KEY}}",
    directory: "{{DIRECTORY}}"
};

let dbName = '{{DATABASE_NAME}}'
CBL.CreateOrOpenDatabase(dbName,config, function(rs) { 
  console.log("database "+ dbName + " creation: "+ rs.toString())
  }, function(error) { 
    console.log(error.toString())
    });

```

_Params_

 * dbName: Name of the Database as string.

 * config: Couchbase Database configuration JSONobject containing following.

    * directory: Path of the database directory as string.
    * encryptionKey: Encryption key as string.
    
 * Error Callback: Asynchronously triggers when the function fails execution. Contains Error string as param, If there is an exception while execution the param will have the string exception.
 * Success Callback:Asynchronously triggers when the function succeeds execution. Contains string Response as param, If there is no exception while execution the param can contain one of the following responses.

_Example Response_

 * _"Success"_
 * _"Database already exists"_
 * _"Missing Arguments: Database Name"_
 * _"Missing Arguments: Directory"_
 * _"Error while Creating Database: \{exception\}"_



### Close Database

```
let response = CBL.closeDatabase(dbName,function(rs) { 
  console.log("database "+ dbName + " closing : "+ rs.toString())
  }, function(error) {
     console.log(error.toString())
     });
```

_Params_

 * dbName:  Name of the Database as string.
 * Error Callback: Asynchronously triggers when the function fails execution. Contains Error string as param, If there is an exception while execution the param will have the string exception.
 * Success Callback:Asynchronously triggers when the function succeeds execution. Contains string Response as param, If there is no exception while execution the param can contain one of the following responses.
 
_Example Response_

 * _"Success"_
 * _"Database not found"_
 * _"Error while Closing Database : \{exception\}"_



### Delete Database

```
let response = CBL.deleteDatabase(dbName);
console.log("close" + dbName+ " database reponse is :" + response);
```

_Params_

 * dbName:  Name of the Database as string.

_Example Response_

 * _"Success"_
 * _"Database not found"_
 * _"Error while Deleting Database : \{exception\}"_



### Database Exists

```

 var dbexists = CouchbaseNativeModule.databaseExists(dbName, dbConfig);
        
```

_Params_

  * dbName: Name of the Database as string.
  * config: Couchbase Database configuration JSONobject containing following.

    * directory: Path of the database directory as string.
    * encryptionKey: Encryption key as string.

_Example Response_

 * _"Database already exists"_
 * _"Database not exists"_
 * _"Error"_
 * _"Missing Arguments : Database Name"_



### Create/Update Document

```
let docid = "{{DOCUMENT_ID}}";
let data = "{{JSON_OBJECT}}"; e.g { foo : 'bar', adam : 'eve' }
let dbName = "{{DATABASE_NAME}}";

CBL.setDocument(dbName,docid, JSON.stringify(data), function(rs) {
   console.log("Added document with body"+JSON.stringify(data) +" to db " + dbName + " "+ rs.toString())
   }, function(error) {
     console.log(error.toString()) 
     });

```

_Params_

 * dbName: Name of the Database as string.
 * docid: Unique id of the document as string.
 * data: A JSON object containing data to be saved in document.
 * Error Callback: Asynchronously triggers when the function fails execution. Contains Error string as param, If there is an exception while execution the param will have the string exception.
 * Success Callback: Asynchronously triggers when the function succeeds execution. Contains string Response as param, If there is no exception while execution the param can contain one of the following responses.

_Example Response_

 * _"Success"_
 * _"Document is Null"_
 * _"Document not found"_
 * _"Database not found"_
 * _"Missing Arguments: Database Name"_
 * _"Missing Arguments: Document ID"_
 * _"Missing Arguments: Document Data"_
 * _"Invalid Arguments: Document data is not in proper JSON format"_
 * _"Error while Creating Document: \{exception\}"_



### Get Document

```
let docid = "{{DOCUMENT_ID}}";
let dbName = "{{DATABASE_NAME}}";
CBL.getDocument(dbName,docid,function(rs) {
  console.log("Fetched document "+docid+ " from db " + dbName + " " + rs.toString()) 
  }, function(error) { 
    console.log(error.toString())
    });

```

_Params_

 * dbName: Name of the Database as string.
 * docid: Unique id of the document as string.
 * Error Callback: Asynchronously triggers when the function fails execution. Contains Error string as param, If there is an exception while execution the param will have the string exception.
 * Success Callback: Asynchronously triggers when the function succeeds execution. Contains string Response as param, If there is no exception while execution the param can contain one of the following responses.

_Example Response_

 * _"\{Document as JSON\}"_
 * _"Database not found"_
 * _"Document not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : Document ID"_
 * _"Error while Fetching Document : \{exception\}"_


### Save Blob

```
var blobMeta = CBL.setBlob(dbName,contentType,blob);
```

_Params_

 * dbName: Name of the Database as string.
 * contentType: MIME content type of the binary data
 * blob:  Base64 encoded string corresponding to binary data to be stored

_Example Response_

 * _"\{BLOB Meta Data\}"_: Synchronously returns a String of JSON Object of blob Meta Data which can be used retrieve blob by passing object to getBlob function.
 * _"Database not found"_
 * _"Missing Arguments : Content Type"_
 * _"Missing Arguments : Blob Data"_
 * _"Error while Creating Blob : \{exception\}"_


### Get Blob

```
CBL.getBlob(dbName,blobMeta,this.success_callback,this.error_callback);
```

_Params_

  * dbName: Name of the Database as string.
  * _blobMeta_: Meta Data JSON object of Blob which is returned from save blob function.
  * _Error Callback_: Asynchronously triggers when the function fails execution. Contains Error string as param, If there is an exception while execution the param will have the string exception.
  * _Success Callback_: Asynchronously triggers when the function succeeds execution. Contains string Response as param, If there is no exception while execution the param can contain one of the following responses.


_Example Response_

 * _"\{Base64 encoded Blob String\}"_
 * _"Blob not found"_
 * _"Database not found"_
 * _"Missing Arguments : BlobObject"_
 * _"Invalid Arguments : Blob Object is not in proper JSON format"_
 * _"Error while Fetching Blob : \{exception\}"_




### Add Database Change Listener

```

var JSListenerEvent = 'OnDatabaseChanged'

var response = CBL.EventsListeners.addDatabaseChangeListener(dbName,JSListenerEvent);

if(response=='Success') {
    CBL.EventsListeners.addListener(JSListener, (eventResponse) => { console.log(eventResponse) });
    }
    else {
        console.log("ERROR: " + response);
    }


```

_Params_

  * dbName: Name of the Database as string.
  * _JSListenerEvent_: String name of the Javascript listener event.


_Example Response for addChangeListener_
   * _"Success"_
   * _"Database not found"_
   * _"Missing Arguments : Database Name"_
   * _"Missing Arguments : JSListener"_
   * _"Database listener already registered with database. Please remove the database listener before registering new one."_


_Example Response in eventResponse_
   * _{"Modified": {"DocumentID": "DocumentJson"},"Deleted": {"DocumentID": "DocumentJson"}}_
   * _{"Deleted": {"DocumentID1": "Document1Json","DocumentID2": "Document2Json"...}}_
   * _{"Modified": {"DocumentID1": "Document2Json","DocumentID2": "Document2Json"...}}_



### Remove Database Change Listener

```

var JSListenerEvent = 'OnDatabaseChanged'
.....

var response = CBL.removeDatabaseChangeListener(dbName);

if(response=='Success') {
     CBL.EventsListeners.removeAllListeners(JSListenerEvent);
     }
     else {
        console.log("ERROR: " + response);
     }
```

_Params_

  * dbName: Name of the Database as string.
  * _JSListenerEvent_: String name of the Javascript listener event.


_Example Response_

 * _"Success"_
 * _"Database not found"_
 * _"Database listener not registered with database."_
 * _"Missing Arguments : Database Name"_



### Create Value Index

```

let indexExpressions = ['name', 'location'];
let indexName = "nameLocationIndex";

 var response = CouchbaseNativeModule.createValueIndex(dbName, indexName, indexExpressions);
        
```

_Params_

  * dbName: Name of the Database as string.
  * indexName: String name of index to be created.
  * indexExpressions: Array of Expressions of index to be created.
 

_Example Response_

 * _"Success"_
 * _"Database not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : Index Name"_
 * _"Missing Arguments : Index Expressions"_



### Create FTS Index

```

let indexExpressions = ['name', 'location'];
let indexName = "nameLocationIndex";
boolean ignoreAccents = true;
let language = "English";

 var response = CouchbaseNativeModule.createValueIndex(dbName, indexName, ignoreAccents, language, indexExpressions);
        
```

_Params_

  * dbName: Name of the Database as string.
  * indexName: String name of index to be created.
  * ignoreAccents (nullable) : Boolean value for ignoreAccents of index to be created.
  * language (nullable) : String language for index to be created.
  * indexExpressions: Array of Expressions of index to be created.
 

_Example Response_

 * _"Success"_
 * _"Database not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : Index Name"_
 * _"Missing Arguments : Index Expressions"_




### Delete Index

```

 let indexName = "nameLocationIndex";

 var response = CouchbaseNativeModule.deleteIndex(dbName, indexName);
        
```

_Params_

  * dbName: Name of the Database as string.
  * indexName: String name of index to be deleted.
 

_Example Response_

 * _"Success"_
 * _"Database not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : Index Name"_




### Enable Logging

```
let domain = "REPLICATOR"; // e.g for ALL_DOMAINS enter null }
let logLevel = "verbose";
 
var response = await CouchbaseNativeModule.enableLogging(domain,logLevel);
```

_Params_

  * domain: String value of log domain.
  * logLevel: String value of logLevel.
 
_Example Response_

 * _"Success"_
 * _"Error"_




### Query

```

  let query = "{{QUERY_STRING}}"; //e.g "select * from users"

  CouchbaseNativeModule.query(dbName, query,function(rs) {
     console.log("Query result "+ rs.toString())
     }, function(error) { 
       console.log(error.toString())
       }););
        
```

_Params_

  * dbName: Name of the Database as string.
  * query: String query to be executed.
  * Error Callback: Asynchronously triggers when the function fails execution. Contains Error string as param, If there is an exception while execution the param will have the string exception.
  * Success Callback:Asynchronously triggers when the function succeeds execution. Contains string Response as param, If there is no exception while execution the param can contain one of the following responses.


_Example Response_

 * _"[Query response]"_
 * _"Database not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : Query"_




### Live Query

```

  let query = "{{QUERY_STRING}}"; //e.g "select * from users"
  let JSListenerEvent = "OnQueryChanged"

  let listenerAddResponse = await CouchbaseNativeModule.queryWithChangeListener(dbName, query, JSListenerEvent);

  if (listenerAddResponse == "Success") {
      CBL.EventsListeners.addListener(JsListener, function(response){
        conosole.log("Query Response : ", response);
      });  
  }


        
```

_Params_

  * dbName: Name of the Database as string.
  * query: String query to be executed.
  * _JSListenerEvent_: String name of the Javascript listener event.


_Example Response_

 * _"Success"_
 * _"Database not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : Query"_


_Example Response in eventResponse_
   * _{{"DATABASE_NAME}": {{DocumentJson}}}_
   


### Stop Live Query

```
  let query = "{{QUERY_STRING}}"; //e.g "select * from users"
  let JSListenerEvent = "OnQueryChanged"

  var stopQueryListener = await CouchbaseNativeModule.removeQueryChangeListener(dbname, query);

  if (stopQueryListener == "Success") {
      CBL.EventsListeners.removeAllListeners(stopQueryListener);
  }
        
```

_Params_

  * dbName: Name of the Database as string.
  * query: String query to be executed.


_Example Response_

 * _"Success"_
 * _"Database not found"_
 * _"Query not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : Query"_



### Create Replicator

```
    var config = {
            databaseName: "{{DATABASE_NAME}}",
            target: "{{STRING_URI}}", // e.g "ws://10.0.2.2:4984/",
            authenticator: {
                authType: "{{AUTH_TYPE}}", // e.g. "Basic"
                username: "{{AUTH_USERNAME}}", // e.g. "user@example.com"
                password: "{{AUTH_PASSWORD}}" // e.g. "examplePassword"
            }, //optional
            continuous: {{BOOLEAN}}, //optional
            headers: [{HEADER_ARRAY}], //optional
            channels: [{CHANNELS_LIST}], //optional
            documentIds: [{DOCUMENT_ID_LIST}], //optional
            acceptOnlySelfSignedServerCertificate: {{BOOLEAN}}, //optional
            pinnedServerCertificateUri: {{STRING_URI}}, //optional
            heartbeat:{{HEARTBEAT_INT}}, //optional
          
        }

  let ReplicatorID = await CouchbaseNativeModule.createReplicator(dbname, config);
  
  console.log("ReplicatorID", ReplicatorID);

        
```

_Params_

  * dbName: Name of the Database as string.
  * config: Configuration object for replicator.


_Example Response_

 * _"{{REPLICATOR_ID}}"_
 * _"Database not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : Config"_




### Start Replicator

```
  let startReplicatorResponse = await CouchbaseNativeModule.replicatorStart(dbname, ReplicatorID);
     
  console.log("Replicator Started", startReplicatorResponse)
        
```

_Params_

  * dbName: Name of the Database as string.
  * ReplicatorID: String ID of replicator, obtained from CreateReplicator function.


_Example Response_

 * _"Success"_
 * _"Failed"_
 * _"Database not found"_
 * _"Replicator not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : ReplicatorID"_




### Stop Replicator

```
  let stopReplicatorResponse = await CouchbaseNativeModule.replicatorStop(dbname, ReplicatorID);
     
  console.log("Replicator Stopped", stopReplicatorResponse)
    
```

_Params_

  * dbName: Name of the Database as string.
  * ReplicatorID: String ID of replicator, obtained from CreateReplicator function.


_Example Response_

 * _"Success"_
 * _"Failed"_
 * _"Database not found"_
 * _"Replicator not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : ReplicatorID"_




### Create Replicator Listener

```
  let JSListenerEvent = "OnReplicatorChanged"

  let ReplicatorListenerResponse = await CouchbaseNativeModule.replicationAddChangeListener(dbname, ReplicatorID, JSListenerEvent);
     
   if (ReplicatorListenerResponse == "Success") {
      CBL.EventsListeners.addListener(JSListenerEvent, function(response){
        conosole.log("Replicator Status Response : ", response);
      });  
  }
        
```

_Params_

  * dbName: Name of the Database as string.
  * ReplicatorID: String ID of replicator, obtained from CreateReplicator function.
  * _JSListenerEvent_: String name of the Javascript listener event.


_Example Response_

 * _"Success"_
 * _"Database not found"_
 * _"Replicator not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : ReplicatorID"_
 * _"Missing Arguments : JSListener"_


_Example Response in eventResponse_

   * _{"status": "{STATUS}", "completed":{COMPLETED_TASKS}, "total":{TOTAL_TASKS}}_
   * _{"status": "{STATUS}", "error":"{ERROR_MESSAGE}", "errorCode":"{ERROR_CODE}", "completed":{COMPLETED_TASKS}, "total":{TOTAL_TASKS}}_
   



### Remove Replicator Listener

```
  let JSListenerEvent = "OnReplicatorChanged"

  var stopReplicatorListener = await CouchbaseNativeModule.replicationRemoveChangeListener(dbname, ReplicatorID);

  if (stopReplicatorListener == "Success") {
      CBL.EventsListeners.removeAllListeners(JSListenerEvent);
  }
        
```

_Params_

  * dbName: Name of the Database as string.
  * ReplicatorID: String ID of replicator, obtained from CreateReplicator function.


_Example Response_

 * _"Success"_
 * _"Database not found"_
 * _"Replicator not found"_
 * _"Missing Arguments : Database Name"_
 * _"Missing Arguments : ReplicatorID"_



