-- All the data related to time are stored in unix time stamp and therefore, the data types for the time related data
-- are represented in BIGINT.
-- Since the database systems does not support adding default unix time to the database columns, the default data
-- storing is handled within the database queries.

CREATE TABLE IF NOT EXISTS OB_CONSENT (
  CONSENT_ID            VARCHAR(255) NOT NULL,
  RECEIPT               JSON NOT NULL,
  CREATED_TIME          BIGINT NOT NULL,
  UPDATED_TIME          BIGINT NOT NULL,
  CLIENT_ID             VARCHAR(255) NOT NULL,
  CONSENT_TYPE          VARCHAR(64) NOT NULL,
  CURRENT_STATUS        VARCHAR(64) NOT NULL,
  CONSENT_FREQUENCY     INT,
  VALIDITY_TIME         BIGINT,
  RECURRING_INDICATOR   BOOLEAN,
  PRIMARY KEY (CONSENT_ID)
)
ENGINE INNODB;

CREATE TABLE IF NOT EXISTS OB_CONSENT_AUTH_RESOURCE (
  AUTH_ID           VARCHAR(255) NOT NULL,
  CONSENT_ID        VARCHAR(255) NOT NULL,
  AUTH_TYPE         VARCHAR(255) NOT NULL,
  USER_ID           VARCHAR(255),
  AUTH_STATUS       VARCHAR(255) NOT NULL,       
  UPDATED_TIME      BIGINT NOT NULL,
  PRIMARY KEY(AUTH_ID),
  CONSTRAINT FK_ID_OB_CONSENT_AUTH_RESOURCE FOREIGN KEY (CONSENT_ID) REFERENCES OB_CONSENT (CONSENT_ID)
)
ENGINE INNODB;

CREATE TABLE IF NOT EXISTS OB_CONSENT_MAPPING (
  MAPPING_ID        VARCHAR(255) NOT NULL,
  AUTH_ID           VARCHAR(255) NOT NULL,
  ACCOUNT_ID        VARCHAR(255) NOT NULL,
  PERMISSION        VARCHAR(255) NOT NULL,
  MAPPING_STATUS    VARCHAR(255) NOT NULL,
  PRIMARY KEY(MAPPING_ID),
  CONSTRAINT FK_OB_CONSENT_MAPPING FOREIGN KEY (AUTH_ID) REFERENCES OB_CONSENT_AUTH_RESOURCE (AUTH_ID)
)
ENGINE INNODB;

CREATE TABLE IF NOT EXISTS OB_CONSENT_STATUS_AUDIT (
  STATUS_AUDIT_ID   VARCHAR(255) NOT NULL,
  CONSENT_ID        VARCHAR(255) NOT NULL,
  CURRENT_STATUS    VARCHAR(255) NOT NULL,
  ACTION_TIME       BIGINT NOT NULL,
  REASON            VARCHAR(255),
  ACTION_BY         VARCHAR(255),
  PREVIOUS_STATUS   VARCHAR(255),
  PRIMARY KEY(STATUS_AUDIT_ID),
  CONSTRAINT FK_OB_CONSENT_STATUS_AUDIT FOREIGN KEY (CONSENT_ID) REFERENCES OB_CONSENT (CONSENT_ID)
)
ENGINE INNODB;

CREATE TABLE IF NOT EXISTS OB_CONSENT_FILE (
  CONSENT_ID        VARCHAR(255) NOT NULL,
  CONSENT_FILE      BLOB NOT NULL,
  PRIMARY KEY(CONSENT_ID),
  CONSTRAINT FK_OB_CONSENT_FILE FOREIGN KEY (CONSENT_ID) REFERENCES OB_CONSENT (CONSENT_ID)
)
ENGINE INNODB;

CREATE TABLE IF NOT EXISTS OB_CONSENT_ATTRIBUTE (
  CONSENT_ID        VARCHAR(255) NOT NULL,
  ATT_KEY           VARCHAR(255) NOT NULL,
  ATT_VALUE         VARCHAR(255) NOT NULL,
  PRIMARY KEY(CONSENT_ID, ATT_KEY),
  CONSTRAINT FK_OB_CONSENT_ATTRIBUTE FOREIGN KEY (CONSENT_ID) REFERENCES OB_CONSENT (CONSENT_ID) ON DELETE CASCADE
)
ENGINE INNODB;

CREATE TABLE IF NOT EXISTS OB_THROTTLE_DATA (
  THROTTLE_GROUP VARCHAR(100) NOT NULL,
  THROTTLE_PARAM VARCHAR(100) NOT NULL,
  LAST_UPDATE_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNLOCK_TIMESTAMP TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  OCCURRENCES INT(11) NOT NULL,
  PRIMARY KEY (THROTTLE_GROUP,THROTTLE_PARAM)
)
ENGINE INNODB;
