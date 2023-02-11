create table public."userAccounts" (
    "id" bigserial primary key,
    "firstName" varchar(191) not null,
    "middleName" varchar(191) null,
    "lastName" varchar(191) not null,
    "name" text not null,
    "dateOfBirth" date null,
    "gender" text not null default 'NOT SPECIFIED' check("gender" in ('MALE', 'FEMALE', 'OTHERS', 'UNKNOWN', 'NOT SPECIFIED')),
    "phone" varchar(17) null,
    "username" varchar(50) unique not null,
    "email" varchar(191) not null unique,
    "password" text not null,
    "passwordResetCode" varchar(8) null,
    "passwordResetLink" text null,
    "passwordResetTime" timestamp null,
    "passwordChangedTime" timestamp null,
    "securityPin" varchar(4) null,
    "emailAddressVerificationCode" varchar(8) null,
    "phoneNumberVerificationCode" varchar(8) null,
    "countryCode" varchar(3) not null default 'KE',
    "countryName" varchar(255) not null default 'Kenya',
    "timezoneName" varchar(255) not null default 'UTC',
    "timezoneOffsetSeconds" integer not null default 0,
    "lastSeenTime" timestamp null,
    "lastLoginTime" timestamp null,
    "type" text not null default 'USER' check("type" in ('SUPERUSER', 'ADMIN', 'USER')),
    "status" text check("status" in ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'BLOCKED')),
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."countries"(
    "id" serial primary key,
    "name" varchar(255) not null unique,
    "alphaTwoCode" character(2) not null,
    "alpha3Code" character(3) not null,
    "numericCode" varchar(5) not null,
    "status" varchar(191) not null default 'ACTIVE' check("status" in ('ACTIVE', 'INACTIVE')),
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."administrativeLevels"(
    "id" serial primary key,
    "countryId" integer not null,
    "name" varchar(255) not null,
    "order" integer not null,
    "status" varchar(191) not null default 'ACTIVE' check("status" in ('ACTIVE', 'INACTIVE')),
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."farms"(
    "id" serial primary key,
    "countryId" integer not null,
    "name" varchar(255) not null,
    "ownerName" varchar(255) not null,
    "ownerPhone" varchar(255) not null,
    "ownerEmail" varchar(255) not null,
    "latitude" double precision null,
    "longitude" double precision null,
    "status" varchar(191) not null default 'ACTIVE' check("status" in ('ACTIVE', 'INACTIVE')),
    "createdBy" integer,
    "updatedBy" integer,
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."farmAdministrativeLevels"(
    "id" bigserial primary key,
    "farmId" integer not null,
    "countryId" integer not null,
    "administrativeLevelName" varchar(255) not null,
    "administrativeLevelOrder" integer not null,
    "value" varchar(255) not null,
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."commodities" (
    "id" serial primary key,
    "name" varchar(255) not null unique,
    "botanicalName" varchar(255) null,
    "description" text null,
    "status" varchar(191) not null default 'ACTIVE' check("status" in ('ACTIVE', 'INACTIVE')),
    "createdBy" integer null,
    "updatedBy" integer null,
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."pests" (
    "id" bigserial primary key,
    "lifeForm" text not null,
    "scientificName" text not null,
    "commonName" text not null,
    "kingdom" varchar(255) not null,
    "phylum" varchar(255) not null,
    "genus" varchar(255) not null,
    "family" varchar(255) not null,
    "pestStatus" text null,
    "phytoSanitaryStatus" text not null default 'NOT SPECIFIED' check("phytoSanitaryStatus" in (
        'QUARANTINE',
        'NON-QUARANTINE',
        'REGULATED',
        'NON-REGULATED',
        'NOT SPECIFIED'
    )),
    "imageUrls" json not null default '[]',
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."plantParts"(
    "id" serial primary key,
    "name" varchar(191) not null unique,
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."pestPlantParts"(
    "id" serial primary key,
    "pestId" integer not null,
    "plantPartName" varchar(191) not null
);

create table public."pestCommodities"(
    "id" serial primary key,
    "pestId" integer not null,
    "commodityId" integer not null,
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."projects" (
    "id" serial primary key,
    "name" varchar(255) not null,
    "description" text null,
    "objectives" text null,
    "startDate" date,
    "endDate" date,
    "status" varchar(191) not null default 'ACTIVE' check("status" in ('INITIATION', 'IN PROGRESS', 'COMPLETED', 'SUSPENDED')),
    "createdBy" integer null,
    "updatedBy" integer null,
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."scouts"(
    "id" serial primary key,
    "userAccountId" integer not null,
    "name" text not null,
    "countryId" integer not null,
    "nationalIdNumber" varchar(191) not null,
    "phoneNumber" varchar(17) not null,
    "email" varchar(191) not null,
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."scoutProjectFarms"(
    "id" serial primary key,
    "scoutId" integer not null,
    "projectId" integer not null,
    "farmId" integer not null,
    "status" text check("status" in ('ACTIVE', 'INACTIVE')),
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);

create table public."projectFarms"(
    "id" bigserial primary key,
    "projectId" integer not null,
    "farmId" integer not null
);

create table public."projectCommodities" (
    "id" bigserial primary key,
    "projectId" integer not null,
    "commodityId" integer not null
);

create table public."projectPests" (
    "id" bigserial primary key,
    "projectId" integer not null,
    "commodityId" integer not null,
    "pestId" integer not null
);

create table public."scoutReports" (
    "id" serial primary key,
    "scoutId" integer not null,
    "projectId" integer not null,
    "farmId" integer not null,
    "commodityId" integer not null,
    "latitude" double precision not null,
    "longitude" double precision not null,
    "description" text not null,
    "imageUrls" json not null default '[]',
    "pestId" integer null,
    "date" timestamp not null,
    "createdAt" timestamp not null default now(),
    "updatedAt" timestamp null
);
