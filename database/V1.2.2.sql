insert into template(template_id,type, code, title, message, language, from_name, from_address, encode, tenant_id)
values
    (16,
     'EMAIL',
     'ANNOUNCE_INTERACTION_CHATBOT',
     'Thông báo người dùng tương tác',
     '<html>
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
      <p>
        Khách hàng <b>${UserName}</b> vừa chat trên <b>${PageName}</b>.
      </p>
      <p>
        Bạn vui lòng mở Fanpage để tư vấn.
      </p>
    </div>
  </div>
</body>
</html>
',
     'vi-VN',
     'Bukizi',
     'no-reply@bukizi.com',
     'freemaker',
     'tenant-bukizi');