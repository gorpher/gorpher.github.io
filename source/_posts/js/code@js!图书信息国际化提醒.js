//读者空间的相关国际化
var spaceI18n = {
	rdid:"请输入读者证号",
	rdName:"请输入读者姓名",
	rdPasswdAndRepPasswd:"请输入密码和重复密码!",
	rdRegisterName:"请输入读者注册名",
	passwdNotMatch:"两次输入密码不符",
	rdCertify:"请输入身份证号",
	rdBornDate:"请输入出生日期，且按yyyy-mm-dd的格式进行输入!",
	rdNation:"请输入民族!",
	rdNative:"请输入籍贯!",
	rdAddress:"请输入通讯地址!",
	rdPhone:"请输入联系电话!",
	rdLoginId:"请输入手机!",
	showMessage:"显示说明",
	hideMessage:"隐藏说明",
	enterSearchWord:"请输入需要查询的信息!",
	currentPage:"当前已是第{0}页",
	enterPage:"请输入跳转的页数!",
	pageBeyond:"您输入的页数超出范围了，请重新输入!",
	passwdLengthNotMatch:"密码长度至少6位",
	rdCertifyNotMatch:"输入的身份证号长度不符",
	rdEmail:"请输入Email",
	rdEmailNotMatch:"输入的Email格式不正确",
	rdPhoto:"请选择一张照片进行上传",
	wrongImgType:"图片类型必须是{0}中的一种",
	disableFile:"无效的图片文件！",
	socialSecurityCard:"请输入社保卡号",
	checkAll:"您必须勾选所有复选框,才可以点击同意",
	rdCertifyExist:"您输入的身份证号已经注册过，请点击确认以继续注册。"
};

//借阅情况的图标国际化
var chartI18n = {
	year:"年",
	month:"月",
	loanSituation:"借阅情况",
	readerLoanSituation:"读者借阅情况",
	readerLoanTrendGraph:"读者借阅趋势图",
	readerLoanCount:"读者借阅数量",
	yourLoanNum:"您{0}年借阅量为{1}",
	monthLoanNum:"您{0}月借阅量为{1}",
	clickToCheckMonthLoan:"点击进入查看月份借阅情况",
	clickToCheckYearLoan:"点击返回查看年份借阅情况",
	bibliosTimeTrendGraph:"书目数量-时间趋势图",
	bibliosCount:"书目数量",
	bibliosSituation:"书目分布情况",
	bibliosNum:"{0}年的书目数量为{1}<br/>点击查看{2}年的书目",
	showChart:"显示趋势图",
	hideChart:"隐藏趋势图",
	loanTrendChart:"借阅趋势图",
	loanCount:"借阅次数",
	hoverTips:"{0}年借阅次数为{1}"
};

//searchResult 检索结果页面部分国际化
var searchResultI18n = {
	showClassFacet:"显示分类导航",
	hideClassFacet:"隐藏分类导航"
};

//jsp_tiles/hotsearch
var hotsearchI18n = {
	keywordSearchTrend: "关键字[{0}]检索趋势",
	searchTimes: "检索次数",
	chartTitle: "时间(年-月)",
	highcharts_weekday_day7: "星期天",
	highcharts_weekday_day1: "星期一",
	highcharts_weekday_day2: "星期二",
	highcharts_weekday_day3: "星期三",
	highcharts_weekday_day4: "星期四",
	highcharts_weekday_day5: "星期五",
	highcharts_weekday_day6: "星期六"
};
//读者自定义荐购图书
var recommendCustomI18n={
	newForm_title:"书名不能为空！",
	newForm_author:"著者不能为空！",
	newForm_pubDate:"出版时间不能为空！",
	newForm_title_beyondMaxNum:"标题字数不能超过50字！",
	newForm_author_beyondMaxNum:"著者名称不能超过30个字！",
	newForm_pubDate_beyondMaxNum:"时间格式（年-月-日，yyyy-mm-dd）不正确或者超过10个字符！",
	newForm_isbn_beyondMaxNum:"ISBN编号不能超过20个字符！",
	newForm_publisher_beyondMaxNum:"出版社名称不能超过30个字符！",
	newForm_classNo_beyondMaxNum:"分类号字符不能超过20个字符！",
	newForm_subject_beyondMaxNum:"主题词长度不能超过30个字符！",
	newForm_price_beyondMaxNum:"价格不能超过100个字符！"
};

//排行榜中的添加到例外的
var ranking={
	connectFail:"连接出现问题",
	addConfirm:"确定要添加到例外,添加后读者将不能在排行榜中看到该书,但管理员可以看到所有的!",
	deleteConfirm:"确定要从例外中删除,删除后读者可以在排行榜中看到该书!"
};

//强制读者完善email和手机号码信息
var readerInfo={
	inputEmail:"请输入有效的一个email",
	inputMobilePhone:"请输入正确的手机号码",
	successApplyValid : "验证邮箱已经发送到您填写的邮箱中,请您按照邮箱中的提示完成验证步骤",
	repeatApplyValid : "您已经申请过验证了，请查收邮箱。或者重新输入新的邮箱地址进行验证。",
	failApplyValid:"信息填写失败,请重试",
	failUpdateRdInfo:"更新失败,请重试!"
};

//图书详细信息
var bookDetailsI18n={
	eBook_continue:"继续",
	eBook_close:"关闭",
	eBook_loanDeadline:"电子书借阅期限为{0}天,",
	eBook_loansLeft:"您还能借阅{0}本电子书,",
	eBook_doLoan:"点击“继续”，将为您借阅电子书《{0}》。"
};