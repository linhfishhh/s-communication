alter table template
	add reply_to varchar(100);

alter table email
	add reply_to varchar(100);

INSERT INTO "public"."communication_template_group" ("id", "code", "type") VALUES (13, 'REMIND_PAY_INVOICE', 'EMAIL');
INSERT INTO "public"."communication_template" ("id", "provider_type", "model_name", "short_code", "type", "preview_url", "communication_template_group_id", "is_default", "created_date", "created_by", "modified_date", "modified_by", "provider_id", "template_code") VALUES (21, 'EDUCATION', '1', 'REMIND_PAY_INVOICE', 'EMAIL', 'https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/template_email.png', 13, true, DEFAULT, 'SYSTEM', DEFAULT, 'SYSTEM', null, '21:EDUCATION:REMIND_PAY_INVOICE');
INSERT INTO "public"."template" ("template_id", "type", "code", "title", "message", "language", "from_name", "from_address", "encode", "created_date", "created_by", "modified_date", "modified_by", "tenant_id", "default_param_value", "reply_to") VALUES (51, 'EMAIL', '21:EDUCATION:REMIND_PAY_INVOICE', 'Nhắc thanh toán hóa đơn', '<html>

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

    .color-red {
       color: red;
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

    .p-t-10 {
      padding-top: 10px;
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
     <div class="header" style="background-image: url('https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/hoa_las.png');">
       <div class="horizontal-center" >
         <span class="provider-name">${ProviderName?if_exists}</span>
       </div>
     </div>

     <div class="body">
       <div class="content">
         <table class="table padding-1">
           <tr>
             <td class="padding-v-1">Xin chào <b>
               ${ProviderLeadName?if_exists},
             </td>
           </tr>
           <tr>
             <td class="padding-v-1">
               Bạn có hóa đơn <b>${InvoiceCode?if_exists}</b> cần thanh toán trước ngày <b>${DeadlinePaidDate?if_exists}</b>.
             </td>
           </tr>
           <tr>
             <td class="padding-v-1">
               Chi tiết hóa đơn như sau:
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Tên hoá đơn</b>: ${InvoiceName?if_exists}
             </td>
           </tr>
                 <tr>
             <td class="p-t-10">
              <b>Mô tả:</b> ${InvoiceDescription?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Mã hoá đơn:</b> ${InvoiceCode?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Tên khách hàng:</b> ${ProviderLeadName?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Cơ sở:</b> ${BranchName?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Người tạo:</b> ${CreatorProfileRoleName?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Ngày khởi tạo:</b> ${CreatedDate?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Ngày cập nhật cuối:</b> ${ModifiedDate?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Giá trị hoá đơn</b>: <span class="color-red">${SubTotal?if_exists}</span>
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Khuyến mãi:</b> ${SaleAmountOrPercent?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Phụ thu:</b> ${SurchargeAmountOrPercent?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Số tiền cần thu:</b> ${Total?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Số tiền đã thanh toán:</b> ${PaidAmount?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
              <b>Số tiền còn nợ:</b> <span class="color-red">${RemainingAmount?if_exists}</span>
             </td>
           </tr>
           <tr>
             <td class="padding-v-1">
              <b>Ngày phải trả:</b> <span class="color-red">${DeadlinePaidDate?if_exists}</span>
             </td>
           </tr>
           <tr>
             <td class="padding-v-1">
               <img src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/star.png" /> Chuyển
               tiền vào số tài khoản:
             </td>
           </tr>
           <tr>
             <td>
               <ul>
                 <#list BankAccounts as BankAccount>
                 <li>
                   <b>${BankAccount?if_exists}<b>
                 </li>
               </#list>
               </ul>
             </td>
           </tr>
           <tr>
             <td>
               <img src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/star.png" /> Nội dung:
               </span><b>${InvoiceCode?if_exists}</b> (mã hóa đơn của bạn)
             </td>
           </tr>
           <tr>
               <td class="padding-v-1">Vui lòng bỏ qua email này nếu bạn đã thanh toán.</td>
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

     </html>', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemaker', null, 'SYSTEM', null, 'SYSTEM', 'tenant-bukizi', '{"ClassName":"Tên_lớp","ProviderName":"Tên_doanh_nghiệp","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","ProviderPhone":"Điện_thoại","ProviderEmail":"Email","ProviderLocation":"Địa_chỉ","MoreInfo":"Thông_tin_bổ_sung_thêm","ProviderSignature":"Chữ_ký","InvoiceName":"Tên_hoá_đơn","InvoiceDescription":"Mô_tả","InvoiceCode":"Mã_hóa_đơn","ProviderLeadName":"Tên_khách_hàng","BranchName":"Tên_chi_nhánh","CreatorProfileRoleName":"Người_tạo","CreatedDate":"Ngày_khởi_tạo","ModifiedDate":"Ngày_cập_nhật_cuối","SubTotal":"Giá_trị_hóa_đơn","SaleAmountOrPercent":"Khuyến_mại","SurchargeAmountOrPercent":"Phụ_thu","Total":"Số_tiền_cần_thu","PaidAmount":"Số_tiền_đã_thanh_toán","RemainingAmount":"Số_tiền_còn_nợ","DeadlinePaidDate":"Ngày_phải_trả","BankAccounts":["Tài_khoản_ngân_hàng"]}', null);