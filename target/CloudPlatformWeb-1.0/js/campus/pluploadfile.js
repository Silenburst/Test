//plupload 组件的相对根路径
var plupload_basePath = basepath + "/js/plupload";
var houseExclusiveImgIndex = 0;
// 图片上传组件
var uploaderDjwt = new plupload.Uploader({
	runtimes : 'html5,flash,silverlight,html4',
	browse_button : 'fkPickfiles', // you can pass in id...
	container : document.getElementById('fkContainer'), // ... or DOM  Element itself
	// url : 'servlet/fileUpload',
	url : basepath + '/file!upload.action',
	//url : cloudPlatformUrl+"/services/newenv/lpzd/crawl/uploadFile/",
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

			//var $imgContainer = $("#ulHouseExclusiveFiles0 .panel-body");
			var $imgContainer = $("#fkContainer").parent();

			plupload.each(files,function(file) {
				var sHtml = ' <div class="album-image col-lg-2" id="img'+file.id+'"><img id="file-'
					+ file.id
					+ '" width="200" height="150" class="img-thumbnail"></div>';
				$imgContainer.append(sHtml);
				!function(f) {
					previewImage(f, function(imgsrc) {
						$('#file-' + f.id).attr("src", imgsrc);
					})
				}(file);

			});


			setTimeout("uploaderDjwt.start()", 100); // IE8要缓一会再上传
			// uploader.start();
		},

		FileUploaded : function(up, file, resp) {
			var result = $.parseJSON(resp.response);
			//var theForm = $("#fanghaoForm #webImageofhouse_image_hidden");
			var theForm = $("#postform");
			var sHtml='';
			sHtml += "<input type='hidden' name='s_picture' value='"+result.fileName+"' id='pic"+file.id+"'/>";

			var theImageLi = $('#file-' + file.id).parent();
			theImageLi.append('<div class="text-center"><a href="javascript:void(0)" onclick="deleteImg(\''+file.id+'\')">删除</a></div>');
			var coverButton = '<div style=" position:absolute; bottom:20px;  height:40px; width:100px;border-bottom-right-radius: 6px; border-bottom-left-radius: 6px;">'
				+ '<button type="button" onclick="setCover(\''+result.fileName+'\',this);" class="coverButton" id="'+result.fileName+'">设为封面</button></div>';
			theImageLi.append(coverButton);
			theForm.append(sHtml);
			houseExclusiveImgIndex++;
		},

		UploadComplete: function(up, files) {
			alert("上传成功!");
		},

		Error : function(up, err) {
			alert("上传失败：" + err.message);
		}
	}
});


var uploaderDjwt1 = new plupload.Uploader({
	runtimes : 'html5,flash,silverlight,html4',
	browse_button : 'fkPickfiles1', // you can pass in id...
	container : document.getElementById('fkContainer1'), // ... or DOM  Element itself
	url : basepath + '/file!upload.action',
	resize : {
		width : 800,
		height : 640,
		quality : 90,
		crop : false
	},
	filters : {
		max_file_size : '5mb',
		mime_types : [ {
			title : "图片文件",
			extensions : "jpg,gif,png,xls,doc"
		} ]
	},
	flash_swf_url : plupload_basePath + '/Moxie.swf',
	silverlight_xap_url : plupload_basePath + '/Moxie.xap',
	init : {
		BeforeUpload : function(up, file) {
		},
		FilesAdded : function(up, files) {
			var $imgContainer1 = $("#fkContainer1").parent();
			plupload.each(files,function(file) {
				var sHtml = ' <div class="album-image col-lg-2" id="img'+file.id+'"><img id="file-'
					+ file.id
					+ '" width="200" height="150" class="img-thumbnail"></div>';
				$imgContainer1.append(sHtml);
				!function(f) {
					previewImage(f, function(imgsrc) {
						$('#file-' + f.id).attr("src", imgsrc);
					})
				}(file);

			});
			setTimeout("uploaderDjwt1.start()", 100); // IE8要缓一会再上传
		},
		FileUploaded : function(up, file, resp) {
			var result = $.parseJSON(resp.response);
			var theForm = $("#postform");
			var sHtml='';
			sHtml += "<input type='hidden' name='f_picture' value='"+result.fileName+"' id='pic"+file.id+"'/>";

			var theImageLi = $('#file-' + file.id).parent();
			theImageLi.append('<div class="text-center"><a href="javascript:void(0)" onclick="deleteImg(\''+file.id+'\')">删除</a></div>');
			var coverButton = '<div style=" position:absolute; bottom:20px;  height:40px; width:100px;border-bottom-right-radius: 6px; border-bottom-left-radius: 6px;">'
				+ '<button type="button" onclick="setCover(\''+result.fileName+'\',this);" class="coverButton" id="'+result.fileName+'">设为封面</button></div>';
			theImageLi.append(coverButton);
			theForm.append(sHtml);
			houseExclusiveImgIndex++;
		},
		UploadComplete: function(up, files) {
			alert("上传成功!");
		},
		Error : function(up, err) {
			alert("上传失败：" + err.message);
		}
	}
});



var uploaderDjwt2 = new plupload.Uploader({
	runtimes : 'html5,flash,silverlight,html4',
	browse_button : 'fkPickfiles2', // you can pass in id...
	container : document.getElementById('fkContainer2'), // ... or DOM  Element itself
	url : basepath + '/file!upload.action',
	resize : {
		width : 800,
		height : 640,
		quality : 90,
		crop : false
	},
	filters : {
		max_file_size : '5mb',
		mime_types : [ {
			title : "图片文件",
			extensions : "jpg,gif,png,xls,doc"
		} ]
	},
	flash_swf_url : plupload_basePath + '/Moxie.swf',
	silverlight_xap_url : plupload_basePath + '/Moxie.xap',
	init : {
		BeforeUpload : function(up, file) {
		},
		FilesAdded : function(up, files) {
			var $imgContainer2 = $("#fkContainer2").parent();
			plupload.each(files,function(file) {
				var sHtml = ' <div class="album-image col-lg-2" id="img'+file.id+'"><img id="file-'
					+ file.id
					+ '" width="200" height="150" class="img-thumbnail"></div>';
				$imgContainer2.append(sHtml);
				!function(f) {
					previewImage(f, function(imgsrc) {
						$('#file-' + f.id).attr("src", imgsrc);
					})
				}(file);

			});
			setTimeout("uploaderDjwt2.start()", 100); // IE8要缓一会再上传
		},

		FileUploaded : function(up, file, resp) {
			var result = $.parseJSON(resp.response);
			var theForm = $("#postform");
			var sHtml='';
			sHtml += "<input type='hidden' name='x_picture' value='"+result.fileName+"' id='pic"+file.id+"'/>";
			var theImageLi = $('#file-' + file.id).parent();
			theImageLi.append('<div class="text-center"><a href="javascript:void(0)" onclick="deleteImg(\''+file.id+'\')">删除</a></div>');
			var coverButton = '<div style=" position:absolute; bottom:20px;  height:40px; width:100px;border-bottom-right-radius: 6px; border-bottom-left-radius: 6px;">'
				+ '<button type="button" onclick="setCover(\''+result.fileName+'\',this);" class="coverButton" id="'+result.fileName+'">设为封面</button></div>';
			theImageLi.append(coverButton);
			theForm.append(sHtml);
			houseExclusiveImgIndex++;
		},
		UploadComplete: function(up, files) {
			alert("上传成功!");
		},
		Error : function(up, err) {
			alert("上传失败：" + err.message);
		}
	}
});





function removeExclusiveImg(inputName, fileName, theLink) {
	if (confirm("您确认要删除该图片吗？")) {
		$.ajax({
			url : basepath + "/file!delete.action?fileName=" + fileName,
			dataType : "json",
			type : "POST",
			success : function(json) {
				if (json.code == "ok") {
					var theForm = $("#postform");
					$(theLink).parent().parent().remove();
					theForm.find("input[value='"+fileName+"']").remove();
				} else {

				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("删除出错：" + errorThrown);
			}
		});
	}
}

// plupload中为我们提供了mOxie对象
// 有关mOxie的介绍和说明请看：https://github.com/moxiecode/moxie/wiki/API
// 如果你不想了解那么多的话，那就照抄本示例的代码来得到预览的图片吧
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
			preloader.downsize(80, 80);// 先压缩一下要预览的图片,宽80，高80
			var imgsrc = preloader.type == 'image/jpeg' ? preloader
				.getAsDataURL('image/jpeg', 80) : preloader.getAsDataURL(); // 得到图片src,实质为一个base64编码的数据
			callback && callback(imgsrc); // callback传入的参数为预览图片的url
			preloader.destroy();
			preloader = null;
		};
		preloader.load(file.getSource());
	}
}

function deleteImg(object){
	$("#img" +object).css("display","none"); 
	$("#pic" +object).remove(); 
}



uploaderDjwt.init();
uploaderDjwt1.init();
uploaderDjwt2.init();