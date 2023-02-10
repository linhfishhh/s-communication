INSERT INTO "public"."template" ("template_id", "type", "code", "title", "message", "language", "from_name", "from_address", "encode", "created_date", "created_by", "modified_date", "modified_by", "tenant_id", "default_param_value", "reply_to") VALUES (52, 'EMAIL', '22:EDUCATION:PROVIDER_REGISTER_ACCOUNT_FOR_STUDENT', 'Đăng ký tài khoản cho học viên mới thành công', '<html>

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

      background-color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#7058B7</#if>;
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
      color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#F0F1F5</#if>;
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
      color: #6C6B85;
    }


    .padding-1 {
      padding: 10px;
    }

    .padding-v-1 {
      padding-top: 10px;
      padding-bottom: 10px;
    }

    .pt-10 {
      padding-top: 10px;
    }

    .p-t-10 {
      padding-top: 10px;
    }

    .pb-10 {
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

      background-color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#7058B7</#if>;
      border: none;
      margin: 20px 0px;
    }

    a.payment-label {
      color: #fff !important;
      font-weight: bold;
      text-decoration: none;
      text-transform: capitalize;
      font-size: 16px;
    }

    .link-label {
      color: #6C6B85;
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
          Bạn đã được <b>${ProviderName?if_exists}</b> đăng ký thành công tài khoản:
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Chi tiết tài khoản như sau:
        </td>
      </tr>
      <tr>
        <td class="p-t-10">
          <b>Tên tài khoản</b>: ${Username?if_exists}
        </td>
      </tr>
      <tr>
        <td class="p-t-10">
          <b>Mật khẩu:</b> ${Password?if_exists}
        </td>
      </tr>
      <tr>
        <td class="p-t-10">
          <b>Tên:</b> ${ProviderLeadName?if_exists}
        </td>
      </tr>
      <tr>
        <td class="p-t-10">
          <b>Số điện thoại:</b> ${ProviderLeadPhone?if_exists}
        </td>
      </tr>
      <tr>
        <td class="p-t-10">
          <b>Email:</b> ${ProviderLeadEmail?if_exists}
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
          <div><span class="stress">${MoreInfo?if_exists}</span> </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</body>
</html>
', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'tenant-bukizi', '{"ProviderName":"Tên_doanh_nghiệp","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","ProviderPhone":"Điện_thoại","ProviderEmail":"Email","ProviderLocation":"Địa_chỉ","MoreInfo":"Thông_tin_bổ_sung_thêm","ProviderSignature":"Chữ_ký","Username":"Tài_khoản","Password":"Mật_khẩu", "ProviderLeadName":"Tên_học_viên","ProviderLeadPhone":"Điện_thoại","ProviderLeadEmail":"Email"}', null);


INSERT INTO "public"."template" ("template_id", "type", "code", "title", "message", "language", "from_name", "from_address", "encode", "created_date", "created_by", "modified_date", "modified_by", "tenant_id", "default_param_value", "reply_to") VALUES (53, 'EMAIL', '23:EDUCATION:EVALUATION_STUDENT', 'Đánh giá và nhận xét', '<html>

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

      background-color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#7058B7</#if>;
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
      color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#7058B7</#if>;
    }

    .separator {
      border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#F0F1F5</#if>;
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
      color: #6C6B85;
    }


    .padding-1 {
      padding: 10px;
    }

    .padding-v-1 {
      padding-top: 10px;
      padding-bottom: 10px;
    }

    .pt-10 {
      padding-top: 10px;
    }

    .p-t-10 {
      padding-top: 10px;
    }

    .pb-10 {
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

      background-color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#7058B7</#if>;
      border: none;
      margin: 20px 0px;
    }

    a.payment-label {
      color: #fff !important;
      font-weight: bold;
      text-decoration: none;
      text-transform: capitalize;
      font-size: 16px;
    }

    .link-label {
      color: #6C6B85;
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
    <span class="provider-name">${ProviderName?if_exists}</span>
  </div>
</div>

<div class="body">
  <div class="content">
    <table class="table padding-1">
      <tr>
        <td class="padding-v-1">Xin chào <b>
          ${StudentName?if_exists},
        </td>
      </tr>
      <tr>
        <td class="padding-v-1">
          Bạn có đánh giá và nhận xét cho bài tập <b>${ExerciseTitle?if_exists}</b>:
        </td>
      </tr>
      <tr>
        <td class="p-t-10">
          <b>Làm bài lần cuối vào</b>: ${EvaluationDate?if_exists}
        </td>
      </tr>
      <tr>
        <td class="p-t-10">
          <b>Tiến độ làm bài:</b> ${Inprocess?if_exists}%
        </td>
      </tr>
      <tr>
        <td class="p-t-10">
          <b>Điểm số hiện tại:</b> ${Score?if_exists}/${TotalQuestion?if_exists} câu hỏi
        </td>
      </tr>
      <tr>
        <td class="p-t-10">
          <b>Đánh giá:</b> ${EvaluationScore?if_exists} <img src="https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.dev/bukizi/static/star.png" />
        </td>
      </tr>
      <tr>
        <td class="p-t-10">
          <b>Nhận xét:</b> ${Evaluation?if_exists}
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
          <div><span class="stress">${MoreInfo?if_exists}</span> </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</body>

</html>', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'tenant-bukizi', '{"ProviderName":"Tên_doanh_nghiệp","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","ProviderPhone":"Điện_thoại","ProviderEmail":"Email","ProviderLocation":"Địa_chỉ","MoreInfo":"Thông_tin_bổ_sung_thêm","ProviderSignature":"Chữ_ký","StudentName":"Tên_học_viên","ExerciseTitle":"Tên_bài_tập","EvaluationDate":"Thời_gian_làm_bài_lần_cuối","Inprocess":"Tiến_độ","Score":"Điểm","TotalQuestion":"Số_câu_hỏi","EvaluationScore":"Đánh_giá","Evaluation":"Nhận_xét"}', null);

INSERT INTO "public"."template" ("template_id", "type", "code", "title", "message", "language", "from_name", "from_address", "encode", "created_date", "created_by", "modified_date", "modified_by", "tenant_id", "default_param_value", "reply_to") VALUES (54, 'EMAIL', '24:EDUCATION:PROVIDER_CHANGE_STUDENT_PASSWORD', 'Trung tâm cập nhật lại mật khẩu', '<html>

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

           background-color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#7058B7</#if>;
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
           color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#7058B7</#if>;
         }

         .separator {
           border-bottom: 3px solid <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#F0F1F5</#if>;
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
           color: #6C6B85;
         }


         .padding-1 {
           padding: 10px;
         }

         .padding-v-1 {
           padding-top: 10px;
           padding-bottom: 10px;
         }

         .pt-10 {
           padding-top: 10px;
         }

         .p-t-10 {
           padding-top: 10px;
         }

         .pb-10 {
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

           background-color: <#if ProviderEmailColor??>${ProviderEmailColor}<#else>#7058B7</#if>;
           border: none;
           margin: 20px 0px;
         }

         a.payment-label {
           color: #fff !important;
           font-weight: bold;
           text-decoration: none;
           text-transform: capitalize;
           font-size: 16px;
         }

         .link-label {
           color: #6C6B85;
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
         <span class="provider-name">${ProviderName?if_exists}</span>
       </div>
     </div>

     <div class="body">
       <div class="content">
         <table class="table padding-1">
           <tr>
             <td class="padding-v-1">Xin chào <b>
               ${StudentName?if_exists},
             </td>
           </tr>
           <tr>
             <td class="padding-v-1">
               Mật khẩu của bạn đã được trung tâm thay đổi:
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
               <b>Tên tài khoản</b>: ${Username?if_exists}
             </td>
           </tr>
           <tr>
             <td class="p-t-10">
               <b>Mật khẩu:</b> ${Password?if_exists}
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
               <div><span class="stress">${MoreInfo?if_exists}</span> </div>
             </td>
           </tr>
         </table>
       </div>
     </div>
     </body>

     </html>', 'vi-VN', 'Bukizi', 'no-reply@bukizi.com', 'freemarker', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'tenant-bukizi', '{"ProviderName":"Tên_doanh_nghiệp","ProviderAvatar":"https://s3-ap-southeast-1.amazonaws.com/com.stgsolution.prod/bukizi/static/common/logo.png","ProviderPhone":"Điện_thoại","ProviderEmail":"Email","ProviderLocation":"Địa_chỉ","MoreInfo":"Thông_tin_bổ_sung_thêm","ProviderSignature":"Chữ_ký","StudentName":"Tên_học_viên","Username":"Tài_khoản","Password":"Mật_khẩu"}', null);