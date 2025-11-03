// ----------
var strToRedirectOldBrowsersTo;
function BrowserObj(){
	this.intV=new Number(parseInt(navigator.appVersion),10);
	this.strBrowser=navigator.appName;
	this.strAgent=navigator.userAgent;
	this.bWin=this.strAgent.search(/Windows/i)!=-1;
	this.bMac=this.strAgent.search(/Mac/i)!=-1;
	this.bLinux=this.strAgent.search(/Linux/i)!=-1;
	this.intWidth=new Number(screen.width);
	this.intHeight=new Number(screen.height);
	//if(this.intV<4) return location.href=(typeof strToRedirectOldBrowsersTo != "undefined")? strToRedirectOldBrowsersTo : "http://webstandards.org/upgrade";
	this.opera=this.strAgent.search(/Opera/i)!=-1;
	this.opera5=(this.opera&&this.strAgent.search(/Opera(\s|\/)5/i)!=-1);
	this.opera6=(this.opera&&this.strAgent.search(/Opera(\s|\/)6/i)!=-1);
	this.opera70=(this.opera&&this.strAgent.search(/Opera(\s|\/)7.0\s/i)!=-1);
	this.opera7=(this.opera&&!this.opera70&&this.strAgent.search(/Opera(\s|\/)7/i)!=-1);
	this.gecko=(!this.opera&&this.strAgent.search(/Gecko/i)!=-1&&this.strAgent.search(/Netscape/i)==-1&&this.strAgent.search(/Safari/i)==-1);
	this.konqueror=(!this.opera&&!this.gecko&&this.strAgent.search(/konqueror/i)!=-1);
	this.safari=(this.strAgent.search(/safari/i)!=-1);
	this.ns=(!this.opera&&!this.gecko&&this.strBrowser.search(/Netscape/i)!=-1&&!this.safari);
	this.ns4=(this.ns&&this.intV==4);
	this.ns60=(this.ns&&this.strAgent.search(/Netscape6\/6.0/i)!=-1);
	this.ns6=(this.ns&&this.strAgent.search(/Netscape6/i)!=-1);
	this.ns7=(this.ns&&this.strAgent.search(/Netscape\/7/i)!=-1);	
	this.ie=(!this.opera&&this.strAgent.search(/MSIE/i)!=-1);
	this.ie4=(this.ie&&this.strAgent.search(/MSIE 4/i)!=-1);
	this.ie5=(this.ie&&(this.strAgent.search(/MSIE 5.0/i)!=-1||(this.bMac&&this.strAgent.search(/MSIE 5/i)!=-1)));
	this.ie51=(this.ie&&this.strAgent.search(/MSIE 5.1/i)!=-1);
	this.ie52=(this.ie&&this.strAgent.search(/MSIE 5.2/i)!=-1);
	this.ie55=(this.ie&&this.strAgent.search(/MSIE 5.5/i)!=-1);
	this.ie6=(this.ie&&this.strAgent.search(/MSIE 6/i)!=-1);
	this.intV=new Number(parseFloat((this.ns7||this.opera70||this.opera7)?7:(this.ie6||this.ns6||this.opera6)?6:(this.ie55)?5.5:(this.ie52)?5.2:(this.ie51)?5.1:(this.ie5||this.opera5)?5:this.intV), 10);
	this.strColl=new String((this.ie)?"all.":"");
	this.strLayerColl=new String((this.ie)?"all.":(this.ns4)?"layers.":"");
	this.strCSS=new String((this.ns4)?"":".style");
}
var is=new BrowserObj();
/*for(var i in is)
	document.write(i + " = " + is[i] + "<br>");*/
if(is.ie4){
	document.getElementById=function (strID){
		return document.all[strID];
	}
}
// ----------
document.getElementsByClassName = function (strClassName){
	var arrAllElms = document.getElementsByTagName("*");
	var arrElmsWithClassName = new Array();
	for(var i=0; i<arrAllElms.length; i++){
		if(arrAllElms[i].className == strClassName){
			arrElmsWithClassName.push(arrAllElms[i]);
		}
	}
	return arrElmsWithClassName;
}
// ----------
function checkAvailScreen(bWithScrollArea){
	var bWithScrollArea=(typeof bWithScrollArea!="undefined")?bWithScrollArea:false;
	var intScrollLeft=(bWithScrollArea)?(is.ns)? window.pageXOffset : document.body.scrollLeft:0;
	var intScrollTop=(bWithScrollArea)?(is.ns)? window.pageYOffset : document.body.scrollTop:0;
	return [new Number(((is.ns)?window.innerWidth:document.body.clientWidth)+intScrollLeft),new Number(((is.ns)?window.innerHeight:document.body.clientHeight)+intScrollTop)];
}
// ----------
function getElm(strID,strLayerRef){
	var oReturnObj;
	if(is.ns4||is.ie4){
		oReturnObj=eval(((typeof strLayerRef!="undefined")?strLayerRef:"")+"document."+is.strLayerColl+strID);
	}
	else{
		oReturnObj=document.getElementById(strID);
	}
	return oReturnObj;
}
// ----------
function getCSSObj(strID,strLayerRef){
	var oReturnObj;
	if(is.ns4||is.ie4){
		oReturnObj=eval(((typeof strLayerRef!="undefined")?strLayerRef:"")+"document."+is.strLayerColl+strID+is.strCSS);
	}
	else{
		oReturnObj=document.getElementById(strID).style;
	}
	return oReturnObj;
}
// ----------
function redirectToBrowserInfo(strURLToRedirectTo){	
	var bRedirect = false;	
	if(!is.gecko && !is.ns && !is.ie && !is.safari){
		if((is.opera && is.intV > 7) || is.opera7){
			var bShowConfimMessage = (getCookie('disableBrowserCheck') != "1") ? true : false;
			if(bShowConfimMessage){
				if(!confirm("Vi ser att Du använder Opera. Vi kan inte garantera\natt denna webbplats fungerar i din webbläsare.\n\nVill du fortsätta till webbplatsen?")){
					bRedirect = true;
				}else{
					setCookie('disableBrowserCheck','1'); //We set an session cookie so the user dont have to confim on every page
				}
			}
		}
		else{
			bRedirect = true;
		}	
	}
	else{
		if(is.intV < 5 || is.ns60){
			bRedirect = true;
		}
	}
	if(bRedirect){
		location.href = strURLToRedirectTo;
	}
}
// ----------