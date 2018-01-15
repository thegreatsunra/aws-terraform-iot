variable "cloudtrail" {
  default = "cloudTrail"
  type = "string"
}

##################################

variable "table_events" {
  default = "events"
  type = "string"
}

variable "table_devices" {
  default = "devices"
  type = "string"
}

##################################

variable identity_pool {
  default = "identityPool"
  type = "string"
}

variable user_pool {
  default = "userPool"
  type = "string"
}

##################################

variable "service_role_path" {
  default = "/service-role/"
  type = "string"
}

variable "iot_policy" {
  default = "thing"
  type = "string"
}

variable "cognito_unauth_role" {
  default = "cognitoUnauth"
  type = "string"
}

variable "cognito_unauth_policy" {
  default = "cognitoUnauth"
  type = "string"
}

variable "cognito_auth_role" {
  default = "cognitoAuth"
  type = "string"
}

variable "cognito_auth_policy" {
  default = "cognitoAuth"
  type = "string"
}

variable "api_role" {
  default = "apiGateway"
  type = "string"
}

variable "api_policy" {
  default = "apiGateway"
  type = "string"
}

variable "log_policy" {
  default = "log"
  type = "string"
}

variable "db_delete_role" {
  default = "dbDelete"
  type = "string"
}

variable "db_delete_policy" {
  default = "dbDelete"
  type = "string"
}

variable "db_query_role" {
  default = "dbQuery"
  type = "string"
}

variable "db_query_policy" {
  default = "dbQuery"
  type = "string"
}

variable "db_update_role" {
  default = "dbUpdate"
  type = "string"
}

variable "db_update_policy" {
  default = "dbUpdate"
  type = "string"
}

variable "lambda_basic_execution_role" {
  default = "lambda_basic_execution"
  type = "string"
}

variable "lambda_basic_execution_policy" {
  default = "lambda_basic_execution"
  type = "string"
}

##################################

variable "api" {
  default = "api"
  type = "string"
}

variable "routes" {
  type    = "map"
  default = {
    "devices_info" = "devicesInfo"
    "devices_list" = "devicesList"
    "devices_update" = "devicesUpdate"
    "devices_upload" = "devicesUpload"
    "events_info" = "eventsInfo"
    "events_list" = "eventsList"
  }
}

variable "functions" {
  type    = "map"
  default = {
    "events" = "events"
    "cognito" = "cognito"
  }
}
