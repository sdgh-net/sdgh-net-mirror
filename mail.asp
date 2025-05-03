<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<TITLE>��ӭʹ����ҵ�����ʾ�</TITLE>
<!--File: LOGIN.HTML-->
<META content="MSHTML 6.00.2800.1226" name=GENERATOR></HEAD>
<script language="JavaScript"> 
	  var current = "��¼";
  var help     = "��õ�ǰ��Ϣ�İ���: " + current;
  var headerMessage = "";
// Refresh screen to virtual IP-less domain based on URL
if (document.referrer.indexOf("login.")==-1 && 
    document.referrer.indexOf("logoff.")==-1){
  var myURL = document.URL;
    var myDomain = self.location.hostname;
    var currentDomain = "sdgh.net";
    if (myDomain.indexOf(currentDomain)==-1 &&
		    myURL.indexOf("/login.")==-1){
    // Submit a bogus login attempt to pull up the correct template
    document.write('</head><body><form name="domainSwitchForm" action="login.cgi?_" method="POST">');
    document.write('<input type=hidden name="page" value="login">');
    document.write('<input type=hidden name="userid" value="@'+myDomain+'">');
    document.write('<input type=hidden name="passwd" value=" ">');
		document.write('</form></body></html>');
		document.close();
    document.domainSwitchForm.submit();
  }
}

var attemptedImageReload=false
function imageLoadError(myImage){
	if(attemptedImageReload==false){
		if ((navigator.appVersion.indexOf("MSIE") > 0)
			&& (parseInt(navigator.appVersion) >= 4)) {
			// IE 4 or higher on PCs and Macs can do the image swap in the case of a missing img
	  	myImage.src="logo.gif";
		}else{
			// use a clearpixel gif for Netscape, since it doesn't resize properly
			myImage.src="clearpixel.gif";
		}
		attemptedImageReload=true
	}
	return false;
}

function smartLogin(){
  if (document.logon.userid.value == ""){
    alert(X.NeedUID);
    document.logon.userid.focus();
    return false;
  }
  if (document.logon.passwd.value == ""){
    alert(X.NeedPass);
    document.logon.passwd.focus();
    return false;
   } 
  // Check whether a domain was entered along with the userid.
  // If not, concatenate the userid and current domain.
  if (document.logon.userid.value.indexOf("@")==-1){
    var fullUserid = document.logon.userid.value + "@sdgh.eu.org";
    document.logon.userid.value = fullUserid;
  } 
	// set session-only pw and username cookies for calendar server autologin - new in v7
	Set_Cookie('myICalUserName',document.logon.userid.value,null,null,"/");
	Set_Cookie('myICalPassword',document.logon.passwd.value,null,null,"/");
	if(document.logon.Use_Cookie.checked==true){
		Set_Cookie('IMail_UserId',document.logon.userid.value,expires,null,"/");
		Set_Cookie('IMail_password',document.logon.passwd.value,expires,null,"/");
	}else{
		deleteCookie("IMail_UserId", "/", null);
		deleteCookie("IMail_password", "/", null);
		deleteCookie("IMail_UserKey", "/", null);
	}
  return true;
}
    // Begin cs_help.cgi
      function openHelp(sHelp)
      {
        url = '//' + sHelp + '.html';
        helpWin=window.open("",sHelp,"width=400,height=400,status=no,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
		helpWin.document.write('<HTML><HEAD><TITLE>���߰���</TITLE></HEAD><FRAMESET BORDER=0 ROWS="24, *">');
		helpWin.document.write('<FRAME MARGINWIDTH="0" MARGINHEIGHT="0" SCROLLING="no" NAME="toolbar" NORESIZE SRC="helptoolbar.html">');
		helpWin.document.write('<FRAME MARGINWIDTH="0" MARGINHEIGHT="0" SCROLLING="auto" NAME="mainPage" src="' + url + '">');
		helpWin.document.write('<NOFRAMES>Sorry, you need to have a browser that supports frames to view this file.</NOFRAMES>');
		helpWin.document.write('</FRAMESET></HTML>');
      }
  var current;
  var menu     = "���ص����˵�";
  var compose  = "����һ�����ʼ�";
  var asearch  = "���������ʼ�";
  var logout   = "�ǳ�";
  var check	= "���˿�ʼ������еط�";
  var CSSstatus = "0";
  var CSSObject = '�˵�ѡ��';
  var CSSselect = "��ѡ���ռ���";
  var Preferences = "��������";
  var subfold = "�������";
  var ab = "��ַ��";
  var calendar = "�ճ̱�";
  var mailboxname = "�ʼ���";
  var passwordpassword = "�޸�����";
  var planplanplanplan = "�޸�����ǩ��";
  var signaturesignature = "�޸��ҵ�ǩ��";
  var userprefuserpref = "�û����Ի�����";
  var chgvacchgvacchgvac = "����Զ��ظ�";
  var chgfwdchgfwdchgfwd = "�޸��ʼ�ת��";
  var chgldapchgldapchgldap = "�ı��û���Ϣ";
  var autoresplinkautoresplink = "�༭�Զ��ظ�";
  var chgruleschgrules = "�޸Ĵ�������";
  // convert all characters to lowercase to simplify testing 
  var agt=navigator.userAgent.toLowerCase();
  // Note: On IE5, these return 4, so use is_ie5up to detect IE5. 
  var is_major = parseInt(navigator.appVersion); 
  var is_minor = parseFloat(navigator.appVersion); 
  var is_nav  = ((agt.indexOf('mozilla')!=-1) && (agt.indexOf('spoofer')==-1) 
                && (agt.indexOf('compatible') == -1) && (agt.indexOf('opera')==-1) 
                && (agt.indexOf('webtv')==-1)); 
  var is_nav3 = (is_nav && (is_major == 3));
  var is_nav4up = (is_nav && (is_major >= 4));
  var is_ie   = (agt.indexOf("msie") != -1);
  var is_ie4up  = (is_ie  && (is_major >= 4));

  if(is_nav4up)
  {
    CSSObject += 'NS';
  }

  function statusBarMsg(message)
  {
    window.status = message;
  }

  function chgTextBox(form)
  {
    var i;
	var newOpt = "&lt;�½�&gt;";
	var deleteOpt = "&lt;ɾ��&gt;";

    i = form.subarea.selectedIndex;
  
    if(i==-1)
    {
      return;
    }

    if(form.subarea.options[i].text==newOpt)
    {
      form.newMbxName.value="";
	  form.newMbxName.focus();
	  return;
    }
    if(form.subarea.options[i].text==deleteOpt)
    {
      form.newMbxName.value="Delete the message";
	  return;
	}
	else
	{
	  form.newMbxName.value=form.subarea.options[i].text;
	  return;
	}
  }

  function doButton(sButton)
  {
    if (sButton == "����"
        || sButton == "ȡ��")
      document.Search.search_ok.value = sButton;
      document.Search.submit();
  }

  function doButton2(TopBottom,sButton)
  {
    if (sButton=="��һ��"
        || sButton=="��һ��"
        || sButton=="�ظ�"
        || sButton=="�ظ�����"
        || sButton=="��ǰ"
        || sButton=="ɾ��"
        || sButton=="�ƶ���")
    {
      if (TopBottom=="Top")
      {
        document.Buttons.imail_action.value=sButton;
        document.Buttons.submit();
      }
	  if (TopBottom=="Move")
	  {
	    document.MoveButton.imail_action.value=sButton;
        document.MoveButton.submit();
	  }
      if (TopBottom=="Bottom")
      {
        document.BottomButtons.imail_action.value=sButton;
        document.BottomButtons.submit();
      }
      return;
    }
  }

  function doButton3(sButton)
  {
    if (sButton=="Top��ҳ"
       || sButton=="Topĩҳ"
       || sButton=="Top��ת"
       || sButton=="Top��ҳ"
       || sButton=="Top��ҳ"
       || sButton=="��ҳ"
       || sButton=="ĩҳ"
       || sButton=="��ת"
       || sButton=="��ҳ"
       || sButton=="��ҳ")
    {
      var nCounter = document.forms.length;
      var nForms   = 0;
      while (nForms < nCounter)
      {
        if (document.forms[nForms].name == sButton)
		{
          document.forms[nForms].submit();
		}
          nForms++
      }
    } else if (sButton=="ɾ��"
              || sButton=="ɾ������"
              || sButton=="�ƶ���"
              || sButton=="�� Mailbox")
      {
        document.mboxsummary.imail_action.value=sButton;
        document.mboxsummary.submit();
        return;
      }
  }

  function newMailCount(data, NumValue)
  {
    if(NumValue==1)
	{
	  if(data.split("/"))
	  {
	    countArray = new Array(2);
	    countArray = data.split("/");
	    if(countArray[1] > 0)
		{
	      document.write("(" + countArray[1] + ")");
	    }
	      return;
	  }
	  else
	  {
	    return;
	  }
    }
	if(NumValue==0)
	{
	  if(data.split("/"))
	  {
	    countArray = new Array(2);
	    countArray = data.split("/");
	    document.write(countArray[0]);
	    return;
	  }
	  else
	  {
	    document.write(data);
		return;
	  }
	}
  }

  function checkAll()
  {
    for (var i=0;i<document.mboxsummary.elements.length;i++)
    {
      var e = document.mboxsummary.elements[i];
      var boolValue = document.sortedsummary.selectAll.checked;
      if (e.name != 'selectAll')
	  {
        e.checked = boolValue;
	  }
    }
  }

  function goToPage(numPages, curr, type)
  {
    var counter;
	var maxCount;
	document.write('<SELECT NAME="gotopage" SIZE="1" VALIGN="top" onChange="doButton3(');
	document.write("'" + type + "'");
	document.write(');">');
	for(counter=1,maxCount=numPages; maxCount > 0; maxCount--,counter++)
	{
	  if(counter == curr)
	  {
	    document.writeln('<OPTION VALUE="' + counter + '" SELECTED>' + counter + '</OPTION>');
	  }
	  else
	  {
	    document.writeln('<OPTION VALUE="' + counter + '">' + counter + '</OPTION>');
	  }
	}
	document.writeln('</SELECT>');
  }

  function newMsgCount()
  { 
    if(0>0)
	{
	  	   document.writeln('<FONT SIZE="2" FACE="Arial, Helvetica"><B>0 unread message(s)</B></FONT>');
	  	}
	else
	{
	  	    document.writeln('<FONT SIZE="2" FACE="Arial, Helvetica">No new message.</FONT>');
	  	}
  }

  function deleteMe(num)
  {
    for (var i=0;i<document.mboxsummary.elements.length;i++)
    {
      var me = document.mboxsummary.elements[i];
      if (me.name == 'msgsort' && me.value == num)
	  {
        me.checked = true;
	  }
	  else
	  {
	    me.checked = false;
	  }
    }
	doButton3('ɾ��');
  }

  function selectMe(me, match)
  {
    var maxNum, counter, choice;
    maxNum = me.length;
    for (counter=0; counter<maxNum; counter++)
    {
      choice = me.options[counter];
      if(choice.text==match)
	  {
	    choice.selected=1;
	    return;
	  }
	}
	return;
  }

  function selectMailbox(mailbox)
  {
    var maxNum, counter, choice;
    maxNum = document.ModRul.subarea.length;
    for (counter=0; counter<maxNum; counter++)
    {
      choice = document.ModRul.subarea.options[counter];
      if(choice.text==mailbox)
	  {
	    choice.selected=1;
	    return;
	  }
	  if(mailbox=="NUL")
	  {
	    document.ModRul.subarea.options[1].selected=1;
	    document.ModRul.newMbxName.value="";
	    return;
	  }
	}
	document.ModRul.subarea.options[0].selected=1;
	return;
  }

    function openIWebCal()
  { 
    				  newWindow = open("http://sdgh.net:8484/ical.cgi?&App=ICalMsg&UserKey=/",
			"Calendar", "toolbar=yes,location=1,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=1,copyhistory=1,width=512,height=512");
			  }

  	function writeTextBox(form)
	{
	  i = form.Target.selectedIndex;
	  if((form.Target.options[i].text.search("@")!=-1) && (i != -1))
	  {
	    form.newaddr.value = form.Target.options[i].text;
	  }
	}

	function findMe(formList, textBoxValue)
	{
	  if(textBoxValue.charAt(0)=='<' && textBoxValue.charAt(textBoxValue.length - 1)=='>')
	  {
	    selectMe(formList, textBoxValue);
	  }

	  if(textBoxValue.charAt(0)!='<' && textBoxValue.charAt(textBoxValue.length - 1)!='>')
	  {
	    textBoxValue = '<' + textBoxValue + '>';
	    selectMe(formList, textBoxValue);
	  }

	  return;
	}

	function searchaddr(form, searchtext, listName)
    {

	  var i = 0;
	  var quote = '"';

	  if(searchtext == "")
	  {
	    alert("The text field for the " + listName + " is blank.");
		return;
	  }

      for(i=0; i< form.Target.length; i++)
	  {

	    if(form.Target.options[i].text == searchtext )
	    {	
	 	  form.Target.selectedIndex = i;
		  return;
		}
	    else
	    {
          if(form.Target.options[i].text.indexOf(searchtext) != -1)
	      {	
 		    form.Target.selectedIndex = i;
		    return;
	      }
        }
	  } 	
	
	  alert("User "+ quote + searchtext + quote + " could not be found in the "+ listName +"." );
	  return;
    }

  function show(id)
	{
	  if(document.getElementById)
	  {
      document.getElementById(id).style.visibility = "visible";
      document.getElementById(id).style.display = "block";
      return 1;
    }
	  else if(document.layers)
	  {
	    document.layers[id].visibility = "show";
      document.layers[id].display = "block";
      return 1;
    }
	  else if(document.all)
	  {
	    document.all[id].style.visibility = "visible";
      document.all[id].style.display = "block";
      return 1;
	  }
    return 0;
	}
	
	function hide(id)
	{
	  if(document.getElementById)
	  {
      document.getElementById(id).style.visibility = "hidden";
      document.getElementById(id).style.display = "none";
      return 1;
    }
	  else if(document.layers)
	  {
      document.layers[id].visibility = "hide";
      document.layers[id].display = "none";
      return 1;
    }
	  else if(document.all)
	  {
	    document.all[id].style.visibility = "hidden";
      document.all[id].style.display = "none";
      return 1;
    }
    return 0;
	}	function getCookie(name)
	{
		var cookieFound = false;
		var start = 0;
		var end = 0;
		var cookieString = document.cookie;
		var cookieValue;

		var i = 0;
		
		//scan the Cookie for the name
		while (i <= cookieString.length){
			start = i;
			end = start + name.length;
			if(cookieString.substring(start, end) == name){
				cookieFound = true;
				break;
			}
			i++;
		}
		
		//is name found/
		if(cookieFound){
			start = end+1;
			end = document.cookie.indexOf(";",start);
			if(end < start)
				end = document.cookie.length;
			cookieValue = document.cookie.substring(start, end);
			start = 0;
			end = cookieValue.indexOf(" ", start);
			if(end < start)
				end = cookieValue.length;
			return cookieValue.substring(start, end);
		}
		return "";
	}

	function initFields()
	{
		document.logon.userid.value = getCookie("IMail_UserId");
		document.logon.passwd.value = getCookie("IMail_password");
	}

	function deleteCookie(name, path, domain){
		if(getCookie(name)){
			document.cookie = name+ "=" + 
				((path) ? "; path=" + path : "") +
				((domain) ? "; domain=" + domain: "") +
				"; expires=Thu, 01-Jan-70 00:00:01 GMT";
		}
	}
	
// for Classics
function Set_Cookie(name,value,expires,domain,path,secure) {
    document.cookie = name + "=" +escape(value) +
        ( (expires) ? ";expires=" + expires.toGMTString() : "") +
        ( (path) ? ";path=" + path : "") + 
        ( (domain) ? ";domain=" + domain : "") +
        ( (secure) ? ";secure" : "");
}

expires = new Date();
expires.setTime(expires.getTime() + (365 * 24 * 60 * 60 * 1000));


	function formSubmit()
	{
		deleteCookie("IMail_UserId", "/", null);
		deleteCookie("IMail_password", "/", null);
		deleteCookie("IMail_UserKey", "/", null);
	}
</script>
  <STYLE TYPE="text/css">
    <!--
    <!--ICAL.Include.style.cgi-->
body {
	background-color: #31689E;
}
.style2 {font-size: 12px}
    -->
  </STYLE>
    <LINK href="login.css" rel=stylesheet>
<BODY text=#000000 leftMargin=0 topMargin=0 scroll=no onLoad="statusBarMsg(current); document.logon.userid.focus(); initFields();">
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="middle" bgcolor="#31689E">  <table width="694"  border="0" cellpadding="0" cellspacing="1" bgcolor="#333333">
        <tr>
          <td><TABLE WIDTH=694 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
            <TR>
              <TD COLSPAN=3> <IMG SRC="images/login_1.jpg" WIDTH=694 HEIGHT=66 ALT=""></TD>
            </TR>
            <TR>
              <TD> <IMG SRC="images/login_2.jpg" WIDTH=376 HEIGHT=369 ALT=""></TD>
              <TD> <IMG SRC="images/login_3.jpg" WIDTH=9 HEIGHT=369 ALT=""></TD>
              <TD width="309" align="center" valign="top" background="images/login_3.jpg">
                <FORM NAME="logon" METHOD="POST" ACTION="login.cgi" onSubmit="return smartLogin();">
                  <INPUT NAME="page" TYPE="hidden" id="page2" VALUE="login">
                  <TABLE height=85 cellSpacing=0 cellPadding=0 width="100%"  border=0>
                    <TBODY>
                      <TR>
                        <TD width="74%" >
                          <TABLE cellSpacing=4 cellPadding=0 width="100%" 
border=0>
                            <TBODY>
                              <TR>
                                <TD height=30 colspan="2" align=right valign="bottom"></TD>
                                </TR>
                              <TR>
                                <TD align=right height=30>&nbsp;</TD>
                                <TD height=30>&nbsp;</TD>
                              </TR>
                              <TR>
                                <TD align=right width="29%" height=30  style="font-size:9pt ">�����ʺ�</TD>
                                <TD height=30>
                                    <INPUT NAME="userid" id="userid2"  
                              style="FONT-FAMILY: Tahoma" size=20>
                                </TD>
                              </TR>
                              <TR>
                                <TD align=right width="29%"  style="font-size:9pt ">��¼����</TD>
                                <TD>
                                    <INPUT 
                              NAME="passwd" type=password id="passwd2"  
                              style="FONT-FAMILY: Tahoma" size=20 maxlength="20">
&nbsp;&nbsp;&nbsp;&nbsp; </TD>
                              </TR>
                              <TR>
                                <TD align=right>&nbsp;</TD>
                                <TD class=fontyinyin height=20><input name="imageField" type="image" src="images/signin.gif" width="100" height="19" border="0"></TD>
                              </TR>
                            </TBODY>
                          </TABLE>
                          <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
                            <TBODY>
                              <TR>
                                <TD width="20%" height=89   style="font-size:9pt "></TD>
                                <TD width="80%" height=89  style="font-size:9pt "><FONT color=#666666><B><FONT 
                  face="Arial, Helvetica, sans-serif"><BR>
                                          <INPUT NAME="Expire_Cache" TYPE="checkbox" id="Expire_Cache" VALUE="1" >
                        </FONT></B><FONT 
                  face="Arial, Helvetica, sans-serif">��ȫ���(ҳ���Զ�����)<B><br>
                        <INPUT NAME="Use_Cookie" TYPE="checkbox" id="Use_Cookie" VALUE="1" >
                        </B>ʹ��Cookie��������<B><br>
                                </B></FONT></FONT></TD>
                              </TR>
                            </TBODY>
                        </TABLE></TD>
                      </TR>
                    </TBODY>
                  </TABLE>
              </FORM>
                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="26" valign="bottom"><span class="style2"> �˺�Ҫ������ȫ�ƣ��磺<b>name@xxxxx.com</b></span></td>
                  </tr>
                  <tr>
                    <td><table width="100%" height="44"  border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td height="10"></td>
                      </tr>
                      <tr>
                        <td height="34"   style="font-size:9pt "><font color="#666666">��ǰʱ��:
                              Thursday, May 01, 2025 09:24:16
                          </font></td>
                      </tr>
                    </table></td>
                  </tr>
                </table>
                </TD>
            </TR>
          </TABLE></td>
        </tr>
      </table>	      	</td>
  </tr>
</table>
</BODY></HTML>
