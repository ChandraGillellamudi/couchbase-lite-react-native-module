import { NativeModules, Platform, NativeEventEmitter, DeviceEventEmitter } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-cblite' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", android: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const linkin_err = new Proxy(
  {},
  {
    get() {
      throw new Error(LINKING_ERROR);
    },
  }
);

//const CBLite = NativeModules.CBLite ? NativeModules.CBLite : linkin_err;

const CBLite = Platform.OS == 'ios'? (NativeModules.Cblite
  ? NativeModules.Cblite :linkin_err) : (NativeModules.CBLite? NativeModules.CBLite : linkin_err);


export const EventsListeners = Platform.OS === 'ios' ? new NativeEventEmitter(NativeModules.RNEventEmitter): DeviceEventEmitter

export function CreateOrOpenDatabase(
  dbname: string,
  config: Object,
  OnSuccessCallback: Function,
  OnErrorCallback: Function
): void {
  CBLite.CreateOrOpenDatabase(
    dbname,
    config,
    OnSuccessCallback,
    OnErrorCallback
  );
}
export function closeDatabase(
  dbname: string,
  OnSuccessCallback: Function,
  OnErrorCallback: Function
): void {
  CBLite.closeDatabase(dbname, OnSuccessCallback, OnErrorCallback);
}
export function deleteDatabase(dbname: string): string {
  return CBLite.deleteDatabase(dbname);
}
export function copyDatabase(
  currentdbname: string,
  newDBName: string,
  currentConfig: Object,
  newConfig: Object,
  OnSuccessCallback: Function,
  OnErrorCallback: Function
): void {
  CBLite.copyDatabase(
    currentdbname,
    newDBName,
    currentConfig,
    newConfig,
    OnSuccessCallback,
    OnErrorCallback
  );
}
export function databaseExists(
  dbname: string,
  config: Object
): string {
  return CBLite.databaseExists(dbname, config);
}
export function deleteDocument(
  dbname: string,
  docid: string,
  OnSuccessCallback: Function,
  OnErrorCallback: Function
): void {
  CBLite.deleteDocument(dbname, docid, OnSuccessCallback, OnErrorCallback);
}

export function purgeDocument(
  dbname: string,
  docid: string,
  OnSuccessCallback: Function,
  OnErrorCallback: Function
): void {
  CBLite.purgeDocument(dbname, docid, OnSuccessCallback, OnErrorCallback);
}
export function getDocument(
  dbname: string,
  docid: string,
  OnSuccessCallback: Function,
  OnErrorCallback: Function
): void {
  CBLite.getDocument(dbname, docid, OnSuccessCallback, OnErrorCallback);
}
export function setDocument(
  dbname: string,
  docid: string,
  data: string,
  OnSuccessCallback: Function,
  OnErrorCallback: Function
): void {
  CBLite.setDocument(dbname, docid, data, OnSuccessCallback, OnErrorCallback);
}
export function setBlob(
  dbname: string,
  type: string,
  imagedata: string,
): string {
  return CBLite.setBlob(dbname, type, imagedata);
}
export function getBlob(
  dbname: string,
  blobData: object,
  OnSuccessCallback: Function,
  OnErrorCallback: Function
): void {
  CBLite.getBlob(dbname, blobData, OnSuccessCallback, OnErrorCallback);
}
export function createValueIndex(
  dbname: string,
  indexName: string,
  indexExpressions: [string]
): string {
  return CBLite.createValueIndex(dbname, indexName, indexExpressions);
}
export function createFTSIndex(
  dbname: string,
  indexName: string,
  options: Object,
  indexExpressions: [string]
): string {
  return CBLite.createFTSIndex(dbname, indexName, options, indexExpressions);
}
export function deleteIndex(
  dbname: string,
  indexName: string
): string {
  return CBLite.deleteIndex(dbname, indexName);
}
export function addDatabaseChangeListener(
  dbname: string,
  listener: string
): string {
  return CBLite.addDatabaseChangeListener(dbname, listener);
}
export function removeDatabaseChangeListener(dbname: string): string {
  return CBLite.removeDatabaseChangeListener(dbname);
}
export function enableConsoleLogging(
  domain: string,
  logLevel: string
): string {
  return CBLite.enableConsoleLogging(domain, logLevel);
}
export function createQuery(dbname: string, query: string): string {
  return CBLite.createQuery(dbname, query);
}
export function query(
  dbname: string,
  // eslint-disable-next-line no-shadow
  query: string,
  OnSuccessCallback: Function,
  OnErrorCallback: Function
): void {
  CBLite.query(dbname, query, OnSuccessCallback, OnErrorCallback);
}
export function queryWithChangeListener(
  dbname: string,
  // eslint-disable-next-line no-shadow
  query: string,
  listener: string
): string {
  return CBLite.queryWithChangeListener(dbname, query, listener);
}
export function removeQueryChangeListener(
  dbname: string,
  // eslint-disable-next-line no-shadow
  query: string
): string {
  return CBLite.removeQueryChangeListener(dbname, query);
}



export function createReplicator(
  dbname: string,
  // eslint-disable-next-line no-shadow
  replicatorConfig: Object,
): string {
  return CBLite.createReplicator(dbname, replicatorConfig);
}

export function replicationAddChangeListener(
  dbname: string,
  // eslint-disable-next-line no-shadow
  replicatorID: string,
  // eslint-disable-next-line no-shadow
  JSlistener: string
): string {
  return CBLite.replicationAddChangeListener(dbname, replicatorID, JSlistener);
}
export function replicationRemoveChangeListener(
  dbname: string,
  // eslint-disable-next-line no-shadow
  replicatorID: string
): string {
  return CBLite.replicationRemoveChangeListener(dbname, replicatorID);
}
export function replicatorStop(
  dbname: string,
  // eslint-disable-next-line no-shadow
  replicatorID: string
): string {
  return CBLite.replicatorStop(dbname, replicatorID);
}
export function replicatorStart(
  dbname: string,
  // eslint-disable-next-line no-shadow
  replicatorID: string
): string {
  return CBLite.replicatorStart(dbname, replicatorID);
}
