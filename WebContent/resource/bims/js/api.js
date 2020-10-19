/**
 * 各自页面涉及到的接口api写在各自模块，互不影响。
 * 根据实际API编写,格式如下
 * "menus": "/resource/menus/list",//GET:获取全部菜单
 * "menu":"/resource/menus",//GET:获取菜单详情；POST:新增菜单；PUT:修改菜单；DELETE:删除菜单
 
 */

var BIMSapi = {
	"orgUserList": "/fin-user/org/user/list", //根据用户查询本组织及下属组织信息
	"userUserFinanceList": "/fin-user/user/finance/list", //获取当前用户下所有财务中心
	"crmContactsCall": "/customer-gate/getCrmContactsCall", //获取联系人信息
	"publicCurrency": "/public/currency",
	"productLineList":"/public/productLine/list",//查询所有产品线
	"authorityUserProduct":"/fin-user/authority/user/product",//产品线用户绑定配置
	"productSubUser":"/fin-user/product/sub/user",//已配置产品线
	 //文件删除
      "deleteFile" : "/public/sysFile/delete",

	"menuList": "/fin-user/resource/menu/list", //权限资源菜单
	"userAccount": "/fin-user/user/account", //查询子账户
	"userProduct": "/fin-user/product/user", //根据用户查询产品线
	"invoiceType": "/customer-gate/getInvoiceType", //获取发票类型
	"querySysCmpOrg": "/fin-user/org/user/company/list", //获取当前用户公司及以下的组织

	"getWorkflowTaskUser": "/bpm-task/bpm/definition/selectTaskUser", //查询是否需要走工作流以及指派人
	"assignTask": "/bpm-task/bpm/task/assignTask", //转办

	"btnPermissionList": "/fin-user/resource/btn/list", //按钮权限查询
	/**********************************财务开始*************************************/

	/*****************收款管理开始***********************/
	"preMatchTransListQuery": "/finance/receipt/preMatchTransListQuery", //post 待匹配精准
	"bluMatchTransListQuery": "/finance/receipt/bluMatchTransListQuery", //post 待匹配模糊
	"thirdPartyApproveListQuery": "/finance/receipt/thirdPartyApproveListQuery", //post 第三方付款审批
	"bankTransListQuery": "/finance/receipt/bankTransListQuery", //post 流水列表（全流水）
	"bankTransMatchListQuery": "/finance/receipt/bankTransMatchListQuery", //post 流水列表（全匹配）
	"matchedTransListQuery": "/finance/receipt/matchedTransListQuery", //post 已匹配流水
	"releaseTransQuery": "/finance/receipt/releaseTransQuery", //post 释放流水审核列表
	"refundTransListQuery": "/finance/receipt/refundTransListQuery", //post 退款审批 
	"getBankTransInfoDetail": "/finance/receipt/getBankTransInfoDetail", //POST 流水信息查询
	"reqReleaseTransApply": "/finance/receipt/reqReleaseTransApply", //POST 释放匹配流水申请请求
	"claimBankExplainListQuery": "/finance/receipt/claimBankExplainListQuery", // POST 银行流水认领记录列表
	"reqMatchTransBusiness": "/finance/receipt/reqMatchTransBusiness", //POST 匹配流水请求
	"matchServiceItemListQuery": "/finance/receipt/matchServiceItemListQuery", //POST 按照服务项查询待匹配服务项
	"matchInvoiceNoListQuery": "/finance/receipt/matchInvoiceNoListQuery", //POST 按照发票号查询待匹配服务项
	"bankTransAdd": "/finance/receipt/bankTransAdd", //POST 银行流水新建入账
	"reqInvoiceInfoQuery": "/finance/receipt/reqInvoiceInfoQuery", //POST 服务项开票信息列表
	"claimBankExplain": "/finance/receipt/claimBankExplain", //POST 流水认领
	"bankTransDelete": "/finance/receipt/bankTransDelete", //DELETE  流水删除
	"refundTransApply": "/finance/receipt/refundTransApply", //POST 流水退款申请
	"refundTransApprove": "/finance/receipt/refundTransApprove", //POST 流水退款审核
	"reqRefundTransApprove": "/finance/receipt/reqRefundTransApprove", //POST 流水退款审核请求
	"releaseTransApply": "/finance/receipt/releaseTransApply", //POST 流水释放服务项申请提交
	"matchTransBusiness": "/finance/receipt/matchTransBusiness", //POST 匹配流水
	"reqReleaseTransApprove": "/finance/receipt/reqReleaseTransApprove", //POST 释放匹配流水审核请求
	"releaseTransApprove": "/finance/receipt/releaseTransApprove", //POST 释放匹配流水审核提交
	"reqThirdPartyApprove": "/finance/receipt/reqThirdPartyApprove", //POST 第三方付款审批请求
	"thirdPartyApprove": "/finance/receipt/thirdPartyApprove", //POST 	第三方付款审批提交
	"urgeCollectListQuery": "/finance/receipt/urgeCollectListQuery", //POST 催收记录列表
	"urgeDetailListQuery": "/finance/receipt/urgeDetailListQuery", //POST 催收列表
	"urgeCollectBusiness": "/finance/receipt/urgeCollectBusiness", //POST 催收
	"bankTransImport": "/finance/receipt/bankTransImport", //POST 银行流水导入
	"thirdPartyPassApprove": "/finance/receipt/thirdPartyPassApprove", //POST 第三方付款审批通过提交
	"thirdPartyRejectApprove": "/finance/receipt/thirdPartyRejectApprove", //POST 第三方付款审批驳回提交
	"sysCodeListQuery": "/finance/manage/sysCodeListQuery", //清算系统代码查询
	"publicSysFileListQuery": "/finance/receipt/publicSysFileListQuery", //文件列表查询
	"matchAccountListQuery": "/finance/receipt/matchAccountListQuery", //按对账单查询服务项列表
	"getExchangeRateInfo": "/finance/manage/getExchangeRateInfo", //汇率
	"matchAccountQuery": "/finance/receipt/matchAccountQuery", //查询对账单（匹配）
	"matchStatementTransBusiness": "/finance/receipt/matchStatementTransBusiness", //POST 按对账单匹配
	"modelDownload":"/finance/file/import/bank/download", //get 导入文件模板下载

	"upload": "/public/upload",
	"download": "/public/download",
	/*****************收款管理结束***********************/

	/*****************外付管理开始***********************/
	"waitOutPayListQuery": "/finance/outpay/waitOutPayListQuery", //POST 待结外付管理列表
	"queryOutPayLedger":"/finance/outpay/queryOutPayLedger",//POST 外付记录列表
	"outPayApplyAdmitListQuery": "/finance/outpay/outPayApplyAdmitListQuery", //POST  待结外付审核列表(待提交))
	"outPayApplyConfirmListQuery": "/finance/outpay/outPayApplyConfirmListQuery", //POST 待结外付审核列表(待支付确认)
	"outPayLFinishistQuery": "/finance/outpay/outPayLFinishistQuery", //POST 已结外付列表
	"transSettlementListQuery": "/finance/outpay/transSettlementListQuery", //POST 清算流水列表
	"getOutPayInfoDetail": "/finance/outpay/getOutPayInfoDetail", // GET 外付信息查询
	"outPayApplyApprovePage": "/finance/outpay/outPayApplyApprovePage", //POST 外付申请审核请求公共弹出页面
	"reqOutPayApply": "/finance/outpay/reqOutPayApply", //POST 外付申请请求
	"waitOutPayListCountQuery": "/finance/outpay/waitOutPayListCountQuery", //POST 待结外付费用总计
	"outPayApplyDirectAdmit": "/finance/outpay/outPayApplyDirectAdmit", //POST 外付申请直接提交
	"outPayApplySave": "/finance/outpay/outPayApplySave", //POST 外付申请保存
	"outPayDetailApply": "/finance/outpay/outPayDetailApply", //POST 外付详情编辑请求
	"outPayApplyDelete": "/finance/outpay/outPayApplyDelete", //POST 外付直接删除
	"outPayApplyUpdate": "/finance/outpay/outPayApplyUpdate", //POST 外付待提交更新
	"outPayApplyAdmit": "/finance/outpay/outPayApplyAdmit", //POST 待结外付直接提交
	"outPayListCountQuery": "/finance/outpay/outPayListCountQuery", //POST 待结外付管理列表(统计)
	"outPayApplyAdmitListCountQuery": "/finance/outpay/outPayApplyAdmitListCountQuery", //POST 待提交(统计)
	"transSettlementListCountQuery": "/finance/outpay/transSettlementListCountQuery", //POST 清算流水列表
	"batchOutPayListQuery":"/finance/batchOutpay/batchOutPayListQuery", //POST 结算单列表
	"batchOutPayDetailApply":"/finance/batchOutpay/batchOutPayDetailApply", //POST 结算单编辑请求
	"batchOutPayDetailCostListQuery":"/finance/batchOutpay/batchOutPayDetailCostListQuery",//POST 结算单详情成本列表
	"batchOutPayApplyAdmit":"/finance/batchOutpay/batchOutPayApplyAdmit", //POST 
	"batchOutPayReturn":"/finance/batchOutpay/batchOutPayReturn", //POST 
	/*****************外付管理结束***********************/

	/*****************开票管理开始***********************/
	// 待开票申请
	"userUserFinanceList": "/fin-user/user/finance/list", //获取当前用户下所有财务中心
	"waitingForInvoiceList": "/finance/invoice/waitInvoiceListQuery", // 待开票申请列表查询 POST
	"queryInvoiceBal": "/finance/invoice/reqWaitInvoiceTotalAmount", // 获取待开票金额
	"invoiceRequest": "/finance/invoice/reqInvoiceApply", //开票申请请求 POST
	//获取联系人信息
	"crmContactsCall": "/customer-gate/getCrmContactsCall",
	//获取客户开票信息
	"InvoiceCall": "/customer-gate/getInvoiceCall",
	//新增客户开票信息
	"addInvoiceCall": "/customer-gate/addInvoiceCall",

	"invoiceType": "/customer-gate/getInvoiceType", //获取发票类型
	"uploadFile": "", // 上传文件
	"downloadFile": "", // 下载文件
	"viewServiceAmountInfo": "/finance/invoice/reqMatchInfoQuery", // 查看是否到款记录列表
	"saveInvoice": "/finance/invoice/invoiceApplySave", //开票申请保存 POST
	"commitInvoice": "/finance/invoice/invoiceApplyAdmit", //开票申请提交
	"accountStatementId": "/finance/invoice/reqInvoiceApply/accountStatementId", //对账单开票申请提交
	"invoiceAccountStatementListQuery": "/finance/invoice/invoiceAccountStatementListQuery",

	// 不开票申请
	"noInvoiceList": "/finance/invoice/notInvoiceListQuery", // 不开票申请列表查询 POST
	"noInvoiceCommit": "/finance/invoice/notInvoiceApply", // 不开票申请提交 POST

	// 待提交
	"waitingForCommitList": "/finance/invoice/invoicePendSubmListQuery", //待提交列表查询POST
	"invoiceCommit": "/finance/invoice/invoiceApplyListAdmit", //待提交列表页面提交 POST
	"invoiceCommitBatch": "/finance/invoice/invoiceApplyListAdmit", //待提交列表批量提交
	"invoiceDelete": "/finance/invoice/invoiceApplyDelete", //待提交列表页面删除 POST
	"queryInvoiceDetailBySeqId": "/finance/invoice/reqInvoiceApplyListEdit", //编辑详情查询 POST
	"invoiceEditSave": "/finance/invoice/invoiceApplyUpdate", //编辑保存
	"queryInvoiceContentByFinancialCenterId": "/finance/settings/queryInvoiceContentInfoForInvoice", //根据财务中心id获取开票内容
	"reqInvoiceInvalIdBillFlag":"/finance/invoice/reqInvoiceInvalIdBillFlag",//借票正常票判断

	// 开票审核
	"invoiceReviewList": "/finance/invoice/invoiceApproveListQuery", //开票审核列表查询 POST
	"reqInvoiceApprove": "/finance/invoice/reqInvoiceApprove", //
	"invoiceReviewApplyAgree": "/finance/invoice/invoiceInfoApprove", // 开票审核请求 POST
	"invoiceReviewApplyReject": "/finance/invoice/invoiceInfoApproveReject", // 开票审核请求 POST
	"batchInvoiceApplyAgree": "/finance/invoice/invoiceInfoBatchApprove", //批量通过审核,
	"queryFileList": "/finance/invoice/fileList",

	// 待登记开票
	"waitingForRegisterList": "/finance/invoice/waitRegisterListQuery/confirmedThird", //待登记开票列表查询 POST
	"waitingForRegisterListnoConfirmed": "/finance/invoice/waitRegisterListQuery/noConfirmed", //待登记开票列表查询 POST
	"confirmThirdPart": "/finance/invoice/waitRegisterThirdPartConfirm", //确认第三方付款声明
	"updateInvoiceNumber": "/finance/invoice/waitRegisterUpdate", //更新发票号 POST
	"backInvoice": "/finance/invoice/waitRegisterReturn", //待登记开票退回 POST
	"exportExcel": "/finance/file/goldenTax/export", //金税导出
	"importExcelDemoDownload": "/finance/file/import/model/download", //金税导入模板下载 
	"importExcel": "/finance/file/goldenTax/import", //金税导入

	// 已开票
	"invoicedList": "/finance/invoice/invoiceInfoListQuery", //已开票列表查询 POST
	"pickupDelivery": "/finance/invoice/invoiceReceive", // 领取快递POST
	"invalidApply": "/finance/invoice/invoiceVoidApply", // 作废申请POST
	"invoiceBatchReceive":"/finance/invoice/invoiceBatchReceive",//invoiceDetailIdList 批量领取快递POST
	"queryInvoiceDetailById": "/finance/invoice/getInvoiceInfoDetail", // 根据明细ID查询发票信息 POST
	"printNotInvoiceInfo":"/finance/invoice/printNotInvoiceInfo",//不开票下载
	"invoicedInfoListExport":"/finance/file/invoicedInfoList/export",//已开票列表下载
	"queryInvocieInfoCount":"/finance/invoice/queryInvocieInfoCount", // GET方式
	// 开票周期
	"invoiceHisListQuery":"/finance/invoice/invoiceHisListQuery",//开票周期 GET
	// 作废审核
	"invalidReviewList": "/finance/invoice/invoiceVoidApproveListQuery", //作废审核列表查询 POST
	"invalidReviewAgree": "/finance/invoice/invoiceVoidApprove", // 作废审核通过申请 
	"invalidReviewReject": "/finance/invoice/invoiceVoidApproveReject", // 作废审核拒绝申请 POST

	// 作废确认
	"invalidConfirmList": "/finance/invoice/invoiceVoidConfirmListQuery",
	"invalidConfirm": "/finance/invoice/invoiceVoidConfirm",
	"invalidReturn": "/finance/invoice/invoiceVoidReturn",

	// 对账单管理
	"accountStatementList": "/finance/invoice/accountStatementListQuery", //对账单管理列表 POST
	"reqAccountServiceItemList": "/finance/invoice/reqAccountServiceItemList", //对账单管理新增列表POST
	"accountStatementAdd": "/finance/invoice/accountStatementAdd", //对账单管理新增列表POST
	"getAccountStatementDetail": "/finance/invoice/getAccountStatementDetail",
	"queryFinanceCenterByUserSubId": "/user/org/finance/subid",
	"accountStatementDelete": "/finance/invoice/accountStatementDelete", //对账单管理删除POST
	"accountStatementDemo":"/finance/file/accountStatementDemo/download",//模板下载
	// 财务设置
	"companyFinanceList":"/fin-user/org/company/finance/list",//查询财务中心
	"paymentNoticeAdd": "/finance/settings/paymentNotice/add", //信息管理新增POST
	"spaymentNoticeList": "/finance/settings/paymentNotice/list", //信息管理列表POST
	"paymentNoticeDetail": "/finance/settings/paymentNotice/detail", //信息管理详情POST
	"paymentNoticeEdit": "/finance/settings/paymentNotice/edit", //信息管理修改POST
	"queryInvoiceContentList": "/finance/settings/queryInvoiceContentList", //分页查询开票内容GET
	"deleteInvoiceContent": "/finance/settings/deleteInvoiceContent", //删除开票内容设置POST
	"addInvoiceContent": "/finance/settings/addInvoiceContent", //新增开票内容设置POST

	"queryInvoiceLockServiceList": "/finance/settings/queryInvoiceLockServiceList", //开票解锁列表POST
	"serviceInvoiceLock": "/finance/settings/serviceInvoiceLock", //锁定接口  
	"serviceInvoiceUnLock": "/finance/settings/serviceInvoiceUnLock", //解锁接口
	"queryCostLockServiceList": "/finance/settings/queryCostLockServiceList", //成本解锁列表POST
	"serviceCostLock": "/finance/settings/serviceCostLock", //锁定接口  
	"serviceCostUnLock": "/finance/settings/serviceCostUnLock", //解锁接口

	// 数据字典
	"queryCodeList": "/finance/manage/sysCodeListQuery", //GET

	// 文件上传下载
	"downloadFile": "/public/download",
	"listFile": "/public/sysFile/getFileList",
	/*****************开票管理结束***********************/

	/*****************解锁管理开始***********************/

	/*****************解锁管理结束***********************/

	/**********************************财务结束*************************************/

	/**********************************结算开始************************************/
	"departmentUserdata":"/fin-user/org/company/department/user/data",//结算报表查公司部门GET请求参数需要传 resourceId
	"excelCostPackageListQuery": "/settlement/excel/export/costPackageListQuery", //应付分包 导出GET
	"excelCostInfoListQuery": "/settlement/excel/export/costInfoListQuery", //其他应付 导出GET
	"excelPaidOutPayListQuery": "/settlement/excel/export/paidOutPayListQuery", //已付外付 导出GET	
	"excelOutPayAccountListQuery": "/settlement/excel/export/outPayAccountListQuery", //应付台账 导出GET	
	"excelInnerPayListQuery": "/settlement/excel/export/innerPayListQuery", //直接关联最小服务项内付 导出GET
	"excelAllocatedExpenseListQuery": "/settlement/excel/export/allocatedExpenseListQuery", //待分摊内付 GET	
	"excelOutpayCostListQuery": "/settlement/excel/export/outpayCostListQuery", //外付成本统计导出GET
	"excelCostNoApportionListQuery": "/settlement/excel/export/costNoApportionListQuery", //成本统计(不含分摊) 导出GET	
	"excelBankMatchListQuery": "/settlement/excel/export/bankMatchListQuery", //流水匹配清单统计 导出GET
	"excelBankUnMatchListQuery": "/settlement/excel/export/bankUnMatchListQuery", //未匹配流水清单统计 导出GET	
	"excelDebitInvoiceListQuery": "/settlement/excel/export/debitInvoiceListQuery", //借发票清单统计查询 导出GET
	"excelCompletedNoInvoiceListQuery": "/settlement/excel/export/completedNoInvoiceListQuery", //完工未开票统计列表查询 导出GET
	"excelInvociedIncomeListQuery": "/settlement/excel/export/invociedIncomeListQuery", //已开票收入统计 导出GET
	"excelreimportInvoiceListQuery": "/settlement/excel/export/reimportInvoiceListQuery", //补录开票统计导出 GET
	"excelDepartmentIncomeQuery": "/settlement/excel/export/departmentIncomeQuery", //部门收入统计导出 GET
	
	"excelPayAgingListQuery": "/settlement/excel/export/payAgingListQuery", //应付账龄统计 导出GET
	"excelPayChangeListQuery": "/settlement/excel/export/payChangeListQuery", //应付变动明细统计 导出GET
	"excelBadDebtProvisionListQuery": "/settlement/excel/export/badDebtProvisionListQuery", //坏账计提列表导出GET
	"excelBadDebtStatisticsListQuery": "/settlement/excel/export/badDebtStatisticsListQuery", //坏账统计列表导出GET
	
	"excelPayProvisionListQuery": "/settlement/excel/export/payProvisionListQuery", //应付计提 GET
	"excelPaySettlementListQuery": "/settlement/excel/export/paySettlementListQuery", //应付清算 GET
	"excelPayWriteListQuery": "/settlement/excel/export/payWriteListQuery", //应付核销 GET
	
	"excelReceivableChangeAllListQuery": "/settlement/excel/export/receivableChangeAllListQuery", //总收入变动明细列表导出 导出GET
	"excelReceivableChangeInvoiceListQuery": "/settlement/excel/export/receivableChangeInvoiceListQuery", //开票变动明细列表查询导出 导出GET
	"excelReceivableWarningListQuery": "/settlement/excel/export/receivableWarningListQuery", //应收预警统计列表查询 导出GET
	"excelReceivableAgingListQuery": "/settlement/excel/export/receivableAgingListQuery", //应收账龄统计列表查询 导出GET
	"excelForecastIncomeListQuery": "/settlement/excel/export/forecastIncomeListQuery", //预测收入统计列表查询 导出GET
	"excelApportionedCostListQuery": "/settlement/excel/export/apportionedCostListQuery", //待分摊间接成本统计列表报表导出 导出GET
	"excelCrossMainFeeListQuery": "/settlement/excel/export/crossMainFeeListQuery", //待分摊跨主体费用列表报表导出 导出GET
	"excelNoSalaryCostListQuery": "/settlement/excel/export/noSalaryCostListQuery", //非薪酬间接成本列表报表导出 导出GET
	"excelSalaryCostListQuery": "/settlement/excel/export/salaryCostListQuery", //薪酬间接成本列表报表导出 导出GET
	"excelShareReasonDetailListQuery": "/settlement/excel/export/shareReasonDetailListQuery", //分摊动因明细列表报表导出 导出GET
	"excelShareReportListQuery": "/settlement/excel/export/shareReportListQuery", //分析报告列表报表导出 导出GET

	"queryCostSubPackageList": "/settlement/expense/costPackageListQuery", // 应付分包 GET
	"queryCostInfoList": "/settlement/expense/costInfoListQuery", //其他应付 GET
	"paidOutPayListQuery": "/settlement/expense/paidOutPayListQuery", //已付外付列表 GET
	"outPayAccountListQuery": "/settlement/expense/outPayAccountListQuery", //应付台账列表查询 GET
	"innerPayListQuery": "/settlement/expense/innerPayListQuery", //直接关联最小服务项内付 GET
	"allocatedExpenseListQuery": "/settlement/expense/allocatedExpenseListQuery", //待分摊内付 GET
	"outpayCostListQuery": "/settlement/expense/outpayCostListQuery", //外付成本统计 GET
	"costNoApportionListQuery": "/settlement/expense/costNoApportionListQuery", //成本统计(不含分摊) GET
	"completedNoInvoiceListQuery": "/settlement/income/completedNoInvoiceListQuery", //完工未开票统计列表查询 GET
	"invociedIncomeListQuery": "/settlement/income/invociedIncomeListQuery", //已开票收入统计 GET
	"reimportInvoiceListQuery": "/settlement/income/reimportInvoiceListQuery", //补录开票统计 GET
	"debitInvoiceListQuery": "/settlement/income/debitInvoiceListQuery", //借发票清单统计查询 GET
	"bankMatchListQuery": "/settlement/income/bankMatchListQuery", //流水匹配清单统计 GET
	"bankUnMatchListQuery": "/settlement/income/bankUnMatchListQuery", //未匹配流水清单统计 GET
	"apportionedCostListQuery": "/settlement/apportioned/apportionedCostListQuery", //待分摊间接成本统计列表 GET
	"payChangeListQuery": "/settlement/expense/payChangeListQuery", //应付变动明细统计 GET
	"payAgingListQuery": "/settlement/expense/payAgingListQuery", //应付账龄统计 GET
	"badDebtProvisionListQuery": "/settlement/income/badDebtProvisionListQuery", //坏账计提列表查询 GET
	"badDebtStatisticsListQuery": "/settlement/income/badDebtStatisticsListQuery", //坏账统计列表查询 GET
	"payProvisionListQuery": "/settlement/expense/payProvisionListQuery", //应付计提 GET
	"paySettlementListQuery": "/settlement/expense/paySettlementListQuery", //应付清算 GET
	"payWriteListQuery": "/settlement/expense/payWriteListQuery", //应付核销 GET

	"receivableChangeAllListQuery": "/settlement/income/receivableChangeAllListQuery", //总收入变动明细列表查询 GET
	"receivableChangeInvoiceListQuery": "/settlement/income/receivableChangeInvoiceListQuery", //开票变动明细列表查询 GET
	"receivableWarningListQuery": "/settlement/income/receivableWarningListQuery", //应收预警统计列表查询 GET
	"crossMainFeeListQuery": "/settlement/apportioned/crossMainFeeListQuery", //待分摊跨主体费用列表查询 GET
	"receivableAgingListQuery": "/settlement/income/receivableAgingListQuery", //应收账龄统计列表查询 GET
	"forecastIncomeListQuery": "/settlement/income/forecastIncomeListQuery", //预测收入统计列表查询 GET
	"noSalaryCostListQuery": "/settlement/apportioned/noSalaryCostListQuery", //非薪酬间接成本列表查询 GET
	"salaryCostListQuery": "/settlement/apportioned/salaryCostListQuery", //薪酬间接成本列表查询 GET
	"shareReasonDetailListQuery": "/settlement/apportioned/shareReasonDetailListQuery", //分摊动因明细列表查询 GET
	"shareReportListQuery": "/settlement/apportioned/shareReportListQuery", //分析报告列表报表 GET
	"departmentIncomeQuery":"/settlement/income/departmentIncomeQuery",//部门确认收入查询

	"queryStandardWagesConfigList": "/settlement/settings/queryStandardWagesConfigList", //分页查询标准工时工资列表 GET
	"deleteStandardWagesConfig": "/settlement/settings/deleteStandardWagesConfig", //删除标准工时工资设置 GET
	"addStandardWagesConfig": "/settlement/settings/addStandardWagesConfig", //新增标准工时工资设置 GET
	"addThreeFeeConfig": "/settlement/settings/addThreeFeeConfig", //新增三项费用比例设置 GET
	"deleteThreeFeeConfig": "/settlement/settings/deleteThreeFeeConfig", //删除三项费用比例设置 GET
	"queryThreeFeeConfigList": "/settlement/settings/queryThreeFeeConfigList", //分页查询三项费用比例设置列表 GET
	"companyFin": "/fin-user/org/company/fin", //查带登陆人公司 GET
	"codeProductlist": "/fin-user/org/code/product/rmdup/list", //查带登陆人公司 GET



	/**********************************结算结束************************************/

	/**********************************设置开始************************************/

	/**********************************设置结束************************************/

	"selectFinTaskUser":"/bpm-task/bpm/definition/selectFinTaskUser", //工作流查询人
	"assignTask":"/bpm-task/bpm/task/assignFinTask", //工作流转办
	"queryTodoList" : "/bpm-task/bpm/my/todoFinTask", //查询待办
	"queryRejectList" : "/bpm-task/bpm/my/todoFinBack", //驳回提醒查询
	"updateLook" : "/bpm-task/bpm/my/updateLook", //更新已看
	"selectBpmProduct":"/bpm-task/bpm/definition/selectBpmFinProduct", //查询产品线绑定关系
	"forbiddenProduct":"/bpm-task/bpm/definition/forbiddenFinProduct",//禁用产品线绑定关系
	"startProduct":"/bpm-task/bpm/definition/startFinProduct",//启用产品线绑定关系
	"insertProduct":"/bpm-task/bpm/definition/insertFinProduct",//新增产品线绑定关系
	"selectInnerOrgBpm":"/bpm-task/bpm/definition/selectInnerFinOrgBpm",//查询未绑定产品线的工作流
	"bpmMyApproveListHistory":"/bpm-task/bpm/my/approveListHistory",//查询审核记录
	"bpmMyApproveListNode":"/bpm-task/bpm/my/approveListNode",//查询审批节点
	"bpmInstanceFlowImage":"/bpm-task/bpm/instance/flowImage",//查询工作流流程图
	"selectBpmAll":"/bpm-task/bpm/definition/selectFinBpmAll", //查询当前已绑定生效工作流
	"doManualEnd":"/bpm-task/bpm/task/doManualEnd", //隐藏驳回
	"selectFinMesTask":"/bpm-task/bpm/my/selectFinMesTask", //消息提醒
	
	"enableSysRole" : "/fin-user/role/enable",//角色启用
	"disableSysRole" : "/fin-user/role/disable",//角色停用
	"querySysResource" : "/fin-user/resource/list",//获取资源树状
	"addSysRole" : "/fin-user/role",//新增角色或修改角色
	"enableDataPermissions" : "/fin-user/data/enable",//启用数据权限
	"disableDataPermissions" : "/fin-user/data/disable",//停用数据权限
	"querySysCmpOrg" : "/fin-user/org/user/company/list",//获取当前用户公司及以下的组织
	"addDataPermissions" : "/fin-user/data",//新增数据权限
	"editDataPermissions" : "/fin-user/data", //修改数据权限
	"querySysOrg" : "/fin-user/org/user/dept/list", //获取组织(包含财务中心和产品线)
	"queryFinance" : "/fin-user/finance/list",//获取财务中心
	"queryProductLine" : "/public/productLine/list",//获取产品线列表
	"modifyOrg" : "/fin-user/org/configure",//组织管理-修改
	"addUserAuthorityBatch" : "/fin-user/authority/role/data",//用户权限授权提交(用户权限操作页面)
	"queryDataPermissionsList" : "/fin-user/data/manager/list",//查询数据权限(用户授权页面)
	"queryRoleList" : "/fin-user/role/manager/list",//查询角色(用户授权页面)
	"queryUserRoleAndData" : "/fin-user/user/role/data",//根据子账户ID查询用户已有角色和数据权限
	"queryUserList" : "/fin-user/user/manager/list", //用户管理-用户列表
	"querySysRole" : "/fin-user/role/list",//获取角色列表
	"queryDataPermissions" : "/fin-user/data/list",//数据权限查询
	"queryUserByOrgAndUsername" : "/fin-user/user_sub/org",//根据组织和用户名查用户
	"addUserAuthority" : "/fin-user/authority",//用户权限授权提交(用户管理页面)
	"departmentFin":"/fin-user/org/company/department/fin",//根据公司unifycode查询公司下属的部门
	"userSub":"/fin-user/user_sub",//切换子账户
	
	"userLogin":"/fin-user/auth",
	"userLogout":"/fin-user/logout",
	"orgSubList":"/fin-user/org/sub/list", //登录人所属公司下的部门
	"orgDepartment":"/fin-user/org/department", //登录人所在公司下的部门（不包含子公司）
	"allCompany":"/fin-user/org/all/company/fin", //登录人所在公司及以下所有公司
	
	
	"exchangeSysCodeInfoList":"/finance/manage/exchangeSysCodeInfoList", //清算系统维护code表查询 POST
    "exchangeSysCodeUpdate":"/finance/manage/exchangeSysCodeUpdate", //清算系统维护code表更新 PUT
    "exchangeSysCodeAdd":"/finance/manage/exchangeSysCodeAdd",  //清算系统维护code表新增 POST
    
    "invoiceCheckListQuery":"/finance/invoice/check/invoiceCheckListQuery", //发票校验列表查询
    "invoiceCheckUpdateReason":"/finance/invoice/check/invoiceCheckUpdateReason", //发票校验添加原因
    "insertSelfInspection":"/finance/invoice/check/insertSelfInspection", //添加、更新上线自查率和文件
    "findInspectionRate":"/finance/invoice/check/findInspectionRate", //查询上线自查率及文件
    "invoiceCheckMatch":"/finance/invoice/check/invoiceCheckMatch", //发票校验匹配按钮
    "invoiceCheckImport":"/finance/invoice/check/invoiceCheckImport", //发票校验导入
    "doProvinceInspection":"/finance/invoice/check/doProvinceInspection",
    "invoiceCheckDownload":"/finance/file/import/invoiceCheck/download",//下载模板
    "invoiceCheckExport":"/finance/file/invoiceCheck/export",
    
    //台账
    "queryInvoiceLedger":"/finance/invoice/queryInvoiceLedger", //GET接口
    "queryBankTransLedger":"/finance/bankTrans/queryBankTransLedger",//流水匹配台账接口GET方式
    //客户供应商修改
   "queryCustomerInfo":"/finance/manage/queryCustomerInfo", //查询客户名称信息接口:  GET方式
   "updateCustomerInfo":"/finance/manage/updateCustomerInfo", //修改客户名称信息接口: POST方式
   "querySupplierInfo":"/finance/manage/querySupplierInfo", //查询供应商信息接口:  GET方式
   "updateSupplierInfo":"/finance/manage/updateSupplierInfo", //修改供应商信息接口:POST方式
};

/**
 * 全局配置
 */
var BIMSglobalConfig = {
		
	// 中检生产环境
	/*
	"serverUrl": "https://fin-data.ccic.com",
 	"ccicIndex": "https://fin.ccic.com",
 	"ccicSSOUrl": "https://sso.ccic.com/idp/oauth2/authorize?client_id=UniversalLine&redirect_uri=https://fin.ccic.com/page/index.html&response_type=code&state=123",
 	"ccicLogoutUrl": "https://public.ccic.com/logout.jsp?appName=结算中台",
 	"agilebpmUrl":"https://fin.ccic.com",
 	"agilebpmHtml":"/agilebpm-ui/bpm/definition/definitionList.html",
 	"agilebpmEditor":"/agilebpm-ui/flow-editor/disabledModeler.html?modelId=",
 	"agilebpmEditorEnable":"/agilebpm-ui/flow-editor/modeler.html?modelId=", //工作流配置页面可以修改
 	"ccicPortalUrl":"https://portal.ccic.com/",
	*/
	
		

	// 中检测试环境
	
	/*"serverUrl": "https://bims-test5.ccic.com",
	"ccicIndex": "https://bims-test4.ccic.com",
	"ccicSSOUrl": "http://sso-test.ccic.com/idp/oauth2/authorize?client_id=tyxtest&redirect_uri=https://bims-test4.ccic.com/page/index.html&response_type=code&state=123",
	"ccicLogoutUrl": "https://public.ccic.com/logout.jsp?appName=结算中台",
	"agilebpmUrl":"https://bims-test4.ccic.com",
	"agilebpmHtml":"/agilebpm-ui/bpm/definition/definitionList.html",
	"agilebpmEditor":"/agilebpm-ui/flow-editor/disabledModeler.html?modelId=",
	"agilebpmEditorEnable":"/agilebpm-ui/flow-editor/modeler.html?modelId=", //工作流配置页面可以修改
	"ccicPortalUrl":"http://portal-test.ccic.com",*/

	"serverUrl": "http://localhost:9082/mbpmV8_3_war_exploded/indexNewVue.html",
	"ccicIndex": "http://localhost:9082/mbpmV8_3_war_exploded/indexNewVue.html",
	"ccicSSOUrl": "http://localhost:9082/mbpmV8_3_war_exploded/indexNewVue.html",
	"ccicLogoutUrl": "http://localhost:9082/mbpmV8_3_war_exploded/indexNewVue.html",
	"agilebpmUrl":"http://localhost:9082/mbpmV8_3_war_exploded/indexNewVue.html",
	"agilebpmHtml":"http://localhost:9082/mbpmV8_3_war_exploded/indexNewVue.html",
	"agilebpmEditor":"http://localhost:9082/mbpmV8_3_war_exploded/indexNewVue.html",
	"agilebpmEditorEnable":"http://localhost:9082/mbpmV8_3_war_exploded/indexNewVue.html", //工作流配置页面可以修改
	"ccicPortalUrl":"http://localhost:9082/mbpmV8_3_war_exploded/indexNewVue.html",

	//公司内部环境
	 /*
	"serverUrl": "http://130.252.200.195:9093",
	"ccicIndex": "http://130.252.200.195:8010",
	"ccicSSOUrl": "http://sso-test.ccic.com/idp/oauth2/authorize?client_id=tyxtest&redirect_uri=http://130.252.200.195:8010/page/index.html&response_type=code&state=123",
	"ccicLogoutUrl": "https://public.ccic.com/logout.jsp?appName=结算中台",
	"agilebpmUrl":"http://130.252.200.195:8180",
	"agilebpmHtml":"/agilebpm-ui/bpm/definition/definitionList.html",
	"agilebpmEditor":"/agilebpm-ui/flow-editor/disabledModeler.html?modelId=",  //工作流配置页面不能修改
	"agilebpmEditorEnable":"/agilebpm-ui/flow-editor/modeler.html?modelId=", //工作流配置页面可以修改
	"ccicPortalUrl":"http://portal-test.ccic.com",
	*/
};