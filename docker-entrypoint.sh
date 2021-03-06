#!/bin/bash

echo "${S3_ACCESS_KEY_ID}:${S3_SECRET_ACCESS_KEY}" > /etc/passwd-s3fs 
chmod 0400 /etc/passwd-s3fs

s3fs $S3_BUCKET $MNT_POINT -f -o url=${S3_ENDPOINT},allow_other,use_cache=/tmp,max_stat_cache_size=1000,stat_cache_expire=900,retries=5,connect_timeout=10${S3_EXTRAVARS}