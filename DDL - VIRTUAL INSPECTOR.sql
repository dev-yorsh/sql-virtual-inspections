create table parameter(
    parameter_id serial primary key,
    code varchar unique,
    name varchar not null,
    description varchar(200),
    reference_parameter varchar,
    prefix varchar,
    ordering smallint,
    active boolean,
    constraint FK_parameter_parameter foreign key(reference_parameter) references parameter(code)
);

create table customer (
    customer_id serial primary key,
    name varchar,
    last_name varchar,
    document_type integer,
    document_number varchar,
    address varchar,
    district varchar,
    email varchar,
    cell_phone varchar,
    phone varchar,
    creation_date timestamp,
    modification_date timestamp,
    user_creation varchar,
    user_modification varchar,
    constraint fk_customer_parameter foreign key(document_type) references parameter(parameter_id)
);

create table employee(
    employee_id serial primary key,
    document_type integer,
    document_number integer,
    name varchar,
    last_name varchar,
    cell_phone varchar,
    email varchar,
    active boolean,
    creation_date timestamp,
    modification_date timestamp,
    user_creation varchar,
    user_modification varchar,
    constraint fk_employee_parameter foreign key(document_type) references parameter(parameter_id)
);

create table electric_meter(
    electric_meter_id serial primary key,
    brand varchar,
    model varchar,
    peak_current varchar,
    work_temperature varchar,
    phase_meter varchar,
    screen_type varchar,
    color varchar,
    description varchar,
    creation_date timestamp,
    modification_date timestamp,
    user_creation varchar,
    user_modification varchar
);

create  table electrical_supply(
    electrical_supply_id serial primary key,
    customer_id integer,
    electric_meter_id integer,
    customer_number integer unique,
    hired_potency varchar,
    connection_type varchar,
    connection_detail varchar,
    tension varchar,
    creation_date timestamp,
    modification_date timestamp,
    user_creation varchar,
    user_modification varchar,
    constraint fk_electrical_supply_customer foreign key (customer_id) references customer(customer_id),
    constraint fk_electrical_supply_meter foreign key (electric_meter_id) references electric_meter(electric_meter_id)
);

create table inspection(
    inspection_id serial primary key,
    code_inspection varchar unique,
    electrical_supply_id integer,
    inspection_status_id smallint,
    address varchar,
    observations varchar,
    latitude_coordinate varchar,
    longitude_coordinate varchar,
    creation_date timestamp,
    modification_date timestamp,
    user_creation varchar,
    user_modification varchar,
    constraint fk_inspection_eletrical_supply foreign key (electrical_supply_id) references electrical_supply(electrical_supply_id),
    constraint fk_inspection_parameter foreign key (inspection_status_id) references parameter(parameter_id)
);

create table order_service(
    order_service_id serial primary key,
    inspection_id integer,
    assigned_employee_id integer,
    inspection_status_id smallint,
    reason varchar,
    contact_person varchar,
    address varchar,
    comment varchar,
    creation_date timestamp,
    modification_date timestamp,
    user_creation varchar,
    user_modification varchar,
    constraint fk_order_service_parameter foreign key(inspection_status_id) references parameter(parameter_id),
    constraint fk_order_service_employe foreign key(assigned_employee_id) references employee(employee_id),
    constraint fk_order_service_inspection foreign key(inspection_id) references inspection(inspection_id)
);

create table attached_document_type(
    attached_document_type_id serial primary key,
    name varchar,
    description varchar,
    allowed_extension varchar,
    active boolean,
    creation_date timestamp,
    modification_date timestamp,
    user_creation varchar,
    user_modification varchar
);

create table attached_document(
    attached_document_id serial primary key,
    attached_document_type_id integer,
    order_service_id integer,
    name varchar,
    description varchar,
    url varchar,
    creation_date timestamp,
    modification_date timestamp,
    user_creation varchar,
    user_modification varchar,
    constraint fk_attached_document_type foreign key(attached_document_type_id) references attached_document_type(attached_document_type_id),
    constraint fk_attached_document_order_service foreign key(order_service_id) references  order_service(order_service_id)
);


