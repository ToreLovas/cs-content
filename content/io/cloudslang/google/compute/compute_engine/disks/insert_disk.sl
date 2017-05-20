#   (c) Copyright 2017 Hewlett-Packard Enterprise Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
########################################################################################################################
#!!
#! @description: Creates a disk resource in the specified project using the data included as inputs.
#!
#! @input project_id: Google Cloud project name.
#!                    Example: 'example-project-a'
#! @input zone: The name of the zone in which the instance lives.
#!              Examples: 'us-central1-a', 'us-central1-b', 'us-central1-c'
#! @input access_token: The access token from get_access_token.
#! @input disk_name:  Name of the Disk. Provided by the client when the Disk is created. The name must be
#!                    1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters
#!                    long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the first
#!                    character must be a lowercase letter, and all following characters must be a dash, lowercase
#!                    letter, or digit, except the last character, which cannot be a dash.
#! @input disk_size: Size of the persistent disk, specified in GB. You can specify this field when creating a
#!                   persistent disk using the sourceImage or sourceSnapshot parameter, or specify it alone to
#!                   create an empty persistent disk.
#!                   If you specify this field along with sourceImage or sourceSnapshot, the value of sizeGb must
#!                   not be less than the size of the sourceImage or the size of the snapshot.
#!                   Constraint: Number greater or equal with 10
#!                   Default: '10'
#!                   Optional
#! @input disk_description: The description of the new Disk.
#!                          Optional
#! @input licenses_list: A list containing any applicable publicly visible licenses separated by <licenses_delimiter>.
#!                       Optional
#! @input licenses_delimiter: The delimiter used to split the <licenses_list>.
#!                            Optional
#! @input source_image: The source image used to create this disk. If the source image is deleted, this field
#!                      will not be set.
#!                      To create a disk with one of the public operating system images, specify the image by its
#!                      family name. For example, specify family/debian-8 to use the latest Debian 8 image:
#!                      'projects/debian-cloud/global/images/family/debian-8'
#!                      Alternatively, use a specific version of a public operating system image:
#!                      'projects/debian-cloud/global/images/debian-8-jessie-vYYYYMMDD'
#!                      To create a disk with a private image that you created, specify the image name in the following
#!                      format: 'global/images/my-private-image'
#!                      You can also specify a private image by its image family, which returns the latest version of
#!                      the image in that family. Replace the image name with family/family-name:
#!                      'global/images/family/my-private-family'
#!                      Note: mutual exclusive with <snapshot_image>
#!                      Optional
#! @input snapshot_image: The source snapshot used to create this disk. You can provide this as a partial or full URL to
#!                        the resource. For example, the following are valid values:
#!                        'https://www.googleapis.com/compute/v1/projects/project/global/snapshots/snapshot'
#!                        'projects/project/global/snapshots/snapshot'
#!                        'global/snapshots/snapshot'
#!                        Note: mutual exclusive with <source_image>
#!                        Optional
#! @input image_encryption_key: The customer-supplied encryption key of the source image. Required if the source image
#!                              is protected by a customer-supplied encryption key.
#!                              Optional
#! @input disk_type: URL of the disk type resource describing which disk type to use to create the disk. Provide
#!                   this when creating the disk.
#! @input disk_encryption_key: Encrypts the disk using a customer-supplied encryption key.
#!                             After you encrypt a disk with a customer-supplied key, you must provide the same key if
#!                             you use the disk later (e.g. to create a disk snapshot or an image,
#!                             or to attach the disk to a virtual machine).
#!                             Customer-supplied encryption keys do not protect access to metadata of the disk.
#!                             If you do not provide an encryption key when creating the disk, then the disk will
#!                             be encrypted using an automatically generated key and you do not need to provide
#!                             a key to use the disk later.
#!                             Optional
#! @input proxy_host: Proxy server used to access the provider services.
#!                    Optional
#! @input proxy_port: Proxy server port used to access the provider services.
#!                    Default: '8080'
#!                    Optional
#! @input proxy_username: Proxy server user name.
#!                        Optional
#! @input proxy_password: Proxy server password associated with the <proxy_username> input value.
#!                        Optional
#! @input pretty_print: Whether to format the resulting JSON.
#!                      Valid: 'true', 'false'
#!                      Default: 'true'
#!                      Optional
#!
#! @output return_result: Contains the ZoneOperation resource, as a JSON object.
#! @output return_code: '0' if operation was successfully executed, '-1' otherwise.
#! @output exception: Exception if there was an error when executing, empty otherwise.
#! @output zone_operation_name: Contains the ZoneOperation name, if the returnCode is '0', otherwise it is empty.
#!
#! @result SUCCESS: The request for the Disk to be inserted was successfully sent.
#! @result FAILURE: An error occurred while trying to send the request.
#!
#!!#
########################################################################################################################

namespace: io.cloudslang.google.compute.compute_engine.disks

operation:
  name: insert_disk

  inputs:
    - project_id
    - projectId:
        default: ${get('project_id', '')}
        required: false
        private: true
    - zone
    - access_token:
        sensitive: true
    - accessToken:
        default: ${get('access_token', '')}
        required: false
        private: true
        sensitive: true
    - disk_name
    - diskName:
        default: ${get('disk_name', '')}
        required: false
        private: true
    - disk_size:
        default: '10'
        required: false
    - diskSize:
        default: ${get('disk_size', '')}
        required: false
        private: true
    - disk_description:
        default: ''
        required: false
    - diskDescription:
        default: ${get('disk_description', '')}
        required: false
        private: true
    - licenses_list:
        default: ''
        required: false
    - licensesList:
        default: ${get('licenses_list', '')}
        required: false
        private: true
    - licenses_delimiter:
        default: ','
        required: false
    - licensesDelimiter:
        default: ${get('licenses_delimiter', '')}
        required: false
        private: true
    - source_image:
        default: ''
        required: false
    - sourceImage:
        default: ${get('source_image', '')}
        required: false
        private: true
    - snapshot_image:
        default: ''
        required: false
    - snapshotImage:
        default: ${get('snapshot_image', '')}
        required: false
        private: true
    - image_encryption_key:
        default: ''
        required: false
    - imageEncryptionKey:
        default: ${get('image_encryption_key', '')}
        required: false
        private: true
    - disk_type
    - diskType:
        default: ${get('disk_type', '')}
        required: false
        private: true
    - disk_encryption_key:
        default: ''
        required: false
    - diskEncryptionKey:
        default: ${get('disk_encryption_key', '')}
        required: false
        private: true
    - proxy_host:
        default: ''
        required: false
    - proxyHost:
        default: ${get('proxy_host', '')}
        required: false
        private: true
    - proxy_port:
        default: '8080'
        required: false
    - proxyPort:
        default: ${get('proxy_port', '')}
        required: false
        private: true
    - proxy_username:
        default: ''
        required: false
    - proxyUsername:
        default: ${get('proxy_username', '')}
        required: false
        private: true
    - proxy_password:
        default: ''
        required: false
        sensitive: true
    - proxyPassword:
        default: ${get('proxy_password', '')}
        required: false
        private: true
        sensitive: true
    - pretty_print:
        default: 'true'
        required: false
    - prettyPrint:
        default: ${get('pretty_print', '')}
        required: false
        private: true

  java_action:
    gav: 'io.cloudslang.content:cs-google-cloud:0.0.1'
    class_name: io.cloudslang.content.gcloud.actions.compute.disks.DisksInsert
    method_name: execute

  outputs:
    - return_code: ${returnCode}
    - return_result: ${returnResult}
    - exception: ${get('exception', '')}
    - zone_operation_name: ${zoneOperationName}

  results:
    - SUCCESS: ${returnCode=='0'}
    - FAILURE
