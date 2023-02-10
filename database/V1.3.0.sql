alter table email
	add from_name varchar(100);

alter table template
	add default_param_value text;

alter table template alter column message type textt using message::textt;

truncate table template;

INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default , 'EMAIL', 'RESET_PASSWORD', 'Quên mật khẩu', 'Xin chào $_UserName_ ,<br>Hệ thống đã tạo lại mật khẩu cho bạn : <b>$_TempPassword_</b><br>Hãy sử dụng mật khẩu mới đăng nhập vào hệ thống để xóa mật khẩu cũ của bạn.', 'vi-VN', 'Reset Password', 'tool@stgsolution.com', 'html', '2019-02-15 09:17:44.508007', 'SYSTEM', '2019-02-15 09:17:44.508007', 'SYSTEM', null, '');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'RESET_PASSWORD', 'Forgot password', 'Dear $_UserName_ , <br>we have created for you a new password: $_TempPassword_ <br> Please use new password to login to our system.', 'en-US', 'Reset Password', 'tool@stgsolution.com', 'html', '2019-02-15 09:17:44.680743', 'SYSTEM', '2019-02-15 09:17:44.680743', 'SYSTEM', null, null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'REGISTER', 'Đăng ký thành công', '<html>
<head>
	<style type="text/css">
		.container{
			max-width: 550px;
			margin: 0 auto;
		}
		.header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
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
		}

		.body {
			border-bottom-left-radius: 15px;
			border-bottom-right-radius: 15px;
		}

		.content {
			padding: 10px;
		}

		.logo {
			width: 100px;
			height: 100px;
		}

		.stress {
			font-weight: bold;
			color: <#if ProviderEmailColor??>${ProviderEmailColor}

			<#else>#7058B7</#if>;
		}

		.separator {
			border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

			<#else>#F0F1F5</#if>;
			margin-left: -10px;
			margin-right: -10px;
		}

		.avatar-big {
			width: 100px;
			height: 100px;
		}

		.table {
			table-layout: fixed;
			width: 100%;
		}

		tr>td.sender-info {
			color: #C4C4CE;
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
			width: 100%;
			line-height: 50px;
			border-radius: 25px;
			text-align: center;

			background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

			<#else>#7058B7</#if>;
			border: none;
			margin: auto;
		}

		a.payment-label {
			color: #fff !important;
			font-weight: bold;
			text-decoration: none;
			text-transform: capitalize;
			font-size: 16px;
		}

		.link-label {
			color: #C4C4CE;
		}

		.origin-price {
			text-decoration: line-through;
		}
		@media (max-width: 600px){
			.container{
			max-width: 450px;
		}
		.header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
			font-size: 18px;
		}
		}
		@media (max-width: 500px){
			.container{
			max-width: 400px;
		}
		.header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
		}
	</style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
	<div class="horizontal-center" >
		<span class="provider-name">${ProviderName}</span>
	</div>
</div>

<div class="body">
	<div class="content">
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
				Để hoàn tất đăng ký, vui lòng thanh toán học phí khóa học, số tiền <b>${CourseFee}₫</b>
				<#if LimitPayDate??>, trước ngày
				<b>${LimitPayDate}</b>
			</#if> theo huớng dẫn sau đây:<br />
			<#else>
			Để hoàn tất đăng ký, vui lòng thanh toán trước toàn bộ học phí khóa học của các bạn để được huởng
			khuyến mãi
			đăng ký theo nhóm, số tiền <b>${CourseFee}₫ (<span
				class="origin-price">${CourseFeeOrigin}₫</span>)</b>, theo huớng dẫn sau đây:
		</#if>
		</td>
		</tr>
		<tr>
			<td>
				<img
						src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/icon_star_purple.png" />
				Chuyển
				tiền vào số tài khoản:
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
				<img
						src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/icon_star_purple.png" />
				Nội dung:
				</span><b>${PaymentCode}</b> (mã đăng ký của bạn)
			</td>
		</tr>
		<tr>
			<td class="margin-v-1">
				<div class="payment-button">
					<a href="${BillLink}" class="payment-label">THANH TOÁN</a>
				</div>
			</td>
		</tr>
		<tr>
			<td class="padding-v-1">
				(Vui lòng bỏ qua mục thanh toán nếu bạn đã hoàn tất thanh toán)
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
		<td class="padding-v-1 link-label">
			Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>
		</td>
	</tr>
	</table>
	<div class="separator margin-v-1"></div>
	<table class="table">
		<tr>
			<td class="avatar-big">
				<img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
			</td>
			<td class="margin-1 sender-info  padding-1">
				<div><b>${ProviderSignature?if_exists}</b></div>
				<div>Địa chỉ: ${ProviderLocation?if_exists}</div>
				<div>Hotline: <span class="stress">${ProviderPhone?if_exists}</span></div>
				<div>
					Email: <span class="stress">${ProviderEmail?if_exists}</span>
				</div>
				<div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
			</td>
		</tr>
	</table>
</div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-03-23 04:55:49.246115', 'SYSTEM', '2020-03-23 04:55:49.246115', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'REGISTER_PROVIDER', 'Đăng ký mới', '<html>

<head>
	<style type="text/css">
		.container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

		.logo {
			width: 100px;
			height: 100px;
		}

		.stress {
			font-weight: bold;

			color: <#if ProviderEmailColor??>${ProviderEmailColor}

			<#else>#7058B7</#if>;
		}

		.separator {
			border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

			<#else>#F0F1F5</#if>;
			margin-left: -10px;
			margin-right: -10px;
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
		@media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
	</style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
	<div class="horizontal-center" >
		<span class="provider-name">${ProviderName}</span>
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
					Chúc mừng <b>${ProviderName}</b>, khoá học / bài viết <b>${CourseName}</b> bắt đầu vào <b>${StartDate}</b>
					vừa có một đăng
					ký mới, thông tin chi tiết như sau:
					<#else>
					Chúc mừng <b>${ProviderName}</b>, khoá học / bài viết <b>${CourseName}</b> vừa có một đăng
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
		<#if CourseType=="SEASON">
		<#if PaymentType=="PAID">
		<tr>
			<td class="padding-v-1">
				Tổng số tiền : <b>${CourseFee}₫</b>
			</td>
		</tr>
		<#else>
		Đây là khoá học / chương trình miễn phí.
	</#if>
</#if>
<tr>
	<td class="padding-v-1">
		Thông tin học viên / khách hàng đăng ký đã được lưu lại trong hệ thống của Bukizi, bạn có thể truy cập <b><a
			href="${CourseLink}">tại đây</a></b> để quản lý khóa học / baì viết này.
	</td>
</tr>
</table>
</div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-03-23 04:55:49.246115', 'SYSTEM', '2020-03-23 04:55:49.246115', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'REMIND_PAY', 'Nhắc thanh toán', '<html>

<head>
  <style type="text/css">
      .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }
    tr>td.sender-info {
      color: #6C6B85;
    }

    .link-label {
      color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

    .logo {
      width: 100px;
      height: 100px;
    }

    .stress {
      font-weight: bold;

      color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#F0F1F5</#if>;
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

      background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
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
    @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
  </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
  <div class="horizontal-center" >
    <span class="provider-name">${ProviderName}</span>
  </div>
</div>

<div class="body">
  <div class="content">
    <!-- <div class="horizontal-center padding-1">
        <img
          class="logo"
          src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/payment.png"
        />
      </div> -->
    <table class="table padding-1">
      <tr>
        <td class="padding-v-1">Xin chào <b>
          <#list Consumers as Consumer>
          ${Consumer.name},
        </#list>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Khoá học <b>${CourseName}</b> sẽ khai giảng vào
          <b>${StartDate}</b>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Mã đăng ký của bạn là: <span class="stress">${PaymentCode}</span>.
        </td>
      </tr>
      <#if PaymentType=="PAID">
      <tr>
        <td class="padding-v-1">
          <#if Consumers?size==1>
          Vui lòng thanh toán học phí khóa học, số tiền
          <b>${CourseFee}₫</b>, trước ngày <b>${LimitPayDate}</b> theo huớng
          dẫn sau đây:
          <#else>
          Để được huởng ưu đãi khi đăng ký theo nhóm, vui lòng thanh toán tổng toàn bộ học phí khóa học của các
          bạn, số tiền <b>${CourseFee}₫ (<span class="origin-price">${CourseFeeOrigin}₫</span>)</b>
          <#if LimitPayDate??>, trước ngày <b>${LimitPayDate}</b></#if> theo huớng dẫn sau đây:
      </#if>
      </td>
      </tr>
      <tr>
        <td>
          <img src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/star.png" /> Chuyển
          tiền vào số tài khoản:
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
    </#if>
    <tr>
      <td class="padding-v-1 link-label">
        Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>
      </td>
    </tr>
    </table>
    <div class="separator margin-v-1"></div>
    <table class="table">
      <tr>
        <td class="avatar-big ">
          <img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
        </td>
        <td class="margin-1 sender-info  padding-1">
          <div><b>${ProviderSignature?if_exists}</b></div>
          <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
          <div>
            Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
          </div>
          <div>
            Email: <span class="stress">${ProviderEmail?if_exists}</span>
          </div>
          <div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-03-23 04:55:49.246115', 'SYSTEM', '2020-03-23 04:55:49.246115', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'ANNOUNCEMENT', '$_Title_', '<html>

<head>
  <style type="text/css">
    .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }
    tr>td.sender-info {
      color: #6C6B85;
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
        border-bottom-left-radius: 15px;
        border-bottom-right-radius: 15px;
    }

    .logo {
      width: 100px;
      height: 100px;
    }

    .stress {
      font-weight: bold;

      color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#F0F1F5</#if>;
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
    @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
  </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
  <div class="horizontal-center" >
    <span class="provider-name">${ProviderName}</span>
  </div>
</div>
<div class="body">
  <div class="content">
    <table class="table padding-1">
      <tr>
        <td class="padding-v-1">Xin chào <b>${ConsumerName}</b>,</td>
      </tr>
      <#if CourseName??>
      <tr>
        <td class="padding-v-1">
          Trung tâm trân trọng gửi bạn thông báo mới nhất từ khoá học
          <b>${CourseName}</b>:
        </td>
      </tr>
    </#if>
    <tr>
      <td class="padding-v-1">
        ${Content}
      </td>
    </tr>
    </table>
    <div class="separator margin-v-1"></div>
    <table class="table">
      <tr>
        <td class="avatar-big">
          <img class="avatar-big avatar " src="${ProviderAvatar?if_exists}" />
        </td>
        <td class="margin-1 sender-info  padding-1">
          <div><b>${ProviderSignature?if_exists}</b></div>
          <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
          <div>
            Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
          </div>
          <div>
            Email: <span class="stress">${ProviderEmail?if_exists}</span>
          </div>
          <div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-06-09 03:30:19.136371', 'SYSTEM', '2020-06-09 03:30:19.136371', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'REMIND_STUDY', 'Nhắc lịch khai giảng', '<html>

<head>
  <style type="text/css">
    .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }

    tr>td.sender-info {
      color: #6C6B85;
    }

    .link-label {
      color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

    .logo {
      width: 100px;
      height: 100px;
    }

    .stress {
      font-weight: bold;

      color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#F0F1F5</#if>;
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
    @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
  </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
  <div class="horizontal-center" >
    <span class="provider-name">${ProviderName}</span>
  </div>
</div>

<div class="body">
  <div class="content">
    <!-- <div class="horizontal-center padding-1">
      <img class="logo" src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/alarm.png" />
    </div> -->
    <table class="table padding-1">
      <tr>
        <td class="padding-v-1">Xin chào <b>
          <#list Consumers as Consumer>
          ${Consumer.name},
        </#list>
          </b>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Khóa học <b>${CourseName}</b> sẽ khai giảng vào <b>${StartDate}</b>.
        </td>
      </tr>

      <tr>
        <td class="padding-v-1">
          Hãy tham gia lớp học đúng giờ nhé!
        </td>
      </tr>
      <tr>
        <td class="padding-v-1 link-label">
          Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>.
        </td>
      </tr>
    </table>
    <div class="separator margin-v-1"></div>
    <table class="table">
      <tr>
        <td class="avatar-big">
          <img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
        </td>
        <td class="margin-1 sender-info  padding-1">
          <div><b>${ProviderSignature?if_exists}</b></div>
          <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
          <div>
            Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
          </div>
          <div>
            Email: <span class="stress">${ProviderEmail?if_exists}</span>
          </div>
          <div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-03-23 04:55:49.246115', 'SYSTEM', '2020-03-23 04:55:49.246115', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'PAYMENT_SUCCESS', 'Xác nhận thanh toán', '<html>

<head>
  <style type="text/css">
    .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }

    tr>td.sender-info {
      color: #6C6B85;
    }

    .link-label {
      color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }
    .logo {
      width: 100px;
      height: 100px;
    }

    .stress {
      font-weight: bold;

      color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#F0F1F5</#if>;
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
    @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
  </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
  <div class="horizontal-center" >
    <span class="provider-name">${ProviderName}</span>
  </div>
</div>

<div class="body">
  <div class="content">
    <!-- <div class="horizontal-center padding-1">
      <img class="logo" src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/congrat.png" />
    </div> -->
    <table class="table padding-1">
      <tr>
        <td class="padding-v-1">Xin chào <b>
          <#list Consumers as Consumer>
          ${Consumer.name},
        </#list>
          </b>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Chúc mừng <#if Consumers?size gt 1>các </#if>bạn đã thanh toán thành công cho khóa học <b>${CourseName}</b>,
        khai giảng vào <b>${StartDate}</b>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Mã đăng ký là: <span class="stress">${PaymentCode}</span>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Thanh toán ngày: <span class="stress">${PayDate}</span>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          <ul>
            <#list Consumers as Consumer>
            <li>
              Họ và tên: <b>${Consumer.name}</b><br />
              Email: <b>${Consumer.email}</b><br />
              <#if Consumer.phone??>
              Số điện thoại: <b>${Consumer.phone}</b><br />
            </#if>
            </li>
          </#list>
          </ul>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1 link-label">
          Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>.
        </td>
      </tr>
    </table>
    <div class="separator margin-v-1"></div>
    <table class="table">
      <tr>
        <td class="avatar-big">
          <img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
        </td>
        <td class="margin-1 sender-info  padding-1">
          <div><b>${ProviderSignature?if_exists}</b></div>
          <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
          <div>
            Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
          </div>
          <div>
            Email: <span class="stress">${ProviderEmail?if_exists}</span>
          </div>
          <div>
          Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span>
          </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-03-23 04:55:49.246115', 'SYSTEM', '2020-03-23 04:55:49.246115', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'PAYMENT_SUCCESS_PROVIDER', 'Xác nhận thanh toán', '<html>

<head>
  <style type="text/css">
    .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }

    tr>td.sender-info {
      color: #6C6B85;
    }

    .link-label {
      color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

    .logo {
      width: 100px;
      height: 100px;
    }

    .stress {
      font-weight: bold;

      color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#F0F1F5</#if>;
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
    @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
  </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
  <div class="horizontal-center" >
    <span class="provider-name">${ProviderName}</span>
  </div>
</div>

<div class="body">
  <div class="content">
    <!-- <div class="horizontal-center padding-1">
      <img class="logo"
        src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/payment.png" />
    </div> -->
    <table class="table padding-1">
      <tr>
        <td class="padding-v-1">
          Chúc mừng <b>${ProviderName}</b>, khoá học <b>${CourseName}</b> sẽ khai giảng vào <b>${StartDate}</b> vừa có
          một xác nhận thanh toán mới, thông tin chi tiết như sau:
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Mã đăng ký là: <span class="stress">${PaymentCode}</span>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          <ul>
            <#if Consumers??>
            <#list Consumers as Consumer>
            <li>
              Họ và tên: <b>${Consumer.name}</b><br />
              Email: <b>${Consumer.email}</b><br />
              <#if Consumer.phone??>Số điện thoại: <b>${Consumer.phone}</b><br /></#if>
            </li>
          </#list>
        </#if>
        </ul>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Tổng số tiền đã thanh toán: <b>${CourseFee}₫</b>
        </td>
      </tr>
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
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-03-23 04:55:49.246115', 'SYSTEM', '2020-03-23 04:55:49.246115', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'REVIEW', 'Đánh giá lớp học', '<html>

<head>
  <style type="text/css">
    .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;
        height: 120px;
        background-size: contain;
        background-repeat: no-repeat;

        background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

        <#else>#7058B7</#if>;
    }

    .horizontal-center{
        padding: 40px 0;
        text-align: center;
    }

    tr>td.sender-info {
      color: #6C6B85;
    }

    .link-label {
      color: #6C6B85;
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
      border-bottom-left-radius: 15px;
      border-bottom-right-radius: 15px;

    }


    .logo {
      width: 100px;
      height: 100px;
    }

    .stress {
      font-weight: bold;

      color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#F0F1F5</#if>;
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
      width: 1200px;
      height: 50px;
      border-radius: 25px;

      background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
      border: none;
      margin: auto;
    }

    a.payment-label {
      color: #fff !important;
      font-weight: bold;
      text-decoration: none;
    }
    @media (max-width: 600px){
      .container{
      max-width: 450px;
    }
    .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
      font-size: 18px;
    }
    }
    @media (max-width: 500px){
      .container{
      max-width: 400px;
    }
    .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
    }
  </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
  <div class="horizontal-center" >
    <span class="provider-name">${ProviderName}</span>
  </div>
</div>

<div class="body">
  <div class="content">
    <!-- <div class="horizontal-center padding-1">
      <img class="logo" src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/review.png" />
    </div> -->
    <table class="table padding-1">
      <tr>
        <td class="padding-v-1">Chào <b>
          <#list Consumers as Consumer>
          ${Consumer.name},
        </#list>
          </b>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          <b>${ProviderName}</b> rất vui khi nhận được ý kiến từ phía học viên nhằm nâng cao chất lượng dịch vụ đào
          tạo. Rất mong quý học viên dành chút thời gian hoàn thành bảng đánh giá sau khóa học ${CourseName} - Khai
          giảng ${StartDate}
        </td>
      </tr>
      <tr>
        <td class="horizontal-center margin-v-1">
          <div class="payment-button vertical-center">
            <a href="${ReviewLink}" class="horizontal-center payment-label">ĐÁNH GIÁ</a>
          </div>
        </td>
      </tr>
    </table>
    <div class="separator margin-v-1"></div>
    <table class="table">
      <tr>
        <td class="avatar-big">
          <img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
        </td>
        <td class="margin-1 sender-info  padding-1">
          <div><b>${ProviderSignature?if_exists}</b></div>
          <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
          <div>
            Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
          </div>
          <div>
            Email: <span class="stress">${ProviderEmail?if_exists}</span>
          </div>
          <div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-05-08 01:05:59.952954', 'SYSTEM', '2020-05-08 01:05:59.952954', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'RESET_PASSWORD', 'Quên mật khẩu', '<html>

<head>
    <style type="text/css">
        .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }

        tr>td.sender-info {
            color: #6C6B85;
        }

        .link-label {
            color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }
        .logo {
            width: 100px;
            height: 100px;
        }

        .stress {
            font-weight: bold;

            color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .separator {
            border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#F0F1F5</#if>;
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
        @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
    </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
    <div class="horizontal-center" >
        <span class="provider-name">${ProviderName}</span>
    </div>
</div>

<div class="body">
    <div class="content">
        <table class="table padding-1">
            <tr>
                <td class="padding-v-1">Xin chào <b>${UserName?if_exists},</b></td>
            </tr>
            <tr>
                <td class="padding-v-1"> Hệ thống đã tạo lại mật khẩu cho bạn: <span
                    class="stress">${TempPassword?if_exists}</span></td>
            </tr>
            <tr>
                <td class="padding-v-1">Hãy sử dụng mật khẩu mới đăng nhập vào hệ thống và thay đổi mật khẩu cũ của bạn.</td>
            </tr>
        </table>
    </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-06-30 10:47:02.277465', 'SYSTEM', '2020-06-30 10:47:02.277465', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'CANCEL_COURSE', 'Khoá học $_CourseName_ bị huỷ', '<html>

<head>
    <style type="text/css">
      .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }
        tr>td.sender-info {
            color: #6C6B85;
        }

        .link-label {
            color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

        .logo {
            width: 100px;
            height: 100px;
        }

        .stress {
            font-weight: bold;

            color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .separator {
        border-bottom: 1px solid <#if ProviderEmailColor??>$ {ProviderEmailColor}

        <#else>#fff</#if>;
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
        @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
    </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
    <div class="horizontal-center" >
        <span class="provider-name">${ProviderName}</span>
    </div>
</div>

<div class="body">
    <div class="content">
        <table class="table padding-1">
            <tr>
                <td class="padding-v-1">Xin chào <b>${ConsumerName}</b>,</td>
            </tr>
            <tr>
                <td class="padding-v-1">
                    Khoá học <b>${CourseName}</b> bạn đăng ký đã bị huỷ.
                </td>
            </tr>
            <tr>
                <td class="padding-v-1">
                    Xin lỗi bạn vì sự bất tiện này.
                </td>
            </tr>
        </table>
        <div class="separator margin-v-1"></div>
        <table class="table">
            <tr>
                <td class="avatar-big">
                    <img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
                </td>
                <td class="margin-1 sender-info  padding-1">
                    <div><b>${ProviderSignature?if_exists}</b></div>
                    <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
                    <div>
                        Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
                    </div>
                    <div>
                        Email: <span class="stress">${ProviderEmail?if_exists}</span>
                    </div>
                     <div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-07-01 09:13:27.216113', 'SYSTEM', '2020-06-30 10:47:02.277465', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'MOVE_CONSUMER', 'Chuyển khoá học', '<html>

<head>
    <style type="text/css">
        .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }

        tr>td.sender-info {
            color: #6C6B85;
        }

        .link-label {
            color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

        .logo {
            width: 100px;
            height: 100px;
        }

        .stress {
            font-weight: bold;

            color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .separator {
            border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#F0F1F5</#if>;
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
        @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
    </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
    <div class="horizontal-center" >
        <span class="provider-name">${ProviderName}</span>
    </div>
</div>

<div class="body">
    <div class="content">
        <!-- <div class="horizontal-center padding-1">
            <img
              class="logo"
              src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/announcement.png"
            />
          </div> -->
        <table class="table padding-1">
            <tr>
                <td class="padding-v-1">Xin chào <b>${ConsumerName}</b>,</td>
            </tr>
            <tr>
                <td class="padding-v-1">
                    Bạn đã được chuyển từ khoá hoc <b>${CourseName}</b> sang khoá học <b>${DestinationCourseName}</b>
                </td>
            </tr>
            <tr>
                <td class="padding-v-1 link-label">
                    Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>
                </td>
            </tr>
        </table>
        <div class="separator margin-v-1"></div>
        <table class="table">
            <tr>
                <td class="avatar-big">
                    <img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
                </td>
                <td class="margin-1 sender-info  padding-1">
                    <div><b>${ProviderSignature?if_exists}</b></div>
                    <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
                    <div>
                        Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
                    </div>
                    <div>
                        Email: <span class="stress">${ProviderEmail?if_exists}</span>
                    </div>
                     <div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-07-01 09:13:27.216113', 'SYSTEM', '2020-06-30 10:47:02.277465', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'VERIFY_EMAIL', 'Xác nhận đăng ký mới', '<html>

<head>
    <style type="text/css">
            .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }
        tr>td.sender-info {
            color: #6C6B85;
        }

        .link-label {
            color: #6C6B85;
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
            /*border: 1px solid <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;*/
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
            padding: 20px;
        }

        .content {
            /*border: 1px solid <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
            border-radius: 15px;
            padding: 10px;*/
        }

        .logo {
            width: 100px;
            height: 100px;
        }

        .stress {
            font-weight: bold;

            color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .separator {
            border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#F0F1F5</#if>;
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
        @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
    </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
    <div class="horizontal-center" >
        <span class="provider-name">${ProviderName}</span>
    </div>
</div>

<div class="body">
    <div class="content">
        <table class="table padding-1">
            <tr>
                <td class="padding-v-1">Xin chào <b>${Username?if_exists},</b></td>
            </tr>
            <tr>
                <td class="padding-v-1">Cám ơn bạn đã sử dụng nền tảng Bukizi</td>
            </tr>
            <tr>
                <td class="padding-v-1 link-label">Để kích hoạt tài khoản của bạn vui lòng nhấn <a
                    href="${LinkVerify?if_exists}"><span class="stress">vào đây</span></a>.</td>
            </tr>
        </table>
    </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-07-01 12:02:26.188333', 'SYSTEM', '2020-07-01 12:02:26.188333', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', 'CHANGE_EMAIL', 'Xác nhận thay đổi email', '<html>

<head>
    <style type="text/css">
      .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }
        tr>td.sender-info {
            color: #6C6B85;
        }

        .link-label {
            color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }
        .logo {
            width: 100px;
            height: 100px;
        }

        .stress {
            font-weight: bold;

            color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .separator {
            border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#F0F1F5</#if>;
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
        @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
    </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
    <div class="horizontal-center" >
        <span class="provider-name">${ProviderName}</span>
    </div>
</div>

<div class="body">
    <div class="content">
        <table class="table padding-1">
            <tr>
                <td class="padding-v-1">Xin chào <b>${Username?if_exists},</b></td>
            </tr>
            <tr>
                <td class="padding-v-1 link-label">Để thay đổi email của bạn vui lòng nhấn <a
                    href="${LinkVerify?if_exists}"><span class="stress">vào đây</span></a>.</td>
            </tr>
        </table>
    </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-07-01 12:02:26.188333', 'SYSTEM', '2020-07-01 12:02:26.188333', 'SYSTEM', 'tenant-bukizi', null);
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', '1:EDUCATION:REGISTER', 'Đăng ký thành công', '<html>
<head>
	<style type="text/css">
		.container{
			max-width: 550px;
			margin: 0 auto;
		}
		.header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
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
		}

		.body {
			border-bottom-left-radius: 15px;
			border-bottom-right-radius: 15px;
		}

		.content {
			padding: 10px;
		}

		.logo {
			width: 100px;
			height: 100px;
		}

		.stress {
			font-weight: bold;
			color: <#if ProviderEmailColor??>${ProviderEmailColor}

			<#else>#7058B7</#if>;
		}

		.separator {
			border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

			<#else>#F0F1F5</#if>;
			margin-left: -10px;
			margin-right: -10px;
		}

		.avatar-big {
			width: 100px;
			height: 100px;
		}

		.table {
			table-layout: fixed;
			width: 100%;
		}

		tr>td.sender-info {
			color: #C4C4CE;
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
			width: 100%;
			line-height: 50px;
			border-radius: 25px;
			text-align: center;

			background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

			<#else>#7058B7</#if>;
			border: none;
			margin: auto;
		}

		a.payment-label {
			color: #fff !important;
			font-weight: bold;
			text-decoration: none;
			text-transform: capitalize;
			font-size: 16px;
		}

		.link-label {
			color: #C4C4CE;
		}

		.origin-price {
			text-decoration: line-through;
		}
		@media (max-width: 600px){
			.container{
			max-width: 450px;
		}
		.header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
			font-size: 18px;
		}
		}
		@media (max-width: 500px){
			.container{
			max-width: 400px;
		}
		.header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
		}
	</style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
	<div class="horizontal-center" >
		<span class="provider-name">${ProviderName}</span>
	</div>
</div>

<div class="body">
	<div class="content">
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
				Để hoàn tất đăng ký, vui lòng thanh toán học phí khóa học, số tiền <b>${CourseFee}₫</b>
				<#if LimitPayDate??>, trước ngày
				<b>${LimitPayDate}</b>
			</#if> theo huớng dẫn sau đây:<br />
			<#else>
			Để hoàn tất đăng ký, vui lòng thanh toán trước toàn bộ học phí khóa học của các bạn để được huởng
			khuyến mãi
			đăng ký theo nhóm, số tiền <b>${CourseFee}₫ (<span
				class="origin-price">${CourseFeeOrigin}₫</span>)</b>, theo huớng dẫn sau đây:
		</#if>
		</td>
		</tr>
		<tr>
			<td>
				<img
						src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/icon_star_purple.png" />
				Chuyển
				tiền vào số tài khoản:
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
				<img
						src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/icon_star_purple.png" />
				Nội dung:
				</span><b>${PaymentCode}</b> (mã đăng ký của bạn)
			</td>
		</tr>
		<tr>
			<td class="margin-v-1">
				<div class="payment-button">
					<a href="${BillLink}" class="payment-label">THANH TOÁN</a>
				</div>
			</td>
		</tr>
		<tr>
			<td class="padding-v-1">
				(Vui lòng bỏ qua mục thanh toán nếu bạn đã hoàn tất thanh toán)
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
		<td class="padding-v-1 link-label">
			Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>
		</td>
	</tr>
	</table>
	<div class="separator margin-v-1"></div>
	<table class="table">
		<tr>
			<td class="avatar-big">
				<img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
			</td>
			<td class="margin-1 sender-info  padding-1">
				<div><b>${ProviderSignature?if_exists}</b></div>
				<div>Địa chỉ: ${ProviderLocation?if_exists}</div>
				<div>Hotline: <span class="stress">${ProviderPhone?if_exists}</span></div>
				<div>
					Email: <span class="stress">${ProviderEmail?if_exists}</span>
				</div>
				<div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
			</td>
		</tr>
	</table>
</div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-03-23 04:55:49.246115', 'SYSTEM', '2020-03-23 04:55:49.246115', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"Khóa_học", "PaymentCode":"Mã_thanh_toán","CourseFeeOrigin":"Học_phí_gốc","Consumers":[{"name":"Tên_học_viên"}],"StartDate":"HH:mm - Thứ x, dd/MM/yyyy","LimitPayDate":"dd/MM/yyyy","CourseLink":"Link_khóa_hoc","ProviderName":"Tên_trung_tâm","BankAccounts":["Thông_tin_tài_khoản_ngân_hàng_1","Thông_tin_tài_khoản_ngân_hàng_2"],"CourseFee":"Học_phí","BillLink":"Link_thanh_toán","ProviderLocation":"Địa_chỉ","ProviderPhone":"Điện_thoại","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","ProviderEmail":"Email","MoreInfo":"Thông_tin_bổ_sung_thêm"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', '2:EDUCATION:REMIND_PAY', 'Nhắc thanh toán', '<html>

<head>
  <style type="text/css">
      .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }
    tr>td.sender-info {
      color: #6C6B85;
    }

    .link-label {
      color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

    .logo {
      width: 100px;
      height: 100px;
    }

    .stress {
      font-weight: bold;

      color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#F0F1F5</#if>;
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

      background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
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
    @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
  </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
  <div class="horizontal-center" >
    <span class="provider-name">${ProviderName}</span>
  </div>
</div>

<div class="body">
  <div class="content">
    <!-- <div class="horizontal-center padding-1">
        <img
          class="logo"
          src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/payment.png"
        />
      </div> -->
    <table class="table padding-1">
      <tr>
        <td class="padding-v-1">Xin chào <b>
          <#list Consumers as Consumer>
          ${Consumer.name},
        </#list>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Khoá học <b>${CourseName}</b> sẽ khai giảng vào
          <b>${StartDate}</b>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Mã đăng ký của bạn là: <span class="stress">${PaymentCode}</span>.
        </td>
      </tr>
      <#if PaymentType=="PAID">
      <tr>
        <td class="padding-v-1">
          <#if Consumers?size==1>
          Vui lòng thanh toán học phí khóa học, số tiền
          <b>${CourseFee}₫</b>, trước ngày <b>${LimitPayDate}</b> theo huớng
          dẫn sau đây:
          <#else>
          Để được huởng ưu đãi khi đăng ký theo nhóm, vui lòng thanh toán tổng toàn bộ học phí khóa học của các
          bạn, số tiền <b>${CourseFee}₫ (<span class="origin-price">${CourseFeeOrigin}₫</span>)</b>
          <#if LimitPayDate??>, trước ngày <b>${LimitPayDate}</b></#if> theo huớng dẫn sau đây:
      </#if>
      </td>
      </tr>
      <tr>
        <td>
          <img src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/star.png" /> Chuyển
          tiền vào số tài khoản:
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
    </#if>
    <tr>
      <td class="padding-v-1 link-label">
        Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>
      </td>
    </tr>
    </table>
    <div class="separator margin-v-1"></div>
    <table class="table">
      <tr>
        <td class="avatar-big ">
          <img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
        </td>
        <td class="margin-1 sender-info  padding-1">
          <div><b>${ProviderSignature?if_exists}</b></div>
          <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
          <div>
            Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
          </div>
          <div>
            Email: <span class="stress">${ProviderEmail?if_exists}</span>
          </div>
          <div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-03-23 04:55:49.246115', 'SYSTEM', '2020-03-23 04:55:49.246115', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"Khóa_học","PaymentCode":"Mã_thanh_toán","CourseFeeOrigin":"Học_phí","Consumers":[{"name":"Tên_học_viên","email":"Email"}],"ProviderLocation":"Địa_chỉ","StartDate":"HH:mm - Thứ x, dd/MM/yyyy","LimitPayDate":"dd/MM/yyyy","CourseLink":"Link_khóa_hoc","ProviderName":"Tên_trung_tâm","ProviderPhone":"Điện_thoại","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","BankAccounts":["Thông_tin_tài_khoản_ngân_hàng_1","Thông_tin_tài_khoản_ngân_hàng_2"],"CourseFee":"Học_phí","BillLink":"Link_thanh_toán","PaymentType":"PAID","ProviderEmail":"Email","MoreInfo":"Thông_tin_bổ_sung_thêm"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', '3:EDUCATION:ANNOUNCEMENT', '$_Title_', '<html>

<head>
  <style type="text/css">
    .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }
    tr>td.sender-info {
      color: #6C6B85;
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
        border-bottom-left-radius: 15px;
        border-bottom-right-radius: 15px;
    }

    .logo {
      width: 100px;
      height: 100px;
    }

    .stress {
      font-weight: bold;

      color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#F0F1F5</#if>;
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
    @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
  </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
  <div class="horizontal-center" >
    <span class="provider-name">${ProviderName}</span>
  </div>
</div>
<div class="body">
  <div class="content">
    <table class="table padding-1">
      <tr>
        <td class="padding-v-1">Xin chào <b>${ConsumerName}</b>,</td>
      </tr>
      <#if CourseName??>
      <tr>
        <td class="padding-v-1">
          Trung tâm trân trọng gửi bạn thông báo mới nhất từ khoá học
          <b>${CourseName}</b>:
        </td>
      </tr>
    </#if>
    <tr>
      <td class="padding-v-1">
        ${Content}
      </td>
    </tr>
    </table>
    <div class="separator margin-v-1"></div>
    <table class="table">
      <tr>
        <td class="avatar-big">
          <img class="avatar-big avatar " src="${ProviderAvatar?if_exists}" />
        </td>
        <td class="margin-1 sender-info  padding-1">
          <div><b>${ProviderSignature?if_exists}</b></div>
          <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
          <div>
            Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
          </div>
          <div>
            Email: <span class="stress">${ProviderEmail?if_exists}</span>
          </div>
          <div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-06-09 03:30:19.136371', 'SYSTEM', '2020-06-09 03:30:19.136371', 'SYSTEM', 'tenant-bukizi', '{"ProviderName":"Tên_trung_tâm","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","ProviderPhone":"Điện_thoại","Content":"Nội_dung","ConsumerName":"Tên_học_viên","Title":"Tiêu_đề","ProviderEmail":"Email","ProviderLocation":"Địa_chỉ","MoreInfo":"Thông_tin_bổ_sung_thêm"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', '4:EDUCATION:REMIND_STUDY', 'Nhắc lịch khai giảng', '<html>

<head>
  <style type="text/css">
    .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }

    tr>td.sender-info {
      color: #6C6B85;
    }

    .link-label {
      color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

    .logo {
      width: 100px;
      height: 100px;
    }

    .stress {
      font-weight: bold;

      color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#F0F1F5</#if>;
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
    @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
  </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
  <div class="horizontal-center" >
    <span class="provider-name">${ProviderName}</span>
  </div>
</div>

<div class="body">
  <div class="content">
    <!-- <div class="horizontal-center padding-1">
      <img class="logo" src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/alarm.png" />
    </div> -->
    <table class="table padding-1">
      <tr>
        <td class="padding-v-1">Xin chào <b>
          <#list Consumers as Consumer>
          ${Consumer.name},
        </#list>
          </b>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Khóa học <b>${CourseName}</b> sẽ khai giảng vào <b>${StartDate}</b>.
        </td>
      </tr>

      <tr>
        <td class="padding-v-1">
          Hãy tham gia lớp học đúng giờ nhé!
        </td>
      </tr>
      <tr>
        <td class="padding-v-1 link-label">
          Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>.
        </td>
      </tr>
    </table>
    <div class="separator margin-v-1"></div>
    <table class="table">
      <tr>
        <td class="avatar-big">
          <img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
        </td>
        <td class="margin-1 sender-info  padding-1">
          <div><b>${ProviderSignature?if_exists}</b></div>
          <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
          <div>
            Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
          </div>
          <div>
            Email: <span class="stress">${ProviderEmail?if_exists}</span>
          </div>
          <div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-03-23 04:55:49.246115', 'SYSTEM', '2020-03-23 04:55:49.246115', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"Khóa_học","PaymentCode":"Mã_thanh_toán","CourseFeeOrigin":"Học_phí_gốc","Consumers":[{"name":"Tên_học_viên","email":"Email"}],"ProviderLocation":"Địa_chỉ","StartDate":"Thứ x, dd/MM/yyyy","LimitPayDate":"dd/MM/yyyy","CourseLink":"Link_khóa_hoc","ProviderName":"Tên_trung_tâm","ProviderPhone":"Điện_thoại","BankAccounts":["Thông_tin_tài_khoản_ngân_hàng_1","Thông_tin_tài_khoản_ngân_hàng_2"],"CourseFee":"Học_phí","BillLink":"Link_thanh_toán","PaymentType": "FREE","ProviderEmail":"Email","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","MoreInfo":"Thông_tin_bổ_sung_thêm"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', '5:EDUCATION:PAYMENT_SUCCESS', 'Xác nhận thanh toán', '<html>

<head>
  <style type="text/css">
    .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }

    tr>td.sender-info {
      color: #6C6B85;
    }

    .link-label {
      color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }
    .logo {
      width: 100px;
      height: 100px;
    }

    .stress {
      font-weight: bold;

      color: <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

      <#else>#F0F1F5</#if>;
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
    @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
  </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
  <div class="horizontal-center" >
    <span class="provider-name">${ProviderName}</span>
  </div>
</div>

<div class="body">
  <div class="content">
    <!-- <div class="horizontal-center padding-1">
      <img class="logo" src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/congrat.png" />
    </div> -->
    <table class="table padding-1">
      <tr>
        <td class="padding-v-1">Xin chào <b>
          <#list Consumers as Consumer>
          ${Consumer.name},
        </#list>
          </b>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Chúc mừng <#if Consumers?size gt 1>các </#if>bạn đã thanh toán thành công cho khóa học <b>${CourseName}</b>,
        khai giảng vào <b>${StartDate}</b>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Mã đăng ký là: <span class="stress">${PaymentCode}</span>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Thanh toán ngày: <span class="stress">${PayDate}</span>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          <ul>
            <#list Consumers as Consumer>
            <li>
              Họ và tên: <b>${Consumer.name}</b><br />
              Email: <b>${Consumer.email}</b><br />
              <#if Consumer.phone??>
              Số điện thoại: <b>${Consumer.phone}</b><br />
            </#if>
            </li>
          </#list>
          </ul>
        </td>
      </tr>
      <tr>
        <td class="padding-v-1 link-label">
          Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>.
        </td>
      </tr>
    </table>
    <div class="separator margin-v-1"></div>
    <table class="table">
      <tr>
        <td class="avatar-big">
          <img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
        </td>
        <td class="margin-1 sender-info  padding-1">
          <div><b>${ProviderSignature?if_exists}</b></div>
          <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
          <div>
            Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
          </div>
          <div>
            Email: <span class="stress">${ProviderEmail?if_exists}</span>
          </div>
          <div>
          Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span>
          </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-03-23 04:55:49.246115', 'SYSTEM', '2020-03-23 04:55:49.246115', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"Khóa_học","PaymentCode":"Mã_thanh_toán","Consumers":[{"name":"Tên_học_viên","email":"Email"}],"ProviderLocation":"Địa_chỉ","StartDate":"Thứ x, dd/MM/yyyy","LimitPayDate":"dd/MM/yyyy","CourseLink":"Link_khóa_hoc","ProviderName":"Tên_trung_tâm","ProviderPhone":"Điện_thoại","PayDate":"dd/MM/yyyy","PaymentType":"PAID","CourseFee":"Học_phí","ProviderEmail":"Email","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","MoreInfo":"Thông_tin_bổ_sung_thêm"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', '6:EDUCATION:CANCEL_COURSE', 'Khoá học $_CourseName_ bị huỷ', '<html>

<head>
    <style type="text/css">
      .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }
        tr>td.sender-info {
            color: #6C6B85;
        }

        .link-label {
            color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

        .logo {
            width: 100px;
            height: 100px;
        }

        .stress {
            font-weight: bold;

            color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .separator {
        border-bottom: 1px solid <#if ProviderEmailColor??>$ {ProviderEmailColor}

        <#else>#fff</#if>;
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
        @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
    </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
    <div class="horizontal-center" >
        <span class="provider-name">${ProviderName}</span>
    </div>
</div>

<div class="body">
    <div class="content">
        <table class="table padding-1">
            <tr>
                <td class="padding-v-1">Xin chào <b>${ConsumerName}</b>,</td>
            </tr>
            <tr>
                <td class="padding-v-1">
                    Khoá học <b>${CourseName}</b> bạn đăng ký đã bị huỷ.
                </td>
            </tr>
            <tr>
                <td class="padding-v-1">
                    Xin lỗi bạn vì sự bất tiện này.
                </td>
            </tr>
        </table>
        <div class="separator margin-v-1"></div>
        <table class="table">
            <tr>
                <td class="avatar-big">
                    <img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
                </td>
                <td class="margin-1 sender-info  padding-1">
                    <div><b>${ProviderSignature?if_exists}</b></div>
                    <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
                    <div>
                        Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
                    </div>
                    <div>
                        Email: <span class="stress">${ProviderEmail?if_exists}</span>
                    </div>
                     <div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-07-01 09:13:27.216113', 'SYSTEM', '2020-06-30 10:47:02.277465', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"Khóa_học","ProviderName":"Tên_trung_tâm","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","ProviderPhone":"Điện_thoại","ConsumerName":"Tên_học_viên","ProviderEmail":"Email","ProviderLocation":"Địa_chỉ","MoreInfo":"Thông_tin_bổ_sung_thêm"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', '7:EDUCATION:MOVE_CONSUMER', 'Chuyển khoá học', '<html>

<head>
    <style type="text/css">
        .container{
      max-width: 550px;
      margin: 0 auto;
    }
    .header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
        }

        tr>td.sender-info {
            color: #6C6B85;
        }

        .link-label {
            color: #6C6B85;
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
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

        .logo {
            width: 100px;
            height: 100px;
        }

        .stress {
            font-weight: bold;

            color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .separator {
            border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#F0F1F5</#if>;
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
        @media (max-width: 600px){
            .container{
            max-width: 450px;
        }
        .header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
            font-size: 18px;
        }
        }
        @media (max-width: 500px){
            .container{
            max-width: 400px;
        }
        .header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
        }
    </style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
    <div class="horizontal-center" >
        <span class="provider-name">${ProviderName}</span>
    </div>
</div>

<div class="body">
    <div class="content">
        <!-- <div class="horizontal-center padding-1">
            <img
              class="logo"
              src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/announcement.png"
            />
          </div> -->
        <table class="table padding-1">
            <tr>
                <td class="padding-v-1">Xin chào <b>${ConsumerName}</b>,</td>
            </tr>
            <tr>
                <td class="padding-v-1">
                    Bạn đã được chuyển từ khoá hoc <b>${CourseName}</b> sang khoá học <b>${DestinationCourseName}</b>
                </td>
            </tr>
            <tr>
                <td class="padding-v-1 link-label">
                    Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>
                </td>
            </tr>
        </table>
        <div class="separator margin-v-1"></div>
        <table class="table">
            <tr>
                <td class="avatar-big">
                    <img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
                </td>
                <td class="margin-1 sender-info  padding-1">
                    <div><b>${ProviderSignature?if_exists}</b></div>
                    <div>Địa chỉ: ${ProviderLocation?if_exists}</div>
                    <div>
                        Hotline: <span class="stress">${ProviderPhone?if_exists}</span>
                    </div>
                    <div>
                        Email: <span class="stress">${ProviderEmail?if_exists}</span>
                    </div>
                     <div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>

</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-07-01 09:13:27.216113', 'SYSTEM', '2020-06-30 10:47:02.277465', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"Khóa_học","CourseLink":"Link_khóa_hoc","ProviderName":"Tên_trung_tâm","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","ProviderPhone":"Điện_thoại", "ConsumerName":"Tên_học_viên","ProviderEmail":"Email","DestinationCourseName":"Khóa_học_đến","ProviderLocation":"Địa_chỉ","MoreInfo":"Thông_tin_bổ_sung_thêm"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'EMAIL', '8:EDUCATION:REGISTER', 'Đăng ký thành công', '<html>
<head>
	<style type="text/css">
		.container{
			max-width: 550px;
			margin: 0 auto;
		}
		.header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;

            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

            <#else>#7058B7</#if>;
        }

        .horizontal-center{
            padding: 40px 0;
            text-align: center;
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
		}

		.body {
			border-bottom-left-radius: 15px;
			border-bottom-right-radius: 15px;
		}

		.content {
			padding: 10px;
		}

		.logo {
			width: 100px;
			height: 100px;
		}

		.stress {
			font-weight: bold;
			color: <#if ProviderEmailColor??>${ProviderEmailColor}

			<#else>#7058B7</#if>;
		}

		.separator {
			border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}

			<#else>#F0F1F5</#if>;
			margin-left: -10px;
			margin-right: -10px;
		}

		.avatar-big {
			width: 100px;
			height: 100px;
		}

		.table {
			table-layout: fixed;
			width: 100%;
		}

		tr>td.sender-info {
			color: #C4C4CE;
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
			width: 100%;
			line-height: 50px;
			border-radius: 25px;
			text-align: center;

			background-color: <#if ProviderEmailColor??>${ProviderEmailColor}

			<#else>#7058B7</#if>;
			border: none;
			margin: auto;
		}

		a.payment-label {
			color: #fff !important;
			font-weight: bold;
			text-decoration: none;
			text-transform: capitalize;
			font-size: 16px;
		}

		.link-label {
			color: #C4C4CE;
		}

		.origin-price {
			text-decoration: line-through;
		}
		@media (max-width: 600px){
			.container{
			max-width: 450px;
		}
		.header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
			font-size: 18px;
		}
		}
		@media (max-width: 500px){
			.container{
			max-width: 400px;
		}
		.header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
		}
	</style>
</head>

<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
	<div class="horizontal-center" >
		<span class="provider-name">${ProviderName}</span>
	</div>
</div>

<div class="body">
	<div class="content">
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
				Để hoàn tất đăng ký, vui lòng thanh toán học phí khóa học, số tiền <b>${CourseFee}₫</b>
				<#if LimitPayDate??>, trước ngày
				<b>${LimitPayDate}</b>
			</#if> theo huớng dẫn sau đây:<br />
			<#else>
			Để hoàn tất đăng ký, vui lòng thanh toán trước toàn bộ học phí khóa học của các bạn để được huởng
			khuyến mãi
			đăng ký theo nhóm, số tiền <b>${CourseFee}₫ (<span
				class="origin-price">${CourseFeeOrigin}₫</span>)</b>, theo huớng dẫn sau đây:
		</#if>
		</td>
		</tr>
		<tr>
			<td>
				<img
						src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/icon_star_purple.png" />
				Chuyển
				tiền vào số tài khoản:
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
				<img
						src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/icon_star_purple.png" />
				Nội dung:
				</span><b>${PaymentCode}</b> (mã đăng ký của bạn)
			</td>
		</tr>
		<tr>
			<td class="margin-v-1">
				<div class="payment-button">
					<a href="${BillLink}" class="payment-label">THANH TOÁN</a>
				</div>
			</td>
		</tr>
		<tr>
			<td class="padding-v-1">
				(Vui lòng bỏ qua mục thanh toán nếu bạn đã hoàn tất thanh toán)
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
		<td class="padding-v-1 link-label">
			Xem lại thông tin khoá học <b><a href="${CourseLink}">tại đây</a></b>
		</td>
	</tr>
	</table>
	<div class="separator margin-v-1"></div>
	<table class="table">
		<tr>
			<td class="avatar-big">
				<img class="avatar-big avatar" src="${ProviderAvatar?if_exists}" />
			</td>
			<td class="margin-1 sender-info  padding-1">
				<div><b>${ProviderSignature?if_exists}</b></div>
				<div>Địa chỉ: ${ProviderLocation?if_exists}</div>
				<div>Hotline: <span class="stress">${ProviderPhone?if_exists}</span></div>
				<div>
					Email: <span class="stress">${ProviderEmail?if_exists}</span>
				</div>
				<div>Thông tin bổ sung: <span class="stress">${MoreInfo?if_exists}</span> </div>
			</td>
		</tr>
	</table>
</div>
</div>
</body>

</html>

<head>
	<style type="text/css">
		.container{
			max-width: 550px;
			margin: 0 auto;
		}
		.header {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 120px;
            background-size: contain;
            background-repeat: no-repeat;
            background-color: <#if ProviderEmailColor??>${ProviderEmailColor}
            <#else>#7058B7</#if>;
        }
        .horizontal-center{
            padding: 40px 0;
            text-align: center;
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
		}
		.body {
			border-bottom-left-radius: 15px;
			border-bottom-right-radius: 15px;
		}
		.content {
			padding: 10px;
		}
		.logo {
			width: 100px;
			height: 100px;
		}
		.stress {
			font-weight: bold;
			color: <#if ProviderEmailColor??>${ProviderEmailColor}
			<#else>#7058B7</#if>;
		}
		.separator {
			border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}
			<#else>#F0F1F5</#if>;
			margin-left: -10px;
			margin-right: -10px;
		}
		.avatar-big {
			width: 100px;
			height: 100px;
		}
		.table {
			table-layout: fixed;
			width: 100%;
		}
		tr>td.sender-info {
			color: #C4C4CE;
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
			width: 100%;
			line-height: 50px;
			border-radius: 25px;
			text-align: center;
			background-color: <#if ProviderEmailColor??>${ProviderEmailColor}
			<#else>#7058B7</#if>;
			border: none;
			margin: auto;
		}
		a.payment-label {
			color: #fff !important;
			font-weight: bold;
			text-decoration: none;
			text-transform: capitalize;
			font-size: 16px;
		}
		.link-label {
			color: #C4C4CE;
		}
		.origin-price {
			text-decoration: line-through;
		}
		@media (max-width: 600px){
			.container{
			max-width: 450px;
		}
		.header {
            height: 100px;
        }
        .horizontal-center{
            padding: 40px 0;
        }
        .provider-name {
			font-size: 18px;
		}
		}
		@media (max-width: 500px){
			.container{
			max-width: 400px;
		}
		.header {
            height: 88px;
        }
        .horizontal-center{
            padding: 30px 0;
        }
		}
	</style>
</head>
<body class="container">
<div class="header" style="background-image: url(''https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png'');">
	<div class="horizontal-center" >
		<span class="provider-name">${ProviderName}</span>
	</div>
</div>
<div class="body">
	<div class="content">
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
				Để hoàn tất đăng ký, vui lòng thanh toán học phí khóa học, số tiền <b>${CourseFee}₫</b>
				<#if LimitPayDate??>, trước ngày
				<b>${LimitPayDate}</b>
			</#if> theo huớng dẫn sau đây:<br />
			<#else>
			Để hoàn tất đăng ký, vui lòng thanh toán trước toàn bộ học phí khóa học của các bạn để được huởng
			khuyến mãi
			đăng ký theo nhóm,', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', '2020-03-23 04:55:49.246115', 'SYSTEM', '2020-03-23 04:55:49.246115', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"Khóa_học_XXXXX", "PaymentCode":"Mã_thanh_toán","CourseFeeOrigin":"Học_phí_gốc","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","Consumers":[{"name":"Tên_học_viên"}],"StartDate":"HH:mm - Thứ x, dd/MM/yyyy","LimitPayDate":"dd/MM/yyyy","CourseLink":"Link_khóa_hoc","ProviderName":"Tên_trung_tâm","BankAccounts":["Thông_tin_tài_khoản_ngân_hàng_1","Thông_tin_tài_khoản_ngân_hàng_2"],"CourseFee":"Học_phí","BillLink":"Link_thanh_toán","ProviderLocation":"Địa_chỉ","ProviderPhone":"Điện_thoại","ProviderEmail":"Email","MoreInfo":"Thông_tin_bổ_sung_thêm"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'SMS', '9:EDUCATION:PROMOTION', 'Khuyến mại khóa học', 'Khuyến mại khóa học $_CourseName_, $_PromotionDetail_, khai giảng $_StartDate_. Truy cập $_WebsiteUrl_ để biết thêm chi tiết.', 'vi-VN', 'Beestro', null, 'text', '2020-12-16 04:42:07.211901', 'SYSTEM', '2020-12-16 04:42:07.211901', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"<b>Tên_khóa_học</b>", "PromotionDetail":"<b>Chi_tiết_khuyến_mại</b>", "StartDate":"<b>Thời_gian</b>", "WebsiteUrl":"<b>Link_website</b>"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'SMS', '10:EDUCATION:GIFT', 'Quà tặng khóa học', 'Hoàn thành khóa học $_CourseName_ bạn sẽ nhận được ngay một phần quà trị giá $_GiftValue_ tới từ $_Sponsor_. Truy cập $_WebsiteUrl_ để biết thêm chi tiết.', 'vi-VN', 'Beestro', null, 'text', '2020-12-16 04:42:07.211901', 'SYSTEM', '2020-12-16 04:42:07.211901', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"<b>Tên_khóa_học</b>", "GiftValue":"<b>Quà_tặng</b>", "Sponsor":"<b>Tài_trợ</b>", "WebsiteUrl":"<b>Link_website</b>"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'SMS', '11:EDUCATION:PAYMENT_SUCCESS', 'Xác nhận thanh toán', 'Cảm ơn bạn đã thanh toán 100% tiền cho khóa học $_CourseName_. Bạn đã được xếp vào lớp $_ClassName_. Lớp học sẽ được triển khai vào $_StartDate_ tại $_Address_.', 'vi-VN', 'Beestro', null, 'text', '2020-12-16 04:42:07.211901', 'SYSTEM', '2020-12-16 04:42:07.211901', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"<b>Tên_khóa_học</b>", "ClassName":"<b>Tên_lớp</b>", "StartDate":"<b>Thời_gian</b>", "Address":"<b>Địa điểm</b>"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'SMS', '12:EDUCATION:REMIND_TEST', 'Thông báo lịch thi', 'Bài thi cuối kỳ khoá học $_CourseName_ của bạn sẽ diễn ra vào $_StartDate_ tại $_Address_, vui lòng đến thi đúng giờ.', 'vi-VN', 'Beestro', null, 'text', '2020-12-16 04:42:07.211901', 'SYSTEM', '2020-12-16 04:42:07.211901', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"<b>Tên_khóa_học</b>", "StartDate":"<b>Thời_gian</b>", "Address":"<b>Địa điểm</b>"}');
INSERT INTO public.template (template_id, type, code, title, message, language, from_name, from_address, encode, created_date, created_by, modified_date, modified_by, tenant_id, default_param_value) VALUES (default, 'SMS', '13:EDUCATION:PROMOTION', 'Khuyến mại khóa học', 'Khuyến mại khóa học $_CourseName_, $_PromotionDetail_, khai giảng $_StartDate_. Truy cập $_WebsiteUrl_ để biết thêm chi tiết.', 'vi-VN', 'Beestro', null, 'text', '2020-12-16 04:42:07.211901', 'SYSTEM', '2020-12-16 04:42:07.211901', 'SYSTEM', 'tenant-bukizi', '{"CourseName":"<b>Tên_khóa_học</b>", "PromotionDetail":"<b>Chi_tiết_khuyến_mại</b>", "StartDate":"<b>Thời_gian</b>", "WebsiteUrl":"<b>Link_website</b>"}');

