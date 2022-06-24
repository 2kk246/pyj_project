<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<hr>

<!-- clock widget start -->
	<script type="text/javascript"> 
		var css_file=document.createElement("link");
		css_file.setAttribute("rel","stylesheet"); 
		css_file.setAttribute("type","text/css"); 
		css_file.setAttribute("href","https://s.bookcdn.com//css/cl/bw-cl-sm2.css?v=0.0.1"); 
		document.getElementsByTagName("head")[0].appendChild(css_file); 
	</script>
	<div id="tw_25_151867534">
		<div style="width:200px; height:;">
		</div>
	</div> 
	<script type="text/javascript"> 
		function setWidgetData_151867534(data){ 
			if(typeof(data) != 'undefined' && data.results.length > 0) { 
				for(var i = 0; i < data.results.length; ++i) { 
					var objMainBlock = ''; 
					var params = data.results[i]; 
					objMainBlock = document.getElementById('tw_'+params.widget_type+'_'+params.widget_id); 
					if(objMainBlock !== null) objMainBlock.innerHTML = params.html_code; 
					} 
				} 
			} 
		var clock_timer_151867534 = -1; 
		widgetSrc = "https://widgets.booked.net/time/info?ver=2;domid=593;type=25;id=151867534;scode=124;city_id=18406;wlangid=24;mode=1;details=0;background=ffffff;border_color=ffffff;color=686868;add_background=ffffff;add_color=333333;head_color=ffffff;border=1;transparent=0"; 
		var widgetUrl = location.href; 
		widgetSrc += '&ref=' + widgetUrl; 
		var wstrackId = ""; 
		if (wstrackId) { widgetSrc += ';wstrackId=' + wstrackId + ';' } 
		var timeBookedScript = document.createElement("script"); 
		timeBookedScript.setAttribute("type", "text/javascript"); 
		timeBookedScript.src = widgetSrc; 
		document.body.appendChild(timeBookedScript); 
	</script>
<!-- clock widget end -->
	
<h5>EZEN Copyright © EZEN Corp. All Rights Reserved.</h5>