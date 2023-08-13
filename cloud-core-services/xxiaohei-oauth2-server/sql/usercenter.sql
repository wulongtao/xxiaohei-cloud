drop table if exists sys_user;
create table sys_user
(
    user_id      bigint unsigned  not null comment '用户id'
        primary key,
    user_name    varchar(50)      not null comment '用户名',
    password    varchar(50)      not null comment '用户密码',
    is_deleted   tinyint unsigned not null comment '是否删除：0-未删除 1-删除',
    gmt_create   datetime         not null default current_timestamp comment '创建事件',
    gmt_modified datetime         not null default current_timestamp on update current_timestamp comment '修改时间'
)
    comment '用户表';

drop table if exists sys_role;
create table sys_role
(
    role_id      bigint unsigned  not null comment '用户id'
        primary key,
    role_code    varchar(32)      not null comment '角色code',
    role_name    varchar(50)      not null comment '角色名称',
    is_deleted   tinyint unsigned not null comment '是否删除：0-未删除 1-删除',
    gmt_create   datetime         not null default current_timestamp comment '创建事件',
    gmt_modified datetime         not null default current_timestamp on update current_timestamp comment '修改时间'
)
    comment '角色表';

drop table if exists sys_user_role;
create table sys_user_role
(
    id      bigint unsigned not null comment '关联表id'
        primary key,
    user_id bigint unsigned not null comment '用户id',
    role_id bigint unsigned not null comment '角色id',
    is_deleted   tinyint unsigned not null comment '是否删除：0-未删除 1-删除',
    gmt_create   datetime         not null default current_timestamp comment '创建事件',
    gmt_modified datetime         not null default current_timestamp on update current_timestamp comment '修改时间'
)
    comment '用户角色表';

drop table if exists sys_permission;
create table sys_permission
(
    permission_id   bigint unsigned  not null comment '权限表id'
        primary key,
    permission_url  varchar(100)     not null comment '权限url',
    permission_name varchar(50)      not null comment '角色名称',
    is_deleted      tinyint unsigned not null comment '是否删除：0-未删除 1-删除',
    gmt_create      datetime         not null default current_timestamp comment '创建事件',
    gmt_modified    datetime         not null default current_timestamp on update current_timestamp comment '修改时间'
)
    comment '权限表';

drop table if exists sys_role_permission;
create table sys_role_permission
(
    id            bigint unsigned not null comment '关联表id'
        primary key,
    permission_id bigint unsigned not null comment '权限表id',
    role_id       bigint unsigned not null comment '角色id',
    is_deleted   tinyint unsigned not null comment '是否删除：0-未删除 1-删除',
    gmt_create   datetime         not null default current_timestamp comment '创建事件',
    gmt_modified datetime         not null default current_timestamp on update current_timestamp comment '修改时间'
)
    comment '权限表';