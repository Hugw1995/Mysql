<%@page import="com.framework.User"%>
<%@page import="com.framework.tools.SystemUtils"%>
<%@page import="com.framework.tools.UI"%>
<%@page import="com.framework.tools.UI_Op"%>
<%@page import="com.framework.tools.UIParser"%>
<%@page import="com.framework.tools.Utils"%>
<%@page import="com.framework.db.Entity"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="qm" uri="/WEB-INF/qm.tld"%>
<%
	User user=SystemUtils.getSessionUser(request, response);
	String userId=user.getId();

	Entity sys_user=(Entity)request.getAttribute("sys_user");
	boolean hasSys_user=sys_user!=null&&sys_user.getResultCount()>0;
	String role_code=(String)request.getAttribute("role_code");

%>
<!DOCTYPE HTML>
<html>
 <head>
  <jsp:include page="/public/base.jsp" />
  <jsp:include page="/public/framejs.jsp" />
  <script type="text/javascript">

    var controller = "com.framework.action.UserAction";
    var entity = "sys_user";
    var front_qm_name = "user";
    var qm_name = "user";
    var form_id = "userFormObj";
    var next_page = "public/pub/user/index.jsp";


    $(document).ready(function() {
      
    });
    
    
    function logout(){
		$.ajax({
	        type : "POST",
	        url : "fw?controller=" + controller + "&method=logOut" + "&entity=user",
	        dataType : "json",
	        data : {
	            method : 'logOut'
	        },
	        success : function(data) {
	            var result="当前系统繁忙";try{data = eval('(' + data + ')');	result=data.result;}catch(e){try{data = eval(data);result=data.result;}catch(e1){}}
	            if (result == 'Y') {
	            	comm.Loading(1, 2, '密码修改成功，请重新登录系统');
	            	parent.comm.DelayUrl(4, "index.jsp");
	            } else {
	                error("退出系统失敗", result);
	            }
	        }
	    });
	}
    
    
    function saveAddDialog(obj, doc) {
    	if($("#sys_user__pwd").val() != $("#sys_user__pwd1").val()){
    		error("小提示","两次输入的新密码不一致");
    		return;
    	}
    	
    	$.messager.progress();
    	$('#' + form_id).form('submit',{
    				url : "fw?controller=" + controller + "&method=changePassword"	+ "&entity=" + entity+"&lockId="+lockId,
    				onSubmit : function(data) {
    					var isValid = $(this).form('validate');
    					if (!isValid) {
    						$.messager.progress('close');
    					}
    					return isValid;
    				},
    				success : function(data) {
    					$.messager.progress('close');
    					var result="当前系统繁忙";try{data = eval('(' + data + ')');	result=data.result;}catch(e){try{data = eval(data);result=data.result;}catch(e1){}}
    					if ("Y" == result) {
    						logout();
    					} else {
    						error("重置密码失败", result);
    					}
    				}
    			});
    }
//add others script

  </script>
 </head>
 <body>
	  <form class="l-form" id="userFormObj" method="post">
	    <input id="sys_user__id" name="sys_user__id" type="hidden" value='<%=userId%>'/>

	    <ul>
	      <li style="width: 150px; text-align: right;">密码(*)：</li>
         <li style="width: 470px; text-align: left;">
	        <div class="l-text" style="width: 468px;">
	          <input id="oldpsw" name="oldpsw" class="easyui-validatebox"  style="width: 464px;" type="password" data-options="required:true,validType:'length[0,50]'" value='<%=hasSys_user?sys_user.getStringValue("pwd"):""%>'/>
	          <div class="l-text-l"></div>
	          <div class="l-text-r"></div>
	        </div>
	      </li>
	      <li style="width: 40px;"></li>
	    </ul>
	    
	    <ul>
	      <li style="width: 150px; text-align: right;">新密码(*)：</li>
         <li style="width: 470px; text-align: left;">
	        <div class="l-text" style="width: 468px;">
	          <input id="sys_user__pwd" name="sys_user__pwd" class="easyui-validatebox"  style="width: 464px;" type="password" data-options="required:true,validType:'length[0,50]'" value='<%=hasSys_user?sys_user.getStringValue("pwd"):""%>'/>
	          <div class="l-text-l"></div>
	          <div class="l-text-r"></div>
	        </div>
	      </li>
	      <li style="width: 40px;"></li>
	    </ul>
	    
	    <ul>
	      <li style="width: 150px; text-align: right;">确认新密码(*)：</li>
         <li style="width: 470px; text-align: left;">
	        <div class="l-text" style="width: 468px;">
	          <input id="sys_user__pwd1" name="sys_user__pwd1" class="easyui-validatebox"  style="width: 464px;" type="password" data-options="required:true,validType:'length[0,50]'" value='<%=hasSys_user?sys_user.getStringValue("pwd"):""%>'/>
	          <div class="l-text-l"></div>
	          <div class="l-text-r"></div>
	        </div>
	      </li>
	      <li style="width: 40px;"></li>
	    </ul>
	    
	  </form>
 </body>
</html>
