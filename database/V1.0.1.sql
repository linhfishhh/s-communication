alter table email alter column email type varchar(500) using email::varchar(500);

alter table email
    add cc varchar(500);

alter table email
    add bcc varchar(500);

alter table email
    add tenant_id varchar(100);
