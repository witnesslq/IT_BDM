<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.zs.entity.CompanySection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加公司组织架构</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="<%=path %>/FRAMEWORK/jquery-easyui/themes/${theme }/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/FRAMEWORK/jquery-easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/FRAMEWORK/jquery-easyui/demo/demo.css">
	<script type="text/javascript" src="<%=path %>/FRAMEWORK/jquery-easyui/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path %>/FRAMEWORK/jquery-easyui/jquery.easyui.min.js"></script>
	
	<script type="text/javascript" src="<%=path %>/FRAMEWORK/js/myjs.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path %>/FRAMEWORK/css/mycss.css">
	<style type="text/css">
	td{
		padding: 3px;
	}
	</style>
	<script type="text/javascript">
	$(function(){
		$('.easyui-tree').tree('collapseAll');
	});
	</script>
  </head>
  
  <body>
  	<div class="easyui-panel" title="添加公司组织架构" style="padding: 5px;display: none;width: 512px;">
  	<form action="<%=path %>/cs!add" method="post">
  	<table border="1" style="width: 100%;" align="center"> 
  	<tr>
  		<td style="width: 100px;">部门名称：</td>
  		<td>
  			<input name="cs.csName" type="text"/>
		</td>
  	</tr>
  	<tr>
  		<td>职员名字：</td>
  		<td>
  			<input name="cs.csMaster" type="text"/>
		</td>
  	</tr>
  	<tr>
  		<td>工号：</td>
  		<td>
  			<input name="cs.csNumber" type="text"/>
		</td>
  	</tr>
  	<tr>
  		<td>职位：</td>
  		<td>
  			<input name="cs.csPosition" type="text"/>
		</td>
  	</tr>
  	<tr>
  		<td>私人电话：</td>
  		<td>
  			<input name="cs.csPhoneP" type="text"/>
		</td>
  	</tr>
  	<tr>
  		<td>公司电话：</td>
  		<td>
  			<input name="cs.csPhoneC" type="text"/>
		</td>
  	</tr>
  	<tr>
  		<td>短号：</td>
  		<td>
  			<input name="cs.csPhoneS" type="text"/>
		</td>
  	</tr>
  	<tr>
  		<td>上级：</td>
  		<td>
			<select name="cs.csLast" id="cc" style="width:100%;"></select>
			<div id="sp">
				<div style="color:#99BBE8;background:#fafafa;padding:5px;">选择上级架构</div>
				${html }
			</div>
  		</td>
  	</tr>
  	<tr>
  		<td colspan="2">
  			<input onclick="return check()" type="submit" value="提交" style="width: 100%;height: 25px;"/>
  		</td>
  	</tr>
  	</table>
  	</form>
  	</div>
	<!--
	测试按钮 
	<a id="a" onclick="">测试组合下拉控件</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="setvalue()">SetValue</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="alert($('#cc').combobox('getText'))">GetValue</a>
	 -->
	
	<script type="text/javascript">
		$(function(){
			$('#cc').combo({
				required:true,
				editable:false
			});
			$('#sp').appendTo($('#cc').combo('panel'));
			$('#sp li div').click(function(){
				var f = $(this).find('font').text();
				var t = $(this).find('.tree-title');
				var str=$("<span>"+t.html()+"</span>");
				str.find('font').remove();
				//alert(f+"*"+str.text() );
				$('#cc').combo('setValue', f).combo('setText', str.text());
			});
			
			$("#a").click(function(){
				alert($('#cc').combobox('getValue'));
			});
			
		});
		function check(){
			var s=$('#cc').combobox('getValue');
			if($.trim(s)==""){
				alert("部门不能为空!");
				return false;
			}else{
				return true;
			}
		} 
		function setvalue(){
			$.messager.prompt('SetValue','Please input the value(CO,NV,UT,etc):',function(v){
				if (v){
					$('#cc').combobox('setText',v);
				}
			});
		}
	</script>
  </body>
</html>
