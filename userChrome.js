/* :::::::: Sub-Script/Overlay Loader v3.0.30mod ::::::::::::::: */

// automatically includes all files ending in .uc.xul and .uc.js from the profile's chrome folder

// New Features:
// supports Greasemonkey-style metadata for userChrome scripts and overlays
// supports a "main" shortcut for the main browser window in include/exclude lines
// supports regexes in the include/exclude lines
// scripts without metadata will run only on the main browser window, for backwards compatibility
//
// 1.Including function of UCJS_loader.
// 2.Compatible with Fx2 and Fx3.0b5pre
// 3.Cached script data (path, leafname, regex)
// 4.Support window.userChrome_js.loadOverlay(overlay [,observer]) //
// Modified by Alice0775
//
// Date 2010/10/10 00:00 Bug 377498 mozIJSSubscriptLoader::loadSubScript charset 入ったけどメタデータ // @charset  UTF-8 としとけばUTF-8で読み込む
// Date 2010/03/31 00:00 XULDocumentのみに適用
// Date 2010/03/11 17:30 debugbuildで動かない場合がある件に対応。
// Date 2010/02/28 13:00 ?が直っているので元に戻した。
// Date 2009/08/06 00:00 tree_style_tab-0.8.2009073102があるとxulのdocument.overlayが出来なくなる件に対応
// Date 2009/05/23 00:00 userChrome.js0.8.1実験中 v3.0.25mod
// Date 2009/04/13 00:00 overlayのobserveの処理変更 v3.0.24mod
// Date 2009/03/10 00:00 例外トラップ
// Date 2009/02/15 15:00 chromehiddenなwindow(popup等)の場合にロードするかどうかを指定できるようにした。
// Date 2008/12/29 06:00 面倒だからdocument.overlayを置き換えるようにした。
// Date 2008/12/27 18:00 Webpanelにchromeを読み込んだときのエラーが出るのを修正(thanks 音吉)
// Date 2008/09/16 00 00 面倒だからFirefox3 の場合はeditBookmarkOverlay.xulは先読みするように修正
// Date 2008/08/28 00 00 なぜか0.8.0+を使っている人がいたので, それに対応
// Date 2008/08/26 23:50 08/26 18:00 以降 Fx2で動かなくなったようなので, 直した
// Date 2008/08/26 22:00 v3.0.11modで動かないなら,これ以降のものも動かないよ。たぶん
// Date 2008/08/26 18:00 Fx3のStarUIをなんとかして欲しいな。
// Date 2008/08/18 04:00 AUTOREMOVEBOM = trueなら文字コード自動判定するようにした。
// Date 2008/08/16 15:00 BOMを自動的に取り除くかどうか指定できるようにした
// Date 2008/07/29 23:00 なんかバグあったかも
// Date 2008/07/25 00:00 USE_0_63_FOLDERおよびFORCESORTSCRIPTがtrueの場合は, フォルダも名順でソートするようにした
// Date 2008/07/14 01:00 typo, regression
// Date 2008/07/14 00:00 typo, regression
// Date 2008/07/13 22:00 サイドバーweb-panelsにchromeウインドウを読み込んだ場合に対応
// Date 2008/03/23 12:00 80氏のフォルダ規則に対応, 0.8modバージョンにも対応
//
(function(){
  // -- config --
  const EXCLUDE_CHROMEHIDDEN = false; //chromehiddenなwindow(popup等)ではロード: しないtrue, する[false]
  const USE_0_63_FOLDER = false; //0.63のフォルダ規則を使うtrue, 使わない[false]
  const FORCESORTSCRIPT = false; //強制的にスクリプトをファイル名順でソートするtrue, しない[false]
  const AUTOREMOVEBOM   = false;  //BOMを自動的に, 取り除く:true, 取り除かない[false](元ファイルは.BOMとして残る)
  const REPLACEDOCUMENTOVERLAY   = true;  //document.overlayを 置き換える[true], 置き換えないfalse
  //=====================USE_0_63_FOLDER = falseの時===================
  var UCJS      = new Array("UCJSFiles","userContent","userMenu"); //UCJS Loader 仕様を適用 (NoScriptでfile:///を許可しておく)
  var arrSubdir = new Array("", "xul","TabMixPlus","withTabMixPlus", "SubScript", "UCJSFiles", "userCrome.js.0.8","userContent","userMenu");    //スクリプトはこの順番で実行される
  //===================================================================
  const ALWAYSEXECUTE   = 'rebuild_userChrome.uc.xul'; //常に実行するスクリプト
  var INFO = true;
  var BROWSERCHROME = "chrome://browser/content/browser.xul";//Seamonkey:chrome://navigator/content/navigator.xul
  // -- config --
/* USE_0_63_FOLDER true の時
 * chrome直下およびchrome/xxx.uc 内の *.uc.js および *.uc.xul
 * chrome/xxx.xul 内の  *.uc.js , *.uc.xul および *.xul
 * chrome/xxx.ucjs 内の *.uc.js は 特別に UCJS Loader 仕様を適用(NoScriptでfile:///を許可しておく)
 */

/* USE_0.63_FOLDER false の時
 *[ フォルダは便宜上複数のフォルダに分けているだけで任意。 下のarrSubdirで指定する ]
 *[ UCJS Loaderを適用するフォルダをUCJSで指定する                                  ]
  プロファイル-+-chrome-+-userChrome.js(このファイル)
                        +-*.uc.jsまたは*.uc.xul群
                        |
                        +-SubScript--------+-*.uc.jsまたは*.uc.xul群
                        |
                        +-UCJSFiles--------+-*.uc.jsまたは*.uc.xul群
                        | (UCJS_loaderでしか動かないもの JavaScript Version 1.7/日本語)
                        |
                        +-xul--------------+-*.xul, *.uc.xulおよび付随File
                        |
                        +-userCrome.js.0.8-+-*.uc.jsまたは*.uc.xul群 (綴りが変なのはなぜかって? )
 */


  //chromeでないならスキップ
  if(!/^chrome:/i.test(location.href)) return;
  //コモンダイアログに対するオーバーレイが今のところ無いので時間短縮のためスキップすることにした
  if(location.href =='chrome://global/content/commonDialog.xul') return;
  if(/.html?$/i.test(location.href)) return;
  window.userChrome_js = {
    USE_0_63_FOLDER: USE_0_63_FOLDER,
    UCJS: UCJS,
    arrSubdir: arrSubdir,
    FORCESORTSCRIPT: FORCESORTSCRIPT,
    ALWAYSEXECUTE: ALWAYSEXECUTE,
    AUTOREMOVEBOM: AUTOREMOVEBOM,
    REPLACEDOCUMENTOVERLAY: REPLACEDOCUMENTOVERLAY,
    INFO: INFO,
    BROWSERCHROME: BROWSERCHROME,
    EXCLUDE_CHROMEHIDDEN: EXCLUDE_CHROMEHIDDEN,

    //スクリプトデータを作成
    getScripts: function(){
      const Cc = Components.classes;
      const Ci = Components.interfaces;
      const ios = Cc["@mozilla.org/network/io-service;1"].getService(Ci.nsIIOService);
      const fph = ios.getProtocolHandler("file").QueryInterface(Ci.nsIFileProtocolHandler);
      const ds = Cc["@mozilla.org/file/directory_service;1"].getService(Ci.nsIProperties);
var Start = new Date().getTime();
      //getdir
      if (this.USE_0_63_FOLDER) {
        var o = [""];
        this.UCJS =[];
        this.arrSubdir =[];
        var workDir = ds.get("UChrm", Ci.nsIFile);
        var dir = workDir.directoryEntries;
        while(dir.hasMoreElements()){
          var file = dir.getNext().QueryInterface(Ci.nsIFile);
          if( !file.isDirectory()) continue;
          var dirName = file.leafName;
          if(/(uc|xul|ucjs)$/i.test(dirName)){
            o.push(dirName);
            if(/ucjs$/i.test(dirName)){
              this.UCJS.push(dirName);
            }
          }
        }
        if(this.FORCESORTSCRIPT){
          o.sort(cmp_name);
        }
        [].push.apply(this.arrSubdir, o);
      }

      var that = this;
      var mediator = Components.classes["@mozilla.org/appshell/window-mediator;1"]
                     .getService(Components.interfaces.nsIWindowMediator);
      if(mediator.getMostRecentWindow("navigator:browser"))
        var mainWindowURL = that.BROWSERCHROME;
      else if (mediator.getMostRecentWindow("mail:3pane"))
        var mainWindowURL = "chrome://messenger/content/messenger.xul";

      this.dirDisable = restoreState(getPref("userChrome.disable.directory", "str", "").split(','));
      this.scriptDisable = restoreState(getPref("userChrome.disable.script", "str", "").split(','));
      this.scripts = [];
      this.overlays = [];

      var findNextRe = /^\/\/ @(include|exclude)[ \t]+(\S+)/gm;
      this.directory = {name:[], UCJS:[], enable:[]};
      for(var i=0, len=this.arrSubdir.length; i<len; i++){
        var s = [], o = [];
        try{
          var dir = this.arrSubdir[i]=="" ? "root" : this.arrSubdir[i];
          this.directory.name.push(dir);
          this.directory.UCJS.push(checkUCJS(dir));

          var workDir = ds.get("UChrm", Ci.nsIFile);
          workDir.append(this.arrSubdir[i]);
          var files = workDir.directoryEntries.QueryInterface(Ci.nsISimpleEnumerator);
          var istream = Cc["@mozilla.org/network/file-input-stream;1"].createInstance(Ci.nsIFileInputStream);
          while(files.hasMoreElements()){
            var file = files.getNext().QueryInterface(Ci.nsIFile);
            if(/\.uc\.js$|\.uc\.xul$/i.test(file.leafName)
               || /\.xul$/i.test(file.leafName) && /\xul$/i.test(this.arrSubdir[i])) {
              var script = getScriptData(
                              this.AUTOREMOVEBOM ? deleteBOMreadFile(file) : readFile(file, true)
                              ,file);
              script.dir = dir;
              if(/\.uc\.js$/i.test(script.filename)){
                script.url = convURL(script.url);
                script.ucjs = checkUCJS(script.file.path);
                s.push(script);
              }else{
                script.xul = '<?xul-overlay href=\"'+ script.url +'\"?>\n';
                o.push(script);
              }
            }
          }
        }catch(e){}
        if(this.FORCESORTSCRIPT){
          s.sort(cmp_fname);
          o.sort(cmp_fname);
        }
        [].push.apply(this.scripts, s);
        [].push.apply(this.overlays, o);
      }
this.debug('Parsing getScripts: '+((new Date()).getTime()-Start) +'msec');

      //拡張のバージョン違いを吸収
      function convURL(url){
//window.userChrome_js.debug( Error().fileName);
        if (!/^(chrome:\/\/\S+\/content\/)\S+/i.test( Error().fileName) ){ //0.8
//window.userChrome_js.debug("userChrome.js version0.8");
          return url;
        } else if (Error().fileName.indexOf("chrome://uc_js/content/uc_js.xul") > -1 ||
             "chrome://userchrome_js_cache/content/userChrome.js" == Error().fileName ){  //0.8.0+ or 0.7
//window.userChrome_js.debug("userChrome.js version 0.8.0+ or 0.7");
          return url;
        } else if (Error().fileName.indexOf("chrome://browser/content/browser.xul -> ") == 0) {  //0.8.1
//window.userChrome_js.debug("userChrome.js version 0.8.1");
          return url;
        } else { //0.8mod
//window.userChrome_js.debug("userChrome.js version 0.8mod");
          return RegExp.$1 + url.substr(url.indexOf("chrome") + 7);
        }
      }

      //nameを比較する関数
      function cmp_name(a, b) {
        if(a.toLowerCase()==b.toLowerCase())
          return  a < b?-1:1;
        else
          return  a.toLowerCase() < b.toLowerCase()?-1:1;
      }
      function cmp_fname(a, b) {
        return cmp_name(a.filename, b.filename);
      }

      //UCJSローダ必要か
      function checkUCJS(aPath){
        for(var i=0,len=that.UCJS.length; i<len; i++){
          if( aPath.indexOf(that.UCJS[i], 0)>-1 )
            return true;
        }
        return false;
      }

      //メタデータ収集
      function getScriptData(aContent,aFile){
        var charset, description;
        var header = (aContent.match(/^\/\/ ==UserScript==[ \t]*\n(?:.*\n)*?\/\/ ==\/UserScript==[ \t]*\n/m) || [""])[0];
        var match, rex = { include: [], exclude: []};
        while ((match = findNextRe.exec(header)))
        {
          rex[match[1]].push(match[2].replace(/^main$/i,mainWindowURL).replace(/\W/g, "\\$&").replace(/\\\*/g, ".*?"));
        }
        if( rex.include.length == 0) rex.include.push(mainWindowURL);
        var exclude = rex.exclude.length > 0 ? "(?!" + rex.exclude.join("$|") + "$)" : "";

        match = header.match(/\/\/ @charset\b(.+)\s*/i);
        charset = "";
        //try
        if(match)
          charset = match.length > 0 ? match[1].replace(/^\s+/,"") : "";

        match = header.match(/\/\/ @description\b(.+)\s*/i);
        description = "";
        //try
        if(match)
          description = match.length > 0 ? match[1].replace(/^\s+/,"") : "";
        //}catch(e){}
        if (description =="" || !description)
          description = aFile.leafName;
        var url = fph.getURLSpecFromFile(aFile);

        return {
          filename: aFile.leafName,
          file: aFile,
          url: url,
          //namespace: "",
          charset: charset,
          description: description,
          //code: aContent.replace(header, ""),
          regex: new RegExp("^" + exclude + "(" + (rex.include.join("|") || ".*") + ")$", "i")
        }
      }

      //スクリプトファイル読み込み
      function readFile(aFile, metaOnly){
        if (typeof metaOnly == 'undefined')
          metaOnly = false;
        var stream = Cc["@mozilla.org/network/file-input-stream;1"].createInstance(Ci.nsIFileInputStream);
        stream.init(aFile, 0x01, 0, 0);
        var cvstream = Cc["@mozilla.org/intl/converter-input-stream;1"].
                                  createInstance(Ci.nsIConverterInputStream);
        cvstream.init(stream, "UTF-8", 1024, Ci.nsIConverterInputStream.DEFAULT_REPLACEMENT_CHARACTER);
        var content = "", data = {};
        while (cvstream.readString(4096, data)) {
          content += data.value;
          if (metaOnly &&
              content.indexOf('// ==/UserScript==') > 0)
            break;
        }
        cvstream.close();
        return content.replace(/\r\n?/g, "\n");
      }

      //スクリプトファイル文字コード変換読み込み
      function deleteBOMreadFile(aFile){
        var UI = Components.classes["@mozilla.org/intl/scriptableunicodeconverter"].
                      createInstance(Components.interfaces.nsIScriptableUnicodeConverter);
        UI.charset = "UTF-8";
        var bytes = readBinary(aFile);
        try {
          if (bytes.length > 3 && bytes.substring(0,3) == String.fromCharCode(239,187,191)){
            aFile.copyTo(null, aFile.leafName + ".BOM");
            bytes = bytes.substring(3,bytes.length);
            writeFile(aFile, bytes);
            return UI.ConvertToUnicode(bytes).replace(/\r\n?/g, "\n");
          }
          var charset = getCharset(bytes);
          //window.userChrome_js.debug(aFile.leafName + " " +charset);
          if (charset == "UTF-8" || charset == "us-ascii"){
            return UI.ConvertToUnicode(bytes).replace(/\r\n?/g, "\n");
          } else {
            UI.charset = charset;
            aFile.copyTo(null, aFile.leafName + "."+UI.charset);
            bytes = UI.ConvertToUnicode(bytes);
            UI.charset = "UTF-8";
            writeFile(aFile, UI.ConvertFromUnicode(bytes));
            return bytes.replace(/\r\n?/g, "\n");
          }
        } catch(ex){
          return readFile(aFile);
        }
      }

      //バイナリ読み込み
      function readBinary(aFile){
        var istream = Components.classes["@mozilla.org/network/file-input-stream;1"]
                                .createInstance(Components.interfaces.nsIFileInputStream);
        istream.init(aFile, -1, -1, false);

        var bstream = Components.classes["@mozilla.org/binaryinputstream;1"]
                                .createInstance(Components.interfaces.nsIBinaryInputStream);
        bstream.setInputStream(istream);
        return bstream.readBytes(bstream.available());
      }

      //バイナリ書き込み
      function writeFile(aFile, aData){
        var foStream = Components.classes["@mozilla.org/network/file-output-stream;1"]
                                 .createInstance(Components.interfaces.nsIFileOutputStream);
        // ファイル追記の際は、0x02 | 0x10 を使う
        foStream.init(aFile, 0x02 | 0x08 | 0x20, parseInt(664, 8), 0); // write, create, truncate
        foStream.write(aData, aData.length);
        foStream.close();
        return aData;
      }

      //文字コードを得る
      function getCharset(str){
        function charCode(str){
          if (/\x1B\x24(?:[\x40\x42]|\x28\x44)/.test(str))
            return 'ISO-2022-JP';
          if (/[\x80-\xFE]/.test(str)){
              var buf = RegExp.lastMatch + RegExp.rightContext;
              if (/[\xC2-\xFD][^\x80-\xBF]|[\xC2-\xDF][\x80-\xBF][^\x00-\x7F\xC2-\xFD]|[\xE0-\xEF][\x80-\xBF][\x80-\xBF][^\x00-\x7F\xC2-\xFD]/.test(buf))
                return (/[\x80-\xA0]/.test(buf)) ? 'Shift_JIS' : 'EUC-JP';
              if (/^(?:[\x00-\x7F\xA1-\xDF]|[\x81-\x9F\xE0-\xFC][\x40-\x7E\x80-\xFC])+$/.test(buf))
                return 'Shift_JIS';
              if (/[\x80-\xA0]/.test(buf))
                return 'UTF-8';
              return 'EUC-JP';
          } else
            return 'us-ascii';
        }

        var charset = charCode(str);
        if (charset == "UTF-8" || charset == "us-ascii")
          return charset;

        //判定に失敗している場合があるので, 再チェック (鈍くさ);
        var UI = Components.classes["@mozilla.org/intl/scriptableunicodeconverter"].
                        createInstance(Components.interfaces.nsIScriptableUnicodeConverter);
        try {
          UI.charset = "UTF-8";
          if (str === UI.ConvertFromUnicode(UI.ConvertToUnicode(str)))
            return "UTF-8";
        } catch(ex){}
        try {
          UI.charset = charset;
          if (str === UI.ConvertFromUnicode(UI.ConvertToUnicode(str)))
            return charset;
        } catch(ex){}
        return "UTF-8";
      }

      //prefを読み込み
      function getPref(aPrefString, aPrefType, aDefault){
        var xpPref = Components.classes['@mozilla.org/preferences-service;1']
                      .getService(Components.interfaces.nsIPrefService);
        try{
          switch (aPrefType){
            case 'complex':
              return xpPref.getComplexValue(aPrefString, Components.interfaces.nsILocalFile); break;
            case 'str':
              return unescape(xpPref.getCharPref(aPrefString).toString()); break;
            case 'int':
              return xpPref.getIntPref(aPrefString); break;
            case 'bool':
            default:
              return xpPref.getBoolPref(aPrefString); break;
          }
        }catch(e){
        }
        return aDefault;
      }

      //pref文字列変換
      function restoreState(a){
        try{
            var sd = [];
            for(var i = 0,max = a.length;i < max;++i) sd[unescape(a[i])] = true;
            return sd;
        }
        catch(e){ return []; }
      }
    },

    //window.userChrome_js.loadOverlay
    overlayWait:0,
    overlayUrl:[],
    loadOverlay: function(url, observer, doc){
       window.userChrome_js.overlayUrl.push([url, observer, doc]);
       if(!window.userChrome_js.overlayWait) window.userChrome_js.load(++window.userChrome_js.overlayWait);

    },

    load: function (){
        if(!window.userChrome_js.overlayUrl.length) return --window.userChrome_js.overlayWait;
        var [url, aObserver, doc] = this.overlayUrl.shift();
        if (!doc) doc = document;
        if (!(doc instanceof XULDocument))
          return 0;
        var observer = {
          observe:function (subject, topic, data) {
            if (topic == 'xul-overlay-merged') {
              if (!!aObserver) {
                try {
                  aObserver.observe(subject, topic, data);
                } catch(ex){
                  window.userChrome_js.error(url, ex);
                }
              }
              if ('userChrome_js' in window)
               window.userChrome_js.load();
            }
          },
          QueryInterface: function(aIID){
            if(!aIID.equals(Components.interfaces.nsISupports)
               && !aIID.equals(Components.interfaces.nsIObserver))
              throw Components.results.NS_ERROR_NO_INTERFACE;
            return this
          }
        };
        try{
          var original_loadOverlay = Components.lookupMethod(doc, 'loadOverlay');
        } catch(ex){
          window.userChrome_js.error(url, ex);
        }
        //if (this.INFO) this.debug("document.loadOverlay: " + url);
        try{
          if ( typeof original_loadOverlay == "function")
            original_loadOverlay(url, observer);
        } catch(ex){
          window.userChrome_js.error(url, ex);
        }
        return 0;
    },

    //xulを読み込む
    runOverlays: function(doc){
      try {
        var dochref = doc.location.href;
      } catch (e) {
        return;
      }

      var overlay;

      if( true ){ //懼�� uc.jsでのloadOverlayに対応
        for(var m=0,len=this.overlays.length; m<len; m++){
          overlay = this.overlays[m];
          if( overlay.filename != this.ALWAYSEXECUTE
            && ( !!this.dirDisable['*']
                 || !!this.dirDisable[overlay.dir]
                 || !!this.scriptDisable[overlay.filename]) ) continue;

          // decide whether to run the script
          if(overlay.regex.test(dochref)){
            if (this.INFO) this.debug("loadOverlay: " + overlay.filename);
            this.loadOverlay(overlay.url, null, doc);
          }
        }
      }else{
        var XUL = '<?xml version="1.0"?>\n';
        var count =0;
        for(var m=0,len=this.overlays.length; m<len; m++){
          overlay = this.overlays[m];
          if( overlay.filename != this.ALWAYSEXECUTE
            && ( !!this.dirDisable['*']
                 || !!this.dirDisable[overlay.dir]
                 || !!this.scriptDisable[overlay.filename]) ) continue;
          // decide whether to run the script
          if(overlay.regex.test(dochref)){
            XUL += overlay.xul;
            count++;
          }
        }
        if(count==0) return;
        XUL += '<overlay id="userChrome.uc.js-overlay" xmlns="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul" xmlns:html="http://www.w3.org/1999/xhtml">\n</overlay>\n';
        try{
            if (this.INFO) this.debug("loadOverlay: " + XUL);
            doc.loadOverlay("data:application/vnd.mozilla.xul+xml;charset=utf-8," + XUL,null);
        }catch(ex){
            this.error(XUL, ex);
        }
      }
    },

    //uc.jsを読み込む
    runScripts: function(doc){
      try {
        var dochref = doc.location.href;
      } catch (e) {
        return;
      }
      if (!(doc instanceof XULDocument))
          return;
      if(!!this.dirDisable['*']) return;

      var script, aScript, url;
      const Cc = Components.classes;
      const Ci = Components.interfaces;
      const maxJSVersion = (function getMaxJSVersion() {
        var appInfo = Components
            .classes["@mozilla.org/xre/app-info;1"]
            .getService(Components.interfaces.nsIXULAppInfo);
        var versionChecker = Components
            .classes["@mozilla.org/xpcom/version-comparator;1"]
            .getService(Components.interfaces.nsIVersionComparator);

        // Firefox 3.5 and higher supports 1.8.
        if (versionChecker.compare(appInfo.version, "3.5") >= 0) {
          return "1.8";
        }
        // Firefox 2.0 and higher supports 1.7.
        if (versionChecker.compare(appInfo.version, "2.0") >= 0) {
          return "1.7";
        }

        // Everything else supports 1.6.
        return "1.6";
      })();

      for(var m=0,len=this.scripts.length; m<len; m++){
        script = this.scripts[m];
      if(!!this.dirDisable[script.dir]) continue;
      if(!!this.scriptDisable[script.filename]) continue;
      if( !script.regex.test(dochref)) continue;
        if( script.ucjs ){ //for UCJS_loader
            if (this.INFO) this.debug("loadUCJSSubScript: " + script.filename);
            aScript = doc.createElementNS("http://www.w3.org/1999/xhtml", "script");
            aScript.type = "application/javascript; version=" + maxJSVersion.toString().substr(0,3);
            aScript.src = script.url;
            try {
              doc.documentElement.appendChild(aScript);
            }catch(ex) {
              this.error(script.filename, ex);
            }
        }else{ //Not for UCJS_loader
          if (this.INFO) this.debug("loadSubScript: " + script.filename);
          try {
            if (script.charset)
              Cc["@mozilla.org/moz/jssubscript-loader;1"].getService(Ci.mozIJSSubScriptLoader)
                       .loadSubScript(script.url, doc.defaultView, script.charset);
            else
              Cc["@mozilla.org/moz/jssubscript-loader;1"].getService(Ci.mozIJSSubScriptLoader)
                       .loadSubScript(script.url, doc.defaultView);
          }catch(ex) {
            this.error(script.filename, ex);
          }
        }
      }
    },

    /**
      * 指定したバージョン文字列と現在の Gecko のバージョンを比較する
      * @param {String} aVersion バージョン文字列(e.g. "1.8" "1.7.5")
      * @return {Number}
      * 実際のバージョンより指定したバージョンの方が新しければ 1、同じなら 0、古ければ -1
      * @see nsIVersionComparator
      * 例Gecko 1.9.0の環境で geckoVersionCompare("1.9.1") とすれば1
      * 例Gecko 1.9.0の環境で geckoVersionCompare("1.8.5") とすれば-11が返される
    */
    geckoVersionCompare: function ChaikaBrowser_geckoVersionCompare(aVersion){
      var versionComparator = Cc["@mozilla.org/xpcom/version-comparator;1"]
          .getService(Ci.nsIVersionComparator);
      var appInfo = Cc["@mozilla.org/xre/app-info;1"].getService(Ci.nsIXULAppInfo);
      return versionComparator.compare(aVersion, appInfo.platformVersion);
    },

    //Fxのバージョンを 数値で返す 3.0 3.5 とか 3.6とか
    getVer: function(){
      var info = Components.classes["@mozilla.org/xre/app-info;1"]
                 .getService(Components.interfaces.nsIXULAppInfo);
      var ver = parseInt(info.version.substr(0,3) * 10,10) / 10;
      return ver;
    },

    debug: function(aMsg){
      Components.classes["@mozilla.org/consoleservice;1"]
        .getService(Components.interfaces.nsIConsoleService)
        .logStringMessage(aMsg);
    },

    error: function(aMsg,err){
      const CONSOLE_SERVICE    = Components.classes['@mozilla.org/consoleservice;1']
                                 .getService(Components.interfaces.nsIConsoleService);
      var error = Components.classes['@mozilla.org/scripterror;1']
                  .createInstance(Components.interfaces.nsIScriptError);
      if(typeof(err) == 'object') error.init(aMsg + '\n' + err.name + ' : ' + err.message,err.fileName || null,null,err.lineNumber,null,2,err.name);
      else error.init(aMsg + '\n' + err + '\n',null,null,null,null,2,null);
      CONSOLE_SERVICE.logMessage(error);
    }
  };

  //少しでも速くするためスクリプトデータの再利用
  var prefObj = Components.classes["@mozilla.org/preferences-service;1"]
                .getService(Components.interfaces.nsIPrefService);
  try{
    var pref = prefObj.getBoolPref("userChrome.enable.reuse");
  }catch(e){
    var pref = true;
  }


  var that = window.userChrome_js;
  window.xxdebug = that.debug;
  //that.debug(typeof that.getScriptsDone);
  if(pref){
    //現在のメインウィンドウは一度もuserChrome.jsのスクリプトで初期化されていない?
    if(!that.getScriptsDone){
      //Firefox or Thunderbard?
      var mediator = Components.classes["@mozilla.org/appshell/window-mediator;1"]
                     .getService(Components.interfaces.nsIWindowMediator);
      if(mediator.getMostRecentWindow("navigator:browser"))
        var windowType = "navigator:browser";
      else if (mediator.getMostRecentWindow("mail:3pane"))
        var windowType = "mail:3pane";
      var enumerator = mediator.getEnumerator(windowType);
      //他の身内のメインウィンドウではどうかな?
      while(enumerator.hasMoreElements()) {
        var win = enumerator.getNext();
        //身内のメインウインドウは初期状態でない?
        if(win.userChrome_js && win.userChrome_js.getScriptsDone){
          //オブジェクトはたぶんこのウインドウのを複製すりゃいいんじゃぁないかな
          that.UCJS = win.userChrome_js.UCJS;
          that.arrSubdir = win.userChrome_js.arrSubdir;
          that.scripts = win.userChrome_js.scripts;
          that.overlays = win.userChrome_js.overlays;
          that.dirDisable = win.userChrome_js.dirDisable;
          that.scriptDisable = win.userChrome_js.scriptDisable;
          that.getScriptsDone = true;
          break;
        }
      }
    }
  }

  if(!that.getScriptsDone){
    if (that.INFO) that.debug("getScripts");
    that.getScripts();
    that.getScriptsDone= true;
  }else{
    if (that.INFO) that.debug("skip getScripts");
  }

  var href = location.href;
  var doc = document;

  //Bug 330458 Cannot dynamically load an overlay using document.loadOverlay
  //until a previous overlay is completely loaded
  if (that.REPLACEDOCUMENTOVERLAY)
    doc.loadOverlay = that.loadOverlay;

  if (that.INFO) that.debug("load " + href);

  //chromehiddenならロードしない
  if (location.href === that.BROWSERCHROME &&
      that.EXCLUDE_CHROMEHIDDEN &&
      document.documentElement.getAttribute("chromehidden") !="" )
    return;

  if( that.getVer()<3 ){
    setTimeout(function(doc){that.runScripts(doc);
      setTimeout(function(doc){that.runOverlays(doc);},0, doc);
    },0, doc);
  }else{
    setTimeout(function(doc){
      that.runScripts(doc);
      //面倒だからFirefox 3 の場合はeditBookmarkOverlay.xulを先読みしておく
      var delay = 500;
      if (location.href === that.BROWSERCHROME &&
       /*  !('TreeStyleTabService' in window) && */
          typeof StarUI != 'undefined' &&
          !(StarUI._overlayLoading || StarUI._overlayLoaded)) {
        that.loadOverlay("chrome://browser/content/places/editBookmarkOverlay.xul", null, doc);
        StarUI._overlayLoaded = true;
        delay = 0;
      }
      setTimeout(function(doc){that.runOverlays(doc);}, delay, doc);
    },500, doc);
  }
  //Sidebar for Trunc
  if(location.href != that.BROWSERCHROME) return;
  if(that.getVer()>2 ){
    window.document.addEventListener("load",
      function(event){
        if (!event.originalTarget.location) return;
        if( !/^chrome:/.test(event.originalTarget.location.href) )return;
        var doc = event.originalTarget;
        var href = doc.location.href;
        if (that.INFO) that.debug("load Sidebar " +  href);
        setTimeout(function(doc){that.runScripts(doc);
          setTimeout(function(doc){that.runOverlays(doc);}, 0, doc);
        },0, doc);
        if (href != "chrome://browser/content/web-panels.xul") return;
        if (!window.document.getElementById("sidebar")) return;
        var sidebarWindow = window.document.getElementById("sidebar").contentWindow;
          if (sidebarWindow){
            loadInWebpanel.init(sidebarWindow);
          }
      }
    , true);
  }
  var loadInWebpanel = {
    sidebarWindow: null,
    init: function(sidebarWindow){
      this.sidebarWindow = sidebarWindow;
      this.sidebarWindow.document.getElementById("web-panels-browser").addEventListener("load", this, true);
      this.sidebarWindow.addEventListener("unload", this, false);
    },
    handleEvent: function(event){
      switch (event.type) {
        case "unload":
          this.uninit(event);
          break;
        case "load":
          this.load(event);
          break;
      }
    },
    uninit: function(event){
      this.sidebarWindow.document.getElementById("web-panels-browser").removeEventListener("load", this, true);
      this.sidebarWindow.removeEventListener("unload", this, false);
    },
    load: function(event){
      var doc = event.originalTarget;
      var href = doc.location.href;
        if( !/^chrome:/.test(href) )return;
        if (that.INFO) that.debug("load Webpanel " +  href);
        setTimeout(function(doc){that.runScripts(doc);
          setTimeout(function(doc){that.runOverlays(doc);},0, doc);
        },0, doc);
    }
  }
})();