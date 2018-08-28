<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link rel="stylesheet" href="assets/materialize/css/materialize.min.css?version=22" media="screen,projection" />
    <!-- Bootstrap Styles-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <!--  <link rel="stylesheet" href="http://cdn.datatables.net/plug-ins/28e7751dbec/integration/bootstrap/3/dataTables.bootstrap.css"> --> 
     <link href="assets/css/dataTables.bootstrap.css" rel="stylesheet" />
    
    <link href="assets/css/override-styles.css?version=11" rel="stylesheet" />
</head>

<body>
	<%@ include file="public/header.jsp"%>
	<%@ include file="public/leftMenu.jsp"%>

	<div id="page-wrapper">
		<div class="header">
			<h1 class="page-header">Tables Page</h1>
			<ol class="breadcrumb">
				<li><a href="#">Home</a></li>
				<li><a href="#">Tables</a></li>
				<li class="active">Data</li>
			</ol>

		</div>

		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<div class="card">

						<div class="card-content">
							<div class="table-responsive">
								<!-- Advanced Tables -->
								<form>
									displayName:<input type="text" id="displayName" class="">

									<input type="button" id="Query" value="Query"
										class="btn btn-success"> <input type="button" id="Add"
										value="Add" class="btn btn-primary">

								</form>
								<table id="example" class="table table-striped table-bordered">
									<thead>
										<tr>
											<th>associateId</th>
											<th>员工全名</th>
											<th>出生日期</th>
											<th>入职时间</th>
											<th>员工状态</th>
											<th>FirstName</th>
											<th>LastName</th>
											<th>操作</th>
										</tr>
									</thead>
								</table>



								<!--End Advanced Tables -->

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>




	<!-- Modal -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					    <div class="modal-dialog">
					        <div class="modal-content">
					            <div class="modal-header">
					                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
					                        aria-hidden="true">&times;</span></button>
					                <h4 class="modal-title" id="myModalLabel">新增</h4>
					            </div>
					            <div class="modal-body">
					                <div class="form-group">
					                    <input type="text" class="form-control" id="associateId" placeholder="员工编号">
					                </div>
					                <div class="form-group">
					                    <input type="text" class="form-control" id="name" placeholder="员工全名">
					                </div>
					                <div class="form-group">
					                    <input type="text" class="form-control" id="birthDate" placeholder="出生日期"
					                           data-date-format="yyyy/mm/dd">
					                </div>
					                <div class="form-group">
					                    <input type="text" class="form-control" id="employmentDate" placeholder="入职日期"
					                           data-date-format="yyyy/mm/dd">
					                </div>
					                 <div class="form-group">
					                    <input type="text" class="form-control" id="firstName" placeholder="firstName">
					                </div>
					                 <div class="form-group">
					                    <input type="text" class="form-control" id="lastName" placeholder="lastName">
					                </div>
					            </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-info" id="initData">添加模拟数据</button>
					                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					                <button type="button" class="btn btn-primary" id="save">保存</button>
					            </div>
					        </div>
					    </div>
					</div>
		


	   <script src="assets/js/jquery.js"></script>
	 <!-- DATA TABLE SCRIPTS -->
	
    <!-- Metis Menu Js -->
    <script src="assets/js/jquery.metisMenu.js"></script>
	
	<!-- Bootstrap Js -->
    <script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/materialize/js/materialize.min.js?version=22"></script>
	
	

	 
	<script src="assets/js/dataTables/jquery.dataTables.js"></script>
	
	<script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
	<script type="text/javascript"
		src="assets/js/date/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript"
		src="assets/js/handlebars-v3.0.1.js"></script>
	
	<script id="tpl" type="text/x-handlebars-template">
    {{#each func}}
    <button type="button" class="btn btn-{{this.type}} btn-sm" onclick="{{this.fn}}">{{this.name}}</button>
    {{/each}}
</script>
	<script>
	var dataTable; 
	var editTable = false;
	var template;//这里才是公共变量。
	
	//这个方法中var 变量是局部变量。，其它function不能直接调用。
		$(function(){
			console.log("初始化开始了。。。");
			//加载时间下拉框控件
			$('#birthDate').datetimepicker();
			$('#employmentDate').datetimepicker();
			
		     //预编译模板
			 var tpl = $("#tpl").html();
		     template = Handlebars.compile(tpl);
		        
			//dataTable = initDatable();//这个也可以
			dataTable = initDatableByConfig();
			
			
			//绑定Query btn方法
			
			$("#Query").bind("click",function(){
				
				query();
				
			});
			
			
			//add 功能
			$("#Add").bind("click",function(){
                clear();
				$("#myModalLabel").text("新增");
				$("#associateId").val(associateId).css("display","none");
				$("#myModal").modal("show");
			});
			
			$("#initData").bind("click",function(){
				initSingleData();
			});
			$("#save").bind("click",function(){
				save();
			});
			
		})
		
		//进入编辑界面
		function edit(name,birthDate,employmentDate,firstName,lastName,associateId){
			editTable = true;
			$("#myModalLabel").text("修改");
			$("#associateId").val(associateId).css("display","");
	        $("#associateId").val(associateId).attr("disabled",true);
	        $("#name").val(name);
	        $("#birthDate").val(birthDate);
	        $("#employmentDate").val(employmentDate);
	        $("#firstName").val(firstName);
	        $("#lastName").val(lastName);
			
			$("#myModal").modal("show");
			
		}
		function deleteEmp(associateId){
			var url ="/bootstrapDemoForTest/servlet/GetEmployeeInfo" ;
        	$.ajax({
	            url:url ,
	            data:{
	            	"associateId":associateId,
	            	"operate":"delete",
	            }, 
	            success: function (data) {
	                query();
	            }
        	});
		}
		function ajax(json) {
        	var url ="/bootstrapDemoForTest/servlet/GetEmployeeInfo" ;
        	$.ajax({
	            url:url ,
	            data:json, 
	            success: function (data) {
	            	//dataTable.ajax.reload();
	                $("#myModal").modal("hide");
	                query();
	            }
        });
    }
		
		function clear(){
			editTable = false;
			$("#name").val("");
			$("#birthDate").val("");
			$("#employmentDate").val("");
			$("#firstName").val("");
			$("#lastName").val("");
		}
		function save(){
			var operate = "add"
			if(editTable == true){
				operate = "update";
			}
			var addJson = {
					"associateId": $("#associateId").val(),
					"name": $("#name").val(),
		            "birthDate": $("#birthDate").val(),
		            "employmentDate": $("#employmentDate").val(),
		            "firstName": $("#firstName").val(),
		            "lastName": $("#lastName").val(),
		            "operate":operate,
		        	};
	        	ajax(addJson);
		}
		function query(){
			console.log("进入query js method");
			dataTable.fnDestroy(false);
			//initDatable(); //这个也可以
			console.log("进入query js method 2222");
			initDatableByConfig();//其实可以继续抽取分离，对于配置的重写，重写各个操作用的配置，然后初始化datatable根据重写 都配置。
			//dataTable.fnDraw(false);
		}
		
		//方式一、这个是完整的初始化datatable，总共单页面单功能的话可以直接用这个。
		//但是一个整体系统有多个功能时，采用方式二即可。抽离出公共配置，然后根据具体功能重写配置，初始化datatable。
		function initDatable(){
			var dataTable = $("#example").dataTable({
				ajax:{
					url:"servlet/GetEmployeeInfo?operate=query",//这里这样写会直接到servelet。如果前面加上/,则会有问题，那就前面还得加工程名。
					data:{
						operate:"query",
						displayname:$("#displayName").val()
					},
					//dataSrc : "json",
				},
				"searching": true,
				"columns": [
			                {"data": "associateId"}, //因为要加行号，所以要多一列，不然会把第一列覆盖
			                {"data": "displayName"},
			                {"data": "birthDate"},
			                {"data": "employmentDate"},
			                {"data": "personalStatus"},
			                {"data": "firstName"},
			                {"data": "LastName"},
			            ],
			           
			});
			
			return dataTable;
		}
		//重写公共配置，针对具体的功能。
		//公共配置里面dataTablesSettings虽然没有ajax，columns,但是这里重写直接.ajax,是可以自动添加属性的。js的特点。
		function initDatableByConfig(){
			//可以设置整体的ajax option。
			$.dataTablesSettings.ajax={
					url:"/bootstrapDemoForTest/servlet/GetEmployeeInfo?operate=query",
							type:"post",
			};
			//也可以单独设置ajax下的某一项，可以细分到最底层
			console.log("查询内容是"+$("#displayName").val());
			$.dataTablesSettings.ajax.data={
					"operate":"query",
					"displayname":$("#displayName").val()
			};
			console.log("进入initDatableByConfig");
			$.dataTablesSettings.columns= [
			   			                {"data": "associateId"}, 
						                {"data": "displayName"},
						                {"data": "birthDate"},
						                {"data": "employmentDate"},
						                {"data": "personalStatus"},
						                {"data": "firstName"},
						                {"data": "lastName"},
						                {"data": null},
						            ];
			$.dataTablesSettings.columnDefs=[
							{
			                    "targets": 7,
			                    "render": function (a, b, c, d) {
			                        var context =
			                        {
			                            func: [
			                                {"name": "修改", "fn": "edit(\'" + c.displayName + "\',\'" + c.birthDate + "\',\'" + c.employmentDate + "\',\'" + c.firstName + "\',\'" + c.lastName + "\',\'" + c.associateId + "\')", "type": "primary"},
			                                {"name": "删除", "fn": "deleteEmp(\'" + c.associateId + "\')", "type": "danger"}
			                            ]
			                        };
			                        var html = template(context);
			                        return html;
			                    }
			                },
								{
								    "targets": 0,//第一列隐藏
								    "visible": false,
								    "searchable": false
								}                
			                                 
			                                 
			            ];
			
			var dataTable = $("#example").dataTable($.dataTablesSettings);
			return dataTable;
		}
		
		
		//设置一个公共datable配置，方便后期把整个系统datatable的公共选项配置加入到一块。讲下方对象放置到单独的公共js中即可。
		$.dataTablesSettings = {
				"searching": true,
		}
		
		
		 /**
	     * 初始化基础数据
	     */
	    function initSingleData() {
	        $("#name").val("张龙");
	        $("#birthDate").val("2016/7/10");
	        $("#employmentDate").val("2016/7/10");
	        $("#firstName").val("龙leo");
	        $("#lastName").val("张");
	    }
	</script>

<!-- Custom Js  这个js必须放到最后，因为报错，不知道为啥，目前，放在前面报错了会影响后面代码的执行2018年8月24日-->
	<script src="assets/js/custom-scripts.js"></script>
</body>
</html>
