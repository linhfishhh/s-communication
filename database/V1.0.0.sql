update template set message = '<html>
<head>
	<style type="text/css">
		.header {
			border-top-left-radius: 15px;
			border-top-right-radius: 15px;
			background-color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#f8797b</#if>;
			padding: 10px;
		}
		.avatar {
			border-radius: 50%;
		}
		.avatar-small {
			width: 50px;
			height: 50px;
		}
		.bukizi-logo {
			height: 50px;
		}
		.provider-name {
			font-size: 24px;
			font-weight: bold;
			color: white;
			padding-left: 10px;
		}
		.body {
			border: 1px solid <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#f8797b</#if>;
			border-bottom-left-radius: 15px;
			border-bottom-right-radius: 15px;
			padding: 20px;
		}
		.content {
			border: 1px solid <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#f8797b</#if>;
			border-radius: 15px;
			padding: 10px;
		}
		.logo {
			width: 100px;
			height: 100px;
		}
		.stress {
			font-weight: bold;
			color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#f8797b</#if>;
		}
		.separator {
			border-bottom: 1px solid <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#f8797b</#if>;
			margin-left: 10px;
			margin-right: 10px;
		}
		.avatar-big {
			width: 100px;
			height: 100px;
		}
		.table {
			table-layout: fixed;
			width: 100%;
		}
		.horizontal-center {
			margin: auto;
			width: fit-content;
			display: table;
		}
		.vertical-center {
			display: table-cell;
			vertical-align: middle;
		}
		.padding-1 {
			padding: 10px;
		}
		.padding-v-1 {
			padding-top: 10px;
			padding-bottom: 10px;
		}
		.margin-1 {
			margin: 10px;
		}
		.margin-v-1 {
			margin-top: 10px;
			margin-bottom: 10px;
		}
		.payment-button {
			width: 130px;
			height: 35px;
			border-radius: 5px;
			background-color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#f8797b</#if>;
			border: none;
			margin: auto;
		}
		a.payment-label {
			color: #fff !important;
			font-weight: bold;
			text-decoration: none;
		}
		.origin-price {
			text-decoration: line-through;
		}
	</style>
</head>
<body>
	<div class="header">
		<div class="horizontal-center">
			<img class="avatar avatar-small vertical-center" src="${ProviderAvatar?if_exists}" />
			<span class="provider-name vertical-center">${ProviderName}</span>
		</div>
	</div>

	<div class="body">
		<div class="content">
			<!-- <div class="horizontal-center padding-1">
				<img class="logo" src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/register.png" />
			</div> -->
			<table class="table padding-1">
				<tr>
					<td class="padding-v-1">
						Chúc mừng <b>
							<#list Consumers as Consumer>
								<#if Consumer?is_last>
									${Consumer.name}
								<#else>
									${Consumer.name},
								</#if>
							</#list>
						</b> đã đăng ký thành công khoá học <b>${CourseName}</b>.
					</td>
				</tr>
				<#if StartDate??>
					<tr>
						<td class="padding-v-1">
							Khoá học <b>${CourseName}</b> sẽ khai giảng vào <b>${StartDate}</b>.
						</td>
					</tr>
				</#if>
				<tr>
					<td class="padding-v-1">
						Mã đăng ký của bạn là: <span class="stress">${PaymentCode}</span>.
					</td>
				</tr>
				<#if HasFee??>
					<tr>
						<td class="padding-v-1">
							<#if Consumers?size==1>
								Để hoàn tất đăng ký, vui lòng thanh toán học phí khóa học, số tiền <b>${CourseFee}₫</b>, trước ngày
								<b>${LimitPayDate}</b> theo huớng dẫn sau đây:<br />
							<#else>
									Để hoàn tất đăng ký, vui lòng thanh toán trước toàn bộ học phí khóa học của các bạn để được huởng khuyến mãi
									đăng ký theo nhóm, số tiền <b>${CourseFee}₫ (<span class="origin-price">${CourseFeeOrigin}₫</span>)</b>, theo huớng dẫn sau đây:
							</#if>
						</td>
					</tr>
					<tr>
						<td>
							<img src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/star.png" /> Chuyển tiền vào số tài khoản:
						</td>
					</tr>
					<tr>
						<td>
							<ul>
								<#list BankAccounts as BankAccount>
									<li>
										<b>${BankAccount}<b>
									</li>
								</#list>
							</ul>
						</td>
					</tr>
					<tr>
						<td>
							<img src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/star.png" /> Nội dung:
							</span><b>${PaymentCode}</b> (mã đăng ký của bạn)
						</td>
					</tr>
					<tr>
						<td class="horizontal-center margin-v-1">
							<div class="payment-button vertical-center">
								<a href="${BillLink}" class="horizontal-center payment-label">THANH TOÁN</a>
							</div>
						</td>
					</tr>
				<#else>
					<tr>
						<td>
							Hãy tham gia lớp học đúng giờ nhé!
						</td>
					</tr>
				</#if>
				<tr>
					<td class="padding-v-1">
						Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>
					</td>
				</tr>
			</table>
			<div class="separator margin-v-1"></div>
			<table class="table">
				<tr>
					<td class="avatar-big padding-1">
						<img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
					</td>
					<td class="margin-1">
						<div><b>${ProviderName?if_exists}</b></div>
						<div>Địa chỉ: ${ProviderLocation?if_exists}</div>
						<div>Hotline: <span class="stress">${ProviderPhone?if_exists}</span></div>
						<div>
							Email: <span class="stress">${ProviderEmail?if_exists}</span>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
' where code = 'REGISTER';
update template set message = '<html>
<head>
	<style type="text/css">
		.header {
			border-top-left-radius: 15px;
			border-top-right-radius: 15px;
			background-color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#f8797b</#if>;
			padding: 10px;
		}
		.avatar {
			border-radius: 50%;
		}
		.avatar-small {
			width: 50px;
			height: 50px;
		}
		.bukizi-logo {
			height: 50px;
		}
		.provider-name {
			font-size: 24px;
			font-weight: bold;
			color: white;
			padding-left: 10px;
		}
		.body {
			border: 1px solid <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#f8797b</#if>;
			border-bottom-left-radius: 15px;
			border-bottom-right-radius: 15px;
			padding: 20px;
		}
		.content {
			border: 1px solid <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#f8797b</#if>;
			border-radius: 15px;
			padding: 10px;
		}
		.logo {
			width: 100px;
			height: 100px;
		}
		.stress {
			font-weight: bold;
			color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#f8797b</#if>;
		}
		.separator {
			border-bottom: 1px solid <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#f8797b</#if>;
			margin-left: 10px;
			margin-right: 10px;
		}
		.avatar-big {
			width: 100px;
			height: 100px;
		}
		.table {
			table-layout: fixed;
			width: 100%;
		}
		.horizontal-center {
			margin: auto;
			width: fit-content;
			display: table;
		}
		.vertical-center {
			display: table-cell;
			vertical-align: middle;
		}
		.padding-1 {
			padding: 10px;
		}
		.padding-v-1 {
			padding-top: 10px;
			padding-bottom: 10px;
		}
	</style>
</head>
<body>
	<div class="header">
		<div class="horizontal-center">
			<img class="bukizi-logo vertical-center" src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/bukizi.png" />
		</div>
	</div>

	<div class="body">
		<div class="content">
			<!-- <div class="horizontal-center padding-1">
				<img class="logo" src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/register.png" />
			</div> -->
			<table class="table padding-1">
				<tr>
					<td class="padding-v-1">
						<#if startDate??>
							Chúc mừng <b>${ProviderName}</b>, khoá học <b>${CourseName}</b> khai giảng vào <b>${StartDate}</b> vừa có một đăng
						ký mới, thông tin chi tiết như sau:
						<#else>
							Chúc mừng <b>${ProviderName}</b>, khoá học <b>${CourseName}</b> vừa có một đăng
						ký mới, thông tin chi tiết như sau:
						</#if>

					</td>
				</tr>
				<tr>
					<td class="padding-v-1">
						Mã đăng ký là: <span class="stress">${PaymentCode}</span>
					</td>
				</tr>
				<#list Consumers as Consumer>
					<tr>
						<td class="padding-v-1">
							Họ và tên: <b>${Consumer.name}</b><br />
							Email: <b>${Consumer.email}</b><br />
							<#if Consumer.phone??>Số điện thoại: <b>${Consumer.phone}</b><br /></#if>
						</td>
					</tr>
				</#list>
				<#if CourseType == "SEASON">
					<#if PaymentType == "PAID">
						<tr>
							<td class="padding-v-1">
								Tổng số tiền học phí: <b>${CourseFee}₫</b>
							</td>
						</tr>
					<#else>
						Đây là khoá học miễn phí.
					</#if>
				</#if>
				<tr>
					<td class="padding-v-1">
						Thông tin học viên đăng ký đã được lưu lại trong hệ thống của Bukizi, bạn có thể truy cập <b><a
								href="${CourseLink}">tại đây</a></b> để quản lý khóa học.
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
' where code = 'REGISTER_PROVIDER';