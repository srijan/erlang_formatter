#!/bin/bash

OTP_SOURCE_DIR="otp_source"
OTP_GIT_REMOTE="git://github.com/erlang/otp.git"

if [ ! -d "${OTP_SOURCE_DIR}" ]; then
	echo "Fetching OTP source"
	git clone "${OTP_GIT_REMOTE}" "${OTP_SOURCE_DIR}"
else
	echo "Updating OTP source"
	cd "${OTP_SOURCE_DIR}" && git pull && cd ../
fi

if [ $? == 0 ]; then
	echo "Copying emacs stuff to erlang_mode"
	mkdir -p erlang_mode
	cp ./"${OTP_SOURCE_DIR}"/lib/tools/emacs/*.el ./erlang_mode/
fi

echo "Finished"