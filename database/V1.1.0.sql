create unique index template_template_id_uindex
    on template (template_id);

create table sms
(
    id             bigserial not null
        constraint sms_pk
            primary key,
    profile_id     bigint,
    tenant_id      varchar(100),
    template_id    bigint
        constraint sms_template_template_id_fk
            references template (template_id),
    content_params varchar(500),
    delivery_time  timestamp with time zone,
    phone_number   varchar(20),
    custom_content varchar(500),
    status         varchar(50),
    result         varchar(500),
    modified_date  timestamp with time zone default now(),
    created_date   timestamp with time zone default now(),
    modified_by    varchar(100)             default 'SYSTEM'::character varying,
    created_by     varchar(100)             default 'SYSTEM'::character varying
);

create unique index sms_id_uindex
    on sms (id);

alter table sms
    add provider_id bigint;

alter table sms
    add brand_name varchar(100);

