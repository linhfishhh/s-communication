--- 2020/06/26

alter table user_notification
    add type varchar(100);

--- 2020/06/30

alter table template
    add tenant_id varchar(100);
