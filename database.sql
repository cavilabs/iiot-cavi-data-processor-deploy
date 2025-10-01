PRAGMA foreign_keys = ON;

drop table if exists device_stop;
drop table if exists events;
drop table if exists changes_catalog;
drop table if exists device_shift;
drop table if exists devices;
drop table if exists shifts;
drop table if exists stops;


--create tables
create table shifts
(
    id          integer not null primary key AUTOINCREMENT,
    code        text    not null UNIQUE,
    description text,
    start_at    text    not null,
    end_at      text    not null
);

create table devices
(
    id          integer not null primary key AUTOINCREMENT,
    code        text    not null UNIQUE,
    description text,
    status      integer default 0
);

create table stops
(
    id          integer not null primary key AUTOINCREMENT,
    code        integer UNIQUE,
    description text
);

create table changes_catalog
(
    id          integer not null primary key AUTOINCREMENT,
    code        integer not null UNIQUE,
    code_change text    not null,
    description text
);

create table device_shift
(
    id                    integer not null primary key AUTOINCREMENT,
    device_id             integer NOT NULL,
    shift_id              integer NOT NULL,
    start_at              text,
    end_at                text,
    status                integer default 0,
    speed                 real,
    efficiency            real,
    hank                  real,
    meters                real,
    hours_produced        text,
    hours_not_produced    text,
    number_stops          integer default 0,
    hours_produced_hr     text,
    hours_not_produced_hr text,
    FOREIGN KEY (device_id) REFERENCES devices (id),
    FOREIGN KEY (shift_id) REFERENCES shifts (id)
);
create table events
(
    id                  integer not null primary key AUTOINCREMENT,
    device_shift_id     integer NOT NULL,
    change_id           integer NOT NULL,
    date_time           text    not null,
    speed               real    not null,
    speed_average       real    not null,
    efficiency          real,
    hank                real,
    meters              real,
    hours_worked        text,
    hours_not_worked    text,
    number_stops        integer default 0,
    hours_wored_hr      text,
    hours_not_worked_hr text,
    FOREIGN KEY (device_shift_id) REFERENCES device_shift (id),
    FOREIGN KEY (change_id) REFERENCES changes_catalog (id)
);

create table device_stop
(
    id              integer not null primary key AUTOINCREMENT,
    device_shift_id integer NOT NULL,
    stop_id         integer,
    start_at        text,
    end_at          text,
    date_time       text,
    FOREIGN KEY (device_shift_id) REFERENCES device_shift (id),
    FOREIGN KEY (stop_id) REFERENCES stops (id)
);


---create indexes
create unique index idx_changes_catalog_code_change on changes_catalog (code, code_change);
create index idx_events_datetime on events (date_time);
create index idx_device_shift_datetime on device_shift (start_at, end_at);

--DATA MASTER TABLES
INSERT INTO shifts(code, description, start_at, end_at)
VALUES ('A', 'PRIMER TURNO', '07:00:00', '15:00:00'),
       ('B', 'SEGUNDO TURNO', '15:00:00', '23:00:00'),
       ('C', 'TERCER TURNO', '23:00:00', '07:00:00');

insert into stops (code, description)
values (0, 'NO INFORMADO'),
       (100, 'Producción'),
       (101, 'Cambio de mudada'),
       (102, 'Cambio de titulo'),
       (103, 'Cambio de material'),
       (104, 'Cambio de cursores'),
       (105, 'Calidad'),
       (106, 'Caída de tensión'),
       (108, 'Falla eléctrica'),
       (109, 'Reparación eléctrica'),
       (110, 'Falla mecánica'),
       (111, 'Reparación mecánica'),
       (112, 'Falta de aire'),
       (113, 'Falta de canillas'),
       (115, 'Falta de material'),
       (116, 'Falta de personal'),
       (117, 'Falta de repuesto'),
       (118, 'Limpieza'),
       (119, 'Mantenimiento preventivo'),
       (120, 'Paro por balance'),
       (121, 'Pérdida operativa'),
       (127, 'Mantenimiento de coneras'),
       (128, 'Capacitación del personal'),
       (129, 'Falla eléctrica y mecánica'),
       (130, 'Apoyo de personal en encanillado'),
       (131, 'Cambio de mudada Falla Eléctrica'),
       (132, 'Cambio de mudada Falla Mecánica'),
       (133, 'Cambio de mudada Falla Eléctrica y Mecánica');

insert into changes_catalog (code, code_change, description)
values (0, '0', 'NO INFORMADO'),
       (8001, '0100110600001001000H', '10/1 AN ALG-SPD40'),
       (8002, '0100110700001001000H', '10/1 AN ALG-SPD70'),
       (8003, '0100111400001001000H', '10/1 AN ALG-T400-SPD70'),
       (8004, '0130110600001001000H', '13/1 AN ALG-SPD40'),
       (8005, '0130113100001001000H', '13/1 AN ALG-SPD65'),
       (8006, '0130110700001001000H', '13/1 AN ALG-SPD70'),
       (8007, '0130110705001001000H', '13/1 AN ALG-SPD70PR.50'),
       (8008, '0160111100001001000H', '16/1 AN ALG50-POL50-SPD70'),
       (8009, '0160111102401001000H', '16/1 AN ALG50-POL50-SPD70PR.24'),
       (8010, '0160113100001001000H', '16/1 AN ALG-SPD65'),
       (8011, '0160110700001001000H', '16/1 AN ALG-SPD70'),
       (8012, '0180111700001001000H', '18/1 AN ALG-F75-SPD70'),
       (8013, '0180111400001001000H', '18/1 AN ALG-T400-SPD70'),
       (8014, '0200111200001001000H', '20/1 AN ALG50-POL50-SP105'),
       (8015, '0200113000001001000H', '20/1 AN ALG50-POL50-SPD65'),
       (8016, '0200111100001001000H', '20/1 AN ALG50-POL50-SPD70'),
       (8017, '0200111100013001000H', '20/1 AN ALG50-POL50-SPD70 ADAPTIV'),
       (8018, '0200111100001041000H', '20/1 AN ALG50-POL50-SPD70 SIRO'),
       (8019, '0200110600001001000H', '20/1 AN ALG-SPD40'),
       (8020, '0200113100001001000H', '20/1 AN ALG-SPD65'),
       (8021, '0200110700001001000H', '20/1 AN ALG-SPD70'),
       (8022, '0200110700001041000H', '20/1 AN ALG-SPD70 SIRO');

--Devices
INSERT INTO devices (code, description, status)
VALUES ('131086232190140', 'Dispositivo de pruebas cavilabs', 1);
INSERT INTO devices (code, description, status)
VALUES ('100000000000001', 'Dispositivo simulado', 1);
INSERT INTO devices (code, description, status)
VALUES ('100000000000002', 'Dispositivo simulado 2', 1);
INSERT INTO devices (code, description, status)
VALUES ('100000000000003', 'Dispositivo simulado 3', 1);
INSERT INTO devices (code, description, status)
VALUES ('100000000000004', 'Dispositivo simulado 4', 1);
INSERT INTO devices (code, description, status)
VALUES ('100000000000005', 'Dispositivo simulado 5', 1);
INSERT INTO devices (code, description, status)
VALUES ('100000000000006', 'Dispositivo simulado 6', 1);
INSERT INTO devices (code, description, status)
VALUES ('100000000000007', 'Dispositivo simulado 7', 1);
INSERT INTO devices (code, description, status)
VALUES ('100000000000008', 'Dispositivo simulado 8', 1);
INSERT INTO devices (code, description, status)
VALUES ('100000000000009', 'Dispositivo simulado 9', 1);
INSERT INTO devices (code, description, status)
VALUES ('100000000000010', 'Dispositivo simulado 10', 1);
