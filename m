Return-Path: <linux-scsi+bounces-11827-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496B3A21540
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Jan 2025 00:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A75B7A1AC0
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Jan 2025 23:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA561F1506;
	Tue, 28 Jan 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bub8h/ba"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9DBEAF6;
	Tue, 28 Jan 2025 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738107734; cv=none; b=ckmwXwLIHL486Lnvo3Uu0tb5PYNxaD9FwoRLAj+TQMPrIymEeJ01EqEGOEpYffK8yNrS7As0AUzADzxub/s4hbhdQ1gJxAJRF2PbCWShjqanKTz/oJv10ZSfrBow/hgHpOKQU30IXQFV/prDEzgabpetFbUg2pOPmVdYU4aWO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738107734; c=relaxed/simple;
	bh=vk5/7P7DdctiHiDW9B+wwE8b8h3nugh9+wKgjj6bar0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZz2Y7JHe6Tq+Ft/SFWX3z8dsC/Z55mX8iAEIxpywhxkXdTyqnjOFUvk0uAA0WQozRkyxWD0Qo30JSml/cMz/W+8xi0vJgS/3W/9305c2YVYOjOE1OxsPDZdrLWkV90mAYDEO0qF2bVPQHGuXhFiIjP178eTaNFBWRSLKqs5jK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bub8h/ba; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SMfoOw032557;
	Tue, 28 Jan 2025 23:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Ym9D0
	z7cx2TXfcL5ctmbHGaD396mE3JeJnk1XpoPufI=; b=bub8h/baOHF8LQFHMFvps
	GyTYR3vEjkUIyjJQEuQ5YypaOfI+IhS2bgxTwYu/YVW/z0+zJwtP2nC1qZ5lcJ36
	VBhBRb5ThhBrAuBIbCSHeAzZIiR1qd563lUTv2dRIuksXd/wA0sfA0Nj3adj0NOL
	kt5BJQEkMWNkUxrDyMlmy8RzFcq6iYT0+GdQ7QWtynP+RMWkNUTYMu4OB1rHE6Qr
	UwyHIBBW9AU+8zm80vOX+ChpCKw3Oxo0QmvEUtNwrr8M9P/Gri1w14IgUMz5XGXz
	NV+UClMTepcxNOO7dNJ6bOPPDirk4S7lXtJ68Blz0VEV5ZwGelO4csxsacfELQvx
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f7a785k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 23:42:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50SMJ6Q4035859;
	Tue, 28 Jan 2025 23:42:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdf2mx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 23:42:05 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50SNg3Wu019555;
	Tue, 28 Jan 2025 23:42:04 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44cpdf2mvx-2;
	Tue, 28 Jan 2025 23:42:04 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, alan.adamson@oracle.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH v2 blktests 1/2] scsi/009: add atomic write tests
Date: Tue, 28 Jan 2025 15:50:33 -0800
Message-ID: <20250128235034.307987-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250128235034.307987-1-alan.adamson@oracle.com>
References: <20250128235034.307987-1-alan.adamson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280172
X-Proofpoint-ORIG-GUID: MGXiIgFBbqU4FOxK2yrzHbn1gXmtQL0c
X-Proofpoint-GUID: MGXiIgFBbqU4FOxK2yrzHbn1gXmtQL0c

Tests basic atomic write functionality. If no scsi test device is provided,
a scsi_debug device will be used. Testing areas include:

- Verify sysfs atomic write attributes are consistent with
  atomic write attributes advertised by scsi_debug.
- Verify the atomic write paramters of statx are correct using
  xfs_io.
- Perform a pwritev2() (with and without RWF_ATOMIC flag) using
  xfs_io:
    - maximum byte size (atomic_write_unit_max_bytes)
    - minimum byte size (atomic_write_unit_min_bytes)
    - a write larger than atomic_write_unit_max_bytes
    - a write smaller than atomic_write_unit_min_bytes

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 common/xfs         |  61 ++++++++++++
 tests/scsi/009     | 233 +++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/009.out |  18 ++++
 3 files changed, 312 insertions(+)
 create mode 100755 tests/scsi/009
 create mode 100644 tests/scsi/009.out

diff --git a/common/xfs b/common/xfs
index 569770fecd53..5db052be7e1c 100644
--- a/common/xfs
+++ b/common/xfs
@@ -6,6 +6,30 @@
 
 . common/shellcheck
 
+_have_xfs_io() {
+	if ! _have_program xfs_io; then
+		return 1
+	fi
+	return 0
+}
+
+# Check whether the version of xfs_io is greater than or equal to $1.$2.$3
+
+_have_xfs_io_atomic_write() {
+	local s
+
+	_have_xfs_io || return $?
+
+	# If the pwrite command supports the -A option then this version
+	# of xfs_io supports atomic writes.
+	s=$(xfs_io -c help | grep pwrite | awk '{ print $4}')
+	if [[ $s == *"A"* ]];
+	then
+		return 0
+	fi
+	return 1
+}
+
 _have_xfs() {
 	_have_fs xfs && _have_program mkfs.xfs
 }
@@ -52,3 +76,40 @@ _xfs_run_fio_verify_io() {
 
 	return "${rc}"
 }
+
+# Use xfs_io to perform a non-atomic write using pwritev2().
+# Args:    $1 - device to write to
+#          $2 - number of bytes to write
+# Returns: Number of bytes written
+run_xfs_io_pwritev2() {
+	local dev=$1
+	local bytes_to_write=$2
+	local bytes_written
+
+	# Perform write and extract out bytes written from xfs_io output
+	bytes_written=$(xfs_io -d -C "pwrite -b ${bytes_to_write} -V 1 -D 0 ${bytes_to_write}" "$dev" | grep "wrote" | sed 's/\// /g' | awk '{ print $2 }')
+	echo "$bytes_written"
+}
+
+# Use xfs_io to perform an atomic write using pwritev2().
+# Args:    $1 - device to write to
+#          $2 - number of bytes to write
+# Returns: Number of bytes written
+run_xfs_io_pwritev2_atomic() {
+	local dev=$1
+	local bytes_to_write=$2
+	local bytes_written
+
+	# Perform atomic write and extract out bytes written from xfs_io output
+	bytes_written=$(xfs_io -d -C "pwrite -b ${bytes_to_write} -V 1 -A -D 0 ${bytes_to_write}" "$dev" | grep "wrote" | sed 's/\// /g' | awk '{ print $2 }')
+	echo "$bytes_written"
+}
+
+run_xfs_io_xstat() {
+	local dev=$1
+	local field=$2
+	local statx_output
+
+	statx_output=$(xfs_io -c "statx -r -m 0x00010000" "$dev" | grep "$field" | awk '{ print $3 }')
+	echo "$statx_output"
+}
diff --git a/tests/scsi/009 b/tests/scsi/009
new file mode 100755
index 000000000000..7624447a6633
--- /dev/null
+++ b/tests/scsi/009
@@ -0,0 +1,233 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Oracle and/or its affiliates
+#
+# Test SCSI Atomic Writes with scsi_debug
+
+. tests/scsi/rc
+. common/scsi_debug
+. common/xfs
+
+DESCRIPTION="test scsi atomic writes"
+QUICK=1
+
+requires() {
+	_have_driver scsi_debug
+	_have_xfs_io_atomic_write
+}
+
+device_requires() {
+	_require_test_dev_sysfs queue/atomic_write_max_bytes
+	if (( $(< "${TEST_DEV_SYSFS}"/queue/atomic_write_max_bytes) == 0 )); then
+		SKIP_REASONS+=("${TEST_DEV} does not support atomic write")
+		return 1
+	fi
+}
+
+fallback_device() {
+	local scsi_debug_params=(
+		delay=0
+		atomic_wr=1
+	)
+	if ! _configure_scsi_debug "${scsi_debug_params[@]}"; then
+		return 1
+		fi
+	echo "/dev/${SCSI_DEBUG_DEVICES[0]}"
+}
+
+cleanup_fallback_device() {
+	_exit_scsi_debug
+}
+
+test_device() {
+	local scsi_debug_atomic_wr_max_length
+	local scsi_debug_atomic_wr_gran
+	local scsi_atomic_max_bytes
+	local scsi_atomic_min_bytes
+	local sysfs_max_hw_sectors_kb
+	local max_hw_bytes
+	local sysfs_logical_block_size
+	local sysfs_atomic_max_bytes
+	local sysfs_atomic_unit_max_bytes
+	local sysfs_atomic_unit_min_bytes
+	local statx_atomic_min
+	local statx_atomic_max
+	local bytes_to_write
+	local bytes_written
+	local test_desc
+
+	echo "Running ${TEST_NAME}"
+
+	sysfs_logical_block_size=$(< "${TEST_DEV_SYSFS}"/queue/logical_block_size)
+	sysfs_max_hw_sectors_kb=$(< "${TEST_DEV_SYSFS}"/queue/max_hw_sectors_kb)
+	max_hw_bytes=$(( "$sysfs_max_hw_sectors_kb" * 1024 ))
+	sysfs_atomic_max_bytes=$(< "${TEST_DEV_SYSFS}"/queue/atomic_write_max_bytes)
+	sysfs_atomic_unit_max_bytes=$(< "${TEST_DEV_SYSFS}"/queue/atomic_write_unit_max_bytes)
+	sysfs_atomic_unit_min_bytes=$(< "${TEST_DEV_SYSFS}"/queue/atomic_write_unit_min_bytes)
+	scsi_debug_atomic_wr_max_length=$(< /sys/module/scsi_debug/parameters/atomic_wr_max_length)
+	scsi_debug_atomic_wr_gran=$(< /sys/module/scsi_debug/parameters/atomic_wr_gran)
+	scsi_atomic_max_bytes=$(( "$scsi_debug_atomic_wr_max_length" * "$sysfs_logical_block_size" ))
+	scsi_atomic_min_bytes=$(( "$scsi_debug_atomic_wr_gran" * "$sysfs_logical_block_size" ))
+
+	test_desc="TEST 1 - Verify sysfs atomic attributes"
+	if [ "$max_hw_bytes" -ge "$sysfs_atomic_max_bytes" ] &&
+		[ "$sysfs_atomic_max_bytes" -ge "$sysfs_atomic_unit_max_bytes" ] &&
+		[ "$sysfs_atomic_unit_max_bytes" -ge "$sysfs_atomic_unit_min_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $max_hw_bytes - $sysfs_max_hw_sectors_kb -" \
+			"$sysfs_atomic_max_bytes - $sysfs_atomic_unit_max_bytes -" \
+			"$sysfs_atomic_unit_min_bytes"
+	fi
+
+	test_desc="TEST 2 - check scsi_debug atomic_wr_max_length is the same as sysfs atomic_write_max_bytes"
+	if [ "$scsi_atomic_max_bytes" -le "$max_hw_bytes" ]
+	then
+		if [ "$scsi_atomic_max_bytes" = "$sysfs_atomic_max_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $scsi_atomic_max_bytes - $max_hw_bytes -" \
+				"$sysfs_atomic_max_bytes"
+		fi
+	else
+		if [ "$sysfs_atomic_max_bytes" = "$max_hw_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $scsi_atomic_max_bytes - $max_hw_bytes -" \
+				"$sysfs_atomic_max_bytes"
+		fi
+	fi
+
+	test_desc="TEST 3 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length"
+	if (("$sysfs_atomic_unit_max_bytes" <= "$scsi_atomic_max_bytes"))
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $sysfs_atomic_unit_max_bytes - $scsi_atomic_max_bytes"
+	fi
+
+	test_desc="TEST 4 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran"
+	if [ "$sysfs_atomic_unit_min_bytes" = "$scsi_atomic_min_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $sysfs_atomic_unit_min_bytes - $scsi_atomic_min_bytes"
+	fi
+
+	test_desc="TEST 5 - check statx stx_atomic_write_unit_min"
+	statx_atomic_min=$(run_xfs_io_xstat "$TEST_DEV" "stat.atomic_write_unit_min")
+	if [ "$statx_atomic_min" = "$scsi_atomic_min_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $statx_atomic_min - $scsi_atomic_min_bytes"
+	fi
+
+	test_desc="TEST 6 - check statx stx_atomic_write_unit_max"
+	statx_atomic_max=$(run_xfs_io_xstat "$TEST_DEV" "stat.atomic_write_unit_max")
+	if [ "$statx_atomic_max" = "$sysfs_atomic_unit_max_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $statx_atomic_max - $sysfs_atomic_unit_max_bytes"
+	fi
+
+	test_desc="TEST 7 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes "
+	test_desc+="with no RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_written=$(run_xfs_io_pwritev2 "$TEST_DEV" "$sysfs_atomic_unit_max_bytes")
+	if [ "$bytes_written" = "$sysfs_atomic_unit_max_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "test_desc - fail $bytes_written - $sysfs_atomic_unit_max_bytes"
+	fi
+
+	test_desc="TEST 8 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with "
+	test_desc+="RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_written=$(run_xfs_io_pwritev2_atomic "$TEST_DEV" "$sysfs_atomic_unit_max_bytes")
+	if [ "$bytes_written" = "$sysfs_atomic_unit_max_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $sysfs_atomic_unit_max_bytes"
+	fi
+
+	test_desc="TEST 9 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 "
+	test_desc+="bytes with no RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_to_write=$(( "${sysfs_atomic_unit_max_bytes}" + "$sysfs_logical_block_size" ))
+	bytes_written=$(run_xfs_io_pwritev2 "$TEST_DEV" "$bytes_to_write")
+	if [ "$bytes_written" = "$bytes_to_write" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $bytes_to_write"
+	fi
+
+	test_desc="TEST 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 "
+	test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should not be succesful"
+	bytes_written=$(run_xfs_io_pwritev2_atomic "$TEST_DEV" "$bytes_to_write")
+	if [ "$bytes_written" = "" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $bytes_to_write"
+	fi
+
+	test_desc="TEST 11 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes "
+	test_desc+="with no RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_written=$(run_xfs_io_pwritev2 "$TEST_DEV" "$sysfs_atomic_unit_min_bytes")
+	if [ "$bytes_written" = "$sysfs_atomic_unit_min_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $scsi_atomic_min_bytes"
+	fi
+
+	test_desc="TEST 12 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes "
+	test_desc+="with RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_written=$(run_xfs_io_pwritev2_atomic "$TEST_DEV" "$sysfs_atomic_unit_min_bytes")
+	if [ "$bytes_written" = "$sysfs_atomic_unit_min_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $scsi_atomic_min_bytes"
+	fi
+
+	test_desc="TEST 13 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 "
+	test_desc+="bytes with no RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_to_write=$(( "${sysfs_atomic_unit_min_bytes}" - "${sysfs_logical_block_size}" ))
+	if [ "$bytes_to_write" = 0 ]
+	then
+		echo "$test_desc - pass"
+		echo "pwrite: Invalid argument"
+	else
+		bytes_written=$(run_xfs_io_pwritev2 "$TEST_DEV" "$bytes_to_write")
+		if [ "$bytes_written" = "$bytes_to_write" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $bytes_written - $bytes_to_write"
+		fi
+	fi
+	test_desc="TEST 14 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 "
+	test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should fail"
+	if [ "$bytes_to_write" = 0 ]
+	then
+		echo "$test_desc - pass"
+	else
+		bytes_written=$(run_xfs_io_pwritev2_atomic "$TEST_DEV" "$bytes_to_write")
+		if [ "$bytes_written" = "" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $bytes_written - $bytes_to_write"
+		fi
+	fi
+
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/scsi/009.out b/tests/scsi/009.out
new file mode 100644
index 000000000000..e31416b93515
--- /dev/null
+++ b/tests/scsi/009.out
@@ -0,0 +1,18 @@
+Running scsi/009
+TEST 1 - Verify sysfs atomic attributes - pass
+TEST 2 - check scsi_debug atomic_wr_max_length is the same as sysfs atomic_write_max_bytes - pass
+TEST 3 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
+TEST 4 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
+TEST 5 - check statx stx_atomic_write_unit_min - pass
+TEST 6 - check statx stx_atomic_write_unit_max - pass
+TEST 7 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with no RWF_ATOMIC flag - pwritev2 should be succesful - pass
+TEST 8 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+TEST 9 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with no RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 11 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with no RWF_ATOMIC flag - pwritev2 should be succesful - pass
+TEST 12 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+TEST 13 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with no RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 14 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+Test complete
-- 
2.43.5


