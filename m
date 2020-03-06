Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6272517C42D
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Mar 2020 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCFRVC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 Mar 2020 12:21:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727030AbgCFRVC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 6 Mar 2020 12:21:02 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026GtB83022411;
        Fri, 6 Mar 2020 12:20:57 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ykk059c8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 12:20:57 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 026HKXKg031418;
        Fri, 6 Mar 2020 17:20:56 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 2yffk7cxkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 17:20:56 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 026HKu7952691392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Mar 2020 17:20:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52D72B2065;
        Fri,  6 Mar 2020 17:20:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D934BB2066;
        Fri,  6 Mar 2020 17:20:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  6 Mar 2020 17:20:55 +0000 (GMT)
From:   wenxiong@linux.vnet.ibm.com
To:     linux-scsi@vger.kernel.org
Cc:     James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        brking@linux.vnet.ibm.com, wenxiong@us.ibm.com,
        Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH] ipr: Kernel panic - not syncing:softlockup when rescan devices in petitboot shell
Date:   Fri,  6 Mar 2020 09:57:28 -0600
Message-Id: <1583510248-23672-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_05:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=1 spamscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060111
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

When trying to rescan disks in petitboot shell, hitting the following
softlockup stacktrace:

Kernel panic - not syncing: System is deadlocked on memory
[  241.223394] CPU: 32 PID: 693 Comm: sh Not tainted 5.4.16-openpower1 #1
[  241.223406] Call Trace:
[  241.223415] [c0000003f07c3180] [c000000000493fc4] dump_stack+0xa4/0xd8 (unreliable)
[  241.223432] [c0000003f07c31c0] [c00000000007d4ac] panic+0x148/0x3cc
[  241.223446] [c0000003f07c3260] [c000000000114b10] out_of_memory+0x468/0x4c4
[  241.223461] [c0000003f07c3300] [c0000000001472b0] __alloc_pages_slowpath+0x594/0x6d8
[  241.223476] [c0000003f07c3420] [c00000000014757c] __alloc_pages_nodemask+0x188/0x1a4
[  241.223492] [c0000003f07c34a0] [c000000000153e10] alloc_pages_current+0xcc/0xd8
[  241.223508] [c0000003f07c34e0] [c0000000001577ac] alloc_slab_page+0x30/0x98
[  241.223524] [c0000003f07c3520] [c0000000001597fc] new_slab+0x138/0x40c
[  241.223538] [c0000003f07c35f0] [c00000000015b204] ___slab_alloc+0x1e4/0x404
[  241.223552] [c0000003f07c36c0] [c00000000015b450] __slab_alloc+0x2c/0x48
[  241.223566] [c0000003f07c36f0] [c00000000015b754] kmem_cache_alloc_node+0x9c/0x1b4
[  241.223582] [c0000003f07c3760] [c000000000218c48] blk_alloc_queue_node+0x34/0x270
[  241.223599] [c0000003f07c37b0] [c000000000226574] blk_mq_init_queue+0x2c/0x78
[  241.223615] [c0000003f07c37e0] [c0000000002ff710] scsi_mq_alloc_queue+0x28/0x70
[  241.223631] [c0000003f07c3810] [c0000000003005b8] scsi_alloc_sdev+0x184/0x264
[  241.223647] [c0000003f07c38a0] [c000000000300ba0] scsi_probe_and_add_lun+0x288/0xa3c
[  241.223663] [c0000003f07c3a00] [c000000000301768] __scsi_scan_target+0xcc/0x478
[  241.223679] [c0000003f07c3b20] [c000000000301c64] scsi_scan_channel.part.9+0x74/0x7c
[  241.223696] [c0000003f07c3b70] [c000000000301df4] scsi_scan_host_selected+0xe0/0x158
[  241.223712] [c0000003f07c3bd0] [c000000000303f04] store_scan+0x104/0x114
[  241.223727] [c0000003f07c3cb0] [c0000000002d5ac4] dev_attr_store+0x30/0x4c
[  241.223741] [c0000003f07c3cd0] [c0000000001dbc34] sysfs_kf_write+0x64/0x78
[  241.223756] [c0000003f07c3cf0] [c0000000001da858] kernfs_fop_write+0x170/0x1b8
[  241.223773] [c0000003f07c3d40] [c0000000001621fc] __vfs_write+0x34/0x60
[  241.223787] [c0000003f07c3d60] [c000000000163c2c] vfs_write+0xa8/0xcc
[  241.223802] [c0000003f07c3db0] [c000000000163df4] ksys_write+0x70/0xbc
[  241.223816] [c0000003f07c3e20] [c00000000000b40c] system_call+0x5c/0x68

As a part of the scan process Linux will allocate and configure a scsi_device
for each target to be scanned. If the device is not present, then the scsi_device
is torn down. As a part of scsi_device teardown a workqueue item will be scheduled
and the lockups we see are because there's 250k workqueue items to be processed.
Accoding to the specification of SIS-64 sas controller, max_channel could be
decreased on SIS-64 adapters to 4.

The patch fixes softlock issue.

Thanks for Oliver Halloran's help with debugging and explanation!

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
---
 drivers/scsi/ipr.c |    3 ++-
 drivers/scsi/ipr.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index ae45cbe..cd8db13 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -9950,6 +9950,7 @@ static void ipr_init_ioa_cfg(struct ipr_ioa_cfg *ioa_cfg,
 	ioa_cfg->max_devs_supported = ipr_max_devs;
 
 	if (ioa_cfg->sis64) {
+		host->max_channel = IPR_MAX_SIS64_BUSES;
 		host->max_id = IPR_MAX_SIS64_TARGETS_PER_BUS;
 		host->max_lun = IPR_MAX_SIS64_LUNS_PER_TARGET;
 		if (ipr_max_devs > IPR_MAX_SIS64_DEVS)
@@ -9958,6 +9959,7 @@ static void ipr_init_ioa_cfg(struct ipr_ioa_cfg *ioa_cfg,
 					   + ((sizeof(struct ipr_config_table_entry64)
 					       * ioa_cfg->max_devs_supported)));
 	} else {
+		host->max_channel = IPR_VSET_BUS;
 		host->max_id = IPR_MAX_NUM_TARGETS_PER_BUS;
 		host->max_lun = IPR_MAX_NUM_LUNS_PER_TARGET;
 		if (ipr_max_devs > IPR_MAX_PHYSICAL_DEVS)
@@ -9967,7 +9969,6 @@ static void ipr_init_ioa_cfg(struct ipr_ioa_cfg *ioa_cfg,
 					       * ioa_cfg->max_devs_supported)));
 	}
 
-	host->max_channel = IPR_VSET_BUS;
 	host->unique_id = host->host_no;
 	host->max_cmd_len = IPR_MAX_CDB_LEN;
 	host->can_queue = ioa_cfg->max_cmds;
diff --git a/drivers/scsi/ipr.h b/drivers/scsi/ipr.h
index a67baeb..b97aa9a 100644
--- a/drivers/scsi/ipr.h
+++ b/drivers/scsi/ipr.h
@@ -1300,6 +1300,7 @@ struct ipr_resource_entry {
 #define IPR_ARRAY_VIRTUAL_BUS			0x1
 #define IPR_VSET_VIRTUAL_BUS			0x2
 #define IPR_IOAFP_VIRTUAL_BUS			0x3
+#define IPR_MAX_SIS64_BUSES			0x4
 
 #define IPR_GET_RES_PHYS_LOC(res) \
 	(((res)->bus << 24) | ((res)->target << 8) | (res)->lun)
-- 
1.6.0.2

