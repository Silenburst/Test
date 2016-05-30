

var tpDatas = null;
function lptp(){
	$.ajax({
		url: basepath + "/cam/campus!lpxxlptp.action",
		dataType: "json", 
		type: "POST",
		data : {"lpid" : $("#tuplpid").val()},
		success: function(result){
			tpDatas = result;
			var shiObj = new Array();
			var fenggeObj = new Array();
			if(result !=null && result.length>0){
				
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
			       			 sHtml +='<a href="javascript:void(0)" onclick="huandengpian('+item.shi+',0)" class="thumb" data-action="edit" data-toggle="modal">'
			       				sHtml += '<img id="file-'+item.id+'" src="http://imgbms.xhjfw.com/'+item.img+'"  width="108" height="80" ></a>'
			       					sHtml += '<p class="name">'
									 sHtml +='<span>户型 ：'+item.shi+'室 '+item.ting+'厅'+item.wei+'卫</span>'
										sHtml +='</p></div>'
											
						shiObj[item.shi]=1;
			       		$("#shiju"+item.shi).html(1);
			       		} else {
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
			       						sHtml +='<a href="javascript:void(0)" onclick="huandengpian(0,'+item.fengge+')" class="thumb" data-action="edit" data-toggle="modal">'
				       					sHtml += '<img id="file-'+item.id+'" src="http://imgbms.xhjfw.com/'+item.img+'"  width="108" height="80" ></a>'
				       					sHtml += '<p class="name">'
										sHtml +='<span>'+fengname+'</span>'
										sHtml +='</p></div>'
											fenggeObj[item.fengge]=1;
			       						$("#fengsl"+item.fengge).html(fenggeObj[item.fengge]);
			       		}else{
			       			fenggeObj[item.fengge] +=1;
							$("#fengsl"+item.fengge).html(fenggeObj[item.fengge]);
			       		}
			       	}
			       	else{
			       		sHtml += ' <div style="width:120px;float:left"><a href="javascript:void(0)" class="thumb" data-action="edit" ><img onclick="imageMax(this)" id="file-'+item.id+'" src="http://imgbms.xhjfw.com/'+item.img+'"  width="108" height="80" ></a></div>'
			       	}
			       	
					$imgContainer.append(sHtml);
				})
			}
		}
	});
}


var home_slide_data
function  huandengpian(shi,fengge){
	var json='['
	$.each(tpDatas,function(i,info){
		if(info.imgType==1){
			if(info.shi==shi){
				json+='{"image":"http://imgbms.xhjfw.com/'+info.img+'","thumb":"http://imgbms.xhjfw.com/'+info.img+'","mark":"0"},';
			}
		}else if(info.imgType==4){
			if(info.fengge==fengge){
				json+='{"image":"http://imgbms.xhjfw.com/'+info.img+'","thumb":"http://imgbms.xhjfw.com/'+info.img+'","mark":"0"},';
			}
		}
		
	});
	json=json.substring(0, json.length-1);
	json +="]";
	var jsonStr=eval("("+json+")");
	 home_slide_data = jsonStr;
	$('.Homeslide').homeslide(home_slide_data, true, 3000);
	$("#huandengpian").modal('show');
}


