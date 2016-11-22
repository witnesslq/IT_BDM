<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.zs.tools.Constant"%>
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
    
    <title>哲盟账号申请记录登记</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="<%=path %>/FRAMEWORK/jquery-easyui/themes/yellow/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/FRAMEWORK/jquery-easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/FRAMEWORK/jquery-easyui/demo/demo.css">
	<script type="text/javascript" src="<%=path %>/FRAMEWORK/jquery-easyui/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path %>/FRAMEWORK/jquery-easyui/jquery.easyui.min.js"></script>
	<!-- 自动补全插件 -->
    <link rel="stylesheet" type="text/css" href="<%=path %>/FRAMEWORK/autocomplete/src/jquery.autocomplete.css"></link>
    <script type="text/javascript" src="<%=path %>/FRAMEWORK/autocomplete/src/jquery.autocomplete.js"></script>
	<!-- 自动补全插件 -->
	<link rel="stylesheet" type="text/css" href="<%=path %>/FRAMEWORK/css/mycss.css">
	<script type="text/javascript">
   	var isSelect=false;
	$(function(){
		$("#sele option[value='"+${page.size}+"']").attr("selected",true);
		$("#eidtASubjectWindow1").show();
		$('#tt').show();
		
		$('.easyui-tree').tree('collapseAll');
		
		$('#sample').AutoComplete({
		    'data': ${query_section},
		    'beforeLoadDataHandler' : function(keyword){
		    	isSelect=false;
	            return true;
	        },
		    'afterSelectedHandler': function(data){
		    	isSelect=true;
	            //alert(data.value+"  "+isSelect);
	            //$('#sample').val("111");测试自定义输出内容:成功
	            var str=data.value;
	            var strs= new Array(); //定义一数组 
				strs=str.split("("); //字符分割 
	            //alert(strs[0]);
	            $('#sample').val(strs[0]);
	        },
	        'onerror': function(msg){alert(msg);},
	        'width':'auto'
		});
		$('#sample2').AutoComplete({
		    'data': ${query_section},
		    'beforeLoadDataHandler' : function(keyword){
		    	isSelect=false;
	            return true;
	        },
		    'afterSelectedHandler': function(data){
		    	isSelect=true;
	            //alert(data.value+"  "+isSelect);
	            //$('#sample').val("111");测试自定义输出内容:成功
	            var str=data.value;
	            var strs= new Array(); //定义一数组 
				strs=str.split("("); //字符分割 
	            //alert(strs[0]);
	            $('#sample2').val(strs[0]);
	        },
	        'onerror': function(msg){alert(msg);},
	        'width':'auto'
		});
	});
	
	function isSubmit(){
		if(isSelect){
			return true;
		}else{
			alert("部门字段不能手动输入，必须从智能提示的列表中选择。");
			return false;
		}
	}
	
	function update(u1,u2,u3,u4,u5,u6,u7,u8,u9,u10){
		$('#u').window('open');
		$('#u_1').val(u1);
		$('#sample').val(u3);
		$('#u_4').val(u4);
		$('#u_5').val(u5);
		$("#u_6 option[value='"+u6+"']").attr("selected",true);
		$('#u_7').val(u7);
		$('#u_8').val(u8);
		$('#u_9').val(u9);
		$('#u_10').val(u10);
	}
	function page(no,cz){
		var num1=$('#page').val();
		if(cz==1){//上下页
			$('#page').val(num1*1+no*1);
		}else if(cz==2){//首末页
			$('#page').val(no);
		}else{
		}
		if($('#page').val()*1<1){
			$('#page').val(1);
		}else if($('#page').val()*1>${page.pageMax}*1){
			$('#page').val(${page.pageMax});
		}
		$('#f1').submit();
	}
	
	</script>
	
  </head>
  
  <body>
    
	
    
    <div class="easyui-panel" title="哲盟账号申请记录登记" style="padding: 5px;display: none;" data-options="tools:'#tt'">
    
    <div style="background-color:white;margin-bottom: 5px;padding: 5px;border: 1px solid #224466; ">
    	快速查询
    	<br/>
    	<form action="<%=path %>/zmn!queryOfFenye" method="post">
    		编号:<input name="id" type="text" value="${id }"/>
    		&nbsp;&nbsp;&nbsp;&nbsp;
    		申请部门：<input name="section" type="text" value="${section }"/>
    		&nbsp;&nbsp;&nbsp;&nbsp;
    		申请人：<input name="men" type="text" value="${men }"/>
    		&nbsp;&nbsp;&nbsp;&nbsp;
    		申请时间:<input name="dates" type="date" value="${dates }"/>
    		~
    		<input name="datee" type="date" value="${datee }"/>
    		<br/>
    		<input type="submit" value="查询"/>
    	</form>	
    </div>
    <div style="margin-bottom: 5px;">
    
    
    <table border="1" id="eidtASubjectWindow1" style="font-size: 12px;">
    <tr>
    	<th>编号</th>
    	<th>申请时间</th>
    	<th>申请部门</th>
    	<th>申请人</th>
    	<th>哲盟</th>
    	<th>在职情况</th>
    	<th>维护IT</th>
    	<th>维护日期</th>
    	<th>维护周数</th>
    	<th>备注</th>
    	<th>操作</th>
    </tr>
    <c:forEach items="${zmns}" var="zmn">
    <tr>
		<td width="">${zmn.zmId }</td>
		<td width=""><fmt:formatDate value="${zmn.zmApplyDate }" pattern="yyyy/M/d" /></td>
		<td width="">${zmn.zmApplyCs }</td>
		<td width="">${zmn.zmApplyMaster }</td>
		<td width="">${zmn.zmNumber }</td>
		<td width="">${zmn.zmOnJob }</td>
		<td width="">${zmn.zmServiceMaster }</td>
		<td width=""><fmt:formatDate value="${zmn.zmServiceDate }" pattern="yyyy/M/d" /></td>
		<td width="">${zmn.zmServiceWeek }</td>
		<td width="">${zmn.zmNote }</td>
		<td width="5%" align="center">
			<a onclick="update('${zmn.zmId }','${zmn.zmApplyDate }','${zmn.zmApplyCs }','${zmn.zmApplyMaster }','${zmn.zmNumber }','${zmn.zmOnJob }','${zmn.zmServiceMaster }','${zmn.zmServiceDate }','${zmn.zmServiceWeek }','${zmn.zmNote }')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-edit'" title="修改"></a>
			<a href="<%=path %>/zmn!delete?id=${zmn.zmId}" onclick="return confirm('确定删除吗?')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-delete'" title="删除"></a>
		</td>
    </tr>
    </c:forEach>
    </table>
	</div>
	
	<div class="easyui-panel" style="padding:5px;width: 100%;display: none;">
		<form id="f1" action="<%=path %>/zmn!queryOfFenye?id=${id}&section=${section}&men=${men}&dates=${dates}&datee=${datee}" method="post">
		<select id="sele" style="float: left;margin-top: 3px;margin-left: 5px;" name="page.size" onchange="$('#f1').submit();">
			<option value="5">5</option>
			<option value="10">10</option>
			<option value="15">15</option>
		</select>
		
		<span style="float: left;margin-left: 5px;">
		<span style="color: #A5A5A5;">|</span>
		<a onclick="page(1,2)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-last'" title="首页"></a>
		<a onclick="page(-1,1)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-l'" title="上一页"></a>
		<span style="color: #A5A5A5;">|</span>
		</span>
		
		<span style="float: left;margin-top: 3px;margin-left: 5px;">
		<input id="page" name="page.pageOn" type="number" style="width: 50px;height: 20px;" value="${page.pageOn }" min="1" max="${page.pageMax }" onchange="$('#f1').submit();"/>
		</span>
		
		<span style="float: left;margin-top: 5px;margin-left: 5px;">/${page.pageMax }</span>
		
		<span style="float: left;margin-left: 5px;">
		<span style="color: #A5A5A5;">|</span>
		<a onclick="page(1,1)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-n'" title="下一页"></a>
		<a onclick="page('${page.pageMax}',2)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-next'" title="末页"></a>
		</span>
		</form>
	</div>
	</div>
	
	<div id="u" class="easyui-window" title="修改" data-options="modal:true,closed:true" style="width:500px;height:auto;padding:10px;display: none;top:200px;">
		<form action="<%=path %>/zmn!update" method="post">
		<table border="0" class="table1">
			<tr>
				<td width="70">编号：</td>
				<td>
					<input id="u_1" name="zmn.zmId" type="text" style="width: 100%;" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<td>申请部门：</td>
				<td>
					<input id="sample" type="text" name="zmn.zmApplyCs" style="width: 100%;"/>
				</td>
			</tr>
			<tr>
				<td>申请人：</td>
				<td>
					<input id="u_4" name="zmn.zmApplyMaster" type="text" style="width: 100%;"/>
				</td>
			</tr>
			<tr>
				<td>哲盟：</td>
				<td>
					<input id="u_5" name="zmn.zmNumber" type="text" style="width: 100%;"/>
				</td>
			</tr>
			<tr>
				<td>在职情况：</td>
				<td>
					<select id="u_6" name="zmn.zmOnJob">
						<option value="入职">入职</option>
						<option value="离职">离职</option>
					</select>
				</td>
			</tr>
			<!-- 
			<tr>
				<td>维护IT：</td>
				<td>
					<input id="u_7" name="zmn.zmServiceMaster" type="text" style="width: 100%;"/>
				</td>
			</tr>
			 -->
			<tr>
				<td>备注：</td>
				<td>
					<input id="u_10" name="zmn.zmNote" type="text" style="width: 100%;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input class="easyui-linkbutton" type="submit" style="width: 95%;padding: 5px;" value="提交" onclick="return isSubmit()"/>
				</td>			
			</tr>
		</table>
		</form>
	</div>
	
	<div id="a" class="easyui-window" title="添加" data-options="modal:true,closed:true" style="width:500px;height:auto;padding:10px;display: none;top:200px;">
		<form action="<%=path %>/zmn!add" method="post">
		<table border="0" class="table1">
			<tr>
				<td width="70">申请部门：</td>
				<td>
					<input id="sample2" type="text" name="zmn.zmApplyCs" style="width: 100%;"/>
				</td>
			</tr>
			<tr>
				<td>申请人：</td>
				<td>
					<input name="zmn.zmApplyMaster" type="text" style="width: 100%;"/>
				</td>
			</tr>
			<tr>
				<td>哲盟：</td>
				<td>
					<input name="zmn.zmNumber" type="text" style="width: 100%;"/>
				</td>
			</tr>
			<tr>
				<td>在职情况：</td>
				<td>
					<select id="u_6" name="zmn.zmOnJob">
						<option value="入职">入职</option>
						<option value="离职">离职</option>
					</select>
				</td>
			</tr>
			<!-- 
			<tr>
				<td>维护IT：</td>
				<td>
					<input name="zmn.zmServiceMaster" type="text" style="width: 100%;"/>
				</td>
			</tr>
			 -->
			<tr>
				<td>备注：</td>
				<td>
					<input name="zmn.zmNote" type="text" style="width: 100%;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input class="easyui-linkbutton" type="submit" style="width: 95%;padding: 5px;" value="提交" onclick="return isSubmit()"/>
				</td>			
			</tr>
		</table>
		</form>
	</div>
	
	<div id="tt" style="display: none;">
		<a class="icon-zs-import" onclick="$('#in').window('open')" style="margin-left: 10px;" title="excel导入"></a>
		<a class="icon-add" onclick="$('#a').window('open')" style="margin-left: 10px;" title="添加"></a>
	</div>
	
	
	<div id="in" class="easyui-window" title="数据导入" data-options="modal:true,closed:true" style="width:400px;height:auto;padding:10px;display: none;overflow-x:hidden;">
		<form action="<%=path %>/zmn!importExcel" method="post" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>Excel模板</td>
				<td onmousemove="$(this).css('background-color','red');" onmouseout="$(this).css('background-color','white');" style="cursor: pointer;" onclick="window.location.href='<%=path%>/files/import/xtz/哲盟账号申请.xlsx';">
					下载模板
				</td>
			</tr>
			<tr>
				<td>导入Excel数据</td>
				<td>
					<input type="file" name="fileExcel"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="导入"/>	
				</td>
			</tr>
		</table>
		</form>
	</div>
	
	
  </body>
</html>
