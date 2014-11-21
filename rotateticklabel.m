<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
      
      	<script type="text/javascript" src="/includes_content/nextgen/scripts/jquery/jquery-latest.js"></script>
      <!-- START OF GLOBAL NAV -->
  <link rel="stylesheet" href="/matlabcentral/css/sitewide.css" type="text/css">
  <link rel="stylesheet" href="/matlabcentral/css/mlc.css" type="text/css">
  <!--[if lt IE 7]>
  <link href="/matlabcentral/css/ie6down.css" type="text/css" rel="stylesheet">
  <![endif]-->

      
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="keywords" content="file exchange, matlab answers, newsgroup access, link exchange, matlab blog, matlab central, simulink blog, matlab community, matlab and simulink community">
<meta name="description" content="File exchange, MATLAB Answers, newsgroup access, Links, and Blogs for the MATLAB &amp; Simulink user community">
<link rel="stylesheet" href="/matlabcentral/css/fileexchange.css" type="text/css">
<link rel="stylesheet" type="text/css" media="print" href="/matlabcentral/css/print.css" />
<title> File Exchange - MATLAB Central</title>
<script src="/matlabcentral/fileexchange/assets/application.js" type="text/javascript"></script>
<link href="/matlabcentral/fileexchange/assets/application.css" media="screen" rel="stylesheet" type="text/css" />
<link href="http://www.mathworks.com/matlabcentral/fileexchange/8722-rotate-tick-label/content/rotateticklabel.m" rel="canonical" />


<link rel="search" type="application/opensearchdescription+xml" title="Search File Exchange" href="/matlabcentral/fileexchange/search.xml" />


  </head>
    <body>
      <div id="header">
  <div class="wrapper">
  <!--put nothing in left div - only 11px wide shadow --> 
    <div class="main">
        	<div id="logo"><a href="/matlabcentral/?s_tid=gn_mlc_logo" title="MATLAB Central Home"><img src="/matlabcentral/images/mlclogo-whitebgd.gif" alt="MATLAB Central" /></a></div>
      
        <div id="headertools">
        

<script language="JavaScript1.3" type="text/javascript">

function submitForm(query){

	choice = document.forms['searchForm'].elements['search_submit'].value;
	
	if (choice == "entire1" || choice == "contest" || choice == "matlabcentral" || choice == "blogs"){
	
	   var newElem = document.createElement("input");
	   newElem.type = "hidden";
	   newElem.name = "q";
	   newElem.value = query.value;
	   document.forms['searchForm'].appendChild(newElem);
	      
	   submit_action = '/searchresults/';
	}
	
	switch(choice){
	   case "matlabcentral":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "c[]";
	      newElem.value = "matlabcentral";
	      document.forms['searchForm'].appendChild(newElem);
	
	      selected_index = 0;
	      break
	   case "fileexchange":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "term";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
	      submit_action = "/matlabcentral/fileexchange/";
	      selected_index = 1;
	      break
	   case "answers":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "term";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
	      submit_action = "/matlabcentral/answers/";
	      selected_index = 2;
	      break
	   case "cssm":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "search_string";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
		  submit_action = "/matlabcentral/newsreader/search_results";
	      selected_index = 3;
	      break
	   case "linkexchange":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "term";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
	      submit_action = "/matlabcentral/linkexchange/";
	      selected_index = 4;
	      break
	   case "blogs":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "c[]";
	      newElem.value = "blogs";
	      document.forms['searchForm'].appendChild(newElem);
	
	      selected_index = 5;
	      break
	   case "trendy":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "search";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
	      submit_action = "/matlabcentral/trendy";
	      selected_index = 6;
	      break
	   case "cody":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "term";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
	      submit_action = "/matlabcentral/cody/";
	      selected_index = 7;
	      break
	   case "contest":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "c[]";
	      newElem.value = "contest";
	      document.forms['searchForm'].appendChild(newElem);
	
	      selected_index = 8;
	      break
	   case "entire1":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "c[]";
	      newElem.value = "entiresite";
	      document.forms['searchForm'].appendChild(newElem);
	      
	      selected_index = 9;
	      break
	   default:
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "c[]";
	      newElem.value = "entiresite";
	      document.forms['searchForm'].appendChild(newElem);
	   
	      selected_index = 9;
	      break
	}

	document.forms['searchForm'].elements['search_submit'].selectedIndex = selected_index;
	document.forms['searchForm'].elements['query'].value = query.value;
	document.forms['searchForm'].action = submit_action;
}

</SCRIPT>


  <form name="searchForm" method="GET" action="" style="margin:0px; margin-top:5px; font-size:90%" onSubmit="submitForm(query)">
          <label for="search">Search: </label>
        <select name="search_submit" style="font-size:9px ">
         	 <option value = "matlabcentral">MATLAB Central</option>
          	<option value = "fileexchange" selected>&nbsp;&nbsp;&nbsp;File Exchange</option>
          	<option value = "answers">&nbsp;&nbsp;&nbsp;Answers</option>
            <option value = "cssm">&nbsp;&nbsp;&nbsp;Newsgroup</option>
          	<option value = "linkexchange">&nbsp;&nbsp;&nbsp;Link Exchange</option>
          	<option value = "blogs">&nbsp;&nbsp;&nbsp;Blogs</option>
          	<option value = "trendy">&nbsp;&nbsp;&nbsp;Trendy</option>
          	<option value = "cody">&nbsp;&nbsp;&nbsp;Cody</option>
          	<option value = "contest">&nbsp;&nbsp;&nbsp;Contest</option>
          <option value = "entire1">MathWorks.com</option>
        </select>
<input type="text" name="query" size="10" class="formelem" value="">
<input type="submit" value="Go" class="formelem gobutton" >
</form>

		  <ol id="access2">
  <li class="first">
    <a href="https://www.mathworks.com/accesslogin/createProfile.do?uri=http%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Ffileexchange%2F8722-rotate-tick-label%2Fcontent%2Frotateticklabel" id="create_account_link">Create Account</a>
  </li>
  <li>
    <a href="https://www.mathworks.com/accesslogin/index_fe.do?uri=http%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Ffileexchange%2F8722-rotate-tick-label%2Fcontent%2Frotateticklabel" id="login_link">Log In</a>
  </li>
</ol>


      </div>
	  
        <div id="globalnav">
        <!-- from includes/global_nav.html -->
        <ol>
                <li class=";" >
                        <a href="/matlabcentral/fileexchange/?s_tid=gn_mlc_fx">File Exchange</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/answers/?s_tid=gn_mlc_an">Answers</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/newsreader/?s_tid=gn_mlc_ng">Newsgroup</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/linkexchange/?s_tid=gn_mlc_lx">Link Exchange</a> 
                </li>
                <li class=";" >
                        <a href="http://blogs.mathworks.com/?s_tid=gn_mlc_blg">Blogs</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/trendy/?s_tid=gn_mlc_tnd">Trendy</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/cody/?s_tid=gn_mlc_cody">Cody</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/contest/?s_tid=gn_mlc_cn">Contest</a> 
                </li>
                <li class="icon mathworks" >
                        <a href="/?s_tid=gn_mlc_main">MathWorks.com</a> 
                </li>
        </ol>
      </div>
    </div>
  </div>
</div>

      <div id="middle">
  <div class="wrapper">

    <div id="mainbody" class="columns2">
  
  

  <div class="manifest">

    <div id="download_submission_button">
            <div class="btnCont ctaBtn ctaBlueBtn btnSmall">
              <div class="btn download"><a href="/matlabcentral/fileexchange/downloads/2770" class="link--download  nologin" title="Download Now">Download Zip</a></div>
            </div>
          </div>


      <p class="license">
      Code covered by the <a href="/matlabcentral/fileexchange/view_license?file_info_id=8722" popup="new_window height=500,width=640,scrollbars=yes">BSD License</a>
      <a href="/matlabcentral/fileexchange/help_license#bsd" class="info notext preview_help" onclick="window.open(this.href,'small','toolbar=no,resizable=yes,status=yes,menu=no,scrollbars=yes,width=600,height=550');return false;">&nbsp;</a>
  </p>



  
  <h3 class="highlights_title">Highlights from <br/>
    <a href="http://www.mathworks.com/matlabcentral/fileexchange/8722-rotate-tick-label" class="manifest_title">Rotate Tick Label</a>
  </h3>
  <ul class='manifest'>
      <li class='manifest'><a href="http://www.mathworks.com/matlabcentral/fileexchange/8722-rotate-tick-label/content//rotateticklabel.m" class="function" title="Function">th=rotateticklabel(h,rot,...</a><span class="description">ROTATETICKLABEL rotates tick labels</span></li>
    <li class="manifest_allfiles">
      <a href="http://www.mathworks.com/matlabcentral/fileexchange/8722-rotate-tick-label/content/rotateticklabel.zip" id="view_all_files">View all files</a>
    </li>
  </ul>

</div>


  <table cellpadding="0" cellspacing="0" class="details file contents">
    <tr>
      <th class="maininfo">
        
  <div id="thumbnail" style="padding-bottom: 3px;">
    <a href="/matlabcentral/fileexchange/screenshots/1010/original.jpg" border="0"><img itemprop="image" src="/matlabcentral/fileexchange/screenshots/1010/preview.jpg" width=100 alt="image thumbnail"/></a>
  </div>


<div id="details">
  <h1 itemprop="name">Rotate Tick Label</h1>
  <p id="author">
    by 
    <span itemprop="author" itemscope itemtype="http://schema.org/Person">
      <span itemprop="name"><a href="http://www.mathworks.com/matlabcentral/fileexchange/authors/20418">Andrew Bliss</a></span>
    </span>
  </p>
  <p>&nbsp;</p>
  <p>
    <span id="submissiondate" 
>
      14 Oct 2005
    </span>
      <span id="date_updated">(Updated 
        <span itemprop="datePublished" content="2005-12-30">30 Dec 2005</span>)
      </span>
  </p>

  <p id="summary">ROTATETICKLABEL rotates tick labels.</p>


  
</div>

        </div>
      </th>
    </tr>
    <tr>
      <td class="file">
        <table cellpadding="0" cellspacing="0" border="0" class="fileview section">
          <tr class="title">
            <th><span class="heading">th=rotateticklabel(h,rot,demo)</span></th>
          </tr>
          <tr>
            <td>
              
              <div class="codecontainer"><pre class="matlab-code">function th=rotateticklabel(h,rot,demo)
%ROTATETICKLABEL rotates tick labels
%   TH=ROTATETICKLABEL(H,ROT) is the calling form where H is a handle to
%   the axis that contains the XTickLabels that are to be rotated. ROT is
%   an optional parameter that specifies the angle of rotation. The default
%   angle is 90. TH is a handle to the text objects created. For long
%   strings such as those produced by datetick, you may have to adjust the
%   position of the axes so the labels don't get cut off.
%
%   Of course, GCA can be substituted for H if desired.
%
%   TH=ROTATETICKLABEL([],[],'demo') shows a demo figure.
%
%   Known deficiencies: if tick labels are raised to a power, the power
%   will be lost after rotation.
%
%   See also datetick.

%   Written Oct 14, 2005 by Andy Bliss
%   Copyright 2005 by Andy Bliss

%DEMO:
if nargin==3
    x=[now-.7 now-.3 now];
    y=[20 35 15];
    figure
    plot(x,y,'.-')
    datetick('x',0,'keepticks')
    h=gca;
    set(h,'position',[0.13 0.35 0.775 0.55])
    rot=90;
end

%set the default rotation if user doesn't specify
if nargin==1
    rot=90;
end
%make sure the rotation is in the range 0:360 (brute force method)
while rot&gt;360
    rot=rot-360;
end
while rot&lt;0
    rot=rot+360;
end
%get current tick labels
a=get(h,'XTickLabel');
%erase current tick labels from figure
set(h,'XTickLabel',[]);
%get tick label positions
b=get(h,'XTick');
c=get(h,'YTick');
%make new tick labels
if rot&lt;180
    th=text(b,repmat(c(1)-.1*(c(2)-c(1)),length(b),1),a,'HorizontalAlignment','right','rotation',rot);
else
    th=text(b,repmat(c(1)-.1*(c(2)-c(1)),length(b),1),a,'HorizontalAlignment','left','rotation',rot);
end

</pre></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>

  </table>
  <script src="/matlabcentral/fileexchange/assets/file_infos/show.js" type="text/javascript"></script>

<p id="contactus"><a href="/company/feedback/">Contact us</a></p>
<!-- Quantcast Tag -->
<script type="text/javascript">
var _qevents = _qevents || [];
(function() {
var elem = document.createElement('script');
elem.src = (document.location.protocol == "https:" ? "https://secure" : "http://edge") + ".quantserve.com/quant.js";
elem.async = true;
elem.type = "text/javascript";
var scpt = document.getElementsByTagName('script')[0];
scpt.parentNode.insertBefore(elem, scpt);
})();
function p2l(pathname,query,hash){
pathname = pathname.replace(/\//gi,"__")
if(pathname === "__") {
pathname = "homepage";
}
pathname = pathname.replace(/\./gi,"_");
query = query.replace(/\?/gi,'-');
params = query.split('&');
args = []
for(arg = 0; arg < params.length; arg++){
args.push(params[arg].split('=')[0]);
}
pathname += args.join('-');
pathname += hash.replace(/#/gi,"-");
return pathname;
};
_qevents.push({
qacct:"p-zfNtLVVEHXE-1",
labels: "_fp.event." + p2l(document.location.pathname,
document.location.search, document.location.hash)
});
</script>
<noscript>
<div style="display:none;">
<img src="//pixel.quantserve.com/pixel/p-zfNtLVVEHXE-1.gif" border="0" height="1" width="1" alt="Quantcast"/>
</div>
</noscript>
<!-- End Quantcast tag -->

<!-- BEGIN Google Code for UK and .COM Domains-->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 1023777138;
var google_conversion_label = "SVIBCMq3xwIQ8rKW6AM";
var google_custom_params = window.google_tag_params;
var google_remarketing_only = true;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/1023777138/?value=0&label=SVIBCMq3xwIQ8rKW6AM&guid=ON&script=0"/>
</div>
</noscript>
<!-- END Google Code for UK and .COM Domains-->

      

	
      
</div>
<div class="clearboth">&nbsp;</div>
</div>
</div>
<!-- footer.html -->
<!-- START OF FOOTER -->

<div id="mlc-footer">
  <script type="text/javascript">
function clickDynamic(obj, target_url, tracking_code) {
	var pos=target_url.indexOf("?");
	if (pos<=0) { 
		var linkComponents = target_url + tracking_code;
		obj.href=linkComponents;
	} 
}
</script>
  <div class="wrapper">
    <div>
      <ul id="matlabcentral">
        <li class="copyright first">&copy; 1994-2014 The MathWorks, Inc.</li>
        <li class="first"><a href="/help.html" title="Site Help">Site Help</a></li>
        <li><a href="/company/aboutus/policies_statements/patents.html" title="patents" rel="nofollow">Patents</a></li>
        <li><a href="/company/aboutus/policies_statements/trademarks.html" title="trademarks" rel="nofollow">Trademarks</a></li>
        <li><a href="/company/aboutus/policies_statements/" title="privacy policy" rel="nofollow">Privacy Policy</a></li>
        <li><a href="/company/aboutus/policies_statements/piracy.html" title="preventing piracy" rel="nofollow">Preventing Piracy</a></li>
        <li class="last"><a href="/matlabcentral/termsofuse.html" title="Terms of Use" rel="nofollow">Terms of Use</a></li>
        <li class="icon"><a href="/company/rss/" title="RSS" class="rssfeed" rel="nofollow"><span class="text">RSS</span></a></li>
        <li class="icon"><a href="/programs/bounce_hub_generic.html?s_tid=mlc_lkd&url=http://www.linkedin.com/company/the-mathworks_2" title="LinkedIn" class="linkedin" rel="nofollow" target="_blank"></a></li>
        <li class="icon"><a href="/programs/bounce_hub_generic.html?s_tid=mlc_fbk&url=https://plus.google.com/117177960465154322866?prsrc=3" title="Google+" class="google" rel="nofollow" target="_blank"><span class="text">Google+</span></a></li>
        <li class="icon"><a href="/programs/bounce_hub_generic.html?s_tid=mlc_fbk&url=http://www.facebook.com/MATLAB" title="Facebook" class="facebook" rel="nofollow" target="_blank"><span class="text">Facebook</span></a></li>
        		<li class="last icon"><a href="/programs/bounce_hub_generic.html?s_tid=mlc_twt&url=http://www.twitter.com/MATLAB" title="Twitter" class="twitter" rel="nofollow" target="_blank"><span class="text">Twitter</span></a></li>        
        
      </ul>
      <ul id="mathworks">
        <li class="first sectionhead">Featured MathWorks.com Topics:</li>
        <li class="first"><a href="/products/new_products/latest_features.html" onclick="clickDynamic(this, this.href, '?s_cid=MLC_new')">New Products</a></li>
        <li><a href="/support/" title="support" onclick="clickDynamic(this, this.href, '?s_cid=MLC_support')">Support</a></li>
        <li><a href="/help" title="documentation" onclick="clickDynamic(this, this.href, '?s_cid=MLC_doc')">Documentation</a></li>
        <li><a href="/services/training/" title="training" onclick="clickDynamic(this, this.href, '?s_cid=MLC_training')">Training</a></li>
        <li><a href="/company/events/webinars/" title="Webinars" onclick="clickDynamic(this, this.href, '?s_cid=MLC_webinars')">Webinars</a></li>
        <li><a href="/company/newsletters/" title="newsletters" onclick="clickDynamic(this, this.href, '?s_cid=MLC_newsletters')">Newsletters</a></li>
        <li><a href="/programs/trials/trial_request.html?prodcode=ML&s_cid=MLC_trials" title="MATLAB Trials">MATLAB Trials</a></li>
        
        		<li class="last"><a href="/company/jobs/opportunities/index_en_US.html" title="Careers" onclick="clickDynamic(this, this.href, '?s_cid=MLC_careers')">Careers</a></li>
                 
      </ul>
    </div>
  </div>
</div>
<!-- END OF FOOTER -->


      
      
<!-- SiteCatalyst code version: H.24.4.
Copyright 1996-2012 Adobe, Inc. All Rights Reserved
More info available at http://www.omniture.com -->
<script language="JavaScript" type="text/javascript" src="/scripts/omniture/s_code.js"></script>


<script language="JavaScript" type="text/javascript">



<!--
if (typeof mboxLoadSCPlugin == 'function') {
	mboxLoadSCPlugin(s); 
}
/************* DO NOT ALTER ANYTHING BELOW THIS LINE ! **************/
var s_code=s.t();if(s_code)document.write(s_code)//--></script>
<script language="JavaScript" type="text/javascript"><!--
if(navigator.appVersion.indexOf('MSIE')>=0)document.write(unescape('%3C')+'\!-'+'-')
//--></script>
<!--/DO NOT REMOVE/-->
<!-- End SiteCatalyst code version: H.24.4. -->


  

    
  
<!-- BEGIN Qualaroo --> 
<script type="text/javascript">
  var _kiq = _kiq || [];
  (function(){
    setTimeout(function(){
			var d = document, f = d.getElementsByTagName('script')[0], s = d.createElement('script'); s.type = 'text/javascript';
			s.async = true; s.src = '//s3.amazonaws.com/ki.js/49559/ahy.js'; f.parentNode.insertBefore(s, f);
    }, 1);
  })();
</script>
<!-- END Qualaroo --> 

    </body>
</html>
