function uplptp(){
	$.ajax({
		url: basepath + "/cam/campus!lpxxlptp.action",
		dataType: "json", 
		type: "POST",
		data : {"lpid" : $("#tuplpid").val()},
		success: function(result){
		//var jk = JSON.stringify(result);
			tpDatas = result;
			//alert("result:"+tpDatas);
			var theForm = $("#lpimageForm #webImageofhouse_image_hidden");
			var topIndex = $("#houseExclusiveImgType").val();
			if(result !=null && result.length>0){
				setTypeImage(theForm,result);
			}
		}
	});
}

function setTypeImage(theForm,result)
{
	$.each(result,function(i,item){
		//设置全局下标
		
		var $imgContainer = null; 
       	if(item.imgType==3){//环境图
       		$imgContainer = $("#ulHouseExclusiveFiles3 .panel-body");
       	} else if(item.imgType==1){//户型图
       		$imgContainer = $("#ulHouseExclusiveFiles1 .panel-body");
       	}else if(item.imgType==2){//交通图
       		$imgContainer = $("#ulHouseExclusiveFiles2 .panel-body");
       	}else if(item.imgType==4){//样板图
       		$imgContainer = $("#ulHouseExclusiveFiles4 .panel-body");
       	}else if(item.imgType==5){//效果图
       		$imgContainer = $("#ulHouseExclusiveFiles5 .panel-body");
       	}
       	
       	var sHtml='';
       	if(item.imgType==1){
       		if(shiObj[item.shi]==null){
       		 sHtml += ' <div style="width:120px;float:left"><p class="name"><span>'+item.shi+'居室(<span id="shiju'+item.shi+'">1</span>)</span></p>'
       			 sHtml +='<a href="javascript:void(0)" onclick="uphuandengpian('+item.shi+',0)" class="thumb" data-action="edit" data-toggle="modal">'
       				sHtml += '<img id="file-'+item.id+'"  src="http://imgbms.xhjfw.com/'+item.img+'" width="108" height="80"></a>'
       					sHtml += '<p class="name">'
						 sHtml +='<span>户型 ：'+item.shi+'室 '+item.ting+'厅'+item.wei+'卫</span>'
							sHtml +='</p></div>';
								
			shiObj[item.shi]=1;
			var _sHtml = '<input type="hidden" id="txtExclusiveImgFileName' + houseExclusiveImgIndex
			+ '" name="imageUrl['+houseExclusiveImgIndex+'].img" value="'
			+ item.img + '"/><input type="hidden" id="txtIndex'+houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].statuss" value="1">'
			+ '<input type="hidden" id="txtType' + houseExclusiveImgIndex
			+ '" name="imageUrl['+houseExclusiveImgIndex+'].imgType" value="'
			+ item.imgType + '"/><input type="hidden" id="txtshi' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].shi" value="'+item.shi+'" />'+
			'<input type="hidden" id="txtwei' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].wei" value="'+item.wei+'" /><input type="hidden" id="txtting' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].ting" value="'+item.ting+'" />';
			theForm.append(_sHtml);
			$imgContainer.append(sHtml);
			$("#shiju"+item.shi).html(shiObj[item.shi]);
       		} else {
       			
       			var _sHtml = '<input type="hidden" id="txtExclusiveImgFileName' + i
				+ '" name="imageUrl['+houseExclusiveImgIndex+'].img" value="'
				+ item.img + '"/><input type="hidden" id="txtIndex'+houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].statuss" value="1">'
				+ '<input type="hidden" id="txtType' + i
				+ '" name="imageUrl['+houseExclusiveImgIndex+'].imgType" value="'
				+ item.imgType + '"/><input type="hidden" id="txtshi' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].shi" value="'+item.shi+'" />'+
				'<input type="hidden" id="txtwei' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].wei" value="'+item.wei+'" /><input type="hidden" id="txtting' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].ting" value="'+item.ting+'" />';
				theForm.append(_sHtml);
       			shiObj[item.shi] += 1;
       			$("#shiju"+item.shi).html(shiObj[item.shi]);
       		}
       	}else if(item.imgType==4){
       		if(fenggeObj[item.fengge]==null){
       				var fengname="";
       				switch (item.fengge) {
					case 1:fengname="新古典";
						break;
					case 2:fengname="美式";
					break;
					case 3:fengname="现代简约";
					break;
					case 4:fengname="公寓";
					break;
					case 3:fengname="地中海风格";
					break;
					case 3:fengname="厨卫";
					break;
					default:
						break;
					}
       						sHtml += ' <div style="width:120px;float:left"><p class="name"><span>'+fengname+'(<span id="fengsl'+item.fengge+'">1</span>)</span></p>'
       						sHtml +='<a href="javascript:void(0)" onclick="uphuandengpian(0,'+item.fengge+')" class="thumb" data-action="edit" data-toggle="modal">'
	       					sHtml += '<img id="file-'+item.id+'" src="http://imgbms.xhjfw.com/'+item.img+'" width="108" height="80"></a>'
	       					sHtml += '<p class="name">'
							sHtml +='<span>'+fengname+'</span>'
							sHtml +='</p></div>'
								fenggeObj[item.fengge]=1;
       						$imgContainer.append(sHtml);
    						var _sHtml = '<input type="hidden" id="txtExclusiveImgFileName' + i
    						+ '" name="imageUrl['+houseExclusiveImgIndex+'].img" value="'
    						+ item.img + '"/><input type="hidden" id="txtIndex'+houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].statuss" value="1">'
    						+ '<input type="hidden" id="txtType' + i
    						+ '" name="imageUrl['+houseExclusiveImgIndex+'].imgType" value="'
    						+ item.imgType + '"/><input type="hidden" id="txtfengge' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].fengge" value="'+item.fengge+'" />';
    						theForm.append(_sHtml);
    						$("#fengsl"+item.fengge).html(fenggeObj[item.fengge]);
       		}else{
       			var _sHtml = '<input type="hidden" id="txtExclusiveImgFileName' + i
				+ '" name="imageUrl['+houseExclusiveImgIndex+'].img" value="'
				+ item.img + '"/><input type="hidden" id="txtIndex'+houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].statuss" value="1">'
				+ '<input type="hidden" id="txtType' + i
				+ '" name="imageUrl['+houseExclusiveImgIndex+'].imgType" value="'
				+ $("#houseExclusiveImgType").val() + '"/><input type="hidden" id="txtfengge' + houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].fengge" value="'+item.fengge+'" />';
				theForm.append(_sHtml);
				fenggeObj[item.fengge] +=1;
				$("#fengsl"+item.fengge).html(fenggeObj[item.fengge]);
       		}
       		
       	}
       	else{
       		sHtml += ' <div style="width:120px;float:left"><a class="thumb"   data-action="edit" data-toggle="modal" style="position:relative" ><img onclick="imageMax(this)"  id="file-'+item.id+'" src="http://imgbms.xhjfw.com/'+item.img+'" width="108" height="80" ></a></div>';
			var _sHtml = '<input type="hidden" id="txtExclusiveImgFileName' + i
			+ '" name="imageUrl['+houseExclusiveImgIndex+'].img" value="'
			+ item.img + '"/><input type="hidden" id="txtIndex'+houseExclusiveImgIndex+'" name="imageUrl['+houseExclusiveImgIndex+'].statuss" value="1">'
			+ '<input type="hidden" id="txtType' + i
			+ '" name="imageUrl['+houseExclusiveImgIndex+'].imgType" value="'
			+ item.imgType + '"/>';
			$imgContainer.append(sHtml);
			var theImageLi = $('#file-' + item.id).parent();
			theImageLi.append('<a href="javascript:void(0)" onclick="removeExclusiveImg('
					+ houseExclusiveImgIndex
					+ ',\''
					+ item.img
					+ '\', this,'+item.imgType+')">删除</a>');
			theForm.append(_sHtml);
       	}
		houseExclusiveImgIndex++;
	})
}
