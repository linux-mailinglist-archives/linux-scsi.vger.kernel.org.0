Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC60C81233
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 08:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfHEGYH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 02:24:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:58178 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfHEGYH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 5 Aug 2019 02:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564986248; x=1596522248;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dy07uosSr7cKziYkXSNyPTsOxT7lydWAZPZiedfNQB4=;
  b=Gb1z+smh2ZUJRHzz12c5n8FKcXRtoAued/OQZ95xNLR5nQOE9C2qhIvN
   X7uiGx47OIxlDIGehgP1B7FI9RiMFMtD+MLJPKx+Xi4PkuYLqxx9bLpjU
   ZgYW6RbqItgxtuRKbZzuMxiSv9krdp4DTN36S0HUDY8J4CVFN0cj3Me1e
   KKBPqj2VkDO29a4scztFqAg3D3VGblLIyx6nQJzvKIGjoSmY5hxVqI0ZH
   GOw5NWkXGNAWwR9K80gv+DFf8K2LwsMF4f8Kq1X4Erzc3eWLbiorq3VCO
   4raXw43EmrPTuzEjnsvfzwPiaa86I+04c1bsICqSgnU9ukJr+ykdpBDzq
   Q==;
IronPort-SDR: nHS2v3CCOze4Dhg6c0h6DWdijIXBMv4OsAtd4mrMj1skBC7kOq5GUhTLr2y68GREaZvHKcvztQ
 iRVPtUB1ko03SScBatApfCXPpR7eYLNOAoLw4X/DX3/ymD8lsyjNkcQgGVcAXrbL23Qc+JuG0A
 I9V9lw9EUCYJ/IkDbItlsnLtKpriDt7WT5fK0w3tMFnhO2I150cnx4ceqR3Xm5nxlq8sjbT8Wy
 llKJtNycCRlhnMKZTGCnmVxdTFgF+uPzjLOVW1rytxCifcPdSsBQTyANORjfODFSShhjErKF6S
 sdE=
X-IronPort-AV: E=Sophos;i="5.64,348,1559491200"; 
   d="scan'208";a="114977754"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Aug 2019 14:24:07 +0800
IronPort-SDR: obY7fVXZQ1GYI4Ao5QcID/UPNrlYBK9BSWCyXUaXD9PJ7z7CjkgfqHoZ52P3sOu8Mv5QVpQZTj
 5VTMgdY44rCQ5ogBD25O2M1joW6LX3Bji1Mu91TL7Id8KBBMedeypXDdUO2oXccejIP/bzsbB6
 evL1CVHx+CAndA2FmtX7+MDiG9+bgaKiCmgYbIZwqL6AXwC4RoXI6D6exg0U6sntrjTIfGcx4h
 yu5NLrE1yJiXmYsMViiVTwwqztKTT4MIDAoazTuL114y+fJqVixUqGwCm/XDARAOHb5Dqlryy+
 qExjG8wpVy4MX9cbRo0GGwB8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2019 23:21:59 -0700
IronPort-SDR: 0ifyC7AQgrYkOhlpSlsHxA8cotwCTpt8O3eVbCNt7e5nVAiqUYE93p1q0Xr/e6C8zYEHadQdvO
 IQ+odcXFW9a+Og/hrY2O9+ZAsinMydpZ37V+eSAMUnoxvBuTlWguRkoWgiGGcpyxGEuqeIHq42
 aH9dFc/VvpaDNWd0d0Sgo6kBxagd5dIqbbNnKg5r+6CzMHAFqYyjW34dgme/D3Z0gQyY20UHwR
 KhgvUFeg6jzsg2cmSfiON1/jDT/sqYGyNh6gKUiNmHlyuV+iE4wvLs8SY82ZooCrcrBvB9q+BH
 Isc=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Aug 2019 23:24:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     Nicholas Bellinger <nab@linux-iscsi.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] scsi: target/tcm_loop: update upper limit of LUN
Date:   Mon,  5 Aug 2019 15:23:13 +0900
Message-Id: <20190805062313.343221-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

targetcli-fb (or its library: rtslib-fb) allows us to create LUN up to
65535. On the other hand, the kernel driver is limiting max_lun to 0.

This limitation causes an actual problem when you delete a loopback device
(using /sys/class/scsi_device/${lun}/device/delete) and rescan it (using
/sys/class/scsi_host/host${h}/scan). You can delete the device, but cannot
rescan it because its LUN is larger than the max_lun and so the scan
request results in -EINVAL error in scsi_scan_host_selected().

This commit fix the upper limit to be as same as rtslib-fb allows.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 drivers/target/loopback/tcm_loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 3305b47fdf53..3db541ad727d 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -336,10 +336,10 @@ static int tcm_loop_driver_probe(struct device *dev)
 	 */
 	*((struct tcm_loop_hba **)sh->hostdata) = tl_hba;
 	/*
-	 * Setup single ID, Channel and LUN for now..
+	 * Setup single ID, and Channel for now..
 	 */
 	sh->max_id = 2;
-	sh->max_lun = 0;
+	sh->max_lun = 65536;
 	sh->max_channel = 0;
 	sh->max_cmd_len = SCSI_MAX_VARLEN_CDB_SIZE;
 
-- 
2.22.0

