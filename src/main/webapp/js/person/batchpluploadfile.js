//plupload 组件的相对根路径
var plupload_basePath=basepath+"/js/plupload";
var houseExclusiveImgIndex = 0;
//图片上传组件
	var uploaderDjwt = new plupload.Uploader({
   runtimes : 'html5,flash,silverlight,html4',
    
   browse_button : 'fkPickfiles', // you can pass in id...
   container: document.getElementById('fkContainer'), // ... or DOM Element itself
    
   //url : 'servlet/fileUpload',
	url : basepath + '/file!upload.action',
	// Resize images on clientside if we can
	resize : {
		width : 800, 
		height : 640, 
		quality : 90,
		crop: false // false:等比例缩放 ,  true:非等比例缩放
	},
    
   filters : {
       max_file_size : '5mb',
       mime_types: [
           {title : "图片文件", extensions : "jpg,gif,png,xls,doc"}
       ]
   },

   // Flash settings
   flash_swf_url : plupload_basePath+'/Moxie.swf',

   // Silverlight settings
   silverlight_xap_url : plupload_basePath+'/Moxie.xap',
    
   init: {
       
       BeforeUpload:function(up,file){

       }, 

       FilesAdded: function(up, files) {
       	
   		$imgContainer = $("#ulHouseExclusiveFiles1");
       	    	
       	plupload.each(files,function(file) {
			var sHtml = ' <div class="col-md-3 col-sm-4 col-xs-12"><div class="album-image"><img id="file-'
					+ file.id
					+ '" width="200" height="150"  class="album-image"></div></div>';
			$imgContainer.append(sHtml);
			!function(f) {
				previewImage(f, function(imgsrc) {
					$('#file-' + f.id).attr("src", imgsrc);
				});
			}(file);

		});
           setTimeout("uploaderDjwt.start()",100);	//IE8要缓一会再上传 
           //uploader.start();
       },
       
       FileUploaded : function(up, file, resp) {
			var result = $.parseJSON(resp.response);
			var theForm = $("#batchFanghaoForm #webImageofhouse_image_hidden");
			$("#houseExclusiveImgType").attr("disabled","");
			var sHtml = '<input type="hidden" id="txtExclusiveImgFileName' + houseExclusiveImgIndex+ '" name="condition.fanghaoImg['+houseExclusiveImgIndex+'].imgPath" value="'
			+ result.fileName + '"/><input type="hidden" id="txtIndex'+houseExclusiveImgIndex+'" name="condition.fanghaoImg['+houseExclusiveImgIndex+'].statuss" value="1">'
			+ '<input type="hidden" id="txtType' + houseExclusiveImgIndex
			+ '" name="condition.fanghaoImg['+houseExclusiveImgIndex+'].type" value="1"/>';
			//名称和删除按钮
			var theImageLi = $('#file-' + file.id).parent().parent();
		//	theImageLi.append('<a href="#" class="name"><span>'+result.fileName+'</span></a>');
			theImageLi.append('<p class="name"><a href="javascript:void(0)"  onclick="removeExclusiveImg('
					+ houseExclusiveImgIndex
					+ ',\''
					+ result.fileName
					+ '\', this)" >删除</p>');
			// alert(sHtml);
			theForm.append(sHtml);
			houseExclusiveImgIndex++;
		},

		UploadComplete: function(up, files) {
//			$("#houseExclusiveImgType").removeAttr("disabled");
			alert("上传成功!"); 
		},



       Error: function(up, err) {
       	alert("上传失败：" + err.message);
       }
   }
});

function removeExclusiveImg(fileIndex, fileName, theLink){
	if(confirm("您确认要删除该图片吗？")){
		$.ajax({
			url: basepath+"/file!delete.action?fileName="+fileName ,
			dataType: "json", 
			type: "POST",
			success: function(json){
				if(json.code=="ok"){
					var theForm = $("#batchFanghaoForm  #webImageofhouse_image_hidden");
					$(theLink).parent().parent().remove();
					theForm.find("#txtExclusiveImgFileType"+fileIndex).remove();
					theForm.find("#txtExclusiveImgFileName"+fileIndex).remove();
					theForm.find("#txtIndex" + fileIndex).remove();
					theForm.find("#txtType" + fileIndex).remove();
//					$("#tupianming").val("");
				//	houseExclusiveImgIndex--;
				} else {
					
				}
	    	},
	    	error : function(XMLHttpRequest, textStatus, errorThrown) {
	    		alert("删除出错：" + errorThrown);
			}
		});
	}
}

//plupload中为我们提供了mOxie对象
//有关mOxie的介绍和说明请看：https://github.com/moxiecode/moxie/wiki/API
//如果你不想了解那么多的话，那就照抄本示例的代码来得到预览的图片吧
function previewImage(file, callback) {//file为plupload事件监听函数参数中的file对象,callback为预览图片准备完成的回调函数 
   if (!file || !/image\//.test(file.type)) return; //确保文件是图片
   if (file.type == 'image/gif') {//gif使用FileReader进行预览,因为mOxie.Image只支持jpg和png
       var fr = new mOxie.FileReader();
       fr.onload = function () {
           callback(fr.result);
           fr.destroy();
           fr = null;
       }
       fr.readAsDataURL(file.getSource());
   } else {
       var preloader = new mOxie.Image();
       preloader.onload = function () {
           preloader.downsize(80, 80);//先压缩一下要预览的图片,宽80，高80
           var imgsrc = preloader.type == 'image/jpeg' ? preloader.getAsDataURL('image/jpeg', 80) : preloader.getAsDataURL(); //得到图片src,实质为一个base64编码的数据
           callback && callback(imgsrc); //callback传入的参数为预览图片的url
           preloader.destroy();
           preloader = null;
       };	
       preloader.load(file.getSource());
   }
}

uploaderDjwt.init();



function validForm(){
	//验证是否还有图片未上传完成
	var userChangeFileNum=$("div [id*='file-']").length;//用户选择的图片数
	var uploadCompleteFileNum=$("div [id*='txtExclusiveImgFileName']").length;//已上传完成的图片数
	if(userChangeFileNum!=uploadCompleteFileNum){
		alert("您有尚未成功上传的图片，请稍后点击保存！");
		return false;
	}
	return true;
}