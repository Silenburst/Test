<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %> 
<%  String basePath = request.getContextPath(); %>
<script>
	$("#fwzt").html("<option>"+fwztStr+"</option>");
	$("#isHavingStr").html("<option>"+isHavingStr+"</option>")
	$("#houselevel").html("<option>"+houselevelStr+"</option>")
</script>
											<div class="panel-heading">

												<div class="panel-options" style="float: left;">

													<ul class="nav nav-tabs">
														<li class="active">
															<a href="#tab-1" data-toggle="tab">委托出租</a>
														</li>
														<li>
															<a href="#tab-2" data-toggle="tab">委托出售</a>
														</li>
													</ul>

												</div>
											</div>

											<div class="panel-body">

												<div class="tab-content">
													<div class="tab-pane active" id="tab-1">

														<form role="form" class="form-horizontal">
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">委托类型</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" readonly=""  id="delegateType1" value="${wt.delegateTypeName}" placeholder="">
																</div>

															</div>

															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">星级房源</label>

																<div class="col-sm-8">
																	<select class="form-control" disabled id="houselevel1">
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">委托来源</label>

																<div class="col-sm-4">
																	<select class="form-control" disabled>
																		<option>${wt.delegateSourceParentIdStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
																<div class="col-sm-4">
																	<select class="form-control" disabled>
																		<option>${wt.delegateSourceIdStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">委托期限</label>

																<div class="col-sm-8">
																	<div class="input-group">
																		<input type="text" class="form-control" id="delegateLimit1" value="${wt.delegateLimit}" readonly="">
																		<span class="input-group-addon">
															天
														</span>
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">房屋现状</label>

																<div class="col-sm-8">
																	<select class="form-control" disabled id="fwzt">
																		<option>${xhjLpfanghao.fwzt}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">可看房时间</label>

																<div class="col-sm-8">
																	<input type="text" class="form-control" id="showingTime1" value="${wt.showingTimeStr}" readonly="">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">可入住时间</label>

																<div class="col-sm-8">
																	<input type="text" class="form-control" readonly="" id="occupancyTime1" value="${occupancyTime1}">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">付佣比例</label>

																<div class="col-sm-8">
																	<input type="text" class="form-control" readonly="" id="commissionRate1" value="${wt.commissionRateStr}">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">税费</label>

																<div class="col-sm-8">
																	<input type="text" class="form-control" readonly="" id="taxAmount1" value="${wt.taxAmounStr}">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">付税类型</label>

																<div class="col-sm-8">
																	<select class="form-control" disabled id="taxingType1">
																		<option>${wt.taxingTypeName}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">业主付税</label>

																<div class="col-sm-8">
																	<input type="text" class="form-control" readonly="" id="ownerPayTax1" value="${wt.ownerPayTaxStr}">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">业主付佣</label>

																<div class="col-sm-8">
																<input type="text" class="form-control" readonly="" id="ownerPaymentType1" value="${wt.ownerPaymentTypeStr}">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">委托日期</label>

																<div class="col-sm-8">
																	<input type="text" class="form-control" readonly="" id="delegateDate1" value="${delegateDate1}">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">租赁类型</label>

																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<option>${wt.rentingTypeStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">托管意向</label>

																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<option>${wt.delegatePurposeStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">租赁方式</label>

																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<option>${wt.rentingWayStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">支付方式</label>

																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<option>${wt.payingTypeStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">月租单价</label>

																<div class="col-sm-8">
																	<div class="input-group">
																		<input type="text" class="form-control" readonly="" value="${wt.price}">
																		<span class="input-group-addon">
															元/月
														</span>
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">总租金</label>

																<div class="col-sm-8">
																	<div class="input-group">
																		<input type="text" class="form-control" readonly="" value="${wt.totalPrice}">
																		<span class="input-group-addon">
															元
														</span>
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">续约折扣</label>

																<div class="col-sm-8">
																	<input type="text" class="form-control" readonly="" value="${wt.discountOfRenewal}">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">违约金</label>

																<div class="col-sm-8">
																	<div class="input-group">
																		<input type="text" class="form-control" readonly="" value="${wt.penaltyAmount}">
																		<span class="input-group-addon">
															元
														</span>
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">首次出租</label>

																<div class="col-sm-8">
																	<select class="form-control" disabled>
																	<s:if test="#wt.isFirstTimeOfRenting==0">
																		<option>否</option>
																		</s:if>
																		<s:if test="#wt.isFirstTimeOfRenting==1">
																		<option>是</option>
																		</s:if>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">租赁起止日期</label>

																<div class="col-sm-4">
																	<input type="text" class="form-control" readonly="" value="${wt.rentBeginDate}">
																</div>
																<div class="col-sm-4">
																	<input type="text" class="form-control" readonly="" value="${wt.rentEndDate}">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">押</label>

																<div class="col-sm-3">
																	<input type="text" class="form-control" readonly="" value="${wt.mortgageRate}">
																</div>
																<label class="col-sm-2 control-label" style="text-align: center;" for="field-3">付</label>
																<div class="col-sm-3">
																	<input type="text" class="form-control" readonly="" value="${wt.payRate}">
																</div>
															</div>

														</form>

													</div>
													<div class="tab-pane" id="tab-2">

														<form role="form" class="form-horizontal">
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">委托类型</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" readonly="" id="field-3" placeholder="" value="${cs.delegateTypeName}">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">总价</label>
																<div class="col-sm-8">
																	<div class="input-group">
																		<input type="text" class="form-control" readonly="" value="${cs.totalPrice}">
																		<span class="input-group-addon">
															万元
														</span>
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">星级房源</label>
																<div class="col-sm-8">
																	<select class="form-control" disabled id="houselevelcs">
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">委托来源</label>
																<div class="col-sm-4">
																	<select class="form-control" disabled>
																		<option>${cs.delegateSourceParentIdStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
																<div class="col-sm-4">
																	<select class="form-control" disabled>
																		<option>${cs.delegateSourceIdStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">房屋现状</label>
																<div class="col-sm-8">
																	<select class="form-control" disabled id="fwzt">
																		<option>${xhjLpfanghao.fwzt}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">可看房时间</label>
																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<option>${cs.showingTimeStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">可入住时间</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" readonly="" value="${occupancyTime2}">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">委托期限</label>
																<div class="col-sm-8">
																	<div class="input-group">
																		<input type="text" class="form-control" readonly="" value="${cs.delegateLimit}">
																		<span class="input-group-addon">
																			天
																		</span>
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">税费</label>
																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<option>${cs.taxAmounStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">个税</label>
																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<option></option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">付税类型</label>
																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<option>${wt.taxingTypeName}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">业主付税</label>
																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<option>${cs.ownerPayTaxStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">抵押</label>
																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<s:if test="#cs.isMortgage==0">
																		<option>不抵押</option>
																		</s:if>
																		<s:if test="#cs.isMortgage==1">
																		<option>已抵押</option>
																		</s:if>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">满五年</label>
																<div class="col-sm-8">
																	<select class="form-control" disabled id="isHavingStr">
																		<option>${xhjLpfanghao.isHavingStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">业主付佣</label>
																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<option>${cs.ownerPaymentTypeStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">付佣比例</label>
																<div class="col-sm-8">
																	<select class="form-control" disabled>
																		<option>${cs.commissionRateStr}</option>
																		<option></option>
																		<option></option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">委托日期</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" readonly="" value="${delegateDate2}">
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" for="field-3">出售原因</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" readonly="">
																</div>
															</div>
														</form>
													</div>
												</div>

											</div>
