//plupload 组件的相对根路径
var plupload_basePath = basepath + "/js/plupload";
var houseExclusiveImgIndex = 0;
var uploaderDjwt;
// 图片上传组件
$(function(){
	uploaderDjwt = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : 'fkPickfiles', // you can pass in id...
		container : document.getElementById('fkContainer'), // ... or DOM  Element itself
		// url : 'servlet/fileUpload',
		url : basepath + '/file!upload.action',
		// Resize images on clientside if we can
		resize : {
			width : 800,
			height : 640,
			quality : 90,
			crop : false
		// false:等比例缩放 , true:非等比例缩放
		},

		filters : {
			max_file_size : '5mb',
			mime_types : [ {
				title : "图片文件",
				extensions : "jpg,gif,png,xls,doc"
			} ]
		},

		// Flash settings
		flash_swf_url : plupload_basePath + '/Moxie.swf',

		// Silverlight settings
		silverlight_xap_url : plupload_basePath + '/Moxie.xap',

		init : {
			
			BeforeUpload : function(up, file) {

			},

			FilesAdded : function(up, files) {

				var imgType = $("#houseExclusiveImgType").val();
				var jushi=$("#jushi").val();
				var fengge=$("#fengge").val();
				topIndx = imgType;
				var $imgContainer = null;
				if (imgType == 1) {
					$imgContainer = $("#ulHouseExclusiveFiles1 .panel-body");
				} else if (imgType == 2) {
					$imgContainer = $("#ulHouseExclusiveFiles2 .panel-body");
				} else if (imgType == 3) {
					$imgContainer = $("#ulHouseExclusiveFiles3 .panel-body");
				} else if (imgType == 4) {
					$imgContainer = $("#ulHouseExclusiveFiles4 .panel-body");
				} else if (imgType == 5) {
					$imgContainer = $("#ulHouseExclusiveFiles5 .panel-body");
				}
				if(imgType==1){
					if(shiObj[jushi]==null){
						plupload.each(files,function(file) {
							var uptpName  =  $("#uptpName").val();
							if(null == uptpName || uptpName =="" || uptpName =="null" || uptpName =="undifined")
							{
								uptpName = file.name;
							}
							var sHtml = '<p class="name"><span>'+jushi+'居室(<span id="shiju'+jushi+'"></span>)</span></p><a href="javascript:void(0)" onclick="uphuandengpian('+$("#jushi").val()+',0)" class="thumb"  data-toggle="modal" style="position:relative"><img id="file-'
									+ file.id
									+ '" width="108" height="80"  title="'+uptpName+'" alt="'+uptpName+'"></a>'
							sHtml += '<p class="name">'
								 sHtml +='<span>户型 ：'+jushi+'室 '+$("#tpting").val()+'厅 '+$("#tpwei").val()+'卫</span>'
									sHtml +='</p>';
							$imgContainer.append(sHtml);
							!function(f) {
								previewImage(f, function(imgsrc) {
									$('#file-' + f.id).attr("src", imgsrc);
								})
							}(file);

						});
						shiObj[jushi]=1;
						 $("#shiju"+jushi).html(shiObj[jushi]);
					}else{
						 shiObj[jushi] += 1;
						 $("#shiju"+jushi).html(shiObj[jushi]);
					}
					
					
				}else if(imgType==4){
					if(fenggeObj[fengge]==null){
						plupload.each(files,function(file) {
							var uptpName  =  $("#uptpName").val();
							if(null == uptpName || uptpName =="" || uptpName =="null" || uptpName =="undifined")
							{
								uptpName = file.name;
							}
							var sHtml = '<p class="name"><span>'+$('#fengge  option:selected').text()+'(<span id="fengsl'+fengge+'"></span>)</span></p><a href="javascript:void(0)" onclick="uphuandengpian(0,'+$("#fengge").val()+')" class="thumb"  data-toggle="modal"><img id="file-'
									+ file.id
									+ '" width="108" height="80" title="'+uptpName+'" alt="'+uptpName+'" ></a>'
							sHtml += '<p class="name">'
								sHtml +='<span>'+$('#fengge  option:selected').text()+'</span>'
									sHtml +='</p>';
							$imgContainer.append(sHtml);
							!function(f) {
								previewImage(f, function(imgsrc) {
									$('#file-' + f.id).attr("src", imgsrc);
								})
							}(file);

						});
						fenggeObj[fengge]=1;
						$("#fengsl"+fengge).html(fenggeObj[fengge]);
					}else{
						fenggeObj[fengge] +=1;
						$("#fengsl"+fengge).html(fenggeObj[fengge]);
					}
					
				}else{
					plupload.each(files,function(file) {
						var uptpName  =  $("#uptpName").val();
						if(null == uptpName || uptpName =="" || uptpName =="null" || uptpName =="undifined")
						{
							uptpName = file.name;
						}
						var sHtml = '<div style="width:120px;float:left"><a class="thumb"   data-action="edit" data-toggle="modal" style="position:relative"><img id="file-'
								+ file.id
								+ '" width="108" height="80"  onclick="imageMax(this)"  title="'+uptpName+'" alt="'+uptpName+'" ></a></div>';
						$imgContainer.append(sHtml);
						!function(f) {
							previewImage(f, function(imgsrc) {
								$('#file-' + f.id).attr("src", imgsrc);
							})
						}(file);

					});
				}
				
				setTimeout("uploaderDjwt.start()", 100); // IE8要缓一会再上传
				// uploader.start();
			},

			FileUploaded : function(up, file, resp) {
				var result = $.parseJSON(resp.response);
				var theForm = $("#lpimageForm #webImageofhouse_image_hidden");
				var topIndex = $("#houseExclusiveImgType").val();
				var jushi=$("#jushi").val();
				var imgType = $("#houseExclusiveImgType").val();
				$("#houseExclusiveImgType").attr("disabled","");
				var sHtml='';
				if(imgType==1){
					 sHtml = '<input type="hidden" id="txtExclusiveImgFileName' + houseExclusiveImgIndex
						+ '" name="imageUrl['+houseExclusiveImgIndex+'].img" value="'
						+ result.fileName + '"/><input type="hidden" id="txtIndex'+houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].statuss" value="1">'
						+ '<input type="hidden" id="txtType' + houseExclusiveImgIndex
						+ '" name="imageUrl['+houseExclusiveImgIndex+'].imgType" value="'
						+ $("#houseExclusiveImgType").val() + '"/><input type="hidden" id="txtshi' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].shi" value="'+jushi+'" />'+
						'<input type="hidden" id="txtwei' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].wei" value="'+$("#tpwei").val()+'" /><input type="hidden" id="txtting' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].ting" value="'+$("#tpting").val()+'" />';
				
				}else if(imgType==4){
					sHtml = '<input type="hidden" id="txtExclusiveImgFileName' + houseExclusiveImgIndex
					+ '" name="imageUrl['+houseExclusiveImgIndex+'].img" value="'
					+ result.fileName + '"/><input type="hidden" id="txtIndex'+houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].statuss" value="1">'
					+ '<input type="hidden" id="txtType' + houseExclusiveImgIndex
					+ '" name="imageUrl['+houseExclusiveImgIndex+'].imgType" value="'
					+ $("#houseExclusiveImgType").val() + '"/><input type="hidden" id="txtwfengge' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].fengge" value="'+$("#fengge").val()+'" />';
				}else{
					 sHtml = '<input type="hidden" id="txtExclusiveImgFileName' + houseExclusiveImgIndex
						+ '" name="imageUrl['+houseExclusiveImgIndex+'].img" value="'
						+ result.fileName + '"/><input type="hidden" id="txtIndex'+houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].statuss" value="1">'
						+ '<input type="hidden" id="txtType' + houseExclusiveImgIndex
						+ '" name="imageUrl['+houseExclusiveImgIndex+'].imgType" value="'
						+ $("#houseExclusiveImgType").val() + '"/>';
						
				}
				
				var theImageLi = $('#file-' + file.id).parent();
				
				if(imgType==2 ){
					theImageLi.append('<a href="javascript:void(0)" onclick="removeExclusiveImg('
							+ houseExclusiveImgIndex
							+ ',\''
							+ result.fileName
							+ '\', this,'+imgType+')">删除</a>');
				} else if(imgType==3){
					theImageLi.append('<a href="javascript:void(0)" onclick="removeExclusiveImg('
							+ houseExclusiveImgIndex
							+ ',\''
							+ result.fileName
							+ '\', this,'+imgType+')">删除</a>');
				}else if(imgType==5){
					theImageLi.append('<a href="javascript:void(0)" onclick="removeExclusiveImg('
							+ houseExclusiveImgIndex
							+ ',\''
							+ result.fileName
							+ '\', this,'+imgType+')">删除</a>');
				}
				theForm.append(sHtml);
				houseExclusiveImgIndex++;
				var jk = null;
				var jkk = JSON.stringify(tpDatas);
				var jkkk='';
				if(imgType==1){
					if(jkk=='[]'){
						 jkkk =jkk.substring(0,jkk.length-1);
					}else{
						 jkkk =jkk.substring(0,jkk.length-1)+",";
					}
					jkkk+= "{\"img\":\""+ result.fileName+"\",\"imgType\":"+$("#houseExclusiveImgType").val()+",\"id\":" +
							"\""+file.id+"\",\"shi\":"+jushi+",\"ting\":"+$("#tpting").val()+"," +
									"\"wei\":"+$("#tpwei").val()+"}";
					jk = JSON.parse(jkkk+"]");
				} else if(imgType==4){
					if(jkk=='[]'){
						 jkkk =jkk.substring(0,jkk.length-1);
					}else{
						 jkkk =jkk.substring(0,jkk.length-1)+",";
					}
					jkkk+= "{\"img\":\""+ result.fileName+"\",\"imgType\":"+$("#houseExclusiveImgType").val()+",\"id\":" +
							"\""+file.id+"\",\"fengge\":"+$("#fengge").val()+"}";
					jk = JSON.parse(jkkk+"]");
				}else{
					if(jkk=='[]'){
						 jkkk =jkk.substring(0,jkk.length-1);
					}else{
						 jkkk =jkk.substring(0,jkk.length-1)+",";
					}
					jkkk+= "{\"img\":\""+ result.fileName+"\",\"imgType\":"+$("#houseExclusiveImgType").val()+",\"id\":" +
							"\""+file.id+"\"}";
					jk = JSON.parse(jkkk+"]");
				}
				if(jk!=null&&jk!=''&&jk!='null'){
					tpDatas = jk;
				}
				
				
			},

			UploadComplete: function(up, files) {
				$("#houseExclusiveImgType").removeAttr("disabled");
				alert("上传成功!"); 
			},

			Error : function(up, err) {
				alert("上传失败：" + err.message);
			}
		}
	});

	//plupload中为我们提供了mOxie对象
	//有关mOxie的介绍和说明请看：https://github.com/moxiecode/moxie/wiki/API
	//如果你不想了解那么多的话，那就照抄本示例的代码来得到预览的图片吧
	function previewImage(file, callback) {// file为plupload事件监听函数参数中的file对象,callback为预览图片准备完成的回调函数
	if (!file || !/image\//.test(file.type))
		return; // 确保文件是图片
	if (file.type == 'image/gif') {// gif使用FileReader进行预览,因为mOxie.Image只支持jpg和png
		var fr = new mOxie.FileReader();
		fr.onload = function() {
			callback(fr.result);
			fr.destroy();
			fr = null;
		}
		fr.readAsDataURL(file.getSource());
	} else {
		var preloader = new mOxie.Image();
		preloader.onload = function() {
			//preloader.downsize(80, 80);// 先压缩一下要预览的图片,宽80，高80
			var imgsrc = preloader.type == 'image/jpeg' ? preloader
					.getAsDataURL('image/jpeg', 80) : preloader.getAsDataURL(); // 得到图片src,实质为一个base64编码的数据
			callback && callback(imgsrc); // callback传入的参数为预览图片的url
			preloader.destroy();
			preloader = null;
		};
		preloader.load(file.getSource());
	}
	}
});

var uploaderInited = false;
function initUploader(){
	if(!uploaderInited){
		uploaderDjwt.init();
		uploaderInited = true;
	}
}


function removeExclusiveImg(fileIndex, fileName, theLink,imgType) {
	if (confirm("您确认要删除该图片吗？")) {
		is=false;
		$.ajax({
			url : basepath + "/file!delete.action?fileName=" + fileName,
			dataType : "json",
			type : "POST",
			success : function(json) {
				if (json.code == "ok") {
					var theForm = $("#lpimageForm  #webImageofhouse_image_hidden");
					$(theLink).parent().parent().remove();
					tpDatas.splice(fileIndex,1);
					if(imgType==1 || imgType==4)
					{
						theForm.html("");
						houseExclusiveImgIndex=0;
						shiObj= [];
						fenggeObj=[];
						$("#ulHouseExclusiveFiles1 .panel-body").html("");
						$("#ulHouseExclusiveFiles2 .panel-body").html("");
						$("#ulHouseExclusiveFiles3 .panel-body").html("");
						$("#ulHouseExclusiveFiles4 .panel-body").html("");
						$("#ulHouseExclusiveFiles5 .panel-body").html("");
						setTypeImage(theForm,tpDatas);
					}else{
						theForm.find("#txtExclusiveImgFileName" + fileIndex).remove();
						theForm.find("#txtIndex" + fileIndex).remove();
						theForm.find("#txtType" + fileIndex).remove();
					}
					
					var shi = parent.document.getElementById("shitp").value;
					var fengge = parent.document.getElementById("fenggetp").value;
					
					shanchutp(tpDatas,shi,fengge);
					if(shi!=null&&shi!=''&&shi!=0){
						if(shiObj[shi]>0){
							shiObj[shi] =shiObj[shi];
						}else{
							$("#huandengpian").modal('hide');
						}
						$("#shiju"+shi).html(shiObj[shi]);
					}
					
					if(fengge!=null&&fengge!=''&&fengge!=0){
					
					if(fenggeObj[fengge]>0){
						fenggeObj[fengge] =fenggeObj[fengge];
					}else{
						$("#huandengpian").modal('hide');
					}
					$("#fengsl"+fengge).html(fenggeObj[fengge]);
					}
				} 
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("删除出错：" + errorThrown);
			}
		});
	}
	}

