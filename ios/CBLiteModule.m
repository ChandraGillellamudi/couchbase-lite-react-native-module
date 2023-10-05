#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(Cblite, NSObject)

RCT_EXTERN_METHOD(CreateOrOpenDatabase:(NSString *)dbname config:(NSDictionary *)config OnSuccessCallback:(RCTResponseSenderBlock)OnSuccessCallback OnErrorCallback:(RCTResponseSenderBlock)OnErrorCallback)

RCT_EXTERN_METHOD(closeDatabase:(NSString *)dbname OnSuccessCallback:(RCTResponseSenderBlock)OnSuccessCallback OnErrorCallback:(RCTResponseSenderBlock)OnErrorCallback)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(
                                        deleteDatabase:(NSString *)dbname
                                        )

RCT_EXTERN_METHOD(copyDatabase:(NSString *)currentdbname newDBName:(NSString *)newDBName currentConfig:(NSDictionary *)currentConfig newConfig:(NSDictionary *)newConfig OnSuccessCallback:(RCTResponseSenderBlock)OnSuccessCallback OnErrorCallback:(RCTResponseSenderBlock)OnErrorCallback)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(databaseExists:(NSString *)dbname config:(NSDictionary *)config)

RCT_EXTERN_METHOD(deleteDocument:(NSString *)dbname docid:(NSString *)docid OnSuccessCallback:(RCTResponseSenderBlock)OnSuccessCallback OnErrorCallback:(RCTResponseSenderBlock)OnErrorCallback)

RCT_EXTERN_METHOD(purgeDocument:(NSString *)dbname docid:(NSString *)docid OnSuccessCallback:(RCTResponseSenderBlock)OnSuccessCallback OnErrorCallback:(RCTResponseSenderBlock)OnErrorCallback)

RCT_EXTERN_METHOD(getDocument:(NSString *)dbname docid:(NSString *)docid OnSuccessCallback:(RCTResponseSenderBlock)OnSuccessCallback OnErrorCallback:(RCTResponseSenderBlock)OnErrorCallback)

RCT_EXTERN_METHOD(setDocument:(NSString *)dbname docid:(NSString *)docid data:(NSString *)data OnSuccessCallback:(RCTResponseSenderBlock)OnSuccessCallback OnErrorCallback:(RCTResponseSenderBlock)OnErrorCallback)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(setBlob:(NSString *)dbname type:(NSString *)type docObject:(NSString *)docObject
                                       )

RCT_EXTERN_METHOD(getBlob:(NSString *)dbname key:(NSString *)key OnSuccessCallback:(RCTResponseSenderBlock)OnSuccessCallback OnErrorCallback:(RCTResponseSenderBlock)OnErrorCallback)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(createValueIndex:(NSString *)dbname indexName:(NSString *)indexName indexExpressions:(NSArray *)indexExpressions)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(createFTSIndex:(NSString *)dbname indexName:(NSString *)indexName options:(NSDictionary *)options indexExpressions:(NSArray *)indexExpressions)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(deleteIndex:(NSString *)dbname indexName:(NSString *)indexName)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(addDatabaseChangeListener:(NSString *)dbname listener:(NSString *)listener)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(removeDatabaseChangeListener:(NSString *)dbname)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(enableConsoleLogging:(NSString *)domain logLevel:(NSString *)logLevel)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(createQuery:(NSString *)dbname query:(NSString *)query)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(createReplicator:(NSString *)dbname replicatorConfig:(NSDictionary *)replicatorConfig)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(replicatorStart:(NSString *)dbname rid:(NSString *)rid)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(replicatorStop:(NSString *)dbname rid:(NSString *)rid)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(replicationRemoveChangeListener:(NSString *)dbname rid:(NSString *)rid)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(replicationAddChangeListener:(NSString *)dbname rid:(NSString *)rid listner:(NSString *)listner)

RCT_EXTERN_METHOD(query:(NSString *)dbname query:(NSString *)query OnSuccessCallback:(RCTResponseSenderBlock)OnSuccessCallback OnErrorCallback:(RCTResponseSenderBlock)OnErrorCallback)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(queryWithChangeListener:(NSString *)dbname query:(NSString *)query listener:(NSString *)listener)

RCT_EXTERN__BLOCKING_SYNCHRONOUS_METHOD(removeQueryChangeListener:(NSString *)dbname query:(NSString *)query)
@end
