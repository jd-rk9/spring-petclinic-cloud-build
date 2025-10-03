#!/bin/sh
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

# -----------------------------------------------------------------------------
# Apache Maven Wrapper startup script, version 3.3.2
#
# Optional ENV vars:
#   MVNW_REPOURL - repo url base for downloading maven distribution
#   MVNW_USERNAME - username for downloading maven distribution
#   MVNW_PASSWORD - password for downloading maven distribution
#   MVNW_VERBOSE - true: enable verbose log; others: silence the output
# -----------------------------------------------------------------------------

set -e

MAVEN_WRAPPER_JAR_FILENAME=".mvn/wrapper/maven-wrapper.jar"

if [ -n "$MVNW_VERBOSE" ]; then
  set -x
fi

if [ -z "$MAVEN_PROJECTBASEDIR" ]; then
  # The search for the project base directory will begin from this script's directory.
  SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" >/dev/null 2>&1 && pwd)"
  MAVEN_PROJECTBASEDIR_CANDIDATE="$(cd -- "${SCRIPT_DIR}" >/dev/null 2>&1 && pwd)"
  while [ ! -f "${MAVEN_PROJECTBASEDIR_CANDIDATE}/${MAVEN_WRAPPER_JAR_FILENAME}" ] && [ "${MAVEN_PROJECTBASEDIR_CANDIDATE}" != "/" ]; do
    MAVEN_PROJECTBASEDIR_CANDIDATE="$(cd -- "${MAVEN_PROJECTBASEDIR_CANDIDATE}/.." >/dev/null 2>&1 && pwd)"
  done
  if [ -f "${MAVEN_PROJECTBASEDIR_CANDIDATE}/${MAVEN_WRAPPER_JAR_FILENAME}" ]; then
    MAVEN_PROJECTBASEDIR="${MAVEN_PROJECTBASEDIR_CANDIDATE}"
    export MAVEN_PROJECTBASEDIR
  else
    echo "Could not find the project base directory. Please try running this command again from the project base directory."
    exit 1
  fi
fi

cd -- "${MAVEN_PROJECTBASEDIR}" >/dev/null 2>&1

MAVEN_WRAPPER_PROPERTIES_FILENAME=".mvn/wrapper/maven-wrapper.properties"

if [ ! -f "${MAVEN_WRAPPER_PROPERTIES_FILENAME}" ]; then
  echo "The file ${MAVEN_WRAPPER_PROPERTIES_FILENAME} does not exist."
  exit 1
fi

load_property() {
  # We do not want to refer to the file using a relative path,
  # because we do not know where this script is being run from.
  local property_file_path="${MAVEN_PROJECTBASEDIR}/${1}"
  local property_name="${2}"
  if [ -f "${property_file_path}" ]; then
    # We are using sed to extract the value of the property from the properties file.
    # The value of the property is everything after the first "=".
    # The "[^=]*" part of the regex is used to match the property name.
    # The "\s*=\s*" part of the regex is used to match the "=" and any surrounding whitespace.
    # The ".*" part of the regex is used to match the value of the property.
    # The "p" command at the end of the sed expression is used to print the matched line.
    # The "-n" option of sed is used to suppress the default output of sed.
    # The "1q" command at the end of the sed expression is used to quit after the first match.
    sed -n "s/^${property_name}\s*=\s*\(.*\)/\1/p; 1q" "${property_file_path}"
  fi
}

DISTRIBUTION_URL_PROPERTY_NAME="distributionUrl"
DISTRIBUTION_URL="$(load_property "${MAVEN_WRAPPER_PROPERTIES_FILENAME}" "${DISTRIBUTION_URL_PROPERTY_NAME}")"

if [ -z "${DISTRIBUTION_URL}" ]; then
  # The "distributionUrl" property is not set in the properties file.
  # We will fall back to the default value.
  # The default value is the same as the one used by the Maven Wrapper plugin.
  DISTRIBUTION_URL="https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.8.8/apache-maven-3.8.8-bin.zip"
fi

if [ -n "$MVNW_REPOURL" ]; then
  # The user has specified a custom repository URL.
  # We will replace the host part of the distribution URL with the custom repository URL.
  # The "sed" command is used to replace the host part of the URL.
  # The "[^/]*" part of the regex is used to match the protocol.
  # The "[^/]*" part of the regex is used to match the host.
  # The ".*" part of the regex is used to match the rest of the URL.
  # The "\1" and "\3" are used to keep the protocol and the rest of the URL.
  # The "${MVNW_REPOURL}" is used to replace the host part of the URL.
  DISTRIBUTION_URL="$(echo "${DISTRIBUTION_URL}" | sed "s|^\([^/]*//\)[^/]*\(.*\)|\1${MVNW_REPOURL}\2|")"
fi

MAVEN_WRAPPER_JAR_PATH="${MAVEN_PROJECTBASEDIR}/${MAVEN_WRAPPER_JAR_FILENAME}"

if [ ! -f "${MAVEN_WRAPPER_JAR_PATH}" ]; then
  echo "Downloading the Maven Wrapper JAR from ${DISTRIBUTION_URL}..."
  # We are using a temporary file to store the downloaded JAR file.
  # This is to avoid a race condition where another process is trying to download the same file.
  TMP_MAVEN_WRAPPER_JAR_PATH="${MAVEN_WRAPPER_JAR_PATH}.tmp"
  if [ -n "$MVNW_USERNAME" ] && [ -n "$MVNW_PASSWORD" ]; then
    # The user has specified a username and password for the custom repository.
    # We will use the "curl" command to download the file.
    # The "-u" option is used to specify the username and password.
    # The "-f" option is used to fail silently on server errors.
    # The "-L" option is used to follow redirects.
    # The "-o" option is used to specify the output file.
    curl -u "${MVNW_USERNAME}:${MVNW_PASSWORD}" -f -L -o "${TMP_MAVEN_WRAPPER_JAR_PATH}" "${DISTRIBUTION_URL}"
  else
    # We will use the "curl" command to download the file.
    # The "-f" option is used to fail silently on server errors.
    # The "-L" option is used to follow redirects.
    # The "-o" option is used to specify the output file.
    curl -f -L -o "${TMP_MAVEN_WRAPPER_JAR_PATH}" "${DISTRIBUTION_URL}"
  fi
  # We are moving the temporary file to the final destination.
  # This is to avoid a race condition where another process is trying to download the same file.
  mv "${TMP_MAVEN_WRAPPER_JAR_PATH}" "${MAVEN_WRAPPER_JAR_PATH}"
fi

if [ ! -r "${MAVEN_WRAPPER_JAR_PATH}" ]; then
  echo "The file ${MAVEN_WRAPPER_JAR_PATH} is not readable."
  exit 1
fi

if [ -z "$JAVA_HOME" ]; then
  # The JAVA_HOME environment variable is not set.
  # We will try to find the Java executable in the PATH.
  JAVA_EXE="$(command -v java)"
  if [ -z "$JAVA_EXE" ]; then
    echo "The JAVA_HOME environment variable is not set, and the java command is not in the PATH."
    exit 1
  fi
else
  # The JAVA_HOME environment variable is set.
  # We will use the Java executable from the JAVA_HOME directory.
  JAVA_EXE="${JAVA_HOME}/bin/java"
fi

exec "${JAVA_EXE}" \
  "-Dmaven.multiModuleProjectDirectory=${MAVEN_PROJECTBASEDIR}" \
  -jar "${MAVEN_WRAPPER_JAR_PATH}" \
  "$@"

exit $?








































































































































































































































































































































-