--
-- PostgreSQL database dump
--

\restrict iyC0QFpZK8JPM1FIqUS40rCkKsGjM4PTv5BeGaVTDKMpEGkxGlHPe4DZC15SiAr

-- Dumped from database version 15.19
-- Dumped by pg_dump version 15.19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.innowacje DROP CONSTRAINT innowacje_user_created_foreign;
ALTER TABLE ONLY public.innowacje_files DROP CONSTRAINT innowacje_files_innowacje_id_foreign;
ALTER TABLE ONLY public.innowacje_files DROP CONSTRAINT innowacje_files_directus_files_id_foreign;
ALTER TABLE ONLY public.directus_versions DROP CONSTRAINT directus_versions_user_updated_foreign;
ALTER TABLE ONLY public.directus_versions DROP CONSTRAINT directus_versions_user_created_foreign;
ALTER TABLE ONLY public.directus_versions DROP CONSTRAINT directus_versions_collection_foreign;
ALTER TABLE ONLY public.directus_users DROP CONSTRAINT directus_users_role_foreign;
ALTER TABLE ONLY public.directus_shares DROP CONSTRAINT directus_shares_user_created_foreign;
ALTER TABLE ONLY public.directus_shares DROP CONSTRAINT directus_shares_role_foreign;
ALTER TABLE ONLY public.directus_shares DROP CONSTRAINT directus_shares_collection_foreign;
ALTER TABLE ONLY public.directus_settings DROP CONSTRAINT directus_settings_storage_default_folder_foreign;
ALTER TABLE ONLY public.directus_settings DROP CONSTRAINT directus_settings_public_registration_role_foreign;
ALTER TABLE ONLY public.directus_settings DROP CONSTRAINT directus_settings_public_foreground_foreign;
ALTER TABLE ONLY public.directus_settings DROP CONSTRAINT directus_settings_public_favicon_foreign;
ALTER TABLE ONLY public.directus_settings DROP CONSTRAINT directus_settings_public_background_foreign;
ALTER TABLE ONLY public.directus_settings DROP CONSTRAINT directus_settings_project_logo_foreign;
ALTER TABLE ONLY public.directus_sessions DROP CONSTRAINT directus_sessions_user_foreign;
ALTER TABLE ONLY public.directus_sessions DROP CONSTRAINT directus_sessions_share_foreign;
ALTER TABLE ONLY public.directus_sessions DROP CONSTRAINT directus_sessions_oauth_client_foreign;
ALTER TABLE ONLY public.directus_roles DROP CONSTRAINT directus_roles_parent_foreign;
ALTER TABLE ONLY public.directus_revisions DROP CONSTRAINT directus_revisions_version_foreign;
ALTER TABLE ONLY public.directus_revisions DROP CONSTRAINT directus_revisions_parent_foreign;
ALTER TABLE ONLY public.directus_revisions DROP CONSTRAINT directus_revisions_activity_foreign;
ALTER TABLE ONLY public.directus_presets DROP CONSTRAINT directus_presets_user_foreign;
ALTER TABLE ONLY public.directus_presets DROP CONSTRAINT directus_presets_role_foreign;
ALTER TABLE ONLY public.directus_permissions DROP CONSTRAINT directus_permissions_policy_foreign;
ALTER TABLE ONLY public.directus_panels DROP CONSTRAINT directus_panels_user_created_foreign;
ALTER TABLE ONLY public.directus_panels DROP CONSTRAINT directus_panels_dashboard_foreign;
ALTER TABLE ONLY public.directus_operations DROP CONSTRAINT directus_operations_user_created_foreign;
ALTER TABLE ONLY public.directus_operations DROP CONSTRAINT directus_operations_resolve_foreign;
ALTER TABLE ONLY public.directus_operations DROP CONSTRAINT directus_operations_reject_foreign;
ALTER TABLE ONLY public.directus_operations DROP CONSTRAINT directus_operations_flow_foreign;
ALTER TABLE ONLY public.directus_oauth_tokens DROP CONSTRAINT directus_oauth_tokens_user_foreign;
ALTER TABLE ONLY public.directus_oauth_tokens DROP CONSTRAINT directus_oauth_tokens_client_foreign;
ALTER TABLE ONLY public.directus_oauth_consents DROP CONSTRAINT directus_oauth_consents_user_foreign;
ALTER TABLE ONLY public.directus_oauth_consents DROP CONSTRAINT directus_oauth_consents_client_foreign;
ALTER TABLE ONLY public.directus_oauth_codes DROP CONSTRAINT directus_oauth_codes_user_foreign;
ALTER TABLE ONLY public.directus_oauth_codes DROP CONSTRAINT directus_oauth_codes_client_foreign;
ALTER TABLE ONLY public.directus_notifications DROP CONSTRAINT directus_notifications_sender_foreign;
ALTER TABLE ONLY public.directus_notifications DROP CONSTRAINT directus_notifications_recipient_foreign;
ALTER TABLE ONLY public.directus_folders DROP CONSTRAINT directus_folders_parent_foreign;
ALTER TABLE ONLY public.directus_flows DROP CONSTRAINT directus_flows_user_created_foreign;
ALTER TABLE ONLY public.directus_flows DROP CONSTRAINT directus_flows_folder_foreign;
ALTER TABLE ONLY public.directus_files DROP CONSTRAINT directus_files_uploaded_by_foreign;
ALTER TABLE ONLY public.directus_files DROP CONSTRAINT directus_files_modified_by_foreign;
ALTER TABLE ONLY public.directus_files DROP CONSTRAINT directus_files_folder_foreign;
ALTER TABLE ONLY public.directus_deployments DROP CONSTRAINT directus_deployments_user_created_foreign;
ALTER TABLE ONLY public.directus_deployment_runs DROP CONSTRAINT directus_deployment_runs_user_created_foreign;
ALTER TABLE ONLY public.directus_deployment_runs DROP CONSTRAINT directus_deployment_runs_project_foreign;
ALTER TABLE ONLY public.directus_deployment_projects DROP CONSTRAINT directus_deployment_projects_user_created_foreign;
ALTER TABLE ONLY public.directus_deployment_projects DROP CONSTRAINT directus_deployment_projects_deployment_foreign;
ALTER TABLE ONLY public.directus_dashboards DROP CONSTRAINT directus_dashboards_user_created_foreign;
ALTER TABLE ONLY public.directus_comments DROP CONSTRAINT directus_comments_user_updated_foreign;
ALTER TABLE ONLY public.directus_comments DROP CONSTRAINT directus_comments_user_created_foreign;
ALTER TABLE ONLY public.directus_collections DROP CONSTRAINT directus_collections_group_foreign;
ALTER TABLE ONLY public.directus_access DROP CONSTRAINT directus_access_user_foreign;
ALTER TABLE ONLY public.directus_access DROP CONSTRAINT directus_access_role_foreign;
ALTER TABLE ONLY public.directus_access DROP CONSTRAINT directus_access_policy_foreign;
DROP INDEX public.directus_sessions_oauth_client_index;
DROP INDEX public.directus_revisions_parent_index;
DROP INDEX public.directus_revisions_activity_index;
DROP INDEX public.directus_oauth_tokens_session_index;
DROP INDEX public.directus_oauth_tokens_previous_session_index;
DROP INDEX public.directus_oauth_tokens_expires_at_index;
DROP INDEX public.directus_oauth_tokens_code_hash_index;
DROP INDEX public.directus_oauth_consents_client_index;
DROP INDEX public.directus_oauth_codes_used_at_index;
DROP INDEX public.directus_oauth_codes_expires_at_index;
DROP INDEX public.directus_oauth_clients_date_created_index;
DROP INDEX public.directus_activity_timestamp_index;
ALTER TABLE ONLY public.innowacje DROP CONSTRAINT innowacje_pkey;
ALTER TABLE ONLY public.innowacje_files DROP CONSTRAINT innowacje_files_pkey;
ALTER TABLE ONLY public.directus_versions DROP CONSTRAINT directus_versions_pkey;
ALTER TABLE ONLY public.directus_users DROP CONSTRAINT directus_users_token_unique;
ALTER TABLE ONLY public.directus_users DROP CONSTRAINT directus_users_pkey;
ALTER TABLE ONLY public.directus_users DROP CONSTRAINT directus_users_external_identifier_unique;
ALTER TABLE ONLY public.directus_users DROP CONSTRAINT directus_users_email_unique;
ALTER TABLE ONLY public.directus_translations DROP CONSTRAINT directus_translations_pkey;
ALTER TABLE ONLY public.directus_shares DROP CONSTRAINT directus_shares_pkey;
ALTER TABLE ONLY public.directus_settings DROP CONSTRAINT directus_settings_pkey;
ALTER TABLE ONLY public.directus_sessions DROP CONSTRAINT directus_sessions_pkey;
ALTER TABLE ONLY public.directus_roles DROP CONSTRAINT directus_roles_pkey;
ALTER TABLE ONLY public.directus_revisions DROP CONSTRAINT directus_revisions_pkey;
ALTER TABLE ONLY public.directus_relations DROP CONSTRAINT directus_relations_pkey;
ALTER TABLE ONLY public.directus_presets DROP CONSTRAINT directus_presets_pkey;
ALTER TABLE ONLY public.directus_policies DROP CONSTRAINT directus_policies_pkey;
ALTER TABLE ONLY public.directus_permissions DROP CONSTRAINT directus_permissions_pkey;
ALTER TABLE ONLY public.directus_panels DROP CONSTRAINT directus_panels_pkey;
ALTER TABLE ONLY public.directus_operations DROP CONSTRAINT directus_operations_resolve_unique;
ALTER TABLE ONLY public.directus_operations DROP CONSTRAINT directus_operations_reject_unique;
ALTER TABLE ONLY public.directus_operations DROP CONSTRAINT directus_operations_pkey;
ALTER TABLE ONLY public.directus_oauth_tokens DROP CONSTRAINT directus_oauth_tokens_pkey;
ALTER TABLE ONLY public.directus_oauth_tokens DROP CONSTRAINT directus_oauth_tokens_client_user_unique;
ALTER TABLE ONLY public.directus_oauth_consents DROP CONSTRAINT directus_oauth_consents_user_client_redirect_uri_unique;
ALTER TABLE ONLY public.directus_oauth_consents DROP CONSTRAINT directus_oauth_consents_pkey;
ALTER TABLE ONLY public.directus_oauth_codes DROP CONSTRAINT directus_oauth_codes_pkey;
ALTER TABLE ONLY public.directus_oauth_codes DROP CONSTRAINT directus_oauth_codes_code_hash_unique;
ALTER TABLE ONLY public.directus_oauth_clients DROP CONSTRAINT directus_oauth_clients_pkey;
ALTER TABLE ONLY public.directus_notifications DROP CONSTRAINT directus_notifications_pkey;
ALTER TABLE ONLY public.directus_migrations DROP CONSTRAINT directus_migrations_pkey;
ALTER TABLE ONLY public.directus_folders DROP CONSTRAINT directus_folders_pkey;
ALTER TABLE ONLY public.directus_flows DROP CONSTRAINT directus_flows_pkey;
ALTER TABLE ONLY public.directus_flows DROP CONSTRAINT directus_flows_operation_unique;
ALTER TABLE ONLY public.directus_files DROP CONSTRAINT directus_files_pkey;
ALTER TABLE ONLY public.directus_fields DROP CONSTRAINT directus_fields_pkey;
ALTER TABLE ONLY public.directus_extensions DROP CONSTRAINT directus_extensions_pkey;
ALTER TABLE ONLY public.directus_deployments DROP CONSTRAINT directus_deployments_provider_unique;
ALTER TABLE ONLY public.directus_deployments DROP CONSTRAINT directus_deployments_pkey;
ALTER TABLE ONLY public.directus_deployment_runs DROP CONSTRAINT directus_deployment_runs_pkey;
ALTER TABLE ONLY public.directus_deployment_projects DROP CONSTRAINT directus_deployment_projects_pkey;
ALTER TABLE ONLY public.directus_deployment_projects DROP CONSTRAINT directus_deployment_projects_deployment_external_id_unique;
ALTER TABLE ONLY public.directus_dashboards DROP CONSTRAINT directus_dashboards_pkey;
ALTER TABLE ONLY public.directus_comments DROP CONSTRAINT directus_comments_pkey;
ALTER TABLE ONLY public.directus_collections DROP CONSTRAINT directus_collections_pkey;
ALTER TABLE ONLY public.directus_activity DROP CONSTRAINT directus_activity_pkey;
ALTER TABLE ONLY public.directus_access DROP CONSTRAINT directus_access_pkey;
ALTER TABLE public.innowacje_files ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.innowacje ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.directus_settings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.directus_revisions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.directus_relations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.directus_presets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.directus_permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.directus_notifications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.directus_fields ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.directus_activity ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.innowacje_id_seq;
DROP SEQUENCE public.innowacje_files_id_seq;
DROP TABLE public.innowacje_files;
DROP TABLE public.innowacje;
DROP TABLE public.directus_versions;
DROP TABLE public.directus_users;
DROP TABLE public.directus_translations;
DROP TABLE public.directus_shares;
DROP SEQUENCE public.directus_settings_id_seq;
DROP TABLE public.directus_settings;
DROP TABLE public.directus_sessions;
DROP TABLE public.directus_roles;
DROP SEQUENCE public.directus_revisions_id_seq;
DROP TABLE public.directus_revisions;
DROP SEQUENCE public.directus_relations_id_seq;
DROP TABLE public.directus_relations;
DROP SEQUENCE public.directus_presets_id_seq;
DROP TABLE public.directus_presets;
DROP TABLE public.directus_policies;
DROP SEQUENCE public.directus_permissions_id_seq;
DROP TABLE public.directus_permissions;
DROP TABLE public.directus_panels;
DROP TABLE public.directus_operations;
DROP TABLE public.directus_oauth_tokens;
DROP TABLE public.directus_oauth_consents;
DROP TABLE public.directus_oauth_codes;
DROP TABLE public.directus_oauth_clients;
DROP SEQUENCE public.directus_notifications_id_seq;
DROP TABLE public.directus_notifications;
DROP TABLE public.directus_migrations;
DROP TABLE public.directus_folders;
DROP TABLE public.directus_flows;
DROP TABLE public.directus_files;
DROP SEQUENCE public.directus_fields_id_seq;
DROP TABLE public.directus_fields;
DROP TABLE public.directus_extensions;
DROP TABLE public.directus_deployments;
DROP TABLE public.directus_deployment_runs;
DROP TABLE public.directus_deployment_projects;
DROP TABLE public.directus_dashboards;
DROP TABLE public.directus_comments;
DROP TABLE public.directus_collections;
DROP SEQUENCE public.directus_activity_id_seq;
DROP TABLE public.directus_activity;
DROP TABLE public.directus_access;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO myuser;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO myuser;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: myuser
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO myuser;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myuser
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    autosave_revision_interval real
);


ALTER TABLE public.directus_collections OWNER TO myuser;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO myuser;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO myuser;

--
-- Name: directus_deployment_projects; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_deployment_projects (
    id uuid NOT NULL,
    deployment uuid NOT NULL,
    external_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    url character varying(255),
    framework character varying(255),
    deployable boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_deployment_projects OWNER TO myuser;

--
-- Name: directus_deployment_runs; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_deployment_runs (
    id uuid NOT NULL,
    project uuid NOT NULL,
    external_id character varying(255) NOT NULL,
    target character varying(255) NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    status character varying(255),
    url character varying(255),
    started_at timestamp with time zone,
    completed_at timestamp with time zone
);


ALTER TABLE public.directus_deployment_runs OWNER TO myuser;

--
-- Name: directus_deployments; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_deployments (
    id uuid NOT NULL,
    provider character varying(255) NOT NULL,
    credentials text,
    options text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    webhook_ids json,
    webhook_secret character varying(255),
    last_synced_at timestamp with time zone
);


ALTER TABLE public.directus_deployments OWNER TO myuser;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO myuser;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text,
    searchable boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_fields OWNER TO myuser;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: myuser
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO myuser;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myuser
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO myuser;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    folder uuid
);


ALTER TABLE public.directus_flows OWNER TO myuser;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid,
    type character varying(255) DEFAULT 'files'::character varying NOT NULL
);


ALTER TABLE public.directus_folders OWNER TO myuser;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO myuser;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO myuser;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: myuser
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO myuser;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myuser
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_oauth_clients; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_oauth_clients (
    client_id character varying(255) NOT NULL,
    client_name character varying(200) NOT NULL,
    redirect_uris json NOT NULL,
    grant_types json NOT NULL,
    token_endpoint_auth_method character varying(255) DEFAULT 'none'::character varying NOT NULL,
    client_secret_hash character varying(64),
    registration_type character varying(10) DEFAULT 'dcr'::character varying NOT NULL,
    client_uri text,
    logo_uri text,
    tos_uri text,
    policy_uri text,
    metadata_fetched_at timestamp with time zone,
    metadata_expires_at timestamp with time zone,
    metadata_etag character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.directus_oauth_clients OWNER TO myuser;

--
-- Name: directus_oauth_codes; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_oauth_codes (
    id uuid NOT NULL,
    code_hash character varying(64) NOT NULL,
    client character varying(255) NOT NULL,
    "user" uuid NOT NULL,
    redirect_uri character varying(255) NOT NULL,
    resource character varying(255) NOT NULL,
    code_challenge character varying(128) NOT NULL,
    code_challenge_method character varying(10) NOT NULL,
    scope character varying(255),
    expires_at timestamp with time zone NOT NULL,
    used_at timestamp with time zone
);


ALTER TABLE public.directus_oauth_codes OWNER TO myuser;

--
-- Name: directus_oauth_consents; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_oauth_consents (
    id uuid NOT NULL,
    "user" uuid NOT NULL,
    client character varying(255) NOT NULL,
    redirect_uri character varying(255) NOT NULL,
    scope character varying(255),
    date_created timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL
);


ALTER TABLE public.directus_oauth_consents OWNER TO myuser;

--
-- Name: directus_oauth_tokens; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_oauth_tokens (
    id uuid NOT NULL,
    client character varying(255) NOT NULL,
    "user" uuid NOT NULL,
    session character varying(64) NOT NULL,
    previous_session character varying(64),
    resource character varying(255) NOT NULL,
    code_hash character varying(64) NOT NULL,
    scope character varying(255),
    expires_at timestamp with time zone NOT NULL,
    date_created timestamp with time zone NOT NULL
);


ALTER TABLE public.directus_oauth_tokens OWNER TO myuser;

--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO myuser;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO myuser;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO myuser;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: myuser
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO myuser;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myuser
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO myuser;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO myuser;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: myuser
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO myuser;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myuser
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO myuser;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: myuser
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO myuser;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myuser
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO myuser;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: myuser
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO myuser;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myuser
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO myuser;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64),
    oauth_client character varying(255)
);


ALTER TABLE public.directus_sessions OWNER TO myuser;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json,
    visual_editor_urls json,
    project_id uuid,
    mcp_enabled boolean DEFAULT false NOT NULL,
    mcp_allow_deletes boolean DEFAULT false NOT NULL,
    mcp_prompts_collection character varying(255) DEFAULT NULL::character varying,
    mcp_system_prompt_enabled boolean DEFAULT true NOT NULL,
    mcp_system_prompt text,
    project_owner character varying(255),
    project_usage character varying(255),
    org_name character varying(255),
    product_updates boolean,
    project_status character varying(255),
    ai_openai_api_key text,
    ai_anthropic_api_key text,
    ai_system_prompt text,
    ai_google_api_key text,
    ai_openai_compatible_api_key text,
    ai_openai_compatible_base_url text,
    ai_openai_compatible_name text,
    ai_openai_compatible_models json,
    ai_openai_compatible_headers json,
    ai_openai_allowed_models json,
    ai_anthropic_allowed_models json,
    ai_google_allowed_models json,
    collaborative_editing_enabled boolean DEFAULT false NOT NULL,
    ai_translation_default_model text,
    ai_translation_glossary json,
    ai_translation_style_guide text,
    license_key character varying(255) DEFAULT NULL::character varying,
    license_token text,
    mcp_oauth_enabled boolean DEFAULT false NOT NULL,
    mcp_oauth_dcr_enabled boolean DEFAULT false NOT NULL,
    mcp_oauth_cimd_enabled boolean DEFAULT false NOT NULL,
    default_save_action character varying(255) DEFAULT 'save-and-quit'::character varying NOT NULL
);


ALTER TABLE public.directus_settings OWNER TO myuser;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: myuser
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO myuser;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myuser
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO myuser;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO myuser;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json,
    text_direction character varying(255) DEFAULT 'auto'::character varying NOT NULL
);


ALTER TABLE public.directus_users OWNER TO myuser;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255),
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO myuser;

--
-- Name: innowacje; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.innowacje (
    id integer NOT NULL,
    user_created uuid,
    date_created timestamp with time zone,
    tytul character varying(255) DEFAULT NULL::character varying,
    opis character varying(255)
);


ALTER TABLE public.innowacje OWNER TO myuser;

--
-- Name: innowacje_files; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.innowacje_files (
    id integer NOT NULL,
    innowacje_id integer,
    directus_files_id uuid
);


ALTER TABLE public.innowacje_files OWNER TO myuser;

--
-- Name: innowacje_files_id_seq; Type: SEQUENCE; Schema: public; Owner: myuser
--

CREATE SEQUENCE public.innowacje_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.innowacje_files_id_seq OWNER TO myuser;

--
-- Name: innowacje_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myuser
--

ALTER SEQUENCE public.innowacje_files_id_seq OWNED BY public.innowacje_files.id;


--
-- Name: innowacje_id_seq; Type: SEQUENCE; Schema: public; Owner: myuser
--

CREATE SEQUENCE public.innowacje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.innowacje_id_seq OWNER TO myuser;

--
-- Name: innowacje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myuser
--

ALTER SEQUENCE public.innowacje_id_seq OWNED BY public.innowacje.id;


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: innowacje id; Type: DEFAULT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.innowacje ALTER COLUMN id SET DEFAULT nextval('public.innowacje_id_seq'::regclass);


--
-- Name: innowacje_files id; Type: DEFAULT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.innowacje_files ALTER COLUMN id SET DEFAULT nextval('public.innowacje_files_id_seq'::regclass);


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
8f75b8b5-f707-4b08-b361-e46ed4bb768b	e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e	\N	8e6d2387-7ba3-415e-a508-d0f4e0b7c41b	\N
efdf3c55-5a96-4c96-be4d-79496370fbf7	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:08:24.344+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_users	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	http://localhost:8055
2	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:09:38.242+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
3	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:09:38.284+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
4	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:09:38.293+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_fields	3	http://localhost:8055
5	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:09:38.302+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_collections	innowacje	http://localhost:8055
6	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:10:03.945+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_fields	4	http://localhost:8055
7	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:10:14.043+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_fields	5	http://localhost:8055
8	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:10:26.39+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_fields	5	http://localhost:8055
9	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:10:36.645+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_fields	6	http://localhost:8055
10	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:10:49.991+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_fields	7	http://localhost:8055
11	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:10:50.285+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_fields	8	http://localhost:8055
12	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:10:50.288+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_collections	innowacje_files	http://localhost:8055
13	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:10:50.367+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_fields	9	http://localhost:8055
14	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:10:50.502+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_fields	10	http://localhost:8055
15	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:11:52.119+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
16	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:12:27.097+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_operations	077db770-b3bd-49d1-9cd5-fde2db6921ab	http://localhost:8055
17	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:12:27.111+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
18	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:12:54.643+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	1	http://localhost:8055
19	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:13:31.615+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_operations	077db770-b3bd-49d1-9cd5-fde2db6921ab	http://localhost:8055
20	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:13:31.63+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
21	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:13:40.837+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	2	http://localhost:8055
22	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:13:40.999+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
23	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:14:02.249+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
24	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:15:11.482+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	3	http://localhost:8055
25	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:15:11.559+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
26	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:18:12.838+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	4	http://localhost:8055
27	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:18:12.885+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
28	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:19:14.508+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	5	http://localhost:8055
29	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:19:14.556+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
30	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:20:19.039+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	1	http://localhost:8055
31	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:20:19.041+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	2	http://localhost:8055
32	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:20:19.042+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	3	http://localhost:8055
33	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:20:19.043+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	4	http://localhost:8055
34	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:20:19.045+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	5	http://localhost:8055
35	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:20:35.861+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
36	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:20:45.145+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	6	http://localhost:8055
37	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:20:45.181+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
38	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:23:51.538+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_operations	077db770-b3bd-49d1-9cd5-fde2db6921ab	http://localhost:8055
39	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:23:51.559+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
40	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:23:57.06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	7	http://localhost:8055
41	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:24:22.784+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_operations	077db770-b3bd-49d1-9cd5-fde2db6921ab	http://localhost:8055
42	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:24:22.808+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
43	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:24:29.29+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	8	http://localhost:8055
44	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:24:55.34+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
45	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:25:00.113+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
46	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:28:22.691+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	9	http://localhost:8055
47	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:28:41.989+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
48	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:28:48.829+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
49	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:29:01.242+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	7d6a3b8f-31a0-4a60-a1aa-2a3396e562c2	http://localhost:8055
50	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:30:05.904+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_operations	f28deab0-d3bd-4e06-97a0-f0aa2fd48cd2	http://localhost:8055
51	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:30:05.917+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	7d6a3b8f-31a0-4a60-a1aa-2a3396e562c2	http://localhost:8055
52	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:30:25.463+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	10	http://localhost:8055
53	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:30:25.93+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	7d6a3b8f-31a0-4a60-a1aa-2a3396e562c2	http://localhost:8055
54	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:32:19.255+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	6	http://localhost:8055
55	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:32:19.256+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	7	http://localhost:8055
56	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:32:19.258+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	8	http://localhost:8055
57	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:32:28.847+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
58	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:32:33.067+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
59	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:32:35.219+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
60	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:32:43.644+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	9	http://localhost:8055
61	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:32:43.646+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	10	http://localhost:8055
62	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:32:54.74+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
63	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:34:26.503+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	http://localhost:8055
64	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:34:36.132+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	7d6a3b8f-31a0-4a60-a1aa-2a3396e562c2	http://localhost:8055
65	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:34:48.731+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
66	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:37:01.695+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_operations	590ecdd4-3f68-4b83-8c7b-35bbb5f560be	http://localhost:8055
67	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:37:01.708+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
68	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:37:17.96+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	11	http://localhost:8055
69	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:37:18.49+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
70	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:38:00.349+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	12	http://localhost:8055
71	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:38:00.718+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
72	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:40:21.948+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_operations	590ecdd4-3f68-4b83-8c7b-35bbb5f560be	http://localhost:8055
73	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:40:21.965+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
74	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:40:30.601+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	13	http://localhost:8055
75	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:40:31.008+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
76	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:42:21.626+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_operations	590ecdd4-3f68-4b83-8c7b-35bbb5f560be	http://localhost:8055
77	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:42:21.641+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
78	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:42:27.199+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	14	http://localhost:8055
79	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:42:27.617+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
80	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:42:51.088+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	11	http://localhost:8055
81	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:42:51.089+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	12	http://localhost:8055
82	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:42:51.091+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	13	http://localhost:8055
83	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:42:51.092+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	14	http://localhost:8055
84	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:47:16.022+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	e12fd3de-d9e6-4975-b887-fcb63934d4cc	http://localhost:8055
85	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:47:18.03+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	1	http://localhost:8055
86	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:47:18.035+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	15	http://localhost:8055
87	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:47:18.243+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
88	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:49:38.14+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	73bc659c-56a1-4e3e-abc8-60c8c404935e	http://localhost:8055
89	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:49:39.534+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	2	http://localhost:8055
90	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:49:39.54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	16	http://localhost:8055
91	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:50:09.109+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	17	http://localhost:8055
92	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:50:12.216+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
93	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:50:20.116+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
94	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:55:30.041+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_operations	590ecdd4-3f68-4b83-8c7b-35bbb5f560be	http://localhost:8055
95	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:55:30.057+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
96	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:56:10.895+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_permissions	1	http://localhost:8055
97	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:56:10.906+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
98	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:56:47.999+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	15	http://localhost:8055
99	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:56:48.002+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	16	http://localhost:8055
100	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:56:48.004+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	17	http://localhost:8055
101	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:57:05.083+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	18	http://localhost:8055
102	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:57:26.381+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
103	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:57:27.387+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_operations	590ecdd4-3f68-4b83-8c7b-35bbb5f560be	http://localhost:8055
104	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:57:27.405+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
105	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:57:40.22+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	f37b0606-3626-4968-9248-8c9d2eda55e8	http://localhost:8055
106	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:57:41.619+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	3	http://localhost:8055
107	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:57:41.625+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	19	http://localhost:8055
108	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:57:45.784+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
109	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:58:37.929+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	18	http://localhost:8055
110	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:58:37.931+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	19	http://localhost:8055
111	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:58:43.628+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	20	http://localhost:8055
112	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:59:02.178+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	c6a78bb1-540c-485b-abe1-76e1e4625f85	http://localhost:8055
113	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:59:03.96+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	4	http://localhost:8055
114	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:59:03.966+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	21	http://localhost:8055
115	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:01:38.365+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
116	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:02:11.483+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	20	http://localhost:8055
117	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:02:11.485+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	21	http://localhost:8055
118	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:02:38.698+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	22	http://localhost:8055
119	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:03:18.362+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
120	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:04:00.147+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	4ba67ce8-6e6a-42c3-ae6e-6ec089f7a648	http://localhost:8055
121	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:04:01.363+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	5	http://localhost:8055
122	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:04:01.368+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	23	http://localhost:8055
123	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:04:01.796+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
124	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:05:24.4+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
125	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:06:19.235+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	22	http://localhost:8055
126	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:06:19.236+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	23	http://localhost:8055
127	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:06:37.645+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	24	http://localhost:8055
128	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:07:17.834+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
130	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:08:19.849+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	6	http://localhost:8055
131	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:08:19.854+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	25	http://localhost:8055
133	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:09:45.807+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	cfd0d14c-e0d3-4165-8b5f-b6e4612fbfab	http://localhost:8055
129	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:08:18.441+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	7c96933a-4844-4cad-8a14-2fb48dedafef	http://localhost:8055
132	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:08:20.221+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
134	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:09:47.711+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	7	http://localhost:8055
135	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:09:47.716+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	25	http://localhost:8055
136	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:09:48.055+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
137	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:11:43.259+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	6	http://localhost:8055
138	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:11:43.261+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	7	http://localhost:8055
139	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:11:43.267+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	25	http://localhost:8055
140	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:12:16.703+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
141	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:14:07.241+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	d3bf6430-792b-4f2d-b673-db335309f44c	http://localhost:8055
142	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:14:08.708+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	8	http://localhost:8055
143	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:14:08.713+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	25	http://localhost:8055
144	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:14:14.604+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
145	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:16:19.384+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	26	http://localhost:8055
146	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:16:44.929+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
147	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:16:57.88+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	16b65f90-a85f-403c-8fce-d0d57d18d8ca	http://localhost:8055
148	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:16:59.191+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	9	http://localhost:8055
149	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:16:59.199+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	27	http://localhost:8055
150	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:16:59.74+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
151	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:18:54.805+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	24	http://localhost:8055
152	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:18:54.807+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	25	http://localhost:8055
153	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:18:54.81+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	26	http://localhost:8055
154	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:18:54.812+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	27	http://localhost:8055
155	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:19:19.411+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	28	http://localhost:8055
156	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:19:58.469+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
157	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:20:09.476+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	1323ad0b-be3e-4755-ae99-1f3b9d662105	http://localhost:8055
158	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:20:10.965+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	10	http://localhost:8055
159	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:20:10.968+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	29	http://localhost:8055
160	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:20:11.54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
161	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:27:25.188+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	28	http://localhost:8055
162	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:27:25.191+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	29	http://localhost:8055
163	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:27:43.344+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	30	http://localhost:8055
164	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 05:52:57.722+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	30	http://localhost:8055
165	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 05:53:12.667+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	31	http://localhost:8055
166	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 05:53:54.534+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
167	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 05:54:16.065+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	f3815d1d-e777-497b-b9e8-db4a09e78a51	http://localhost:8055
168	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 05:54:18.56+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	11	http://localhost:8055
169	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 05:54:18.565+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	32	http://localhost:8055
170	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 05:54:20.107+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
171	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 05:59:09.338+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	31	http://localhost:8055
172	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 05:59:09.341+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	32	http://localhost:8055
173	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:02:24.159+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	6acb4e1f-c5f4-4ae1-b5d6-7d05cd5b4c61	http://localhost:8055
174	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:02:25.575+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	12	http://localhost:8055
175	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:02:25.578+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	33	http://localhost:8055
176	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:03:17.314+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	34	http://localhost:8055
177	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:03:33.522+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
178	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:03:33.674+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
179	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:05:34.52+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_permissions	2	http://localhost:8055
180	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:05:34.531+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
181	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:05:34.536+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_access	efdf3c55-5a96-4c96-be4d-79496370fbf7	http://localhost:8055
182	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:05:40.914+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	33	http://localhost:8055
183	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:05:40.915+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	34	http://localhost:8055
184	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:06:01.765+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	35	http://localhost:8055
185	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:06:05.841+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
186	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:06:23.997+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	554880c2-f0a0-493b-96e8-c241ee80c2b3	http://localhost:8055
187	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:06:25.688+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	13	http://localhost:8055
188	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:06:25.693+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	36	http://localhost:8055
189	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:06:29.133+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
190	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:08:13.003+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_permissions	3	http://localhost:8055
191	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:08:13.01+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_permissions	4	http://localhost:8055
192	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:08:13.014+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_permissions	5	http://localhost:8055
193	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:08:13.018+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_permissions	6	http://localhost:8055
194	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:08:13.024+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
195	update	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:08:13.029+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_access	efdf3c55-5a96-4c96-be4d-79496370fbf7	http://localhost:8055
196	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:08:31.304+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_files	31ccd840-2c44-4053-b7c8-0a0006998b97	http://localhost:8055
197	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:08:32.875+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje_files	14	http://localhost:8055
198	create	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:08:32.88+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	37	http://localhost:8055
199	run	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:08:38.389+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	http://localhost:8055
200	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:09:24.307+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	35	http://localhost:8055
201	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:09:24.308+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	36	http://localhost:8055
202	delete	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:09:24.309+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	innowacje	37	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning, status, autosave_revision_interval) FROM stdin;
innowacje	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f	active	\N
innowacje_files	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f	active	\N
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_deployment_projects; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_deployment_projects (id, deployment, external_id, name, date_created, user_created, url, framework, deployable) FROM stdin;
\.


--
-- Data for Name: directus_deployment_runs; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_deployment_runs (id, project, external_id, target, date_created, user_created, status, url, started_at, completed_at) FROM stdin;
\.


--
-- Data for Name: directus_deployments; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_deployments (id, provider, credentials, options, date_created, user_created, webhook_ids, webhook_secret, last_synced_at) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message, searchable) FROM stdin;
1	innowacje	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
2	innowacje	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	2	half	\N	\N	\N	f	\N	\N	\N	t
3	innowacje	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N	t
4	innowacje	tytul	\N	input	{"placeholder":"Tytuł","iconLeft":"abc"}	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N	t
6	innowacje	opis	\N	input	{"placeholder":"Opis","iconLeft":"abc"}	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N	t
7	innowacje	pliki	files	files	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N	t
8	innowacje_files	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N	t
9	innowacje_files	innowacje_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N	t
10	innowacje_files	directus_files_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N	t
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
e12fd3de-d9e6-4975-b887-fcb63934d4cc	local	e12fd3de-d9e6-4975-b887-fcb63934d4cc.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:47:16.02+00	\N	2026-10-03 21:47:16.087+00	\N	1837282	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-03 21:47:16.086+00
73bc659c-56a1-4e3e-abc8-60c8c404935e	local	73bc659c-56a1-4e3e-abc8-60c8c404935e.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:49:38.136+00	\N	2026-10-03 21:49:38.194+00	\N	1837282	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-03 21:49:38.192+00
f37b0606-3626-4968-9248-8c9d2eda55e8	local	f37b0606-3626-4968-9248-8c9d2eda55e8.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:57:40.217+00	\N	2026-10-03 21:57:40.285+00	\N	1837282	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-03 21:57:40.285+00
c6a78bb1-540c-485b-abe1-76e1e4625f85	local	c6a78bb1-540c-485b-abe1-76e1e4625f85.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 21:59:02.176+00	\N	2026-10-03 21:59:02.225+00	\N	1837282	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-03 21:59:02.225+00
4ba67ce8-6e6a-42c3-ae6e-6ec089f7a648	local	4ba67ce8-6e6a-42c3-ae6e-6ec089f7a648.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:04:00.143+00	\N	2026-10-03 22:04:00.186+00	\N	1837282	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-03 22:04:00.185+00
7c96933a-4844-4cad-8a14-2fb48dedafef	local	7c96933a-4844-4cad-8a14-2fb48dedafef.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:08:18.436+00	\N	2026-10-03 22:08:18.517+00	\N	1837282	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-03 22:08:18.516+00
cfd0d14c-e0d3-4165-8b5f-b6e4612fbfab	local	cfd0d14c-e0d3-4165-8b5f-b6e4612fbfab.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:09:45.804+00	\N	2026-10-03 22:09:45.883+00	\N	294418	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-03 22:09:45.882+00
d3bf6430-792b-4f2d-b673-db335309f44c	local	d3bf6430-792b-4f2d-b673-db335309f44c.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:14:07.236+00	\N	2026-10-03 22:14:07.319+00	\N	294418	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-03 22:14:07.318+00
16b65f90-a85f-403c-8fce-d0d57d18d8ca	local	16b65f90-a85f-403c-8fce-d0d57d18d8ca.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:16:57.878+00	\N	2026-10-03 22:16:57.93+00	\N	294418	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-03 22:16:57.929+00
1323ad0b-be3e-4755-ae99-1f3b9d662105	local	1323ad0b-be3e-4755-ae99-1f3b9d662105.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-03 22:20:09.473+00	\N	2026-10-03 22:20:09.576+00	\N	294418	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-03 22:20:09.576+00
f3815d1d-e777-497b-b9e8-db4a09e78a51	local	f3815d1d-e777-497b-b9e8-db4a09e78a51.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 05:54:16.062+00	\N	2026-10-04 05:54:16.107+00	\N	294418	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-04 05:54:16.106+00
6acb4e1f-c5f4-4ae1-b5d6-7d05cd5b4c61	local	6acb4e1f-c5f4-4ae1-b5d6-7d05cd5b4c61.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:02:24.155+00	\N	2026-10-04 06:02:24.257+00	\N	294418	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-04 06:02:24.256+00
554880c2-f0a0-493b-96e8-c241ee80c2b3	local	554880c2-f0a0-493b-96e8-c241ee80c2b3.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:06:23.995+00	\N	2026-10-04 06:06:24.076+00	\N	294418	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-04 06:06:24.075+00
31ccd840-2c44-4053-b7c8-0a0006998b97	local	31ccd840-2c44-4053-b7c8-0a0006998b97.pdf	car.pdf	Car	application/pdf	\N	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:08:31.301+00	\N	2026-10-04 06:08:31.338+00	\N	294418	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-10-04 06:08:31.336+00
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created, folder) FROM stdin;
496f23da-37b3-43c3-a5c3-8fae090128df	Flow	bolt	\N	\N	active	event	all	{"type":"action","scope":["items.create","items.update"],"collections":["innowacje"]}	590ecdd4-3f68-4b83-8c7b-35bbb5f560be	2026-10-03 21:34:48.727+00	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	\N
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_folders (id, name, parent, type) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2026-10-03 21:06:17.482584+00
20201029A	Remove System Relations	2026-10-03 21:06:17.537463+00
20201029B	Remove System Collections	2026-10-03 21:06:17.580816+00
20201029C	Remove System Fields	2026-10-03 21:06:17.634589+00
20201105A	Add Cascade System Relations	2026-10-03 21:06:19.297672+00
20201105B	Change Webhook URL Type	2026-10-03 21:06:19.49751+00
20210225A	Add Relations Sort Field	2026-10-03 21:06:19.593101+00
20210304A	Remove Locked Fields	2026-10-03 21:06:19.691085+00
20210312A	Webhooks Collections Text	2026-10-03 21:06:19.889531+00
20210331A	Add Refresh Interval	2026-10-03 21:06:19.987225+00
20210415A	Make Filesize Nullable	2026-10-03 21:06:20.183526+00
20210416A	Add Collections Accountability	2026-10-03 21:06:20.284595+00
20210422A	Remove Files Interface	2026-10-03 21:06:20.358096+00
20210506A	Rename Interfaces	2026-10-03 21:06:20.427385+00
20210510A	Restructure Relations	2026-10-03 21:06:20.973469+00
20210518A	Add Foreign Key Constraints	2026-10-03 21:06:21.034676+00
20210519A	Add System Fk Triggers	2026-10-03 21:06:21.86253+00
20210521A	Add Collections Icon Color	2026-10-03 21:06:21.96036+00
20210525A	Add Insights	2026-10-03 21:06:22.699146+00
20210608A	Add Deep Clone Config	2026-10-03 21:06:22.797738+00
20210626A	Change Filesize Bigint	2026-10-03 21:06:23.240686+00
20210716A	Add Conditions to Fields	2026-10-03 21:06:23.388877+00
20210721A	Add Default Folder	2026-10-03 21:06:23.610374+00
20210802A	Replace Groups	2026-10-03 21:06:23.688321+00
20210803A	Add Required to Fields	2026-10-03 21:06:23.856524+00
20210805A	Update Groups	2026-10-03 21:06:23.934642+00
20210805B	Change Image Metadata Structure	2026-10-03 21:06:24.007933+00
20210811A	Add Geometry Config	2026-10-03 21:06:24.102707+00
20210831A	Remove Limit Column	2026-10-03 21:06:24.270158+00
20210903A	Add Auth Provider	2026-10-03 21:06:24.943895+00
20210907A	Webhooks Collections Not Null	2026-10-03 21:06:25.239827+00
20210910A	Move Module Setup	2026-10-03 21:06:25.406473+00
20210920A	Webhooks URL Not Null	2026-10-03 21:06:25.633705+00
20210924A	Add Collection Organization	2026-10-03 21:06:25.877169+00
20210927A	Replace Fields Group	2026-10-03 21:06:26.098547+00
20210927B	Replace M2M Interface	2026-10-03 21:06:26.159448+00
20210929A	Rename Login Action	2026-10-03 21:06:26.205033+00
20211007A	Update Presets	2026-10-03 21:06:26.369196+00
20211009A	Add Auth Data	2026-10-03 21:06:26.467861+00
20211016A	Add Webhook Headers	2026-10-03 21:06:26.566531+00
20211103A	Set Unique to User Token	2026-10-03 21:06:26.763138+00
20211103B	Update Special Geometry	2026-10-03 21:06:26.814333+00
20211104A	Remove Collections Listing	2026-10-03 21:06:26.910882+00
20211118A	Add Notifications	2026-10-03 21:06:27.434114+00
20211211A	Add Shares	2026-10-03 21:06:28.092834+00
20211230A	Add Project Descriptor	2026-10-03 21:06:28.216401+00
20220303A	Remove Default Project Color	2026-10-03 21:06:28.462293+00
20220308A	Add Bookmark Icon and Color	2026-10-03 21:06:28.560757+00
20220314A	Add Translation Strings	2026-10-03 21:06:28.634877+00
20220322A	Rename Field Typecast Flags	2026-10-03 21:06:28.667175+00
20220323A	Add Field Validation	2026-10-03 21:06:28.770162+00
20220325A	Fix Typecast Flags	2026-10-03 21:06:28.822716+00
20220325B	Add Default Language	2026-10-03 21:06:29.213324+00
20220402A	Remove Default Value Panel Icon	2026-10-03 21:06:29.887998+00
20220429A	Add Flows	2026-10-03 21:06:33.186804+00
20220429B	Add Color to Insights Icon	2026-10-03 21:06:33.462228+00
20220429C	Drop Non Null From IP of Activity	2026-10-03 21:06:33.658431+00
20220429D	Drop Non Null From Sender of Notifications	2026-10-03 21:06:33.821314+00
20220614A	Rename Hook Trigger to Event	2026-10-03 21:06:33.902956+00
20220801A	Update Notifications Timestamp Column	2026-10-03 21:06:34.298323+00
20220802A	Add Custom Aspect Ratios	2026-10-03 21:06:34.470022+00
20220826A	Add Origin to Accountability	2026-10-03 21:06:34.68809+00
20230401A	Update Material Icons	2026-10-03 21:06:35.268665+00
20230525A	Add Preview Settings	2026-10-03 21:06:35.404956+00
20230526A	Migrate Translation Strings	2026-10-03 21:06:36.79101+00
20230721A	Require Shares Fields	2026-10-03 21:06:37.573049+00
20230823A	Add Content Versioning	2026-10-03 21:06:38.904452+00
20230927A	Themes	2026-10-03 21:06:39.718207+00
20231009A	Update CSV Fields to Text	2026-10-03 21:06:39.926178+00
20231009B	Update Panel Options	2026-10-03 21:06:40.058915+00
20231010A	Add Extensions	2026-10-03 21:06:40.724744+00
20231215A	Add Focalpoints	2026-10-03 21:06:40.819856+00
20240122A	Add Report URL Fields	2026-10-03 21:06:40.96773+00
20240204A	Marketplace	2026-10-03 21:06:44.682137+00
20240305A	Change Useragent Type	2026-10-03 21:06:45.310287+00
20240311A	Deprecate Webhooks	2026-10-03 21:06:45.671052+00
20240422A	Public Registration	2026-10-03 21:06:45.829087+00
20240515A	Add Session Window	2026-10-03 21:06:46.001783+00
20240701A	Add Tus Data	2026-10-03 21:06:46.208351+00
20240716A	Update Files Date Fields	2026-10-03 21:06:46.3579+00
20240806A	Permissions Policies	2026-10-03 21:06:47.72011+00
20240817A	Update Icon Fields Length	2026-10-03 21:06:48.617606+00
20240909A	Separate Comments	2026-10-03 21:06:48.914977+00
20240909B	Consolidate Content Versioning	2026-10-03 21:06:48.97489+00
20240924A	Migrate Legacy Comments	2026-10-03 21:06:49.047444+00
20240924B	Populate Versioning Deltas	2026-10-03 21:06:49.099365+00
20250224A	Visual Editor	2026-10-03 21:06:49.200694+00
20250609A	License Banner	2026-10-03 21:06:49.272099+00
20250613A	Add Project ID	2026-10-03 21:06:49.445552+00
20250718A	Add Direction	2026-10-03 21:06:49.527359+00
20250813A	Add MCP	2026-10-03 21:06:49.597989+00
20251012A	Add Field Searchable	2026-10-03 21:06:49.658248+00
20251014A	Add Project Owner	2026-10-03 21:06:49.936693+00
20251028A	Add Retention Indexes	2026-10-03 21:06:50.438948+00
20251103A	Add AI Settings	2026-10-03 21:06:50.518738+00
20251224A	Remove Webhooks	2026-10-03 21:06:50.593158+00
20260110A	Add AI Provider Settings	2026-10-03 21:06:50.705236+00
20260113A	Add Revisions Index	2026-10-03 21:06:51.025364+00
20260128A	Add Collaborative Editing	2026-10-03 21:06:51.130553+00
20260204A	Add Deployment	2026-10-03 21:06:52.050008+00
20260211A	Add Deployment Webhooks	2026-10-03 21:06:52.188098+00
20260217A	Null Item Versions	2026-10-03 21:06:52.320347+00
20260312A	Add AI Translation Settings	2026-10-03 21:06:52.388937+00
20260507A	Add Licensing	2026-10-03 21:06:52.484154+00
20260512A	Add Autosave Revision Interval	2026-10-03 21:06:52.545031+00
20260512B	Add MCP Oauth	2026-10-03 21:06:54.681814+00
20260727A	Add Default Save Action	2026-10-03 21:06:54.764542+00
20260818A	Add Flow Folders	2026-10-03 21:06:54.994796+00
20260909A	Add Flows Module	2026-10-03 21:06:55.03917+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_oauth_clients; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_oauth_clients (client_id, client_name, redirect_uris, grant_types, token_endpoint_auth_method, client_secret_hash, registration_type, client_uri, logo_uri, tos_uri, policy_uri, metadata_fetched_at, metadata_expires_at, metadata_etag, date_created) FROM stdin;
\.


--
-- Data for Name: directus_oauth_codes; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_oauth_codes (id, code_hash, client, "user", redirect_uri, resource, code_challenge, code_challenge_method, scope, expires_at, used_at) FROM stdin;
\.


--
-- Data for Name: directus_oauth_consents; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_oauth_consents (id, "user", client, redirect_uri, scope, date_created, date_updated) FROM stdin;
\.


--
-- Data for Name: directus_oauth_tokens; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_oauth_tokens (id, client, "user", session, previous_session, resource, code_hash, scope, expires_at, date_created) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
590ecdd4-3f68-4b83-8c7b-35bbb5f560be	Webhook	webhook	request	19	1	{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"{{$trigger.key}}\\",\\n  \\"id_update\\": \\"{{$trigger.keys[0]}}\\"\\n}"}	\N	\N	496f23da-37b3-43c3-a5c3-8fae090128df	2026-10-03 21:37:01.694+00	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
1	innowacje	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
2	innowacje_files	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
3	innowacje_files	share	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
4	innowacje	share	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
5	directus_files	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
6	directus_files	share	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
8e6d2387-7ba3-415e-a508-d0f4e0b7c41b	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	innowacje	user_created	directus_users	\N	\N	\N	\N	\N	nullify
2	innowacje_files	directus_files_id	directus_files	\N	\N	\N	innowacje_id	\N	nullify
3	innowacje_files	innowacje_id	innowacje	pliki	\N	\N	directus_files_id	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_fields	1	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id"}	\N	\N
2	3	directus_fields	2	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created"}	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created"}	\N	\N
3	4	directus_fields	3	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created"}	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created"}	\N	\N
4	5	directus_collections	innowacje	{"singleton":false,"collection":"innowacje"}	{"singleton":false,"collection":"innowacje"}	\N	\N
5	6	directus_fields	4	{"sort":4,"interface":"input","special":null,"options":{"placeholder":"Tytuł","iconLeft":"abc"},"field":"tytul"}	{"sort":4,"interface":"input","special":null,"options":{"placeholder":"Tytuł","iconLeft":"abc"},"field":"tytul"}	\N	\N
6	7	directus_fields	5	{"sort":5,"interface":"input","special":null,"options":{"placeholder":"Treść","iconLeft":"abc"},"field":"tresc"}	{"sort":5,"interface":"input","special":null,"options":{"placeholder":"Treść","iconLeft":"abc"},"field":"tresc"}	\N	\N
7	9	directus_fields	6	{"sort":5,"interface":"input","special":null,"options":{"placeholder":"Opis","iconLeft":"abc"},"field":"opis"}	{"sort":5,"interface":"input","special":null,"options":{"placeholder":"Opis","iconLeft":"abc"},"field":"opis"}	\N	\N
8	10	directus_fields	7	{"sort":6,"interface":"files","special":["files"],"field":"pliki"}	{"sort":6,"interface":"files","special":["files"],"field":"pliki"}	\N	\N
9	11	directus_fields	8	{"sort":1,"hidden":true,"field":"id"}	{"sort":1,"hidden":true,"field":"id"}	\N	\N
10	12	directus_collections	innowacje_files	{"hidden":true,"icon":"import_export","collection":"innowacje_files"}	{"hidden":true,"icon":"import_export","collection":"innowacje_files"}	\N	\N
11	13	directus_fields	9	{"sort":2,"hidden":true,"field":"innowacje_id"}	{"sort":2,"hidden":true,"field":"innowacje_id"}	\N	\N
12	14	directus_fields	10	{"sort":3,"hidden":true,"field":"directus_files_id"}	{"sort":3,"hidden":true,"field":"directus_files_id"}	\N	\N
13	15	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"name":"flow","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]}}	{"name":"flow","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]}}	\N	\N
15	17	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"id":"8d51dad1-04b5-4bd1-80fd-7e76c3a4d362","name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]},"date_created":"2026-10-03T21:11:52.069Z"}	{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab"}	\N	\N
14	16	directus_operations	077db770-b3bd-49d1-9cd5-fde2db6921ab	{"position_x":19,"position_y":1,"name":"Webhook / Request URL","key":"request_wnwf8","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.keys[0]}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/{{$trigger.keys[0]}}\\"\\n}"}}	{"position_x":19,"position_y":1,"name":"Webhook / Request URL","key":"request_wnwf8","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.keys[0]}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/{{$trigger.keys[0]}}\\"\\n}"}}	15	\N
16	18	innowacje	1	{"tytul":"Wpis1","opis":"Tresc1"}	{"tytul":"Wpis1","opis":"Tresc1"}	\N	\N
18	20	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"id":"8d51dad1-04b5-4bd1-80fd-7e76c3a4d362","name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]},"date_created":"2026-10-03T21:11:52.069Z"}	{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab"}	\N	\N
17	19	directus_operations	077db770-b3bd-49d1-9cd5-fde2db6921ab	{"id":"077db770-b3bd-49d1-9cd5-fde2db6921ab","name":"Webhook / Request URL","key":"request_wnwf8","type":"request","position_x":19,"position_y":1,"options":{"method":"POST","url":"http://localhost:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.keys[0]}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/{{$trigger.keys[0]}}\\"\\n}"},"date_created":"2026-10-03T21:12:27.094Z"}	{"name":"Webhook / Request URL","key":"request_wnwf8","type":"request","options":{"method":"POST","url":"http://localhost:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.keys[0]}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/{{$trigger.keys[0]}}\\"\\n}"},"flow":"8d51dad1-04b5-4bd1-80fd-7e76c3a4d362"}	18	\N
19	21	innowacje	2	{"tytul":"Tresc2","opis":"Tresc2"}	{"tytul":"Tresc2","opis":"Tresc2"}	\N	\N
23	25	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"steps":[{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab","key":"request_wnwf8","status":"reject","options":{"method":"POST","url":"http://localhost:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"tresc3\\",\\n  \\"tekst\\": \\"tresc3\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"tresc3","opis":"tresc3"},"key":3,"collection":"innowacje"},"$last":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","cause":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","stack":"Error: Requested domain \\"localhost\\" resolves to a denied IP address\\n    at deniedError (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:5:49)\\n    at Socket.<anonymous> (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:18:26)\\n    at Socket.emit (node:events:519:28)\\n    at GetAddrInfoReqWrap.emitLookup [as callback] (node:net:1472:14)\\n    at GetAddrInfoReqWrap.onlookupall [as oncomplete] (node:dns:134:8)"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"igN6oBC1LtCA8T57pyrEI5K6xkJstMxN_aLRL3fGHN5T0GYdQvyKbhsuj81jKB-i"},"$env":{},"request_wnwf8":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","cause":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","stack":"Error: Requested domain \\"localhost\\" resolves to a denied IP address\\n    at deniedError (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:5:49)\\n    at Socket.<anonymous> (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:18:26)\\n    at Socket.emit (node:events:519:28)\\n    at GetAddrInfoReqWrap.emitLookup [as callback] (node:net:1472:14)\\n    at GetAddrInfoReqWrap.onlookupall [as oncomplete] (node:dns:134:8)"}}}}	\N	\N	\N
20	22	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"steps":[{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab","key":"request_wnwf8","status":"reject","options":{"method":"POST","url":"http://localhost:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"Tresc2\\",\\n  \\"tekst\\": \\"Tresc2\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"Tresc2","opis":"Tresc2"},"key":2,"collection":"innowacje"},"$last":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","cause":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","stack":"Error: Requested domain \\"localhost\\" resolves to a denied IP address\\n    at deniedError (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:5:49)\\n    at Socket.<anonymous> (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:18:26)\\n    at Socket.emit (node:events:519:28)\\n    at GetAddrInfoReqWrap.emitLookup [as callback] (node:net:1472:14)\\n    at GetAddrInfoReqWrap.onlookupall [as oncomplete] (node:dns:134:8)"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"igN6oBC1LtCA8T57pyrEI5K6xkJstMxN_aLRL3fGHN5T0GYdQvyKbhsuj81jKB-i"},"$env":{},"request_wnwf8":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","cause":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","stack":"Error: Requested domain \\"localhost\\" resolves to a denied IP address\\n    at deniedError (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:5:49)\\n    at Socket.<anonymous> (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:18:26)\\n    at Socket.emit (node:events:519:28)\\n    at GetAddrInfoReqWrap.emitLookup [as callback] (node:net:1472:14)\\n    at GetAddrInfoReqWrap.onlookupall [as oncomplete] (node:dns:134:8)"}}}}	\N	\N	\N
21	23	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"steps":[{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab","key":"request_wnwf8","status":"reject","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"Wpis1\\",\\n  \\"tekst\\": \\"Tresc1\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"Wpis1","opis":"Tresc1"},"key":1,"collection":"innowacje"},"$last":{"status":500,"statusText":"INTERNAL SERVER ERROR","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:14:02 GMT","content-type":"application/json","content-length":"210","connection":"close"},"data":{"error":"Błąd indeksacji: Unexpected Response: 404 (Not Found)\\nRaw response content:\\nb'{\\"status\\":{\\"error\\":\\"Not found: Collection `teksty_kolekcja` doesn\\\\'t exist!\\"},\\"time\\":0.000028201}'"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"igN6oBC1LtCA8T57pyrEI5K6xkJstMxN_aLRL3fGHN5T0GYdQvyKbhsuj81jKB-i"},"$env":{},"request_wnwf8":{"status":500,"statusText":"INTERNAL SERVER ERROR","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:14:02 GMT","content-type":"application/json","content-length":"210","connection":"close"},"data":{"error":"Błąd indeksacji: Unexpected Response: 404 (Not Found)\\nRaw response content:\\nb'{\\"status\\":{\\"error\\":\\"Not found: Collection `teksty_kolekcja` doesn\\\\'t exist!\\"},\\"time\\":0.000028201}'"}}}}	\N	\N	\N
22	24	innowacje	3	{"tytul":"tresc3","opis":"tresc3"}	{"tytul":"tresc3","opis":"tresc3"}	\N	\N
24	26	innowacje	4	{"tytul":"tresc4","opis":"trec4"}	{"tytul":"tresc4","opis":"trec4"}	\N	\N
25	27	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"steps":[{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab","key":"request_wnwf8","status":"reject","options":{"method":"POST","url":"http://localhost:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"tresc4\\",\\n  \\"tekst\\": \\"trec4\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"tresc4","opis":"trec4"},"key":4,"collection":"innowacje"},"$last":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","cause":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","stack":"Error: Requested domain \\"localhost\\" resolves to a denied IP address\\n    at deniedError (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:5:49)\\n    at Socket.<anonymous> (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:18:26)\\n    at Socket.emit (node:events:519:28)\\n    at GetAddrInfoReqWrap.emitLookup [as callback] (node:net:1472:14)\\n    at GetAddrInfoReqWrap.onlookupall [as oncomplete] (node:dns:134:8)"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"igN6oBC1LtCA8T57pyrEI5K6xkJstMxN_aLRL3fGHN5T0GYdQvyKbhsuj81jKB-i"},"$env":{},"request_wnwf8":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","cause":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","stack":"Error: Requested domain \\"localhost\\" resolves to a denied IP address\\n    at deniedError (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:5:49)\\n    at Socket.<anonymous> (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:18:26)\\n    at Socket.emit (node:events:519:28)\\n    at GetAddrInfoReqWrap.emitLookup [as callback] (node:net:1472:14)\\n    at GetAddrInfoReqWrap.onlookupall [as oncomplete] (node:dns:134:8)"}}}}	\N	\N	\N
26	28	innowacje	5	{"tytul":"testestes","opis":"testestestes"}	{"tytul":"testestes","opis":"testestestes"}	\N	\N
27	29	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"steps":[{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab","key":"request_wnwf8","status":"reject","options":{"method":"POST","url":"http://localhost:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"testestes\\",\\n  \\"tekst\\": \\"testestestes\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"testestes","opis":"testestestes"},"key":5,"collection":"innowacje"},"$last":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","cause":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","stack":"Error: Requested domain \\"localhost\\" resolves to a denied IP address\\n    at deniedError (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:5:49)\\n    at Socket.<anonymous> (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:18:26)\\n    at Socket.emit (node:events:519:28)\\n    at GetAddrInfoReqWrap.emitLookup [as callback] (node:net:1472:14)\\n    at GetAddrInfoReqWrap.onlookupall [as oncomplete] (node:dns:134:8)"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"igN6oBC1LtCA8T57pyrEI5K6xkJstMxN_aLRL3fGHN5T0GYdQvyKbhsuj81jKB-i"},"$env":{},"request_wnwf8":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","cause":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","stack":"Error: Requested domain \\"localhost\\" resolves to a denied IP address\\n    at deniedError (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:5:49)\\n    at Socket.<anonymous> (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:18:26)\\n    at Socket.emit (node:events:519:28)\\n    at GetAddrInfoReqWrap.emitLookup [as callback] (node:net:1472:14)\\n    at GetAddrInfoReqWrap.onlookupall [as oncomplete] (node:dns:134:8)"}}}}	\N	\N	\N
28	35	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"id":"8d51dad1-04b5-4bd1-80fd-7e76c3a4d362","name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create","items.update"],"collections":["innowacje"]},"date_created":"2026-10-03T21:11:52.069Z"}	{"name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create","items.update"],"collections":["innowacje"]}}	\N	\N
29	36	innowacje	6	{"tytul":"Test1","opis":"test2"}	{"tytul":"Test1","opis":"test2"}	\N	\N
30	37	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"steps":[{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab","key":"request_wnwf8","status":"reject","options":{"method":"POST","url":"http://localhost:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"Test1\\",\\n  \\"tekst\\": \\"test2\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"Test1","opis":"test2"},"key":6,"collection":"innowacje"},"$last":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","cause":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","stack":"Error: Requested domain \\"localhost\\" resolves to a denied IP address\\n    at deniedError (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:5:49)\\n    at Socket.<anonymous> (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:18:26)\\n    at Socket.emit (node:events:519:28)\\n    at GetAddrInfoReqWrap.emitLookup [as callback] (node:net:1472:14)\\n    at GetAddrInfoReqWrap.onlookupall [as oncomplete] (node:dns:134:8)"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"PMm1fCzi72qt8ADGGd_PmAlDLgUGuLmPkbMCrTFenWmC5RVmv3b0Ru6R8cD50_IO"},"$env":{},"request_wnwf8":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","cause":{"name":"Error","message":"Requested domain \\"localhost\\" resolves to a denied IP address","stack":"Error: Requested domain \\"localhost\\" resolves to a denied IP address\\n    at deniedError (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:5:49)\\n    at Socket.<anonymous> (file:///directus/node_modules/.pnpm/@directus+api@file+api_@emnapi+core@1.10.0_@emnapi+runtime@1.10.0_@opentelemetry+api@1._2f4d119371980dc83fa7ce278ba1c6c4/node_modules/@directus/api/dist/request/agent-with-ip-validation.js:18:26)\\n    at Socket.emit (node:events:519:28)\\n    at GetAddrInfoReqWrap.emitLookup [as callback] (node:net:1472:14)\\n    at GetAddrInfoReqWrap.onlookupall [as oncomplete] (node:dns:134:8)"}}}}	\N	\N	\N
32	39	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"id":"8d51dad1-04b5-4bd1-80fd-7e76c3a4d362","name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create","items.update"],"collections":["innowacje"]},"date_created":"2026-10-03T21:11:52.069Z"}	{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab"}	\N	\N
31	38	directus_operations	077db770-b3bd-49d1-9cd5-fde2db6921ab	{"id":"077db770-b3bd-49d1-9cd5-fde2db6921ab","name":"Webhook / Request URL","key":"request_wnwf8","type":"request","position_x":19,"position_y":1,"options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.keys[0]}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/{{$trigger.keys[0]}}\\"\\n}"},"date_created":"2026-10-03T21:12:27.094Z"}	{"name":"Webhook / Request URL","key":"request_wnwf8","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.keys[0]}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/{{$trigger.keys[0]}}\\"\\n}"},"flow":"8d51dad1-04b5-4bd1-80fd-7e76c3a4d362"}	32	\N
33	40	innowacje	7	{"tytul":"test22","opis":"testest2"}	{"tytul":"test22","opis":"testest2"}	\N	\N
35	42	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"id":"8d51dad1-04b5-4bd1-80fd-7e76c3a4d362","name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create","items.update"],"collections":["innowacje"]},"date_created":"2026-10-03T21:11:52.069Z"}	{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab"}	\N	\N
34	41	directus_operations	077db770-b3bd-49d1-9cd5-fde2db6921ab	{"id":"077db770-b3bd-49d1-9cd5-fde2db6921ab","name":"Webhook / Request URL","key":"request_wnwf8","type":"request","position_x":19,"position_y":1,"options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.keys[0]}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/{{$trigger.keys[0]}}\\"\\n}"},"date_created":"2026-10-03T21:12:27.094Z"}	{"name":"Webhook / Request URL","key":"request_wnwf8","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.keys[0]}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/{{$trigger.keys[0]}}\\"\\n}"},"flow":"8d51dad1-04b5-4bd1-80fd-7e76c3a4d362"}	35	\N
36	43	innowacje	8	{"tytul":"testestest","opis":"estestestes"}	{"tytul":"testestest","opis":"estestestes"}	\N	\N
37	44	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"steps":[{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab","key":"request_wnwf8","status":"reject","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"testestest\\",\\n  \\"tekst\\": \\"estestestes\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"testestest","opis":"estestestes"},"key":8,"collection":"innowacje"},"$last":{"status":500,"statusText":"INTERNAL SERVER ERROR","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:24:55 GMT","content-type":"application/json","content-length":"217","connection":"close"},"data":{"error":"Błąd indeksacji: Unexpected Response: 409 (Conflict)\\nRaw response content:\\nb'{\\"status\\":{\\"error\\":\\"Wrong input: Collection `teksty_kolekcja` already exists!\\"},\\"time\\":2.9443837200000003}'"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"PMm1fCzi72qt8ADGGd_PmAlDLgUGuLmPkbMCrTFenWmC5RVmv3b0Ru6R8cD50_IO"},"$env":{},"request_wnwf8":{"status":500,"statusText":"INTERNAL SERVER ERROR","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:24:55 GMT","content-type":"application/json","content-length":"217","connection":"close"},"data":{"error":"Błąd indeksacji: Unexpected Response: 409 (Conflict)\\nRaw response content:\\nb'{\\"status\\":{\\"error\\":\\"Wrong input: Collection `teksty_kolekcja` already exists!\\"},\\"time\\":2.9443837200000003}'"}}}}	\N	\N	\N
38	45	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"steps":[{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab","key":"request_wnwf8","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"test22\\",\\n  \\"tekst\\": \\"testest2\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"test22","opis":"testest2"},"key":7,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:25:00 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"PMm1fCzi72qt8ADGGd_PmAlDLgUGuLmPkbMCrTFenWmC5RVmv3b0Ru6R8cD50_IO"},"$env":{},"request_wnwf8":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:25:00 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
39	46	innowacje	9	{"tytul":"testestes","opis":"testestestes"}	{"tytul":"testestes","opis":"testestestes"}	\N	\N
40	48	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	{"steps":[{"operation":"077db770-b3bd-49d1-9cd5-fde2db6921ab","key":"request_wnwf8","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"testestes\\",\\n  \\"tekst\\": \\"testestestes\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://adres-twojego-frontendu.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"testestes","opis":"testestestes"},"key":9,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:28:48 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"RMz0p3ZCAlknFIBqc7hw1bKj9qYIaaalV706AffCMDmYjcj8OYyPoaWP_zXNrbw0"},"$env":{},"request_wnwf8":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:28:48 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
41	49	directus_flows	7d6a3b8f-31a0-4a60-a1aa-2a3396e562c2	{"name":"flow","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["innowacje","innowacje_files"]}}	{"name":"flow","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["innowacje","innowacje_files"]}}	\N	\N
43	51	directus_flows	7d6a3b8f-31a0-4a60-a1aa-2a3396e562c2	{"id":"7d6a3b8f-31a0-4a60-a1aa-2a3396e562c2","name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje","innowacje_files"]},"date_created":"2026-10-03T21:29:01.240Z"}	{"name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje","innowacje_files"]},"operation":"f28deab0-d3bd-4e06-97a0-f0aa2fd48cd2","date_created":"2026-10-03T21:29:01.240Z","user_created":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","folder":null}	\N	\N
44	52	innowacje	10	{"tytul":"testestest","opis":"testestestes"}	{"tytul":"testestest","opis":"testestestes"}	\N	\N
42	50	directus_operations	f28deab0-d3bd-4e06-97a0-f0aa2fd48cd2	{"position_x":19,"position_y":1,"name":"webhook","key":"webhook","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.keys[0]}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://frontend.pl/innowacje/{{$trigger.keys[0]}}\\"\\n}"}}	{"position_x":19,"position_y":1,"name":"webhook","key":"webhook","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.keys[0]}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://frontend.pl/innowacje/{{$trigger.keys[0]}}\\"\\n}"}}	43	\N
45	53	directus_flows	7d6a3b8f-31a0-4a60-a1aa-2a3396e562c2	{"steps":[{"operation":"f28deab0-d3bd-4e06-97a0-f0aa2fd48cd2","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"testestest\\",\\n  \\"tekst\\": \\"testestestes\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://frontend.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"testestest","opis":"testestestes"},"key":10,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:30:25 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"RMz0p3ZCAlknFIBqc7hw1bKj9qYIaaalV706AffCMDmYjcj8OYyPoaWP_zXNrbw0"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:30:25 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
46	57	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	\N	{"name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]}}	\N	\N
47	58	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	\N	{"name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]}}	\N	\N
48	59	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	\N	{"name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]}}	\N	\N
49	62	directus_flows	8d51dad1-04b5-4bd1-80fd-7e76c3a4d362	\N	{"name":"flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]}}	\N	\N
50	65	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]}}	{"name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]}}	\N	\N
52	67	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"id":"496f23da-37b3-43c3-a5c3-8fae090128df","name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]},"date_created":"2026-10-03T21:34:48.727Z"}	{"name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]},"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","date_created":"2026-10-03T21:34:48.727Z","user_created":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","folder":null}	\N	\N
51	66	directus_operations	590ecdd4-3f68-4b83-8c7b-35bbb5f560be	{"position_x":19,"position_y":1,"name":"Webhook","key":"webhook","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.payload.id}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://frontend.pl/innowacje/{{$trigger.payload.id}}\\"\\n}"}}	{"position_x":19,"position_y":1,"name":"Webhook","key":"webhook","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.payload.id}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://frontend.pl/innowacje/{{$trigger.payload.id}}\\"\\n}"}}	52	\N
53	68	innowacje	11	{"tytul":"tresc1","opis":"tresc2"}	{"tytul":"tresc1","opis":"tresc2"}	\N	\N
54	69	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"tresc1\\",\\n  \\"tekst\\": \\"tresc2\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://frontend.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"tresc1","opis":"tresc2"},"key":11,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:37:18 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"AQLXf6FUxMSJlNEsYx2DbE5dvl3KiD-Vwyj5lAVKUpdtAOejo1y_tPbSswg2FDAH"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:37:18 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
55	70	innowacje	12	{"tytul":"tresc555","opis":"tresc555"}	{"tytul":"tresc555","opis":"tresc555"}	\N	\N
58	73	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"id":"496f23da-37b3-43c3-a5c3-8fae090128df","name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]},"date_created":"2026-10-03T21:34:48.727Z"}	{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be"}	\N	\N
57	72	directus_operations	590ecdd4-3f68-4b83-8c7b-35bbb5f560be	{"id":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","name":"Webhook","key":"webhook","type":"request","position_x":19,"position_y":1,"options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"1\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"2\\"\\n}"},"date_created":"2026-10-03T21:37:01.694Z"}	{"name":"Webhook","key":"webhook","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"1\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"2\\"\\n}"},"flow":"496f23da-37b3-43c3-a5c3-8fae090128df"}	58	\N
62	77	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"id":"496f23da-37b3-43c3-a5c3-8fae090128df","name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]},"date_created":"2026-10-03T21:34:48.727Z"}	{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be"}	\N	\N
61	76	directus_operations	590ecdd4-3f68-4b83-8c7b-35bbb5f560be	{"id":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","name":"Webhook","key":"webhook","type":"request","position_x":19,"position_y":1,"options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.key}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://link-do-frontendu.pl/innowacje/{{$trigger.key}}\\"\\n}"},"date_created":"2026-10-03T21:37:01.694Z"}	{"name":"Webhook","key":"webhook","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"{{$trigger.key}}\\",\\n  \\"tytul\\": \\"{{$trigger.payload.tytul}}\\",\\n  \\"tekst\\": \\"{{$trigger.payload.opis}}\\",\\n  \\"pliki\\": \\"{{$trigger.payload.pliki}}\\",\\n  \\"url\\": \\"https://link-do-frontendu.pl/innowacje/{{$trigger.key}}\\"\\n}"},"flow":"496f23da-37b3-43c3-a5c3-8fae090128df"}	62	\N
63	78	innowacje	14	{"tytul":"tresc666","opis":"666"}	{"tytul":"tresc666","opis":"666"}	\N	\N
56	71	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"undefined\\",\\n  \\"tytul\\": \\"tresc555\\",\\n  \\"tekst\\": \\"tresc555\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://frontend.pl/innowacje/undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"tresc555","opis":"tresc555"},"key":12,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:38:00 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"AQLXf6FUxMSJlNEsYx2DbE5dvl3KiD-Vwyj5lAVKUpdtAOejo1y_tPbSswg2FDAH"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:38:00 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
59	74	innowacje	13	{"tytul":"tresc5555","opis":"55555"}	{"tytul":"tresc5555","opis":"55555"}	\N	\N
60	75	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"1\\",\\n  \\"tytul\\": \\"tresc5555\\",\\n  \\"tekst\\": \\"55555\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"2\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"tresc5555","opis":"55555"},"key":13,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:40:31 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"AQLXf6FUxMSJlNEsYx2DbE5dvl3KiD-Vwyj5lAVKUpdtAOejo1y_tPbSswg2FDAH"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:40:31 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
64	79	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"14\\",\\n  \\"tytul\\": \\"tresc666\\",\\n  \\"tekst\\": \\"666\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://link-do-frontendu.pl/innowacje/14\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"tresc666","opis":"666"},"key":14,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:42:27 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"AQLXf6FUxMSJlNEsYx2DbE5dvl3KiD-Vwyj5lAVKUpdtAOejo1y_tPbSswg2FDAH"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:42:27 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
65	84	directus_files	e12fd3de-d9e6-4975-b887-fcb63934d4cc	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
67	86	innowacje	15	{"tytul":"plik2","opis":"plik2"}	{"tytul":"plik2","opis":"plik2"}	\N	\N
66	85	innowacje_files	1	\N	\N	67	\N
68	87	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"reject","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"15\\",\\n  \\"tytul\\": \\"plik2\\",\\n  \\"tekst\\": \\"plik2\\",\\n  \\"pliki\\": \\"{\\"create\\":[{\\"innowacje_id\\":\\"+\\",\\"directus_files_id\\":{\\"id\\":\\"e12fd3de-d9e6-4975-b887-fcb63934d4cc\\"}}],\\"update\\":[],\\"delete\\":[]}\\",\\n  \\"url\\": \\"https://link-do-frontendu.pl/innowacje/15\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"plik2","opis":"plik2","pliki":{"create":[{"innowacje_id":"+","directus_files_id":{"id":"e12fd3de-d9e6-4975-b887-fcb63934d4cc"}}],"update":[],"delete":[]}},"key":15,"collection":"innowacje"},"$last":{"status":500,"statusText":"INTERNAL SERVER ERROR","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:47:18 GMT","content-type":"text/html; charset=utf-8","content-length":"265","connection":"close"},"data":"<!doctype html>\\n<html lang=en>\\n<title>500 Internal Server Error</title>\\n<h1>Internal Server Error</h1>\\n<p>The server encountered an internal error and was unable to complete your request. Either the server is overloaded or there is an error in the application.</p>\\n"},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"AQLXf6FUxMSJlNEsYx2DbE5dvl3KiD-Vwyj5lAVKUpdtAOejo1y_tPbSswg2FDAH"},"$env":{},"webhook":{"status":500,"statusText":"INTERNAL SERVER ERROR","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:47:18 GMT","content-type":"text/html; charset=utf-8","content-length":"265","connection":"close"},"data":"<!doctype html>\\n<html lang=en>\\n<title>500 Internal Server Error</title>\\n<h1>Internal Server Error</h1>\\n<p>The server encountered an internal error and was unable to complete your request. Either the server is overloaded or there is an error in the application.</p>\\n"}}}	\N	\N	\N
69	88	directus_files	73bc659c-56a1-4e3e-abc8-60c8c404935e	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
71	90	innowacje	16	{"tytul":"plik3","opis":"plik3"}	{"tytul":"plik3","opis":"plik3"}	\N	\N
70	89	innowacje_files	2	\N	\N	71	\N
72	91	innowacje	17	{"tytul":"plik4","opis":"plik4"}	{"tytul":"plik4","opis":"plik4"}	\N	\N
73	92	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"reject","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"16\\",\\n  \\"tytul\\": \\"plik3\\",\\n  \\"tekst\\": \\"plik3\\",\\n  \\"pliki\\": \\"{\\"create\\":[{\\"innowacje_id\\":\\"+\\",\\"directus_files_id\\":{\\"id\\":\\"73bc659c-56a1-4e3e-abc8-60c8c404935e\\"}}],\\"update\\":[],\\"delete\\":[]}\\",\\n  \\"url\\": \\"https://link-do-frontendu.pl/innowacje/16\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"plik3","opis":"plik3","pliki":{"create":[{"innowacje_id":"+","directus_files_id":{"id":"73bc659c-56a1-4e3e-abc8-60c8c404935e"}}],"update":[],"delete":[]}},"key":16,"collection":"innowacje"},"$last":{"status":500,"statusText":"INTERNAL SERVER ERROR","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:50:12 GMT","content-type":"text/html; charset=utf-8","content-length":"265","connection":"close"},"data":"<!doctype html>\\n<html lang=en>\\n<title>500 Internal Server Error</title>\\n<h1>Internal Server Error</h1>\\n<p>The server encountered an internal error and was unable to complete your request. Either the server is overloaded or there is an error in the application.</p>\\n"},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"AQLXf6FUxMSJlNEsYx2DbE5dvl3KiD-Vwyj5lAVKUpdtAOejo1y_tPbSswg2FDAH"},"$env":{},"webhook":{"status":500,"statusText":"INTERNAL SERVER ERROR","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:50:12 GMT","content-type":"text/html; charset=utf-8","content-length":"265","connection":"close"},"data":"<!doctype html>\\n<html lang=en>\\n<title>500 Internal Server Error</title>\\n<h1>Internal Server Error</h1>\\n<p>The server encountered an internal error and was unable to complete your request. Either the server is overloaded or there is an error in the application.</p>\\n"}}}	\N	\N	\N
74	93	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id\\": \\"17\\",\\n  \\"tytul\\": \\"plik4\\",\\n  \\"tekst\\": \\"plik4\\",\\n  \\"pliki\\": \\"undefined\\",\\n  \\"url\\": \\"https://link-do-frontendu.pl/innowacje/17\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"plik4","opis":"plik4"},"key":17,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:50:20 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"AQLXf6FUxMSJlNEsYx2DbE5dvl3KiD-Vwyj5lAVKUpdtAOejo1y_tPbSswg2FDAH"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:50:20 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
76	95	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"id":"496f23da-37b3-43c3-a5c3-8fae090128df","name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]},"date_created":"2026-10-03T21:34:48.727Z"}	{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be"}	\N	\N
75	94	directus_operations	590ecdd4-3f68-4b83-8c7b-35bbb5f560be	{"id":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","name":"Webhook","key":"webhook","type":"request","position_x":19,"position_y":1,"options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"{{$trigger.key}}\\",\\n  \\"id_update\\": \\"{{$trigger.keys[0]}}\\"\\n}"},"date_created":"2026-10-03T21:37:01.694Z"}	{"name":"Webhook","key":"webhook","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"{{$trigger.key}}\\",\\n  \\"id_update\\": \\"{{$trigger.keys[0]}}\\"\\n}"},"flow":"496f23da-37b3-43c3-a5c3-8fae090128df"}	76	\N
77	96	directus_permissions	1	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"innowacje","action":"read"}	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"innowacje","action":"read"}	\N	\N
78	101	innowacje	18	{"tytul":"test111","opis":"test111"}	{"tytul":"test111","opis":"test111"}	\N	\N
79	102	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"id":"496f23da-37b3-43c3-a5c3-8fae090128df","name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":[]},"date_created":"2026-10-03T21:34:48.727Z"}	{"name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":[]}}	\N	\N
81	104	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"id":"496f23da-37b3-43c3-a5c3-8fae090128df","name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":[]},"date_created":"2026-10-03T21:34:48.727Z"}	{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be"}	\N	\N
80	103	directus_operations	590ecdd4-3f68-4b83-8c7b-35bbb5f560be	{"id":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","name":"Webhook","key":"webhook","type":"request","position_x":19,"position_y":1,"options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"{{$trigger.key}}\\",\\n  \\"id_update\\": \\"{{$trigger.keys[0]}}\\"\\n}"},"date_created":"2026-10-03T21:37:01.694Z"}	{"name":"Webhook","key":"webhook","type":"request","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"{{$trigger.key}}\\",\\n  \\"id_update\\": \\"{{$trigger.keys[0]}}\\"\\n}"},"flow":"496f23da-37b3-43c3-a5c3-8fae090128df"}	81	\N
82	105	directus_files	f37b0606-3626-4968-9248-8c9d2eda55e8	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
84	107	innowacje	19	{"tytul":"teste","opis":"111111"}	{"tytul":"teste","opis":"111111"}	\N	\N
83	106	innowacje_files	3	\N	\N	84	\N
86	111	innowacje	20	{"tytul":"test666","opis":"test666"}	{"tytul":"test666","opis":"test666"}	\N	\N
85	108	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"18\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"test111","opis":"test111"},"key":18,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:57:45 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"AQLXf6FUxMSJlNEsYx2DbE5dvl3KiD-Vwyj5lAVKUpdtAOejo1y_tPbSswg2FDAH"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 21:57:45 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
87	112	directus_files	c6a78bb1-540c-485b-abe1-76e1e4625f85	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
89	114	innowacje	21	{"tytul":"test777","opis":"test777"}	{"tytul":"test777","opis":"test777"}	\N	\N
88	113	innowacje_files	4	\N	\N	89	\N
90	115	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"id":"496f23da-37b3-43c3-a5c3-8fae090128df","name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]},"date_created":"2026-10-03T21:34:48.727Z"}	{"name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["innowacje"]}}	\N	\N
91	118	innowacje	22	{"tytul":"test999","opis":"test999"}	{"tytul":"test999","opis":"test999"}	\N	\N
92	119	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"22\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"test999","opis":"test999"},"key":22,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:03:18 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"v0A-xIu3LaIW0yLDOMtwKeQxn4_9LO_405cHNDtzVoirAQoWjPqYUdQ0B9qP7VY5"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:03:18 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
93	120	directus_files	4ba67ce8-6e6a-42c3-ae6e-6ec089f7a648	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
95	122	innowacje	23	{"tytul":"test000","opis":"test000 0 "}	{"tytul":"test000","opis":"test000 0 "}	\N	\N
94	121	innowacje_files	5	\N	\N	95	\N
96	123	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"23\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"test000","opis":"test000 0 ","pliki":{"create":[{"innowacje_id":"+","directus_files_id":{"id":"4ba67ce8-6e6a-42c3-ae6e-6ec089f7a648"}}],"update":[],"delete":[]}},"key":23,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:04:01 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"v0A-xIu3LaIW0yLDOMtwKeQxn4_9LO_405cHNDtzVoirAQoWjPqYUdQ0B9qP7VY5"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:04:01 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
97	124	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"id":"496f23da-37b3-43c3-a5c3-8fae090128df","name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create","items.update"],"collections":["innowacje"]},"date_created":"2026-10-03T21:34:48.727Z"}	{"name":"Flow","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create","items.update"],"collections":["innowacje"]}}	\N	\N
98	127	innowacje	24	{"tytul":"itemek1","opis":"itemek1"}	{"tytul":"itemek1","opis":"itemek1"}	\N	\N
100	129	directus_files	7c96933a-4844-4cad-8a14-2fb48dedafef	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
105	134	innowacje_files	7	\N	\N	\N	\N
99	128	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"24\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"itemek1","opis":"itemek1"},"key":24,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:07:17 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"v0A-xIu3LaIW0yLDOMtwKeQxn4_9LO_405cHNDtzVoirAQoWjPqYUdQ0B9qP7VY5"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:07:17 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
102	131	innowacje	25	{"tytul":"itemek2","opis":"itemek2"}	{"tytul":"itemek2","opis":"itemek2"}	\N	\N
101	130	innowacje_files	6	\N	\N	102	\N
103	132	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"25\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"itemek2","opis":"itemek2","pliki":{"create":[{"innowacje_id":"+","directus_files_id":{"id":"7c96933a-4844-4cad-8a14-2fb48dedafef"}}],"update":[],"delete":[]}},"key":25,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:08:20 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"v0A-xIu3LaIW0yLDOMtwKeQxn4_9LO_405cHNDtzVoirAQoWjPqYUdQ0B9qP7VY5"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:08:20 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
104	133	directus_files	cfd0d14c-e0d3-4165-8b5f-b6e4612fbfab	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
106	136	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"reject","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"undefined\\",\\n  \\"id_update\\": \\"25\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.update","payload":{"pliki":{"create":[{"innowacje_id":"25","directus_files_id":{"id":"cfd0d14c-e0d3-4165-8b5f-b6e4612fbfab"}}],"update":[],"delete":[]}},"keys":["25"],"collection":"innowacje"},"$last":{"status":400,"statusText":"BAD REQUEST","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:09:48 GMT","content-type":"application/json","content-length":"69","connection":"close"},"data":{"error":"Błąd pobierania danych z Directusa (HTTP 403)."}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"v0A-xIu3LaIW0yLDOMtwKeQxn4_9LO_405cHNDtzVoirAQoWjPqYUdQ0B9qP7VY5"},"$env":{},"webhook":{"status":400,"statusText":"BAD REQUEST","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:09:48 GMT","content-type":"application/json","content-length":"69","connection":"close"},"data":{"error":"Błąd pobierania danych z Directusa (HTTP 403)."}}}}	\N	\N	\N
107	137	innowacje_files	6	{"id":6}	{"innowacje_id":null}	\N	\N
108	138	innowacje_files	7	{"id":7}	{"innowacje_id":null}	\N	\N
109	140	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"reject","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"undefined\\",\\n  \\"id_update\\": \\"25\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.update","payload":{"pliki":{"create":[],"update":[],"delete":[6,7]}},"keys":["25"],"collection":"innowacje"},"$last":{"status":400,"statusText":"BAD REQUEST","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:12:16 GMT","content-type":"application/json","content-length":"184","connection":"close"},"data":{"error":"Błąd pobierania danych z Directusa (HTTP 403): {\\"errors\\":[{\\"message\\":\\"You don't have permission to access this.\\",\\"extensions\\":{\\"code\\":\\"FORBIDDEN\\"}}]}"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"v0A-xIu3LaIW0yLDOMtwKeQxn4_9LO_405cHNDtzVoirAQoWjPqYUdQ0B9qP7VY5"},"$env":{},"webhook":{"status":400,"statusText":"BAD REQUEST","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:12:16 GMT","content-type":"application/json","content-length":"184","connection":"close"},"data":{"error":"Błąd pobierania danych z Directusa (HTTP 403): {\\"errors\\":[{\\"message\\":\\"You don't have permission to access this.\\",\\"extensions\\":{\\"code\\":\\"FORBIDDEN\\"}}]}"}}}}	\N	\N	\N
110	141	directus_files	d3bf6430-792b-4f2d-b673-db335309f44c	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
111	142	innowacje_files	8	\N	\N	\N	\N
112	144	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"reject","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"undefined\\",\\n  \\"id_update\\": \\"25\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.update","payload":{"pliki":{"create":[{"innowacje_id":"25","directus_files_id":{"id":"d3bf6430-792b-4f2d-b673-db335309f44c"}}],"update":[],"delete":[]}},"keys":["25"],"collection":"innowacje"},"$last":{"status":400,"statusText":"BAD REQUEST","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:14:14 GMT","content-type":"application/json","content-length":"184","connection":"close"},"data":{"error":"Błąd pobierania danych z Directusa (HTTP 403): {\\"errors\\":[{\\"message\\":\\"You don't have permission to access this.\\",\\"extensions\\":{\\"code\\":\\"FORBIDDEN\\"}}]}"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"v0A-xIu3LaIW0yLDOMtwKeQxn4_9LO_405cHNDtzVoirAQoWjPqYUdQ0B9qP7VY5"},"$env":{},"webhook":{"status":400,"statusText":"BAD REQUEST","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:14:14 GMT","content-type":"application/json","content-length":"184","connection":"close"},"data":{"error":"Błąd pobierania danych z Directusa (HTTP 403): {\\"errors\\":[{\\"message\\":\\"You don't have permission to access this.\\",\\"extensions\\":{\\"code\\":\\"FORBIDDEN\\"}}]}"}}}}	\N	\N	\N
113	145	innowacje	26	{"tytul":"test","opis":"testes"}	{"tytul":"test","opis":"testes"}	\N	\N
114	146	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"26\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"test","opis":"testes"},"key":26,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:16:44 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"v0A-xIu3LaIW0yLDOMtwKeQxn4_9LO_405cHNDtzVoirAQoWjPqYUdQ0B9qP7VY5"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:16:44 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
115	147	directus_files	16b65f90-a85f-403c-8fce-d0d57d18d8ca	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
117	149	innowacje	27	{"tytul":"test4","opis":"test4"}	{"tytul":"test4","opis":"test4"}	\N	\N
116	148	innowacje_files	9	\N	\N	117	\N
118	150	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"27\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"test4","opis":"test4","pliki":{"create":[{"innowacje_id":"+","directus_files_id":{"id":"16b65f90-a85f-403c-8fce-d0d57d18d8ca"}}],"update":[],"delete":[]}},"key":27,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:16:59 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"v0A-xIu3LaIW0yLDOMtwKeQxn4_9LO_405cHNDtzVoirAQoWjPqYUdQ0B9qP7VY5"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:16:59 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
119	155	innowacje	28	{"tytul":"test67","opis":"test67"}	{"tytul":"test67","opis":"test67"}	\N	\N
120	156	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"28\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"test67","opis":"test67"},"key":28,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:19:58 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"v0A-xIu3LaIW0yLDOMtwKeQxn4_9LO_405cHNDtzVoirAQoWjPqYUdQ0B9qP7VY5"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:19:58 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
121	157	directus_files	1323ad0b-be3e-4755-ae99-1f3b9d662105	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
123	159	innowacje	29	{"tytul":"testestestestes","opis":"testestestestes"}	{"tytul":"testestestestes","opis":"testestestestes"}	\N	\N
122	158	innowacje_files	10	\N	\N	123	\N
125	163	innowacje	30	{"tytul":"testx","opis":"testx"}	{"tytul":"testx","opis":"testx"}	\N	\N
124	160	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"29\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"testestestestes","opis":"testestestestes","pliki":{"create":[{"innowacje_id":"+","directus_files_id":{"id":"1323ad0b-be3e-4755-ae99-1f3b9d662105"}}],"update":[],"delete":[]}},"key":29,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:20:11 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"v0A-xIu3LaIW0yLDOMtwKeQxn4_9LO_405cHNDtzVoirAQoWjPqYUdQ0B9qP7VY5"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sat, 03 Oct 2026 22:20:11 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
126	165	innowacje	31	{"tytul":"Wiadomosc 1","opis":"Wiadomosc 1"}	{"tytul":"Wiadomosc 1","opis":"Wiadomosc 1"}	\N	\N
127	166	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"31\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"Wiadomosc 1","opis":"Wiadomosc 1"},"key":31,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 05:53:54 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"ui9vIVW0FgQ-nBWbr7DpJyeuoC41YiYzijTb_VdDlCHXOqhjFCqnDKfqPyfTNlsD"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 05:53:54 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
128	167	directus_files	f3815d1d-e777-497b-b9e8-db4a09e78a51	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
130	169	innowacje	32	{"tytul":"Wiadomosc2","opis":"wiadomosc2"}	{"tytul":"Wiadomosc2","opis":"wiadomosc2"}	\N	\N
129	168	innowacje_files	11	\N	\N	130	\N
131	170	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"32\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"Wiadomosc2","opis":"wiadomosc2","pliki":{"create":[{"innowacje_id":"+","directus_files_id":{"id":"f3815d1d-e777-497b-b9e8-db4a09e78a51"}}],"update":[],"delete":[]}},"key":32,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 05:54:20 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"ui9vIVW0FgQ-nBWbr7DpJyeuoC41YiYzijTb_VdDlCHXOqhjFCqnDKfqPyfTNlsD"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 05:54:20 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
132	173	directus_files	6acb4e1f-c5f4-4ae1-b5d6-7d05cd5b4c61	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
134	175	innowacje	33	{"tytul":"xd","opis":"xdd"}	{"tytul":"xd","opis":"xdd"}	\N	\N
133	174	innowacje_files	12	\N	\N	134	\N
135	176	innowacje	34	{"tytul":"testestes","opis":"testestest"}	{"tytul":"testestes","opis":"testestest"}	\N	\N
136	177	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"33\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"xd","opis":"xdd","pliki":{"create":[{"innowacje_id":"+","directus_files_id":{"id":"6acb4e1f-c5f4-4ae1-b5d6-7d05cd5b4c61"}}],"update":[],"delete":[]}},"key":33,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 06:03:33 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"ui9vIVW0FgQ-nBWbr7DpJyeuoC41YiYzijTb_VdDlCHXOqhjFCqnDKfqPyfTNlsD"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 06:03:33 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
137	178	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"34\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"testestes","opis":"testestest"},"key":34,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 06:03:33 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"ui9vIVW0FgQ-nBWbr7DpJyeuoC41YiYzijTb_VdDlCHXOqhjFCqnDKfqPyfTNlsD"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 06:03:33 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
138	179	directus_permissions	2	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"innowacje_files","action":"read"}	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"innowacje_files","action":"read"}	\N	\N
139	181	directus_access	efdf3c55-5a96-4c96-be4d-79496370fbf7	{"id":"efdf3c55-5a96-4c96-be4d-79496370fbf7","sort":1}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
140	184	innowacje	35	{"tytul":"Itemek1","opis":"itemekitemekitemekitemekitemek"}	{"tytul":"Itemek1","opis":"itemekitemekitemekitemekitemek"}	\N	\N
141	185	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"35\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"Itemek1","opis":"itemekitemekitemekitemekitemek"},"key":35,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 06:06:05 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"ui9vIVW0FgQ-nBWbr7DpJyeuoC41YiYzijTb_VdDlCHXOqhjFCqnDKfqPyfTNlsD"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 06:06:05 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
142	186	directus_files	554880c2-f0a0-493b-96e8-c241ee80c2b3	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
144	188	innowacje	36	{"tytul":"itemek2","opis":"itemekitemekitemekitemekitemekitemekitemekitemekitemekitemekitemekitemekv"}	{"tytul":"itemek2","opis":"itemekitemekitemekitemekitemekitemekitemekitemekitemekitemekitemekitemekv"}	\N	\N
143	187	innowacje_files	13	\N	\N	144	\N
145	189	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"36\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"itemek2","opis":"itemekitemekitemekitemekitemekitemekitemekitemekitemekitemekitemekitemekv","pliki":{"create":[{"innowacje_id":"+","directus_files_id":{"id":"554880c2-f0a0-493b-96e8-c241ee80c2b3"}}],"update":[],"delete":[]}},"key":36,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 06:06:29 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"ui9vIVW0FgQ-nBWbr7DpJyeuoC41YiYzijTb_VdDlCHXOqhjFCqnDKfqPyfTNlsD"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 06:06:29 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":1,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
146	190	directus_permissions	3	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"innowacje_files","action":"share"}	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"innowacje_files","action":"share"}	\N	\N
147	191	directus_permissions	4	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"innowacje","action":"share"}	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"innowacje","action":"share"}	\N	\N
148	192	directus_permissions	5	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	\N	\N
149	193	directus_permissions	6	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"share"}	{"permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"share"}	\N	\N
150	195	directus_access	efdf3c55-5a96-4c96-be4d-79496370fbf7	{"id":"efdf3c55-5a96-4c96-be4d-79496370fbf7","sort":1}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
151	196	directus_files	31ccd840-2c44-4053-b7c8-0a0006998b97	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	{"storage":"local","title":"Car","filename_download":"car.pdf","type":"application/pdf"}	\N	\N
153	198	innowacje	37	{"tytul":"eeeeeeeeeeeeeeeee","opis":"eeeeeeeeeeeeeeeeeeeee"}	{"tytul":"eeeeeeeeeeeeeeeee","opis":"eeeeeeeeeeeeeeeeeeeee"}	\N	\N
152	197	innowacje_files	14	\N	\N	153	\N
154	199	directus_flows	496f23da-37b3-43c3-a5c3-8fae090128df	{"steps":[{"operation":"590ecdd4-3f68-4b83-8c7b-35bbb5f560be","key":"webhook","status":"resolve","options":{"method":"POST","url":"http://web:5000/webhook/index","headers":[{"header":"Content-Type","value":"application/json"}],"body":"{\\n  \\"id_create\\": \\"37\\",\\n  \\"id_update\\": \\"undefined\\"\\n}"}}],"data":{"$trigger":{"event":"innowacje.items.create","payload":{"tytul":"eeeeeeeeeeeeeeeee","opis":"eeeeeeeeeeeeeeeeeeeee","pliki":{"create":[{"innowacje_id":"+","directus_files_id":{"id":"31ccd840-2c44-4053-b7c8-0a0006998b97"}}],"update":[],"delete":[]}},"key":37,"collection":"innowacje"},"$last":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 06:08:38 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":6,"message":"Zapisano w Qdrant","status":"success"}},"$accountability":{"role":"e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e","user":"19d2ce3a-6fbd-41ec-8e94-ea4c2172615b","roles":["e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e"],"admin":true,"app":true,"ip":"172.18.0.1","userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"ui9vIVW0FgQ-nBWbr7DpJyeuoC41YiYzijTb_VdDlCHXOqhjFCqnDKfqPyfTNlsD"},"$env":{},"webhook":{"status":200,"statusText":"OK","headers":{"server":"Werkzeug/3.1.9 Python/3.11.17","date":"Sun, 04 Oct 2026 06:08:38 GMT","content-type":"application/json","content-length":"68","connection":"close"},"data":{"chunks_count":6,"message":"Zapisano w Qdrant","status":"success"}}}}	\N	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token, oauth_client) FROM stdin;
ui9vIVW0FgQ-nBWbr7DpJyeuoC41YiYzijTb_VdDlCHXOqhjFCqnDKfqPyfTNlsD	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-04 06:32:29.707+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	http://localhost:8055	eBUxIgxjVuqEbHotoPxB-E2pAQHyRr-3Y4v0vmGQxUo_u019gNVXx4z9ZrQ2RTLH	\N
eBUxIgxjVuqEbHotoPxB-E2pAQHyRr-3Y4v0vmGQxUo_u019gNVXx4z9ZrQ2RTLH	19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	2026-10-05 06:32:19.707+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36	\N	http://localhost:8055	\N	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, project_id, mcp_enabled, mcp_allow_deletes, mcp_prompts_collection, mcp_system_prompt_enabled, mcp_system_prompt, project_owner, project_usage, org_name, product_updates, project_status, ai_openai_api_key, ai_anthropic_api_key, ai_system_prompt, ai_google_api_key, ai_openai_compatible_api_key, ai_openai_compatible_base_url, ai_openai_compatible_name, ai_openai_compatible_models, ai_openai_compatible_headers, ai_openai_allowed_models, ai_anthropic_allowed_models, ai_google_allowed_models, collaborative_editing_enabled, ai_translation_default_model, ai_translation_glossary, ai_translation_style_guide, license_key, license_token, mcp_oauth_enabled, mcp_oauth_dcr_enabled, mcp_oauth_cimd_enabled, default_save_action) FROM stdin;
1	Directus	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N	\N	en-US	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	01a10397-4bbb-710d-a751-0345cabe7ebd	f	f	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	["gpt-5.4-nano","gpt-5.4-mini","gpt-5.4"]	["claude-haiku-4-5","claude-sonnet-4-6"]	["gemini-3-pro-preview","gemini-3-flash-preview","gemini-2.5-pro","gemini-2.5-flash"]	f	\N	\N	\N	\N	\N	f	f	f	save-and-quit
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides, text_direction) FROM stdin;
19d2ce3a-6fbd-41ec-8e94-ea4c2172615b	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$Qyrr9chuv5bGDCGdD1ChBg$3huS89Z58oag0E1h3ukvX8F81/tKcNBhoXFrRPHpNjo	\N	\N	\N	\N	\N	\N	\N	active	e09b4d2b-fb23-4cd9-b57e-9c3ac713b46e	\N	2026-10-04 06:32:19.806+00	/content/innowacje	default	\N	\N	t	\N	\N	\N	\N	\N	auto
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: innowacje; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.innowacje (id, user_created, date_created, tytul, opis) FROM stdin;
\.


--
-- Data for Name: innowacje_files; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.innowacje_files (id, innowacje_id, directus_files_id) FROM stdin;
1	\N	e12fd3de-d9e6-4975-b887-fcb63934d4cc
2	\N	73bc659c-56a1-4e3e-abc8-60c8c404935e
3	\N	f37b0606-3626-4968-9248-8c9d2eda55e8
4	\N	c6a78bb1-540c-485b-abe1-76e1e4625f85
5	\N	4ba67ce8-6e6a-42c3-ae6e-6ec089f7a648
6	\N	7c96933a-4844-4cad-8a14-2fb48dedafef
7	\N	cfd0d14c-e0d3-4165-8b5f-b6e4612fbfab
8	\N	d3bf6430-792b-4f2d-b673-db335309f44c
9	\N	16b65f90-a85f-403c-8fce-d0d57d18d8ca
10	\N	1323ad0b-be3e-4755-ae99-1f3b9d662105
11	\N	f3815d1d-e777-497b-b9e8-db4a09e78a51
12	\N	6acb4e1f-c5f4-4ae1-b5d6-7d05cd5b4c61
13	\N	554880c2-f0a0-493b-96e8-c241ee80c2b3
14	\N	31ccd840-2c44-4053-b7c8-0a0006998b97
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myuser
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 202, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myuser
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 10, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myuser
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myuser
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 6, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myuser
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, false);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myuser
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 3, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myuser
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 154, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myuser
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: innowacje_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myuser
--

SELECT pg_catalog.setval('public.innowacje_files_id_seq', 14, true);


--
-- Name: innowacje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myuser
--

SELECT pg_catalog.setval('public.innowacje_id_seq', 37, true);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_deployment_projects directus_deployment_projects_deployment_external_id_unique; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_deployment_projects
    ADD CONSTRAINT directus_deployment_projects_deployment_external_id_unique UNIQUE (deployment, external_id);


--
-- Name: directus_deployment_projects directus_deployment_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_deployment_projects
    ADD CONSTRAINT directus_deployment_projects_pkey PRIMARY KEY (id);


--
-- Name: directus_deployment_runs directus_deployment_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_deployment_runs
    ADD CONSTRAINT directus_deployment_runs_pkey PRIMARY KEY (id);


--
-- Name: directus_deployments directus_deployments_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_deployments
    ADD CONSTRAINT directus_deployments_pkey PRIMARY KEY (id);


--
-- Name: directus_deployments directus_deployments_provider_unique; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_deployments
    ADD CONSTRAINT directus_deployments_provider_unique UNIQUE (provider);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_oauth_clients directus_oauth_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_clients
    ADD CONSTRAINT directus_oauth_clients_pkey PRIMARY KEY (client_id);


--
-- Name: directus_oauth_codes directus_oauth_codes_code_hash_unique; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_codes
    ADD CONSTRAINT directus_oauth_codes_code_hash_unique UNIQUE (code_hash);


--
-- Name: directus_oauth_codes directus_oauth_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_codes
    ADD CONSTRAINT directus_oauth_codes_pkey PRIMARY KEY (id);


--
-- Name: directus_oauth_consents directus_oauth_consents_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_consents
    ADD CONSTRAINT directus_oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: directus_oauth_consents directus_oauth_consents_user_client_redirect_uri_unique; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_consents
    ADD CONSTRAINT directus_oauth_consents_user_client_redirect_uri_unique UNIQUE ("user", client, redirect_uri);


--
-- Name: directus_oauth_tokens directus_oauth_tokens_client_user_unique; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_tokens
    ADD CONSTRAINT directus_oauth_tokens_client_user_unique UNIQUE (client, "user");


--
-- Name: directus_oauth_tokens directus_oauth_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_tokens
    ADD CONSTRAINT directus_oauth_tokens_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: innowacje_files innowacje_files_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.innowacje_files
    ADD CONSTRAINT innowacje_files_pkey PRIMARY KEY (id);


--
-- Name: innowacje innowacje_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.innowacje
    ADD CONSTRAINT innowacje_pkey PRIMARY KEY (id);


--
-- Name: directus_activity_timestamp_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_activity_timestamp_index ON public.directus_activity USING btree ("timestamp");


--
-- Name: directus_oauth_clients_date_created_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_oauth_clients_date_created_index ON public.directus_oauth_clients USING btree (date_created);


--
-- Name: directus_oauth_codes_expires_at_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_oauth_codes_expires_at_index ON public.directus_oauth_codes USING btree (expires_at);


--
-- Name: directus_oauth_codes_used_at_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_oauth_codes_used_at_index ON public.directus_oauth_codes USING btree (used_at);


--
-- Name: directus_oauth_consents_client_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_oauth_consents_client_index ON public.directus_oauth_consents USING btree (client);


--
-- Name: directus_oauth_tokens_code_hash_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_oauth_tokens_code_hash_index ON public.directus_oauth_tokens USING btree (code_hash);


--
-- Name: directus_oauth_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_oauth_tokens_expires_at_index ON public.directus_oauth_tokens USING btree (expires_at);


--
-- Name: directus_oauth_tokens_previous_session_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_oauth_tokens_previous_session_index ON public.directus_oauth_tokens USING btree (previous_session);


--
-- Name: directus_oauth_tokens_session_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_oauth_tokens_session_index ON public.directus_oauth_tokens USING btree (session);


--
-- Name: directus_revisions_activity_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_revisions_activity_index ON public.directus_revisions USING btree (activity);


--
-- Name: directus_revisions_parent_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_revisions_parent_index ON public.directus_revisions USING btree (parent);


--
-- Name: directus_sessions_oauth_client_index; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX directus_sessions_oauth_client_index ON public.directus_sessions USING btree (oauth_client);


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_deployment_projects directus_deployment_projects_deployment_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_deployment_projects
    ADD CONSTRAINT directus_deployment_projects_deployment_foreign FOREIGN KEY (deployment) REFERENCES public.directus_deployments(id) ON DELETE CASCADE;


--
-- Name: directus_deployment_projects directus_deployment_projects_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_deployment_projects
    ADD CONSTRAINT directus_deployment_projects_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_deployment_runs directus_deployment_runs_project_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_deployment_runs
    ADD CONSTRAINT directus_deployment_runs_project_foreign FOREIGN KEY (project) REFERENCES public.directus_deployment_projects(id) ON DELETE CASCADE;


--
-- Name: directus_deployment_runs directus_deployment_runs_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_deployment_runs
    ADD CONSTRAINT directus_deployment_runs_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_deployments directus_deployments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_deployments
    ADD CONSTRAINT directus_deployments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_oauth_codes directus_oauth_codes_client_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_codes
    ADD CONSTRAINT directus_oauth_codes_client_foreign FOREIGN KEY (client) REFERENCES public.directus_oauth_clients(client_id) ON DELETE CASCADE;


--
-- Name: directus_oauth_codes directus_oauth_codes_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_codes
    ADD CONSTRAINT directus_oauth_codes_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_oauth_consents directus_oauth_consents_client_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_consents
    ADD CONSTRAINT directus_oauth_consents_client_foreign FOREIGN KEY (client) REFERENCES public.directus_oauth_clients(client_id) ON DELETE CASCADE;


--
-- Name: directus_oauth_consents directus_oauth_consents_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_consents
    ADD CONSTRAINT directus_oauth_consents_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_oauth_tokens directus_oauth_tokens_client_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_tokens
    ADD CONSTRAINT directus_oauth_tokens_client_foreign FOREIGN KEY (client) REFERENCES public.directus_oauth_clients(client_id) ON DELETE CASCADE;


--
-- Name: directus_oauth_tokens directus_oauth_tokens_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_oauth_tokens
    ADD CONSTRAINT directus_oauth_tokens_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_oauth_client_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_oauth_client_foreign FOREIGN KEY (oauth_client) REFERENCES public.directus_oauth_clients(client_id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: innowacje_files innowacje_files_directus_files_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.innowacje_files
    ADD CONSTRAINT innowacje_files_directus_files_id_foreign FOREIGN KEY (directus_files_id) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: innowacje_files innowacje_files_innowacje_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.innowacje_files
    ADD CONSTRAINT innowacje_files_innowacje_id_foreign FOREIGN KEY (innowacje_id) REFERENCES public.innowacje(id) ON DELETE SET NULL;


--
-- Name: innowacje innowacje_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.innowacje
    ADD CONSTRAINT innowacje_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict iyC0QFpZK8JPM1FIqUS40rCkKsGjM4PTv5BeGaVTDKMpEGkxGlHPe4DZC15SiAr

