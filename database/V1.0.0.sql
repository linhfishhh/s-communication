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
						Ch??c m???ng <b>
							<#list Consumers as Consumer>
								<#if Consumer?is_last>
									${Consumer.name}
								<#else>
									${Consumer.name},
								</#if>
							</#list>
						</b> ???? ????ng k?? th??nh c??ng kho?? h???c <b>${CourseName}</b>.
					</td>
				</tr>
				<#if StartDate??>
					<tr>
						<td class="padding-v-1">
							Kho?? h???c <b>${CourseName}</b> s??? khai gi???ng v??o <b>${StartDate}</b>.
						</td>
					</tr>
				</#if>
				<tr>
					<td class="padding-v-1">
						M?? ????ng k?? c???a b???n l??: <span class="stress">${PaymentCode}</span>.
					</td>
				</tr>
				<#if HasFee??>
					<tr>
						<td class="padding-v-1">
							<#if Consumers?size==1>
								????? ho??n t???t ????ng k??, vui l??ng thanh to??n h???c ph?? kh??a h???c, s??? ti???n <b>${CourseFee}???</b>, tr?????c ng??y
								<b>${LimitPayDate}</b> theo hu???ng d???n sau ????y:<br />
							<#else>
									????? ho??n t???t ????ng k??, vui l??ng thanh to??n tr?????c to??n b??? h???c ph?? kh??a h???c c???a c??c b???n ????? ???????c hu???ng khuy???n m??i
									????ng k?? theo nh??m, s??? ti???n <b>${CourseFee}??? (<span class="origin-price">${CourseFeeOrigin}???</span>)</b>, theo hu???ng d???n sau ????y:
							</#if>
						</td>
					</tr>
					<tr>
						<td>
							<img src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/star.png" /> Chuy???n ti???n v??o s??? t??i kho???n:
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
							<img src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/star.png" /> N???i dung:
							</span><b>${PaymentCode}</b> (m?? ????ng k?? c???a b???n)
						</td>
					</tr>
					<tr>
						<td class="horizontal-center margin-v-1">
							<div class="payment-button vertical-center">
								<a href="${BillLink}" class="horizontal-center payment-label">THANH TO??N</a>
							</div>
						</td>
					</tr>
				<#else>
					<tr>
						<td>
							H??y tham gia l???p h???c ????ng gi??? nh??!
						</td>
					</tr>
				</#if>
				<tr>
					<td class="padding-v-1">
						Xem l???i th??ng tin kho?? h???c <b><a href="${CourseLink}">t???i ????y</a></b>
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
						<div>?????a ch???: ${ProviderLocation?if_exists}</div>
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
							Ch??c m???ng <b>${ProviderName}</b>, kho?? h???c <b>${CourseName}</b> khai gi???ng v??o <b>${StartDate}</b> v???a c?? m???t ????ng
						k?? m???i, th??ng tin chi ti???t nh?? sau:
						<#else>
							Ch??c m???ng <b>${ProviderName}</b>, kho?? h???c <b>${CourseName}</b> v???a c?? m???t ????ng
						k?? m???i, th??ng tin chi ti???t nh?? sau:
						</#if>

					</td>
				</tr>
				<tr>
					<td class="padding-v-1">
						M?? ????ng k?? l??: <span class="stress">${PaymentCode}</span>
					</td>
				</tr>
				<#list Consumers as Consumer>
					<tr>
						<td class="padding-v-1">
							H??? v?? t??n: <b>${Consumer.name}</b><br />
							Email: <b>${Consumer.email}</b><br />
							<#if Consumer.phone??>S??? ??i???n tho???i: <b>${Consumer.phone}</b><br /></#if>
						</td>
					</tr>
				</#list>
				<#if CourseType == "SEASON">
					<#if PaymentType == "PAID">
						<tr>
							<td class="padding-v-1">
								T???ng s??? ti???n h???c ph??: <b>${CourseFee}???</b>
							</td>
						</tr>
					<#else>
						????y l?? kho?? h???c mi???n ph??.
					</#if>
				</#if>
				<tr>
					<td class="padding-v-1">
						Th??ng tin h???c vi??n ????ng k?? ???? ???????c l??u l???i trong h??? th???ng c???a Bukizi, b???n c?? th??? truy c???p <b><a
								href="${CourseLink}">t???i ????y</a></b> ????? qu???n l?? kh??a h???c.
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
' where code = 'REGISTER_PROVIDER';