function setupWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
    if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'https://__bridge_loaded__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
}

if (typeof(NMOJSBridge) == "undefined") {
    var NMOJSBridge = {};
    setupWebViewJavascriptBridge(function(bridge) {
        NMOJSBridge.Common = {
        	'onBridgeReady': function() {
                bridge.callHandler('NMOJSBridge.Common.OnBridgeReady');
            },
            'closeWindow': function() {
                bridge.callHandler('NMOJSBridge.Common.closeWindow');
            },

        	'onUserLogin': function(res) {
                bridge.callHandler('NMOJSBridge.Common.onUserLogin', res);
            },
                                 
            'onVerify': function(res) {
                bridge.callHandler('NMOJSBridge.Common.onVerify', res);
            },

            'onError': function(res) {
                bridge.callHandler('NMOJSBridge.Common.onError', res);
            },

            'alert': function(res) {
                bridge.callHandler('NMOJSBridge.Common.alert', res);
            },

            'toast': function(res) {
                bridge.callHandler('NMOJSBridge.Common.toast', res);
            },

    		'saveToClipboard': function(content, callback) {
        		bridge.callHandler('NMOJSBridge.Common.saveToClipboard', content, callback);
    		},
                                 
            'saveImage': function(url, callback) {
                bridge.callHandler('NMOJSBridge.Common.saveImage', url, callback);
            },
            
            'screenshot': function(callback) {
                bridge.callHandler('NMOJSBridge.Common.screenshot', callback);
            },

    		'getConfig': function(params) {
        		bridge.callHandler('NMOJSBridge.Common.getConfig', null, function(response) {
            		params.success(response);
        	})},

        	'getSDKToken': function(params) {
        		bridge.callHandler('NMOJSBridge.Common.getSDKToken', null, function(response) {
            		params.success(response);
        	})},
                                 
            'saveMigrateCode': function(code, callback) {
                bridge.callHandler('NMOJSBridge.Common.saveMigrateCode', code, callback);
            },
            'onConsoleLog': function(log) {
                bridge.callHandler('NMOJSBridge.Common.onConsoleLog', log);
            },
            'onPNLogin': function(json) {
                bridge.callHandler('NMOJSBridge.Common.onPNLogin', json);
            },
            'onSetSpwd': function(res) {
                bridge.callHandler('NMOJSBridge.Common.onSetSpwd', res);
            },
            'postMsgToNative': function(res) {
                bridge.callHandler('NMOJSBridge.Common.postMsgToNative', res);
            },
            'openLinkInNativeBrowser': function(url) {
                bridge.callHandler('NMOJSBridge.Common.openLinkInNativeBrowser', url);
            },
        }
        // 发送事件
        var evt = document.createEvent("Events");
        evt.initEvent("NMOJSBridgeReady", true, true);
        document.dispatchEvent(evt);
    });
}
