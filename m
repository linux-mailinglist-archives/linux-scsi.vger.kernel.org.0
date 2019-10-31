Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595AEEAA11
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Oct 2019 06:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfJaFMP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 31 Oct 2019 01:12:15 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:38896 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfJaFMO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 31 Oct 2019 01:12:14 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  viswas.g@microsemi.com designates 208.19.100.23 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.23;
  receiver=esa4.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="viswas.g@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.23; receiver=esa4.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=viswas.g@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
IronPort-SDR: U0YxOlgpBRy0HmlFSZk03mnKmmxvT90zoRKUVlynMPoCnzv7kGTPLAj+8IABsTGoAd68bFuYF9
 Qd221VrtqQHU0zOmg4ZPDjxhLXmkntOx0rEJ3RkBPlm/43PhJhJa4ooA9HrYYphF0SdabZALyk
 L+bVz7rv4n6Cdyv/ngYLk7IihsPF54UkK9t3JJGWI3VDJgQ+HTZRaQ9cnktXunUllBxjazfMM8
 KMURXGPoVjj+VAK6Ax2iVpuEzgyIy/yif4ZTeh0YLnhgf9+KgEI7O5MxLN4pkWbGo07ZA4/ESy
 eeo=
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="53588627"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.23])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Oct 2019 22:12:14 -0700
Received: from AVMBX1.microsemi.net (10.100.34.31) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 30 Oct
 2019 22:12:13 -0700
Received: from localhost (10.41.130.49) by avmbx1.microsemi.net (10.100.34.31)
 with Microsoft SMTP Server id 15.1.1847.3 via Frontend Transport; Wed, 30 Oct
 2019 22:12:13 -0700
From:   Deepak Ukey <deepak.ukey@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <deepak.ukey@microchip.com>,
        <jinpu.wang@profitbricks.com>, <martin.petersen@oracle.com>,
        <dpf@google.com>, <jsperbeck@google.com>, <auradkar@google.com>,
        <ianyar@google.com>
Subject: [PATCH 06/12] pm80xx : Fix dereferencing dangling pointer.
Date:   Thu, 31 Oct 2019 10:42:35 +0530
Message-ID: <20191031051241.6762-7-deepak.ukey@microchip.com>
X-Mailer: git-send-email 2.19.0-rc1
In-Reply-To: <20191031051241.6762-1-deepak.ukey@microchip.com>
References: <20191031051241.6762-1-deepak.ukey@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Vikram Auradkar <auradkar@google.com>

sas_task structure should not be used after task_done is called.
If the device is gone or not attached, we call task_done on t and
continue to use in the sas_task in rest of the function. task_done
is pointing to sas_ata_task_done, may free the memory associated
with the task before returning.

Signed-off-by: Vikram Auradkar <auradkar@google.com>
Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 447a66d60275..4491de8d40fc 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -388,6 +388,7 @@ static int pm8001_task_exec(struct sas_task *task,
 	struct pm8001_ccb_info *ccb;
 	u32 tag = 0xdeadbeef, rc = 0, n_elem = 0;
 	unsigned long flags = 0;
+	enum sas_protocol task_proto = t->task_proto;
 
 	if (!dev->port) {
 		struct task_status_struct *tsm = &t->task_status;
@@ -412,7 +413,7 @@ static int pm8001_task_exec(struct sas_task *task,
 		pm8001_dev = dev->lldd_dev;
 		port = &pm8001_ha->port[sas_find_local_port_id(dev)];
 		if (DEV_IS_GONE(pm8001_dev) || !port->port_attached) {
-			if (sas_protocol_ata(t->task_proto)) {
+			if (sas_protocol_ata(task_proto)) {
 				struct task_status_struct *ts = &t->task_status;
 				ts->resp = SAS_TASK_UNDELIVERED;
 				ts->stat = SAS_PHY_DOWN;
@@ -434,7 +435,7 @@ static int pm8001_task_exec(struct sas_task *task,
 			goto err_out;
 		ccb = &pm8001_ha->ccb_info[tag];
 
-		if (!sas_protocol_ata(t->task_proto)) {
+		if (!sas_protocol_ata(task_proto)) {
 			if (t->num_scatter) {
 				n_elem = dma_map_sg(pm8001_ha->dev,
 					t->scatter,
@@ -454,7 +455,7 @@ static int pm8001_task_exec(struct sas_task *task,
 		ccb->ccb_tag = tag;
 		ccb->task = t;
 		ccb->device = pm8001_dev;
-		switch (t->task_proto) {
+		switch (task_proto) {
 		case SAS_PROTOCOL_SMP:
 			rc = pm8001_task_prep_smp(pm8001_ha, ccb);
 			break;
@@ -471,8 +472,7 @@ static int pm8001_task_exec(struct sas_task *task,
 			break;
 		default:
 			dev_printk(KERN_ERR, pm8001_ha->dev,
-				"unknown sas_task proto: 0x%x\n",
-				t->task_proto);
+				"unknown sas_task proto: 0x%x\n", task_proto);
 			rc = -EINVAL;
 			break;
 		}
@@ -495,7 +495,7 @@ static int pm8001_task_exec(struct sas_task *task,
 	pm8001_tag_free(pm8001_ha, tag);
 err_out:
 	dev_printk(KERN_ERR, pm8001_ha->dev, "pm8001 exec failed[%d]!\n", rc);
-	if (!sas_protocol_ata(t->task_proto))
+	if (!sas_protocol_ata(task_proto))
 		if (n_elem)
 			dma_unmap_sg(pm8001_ha->dev, t->scatter, t->num_scatter,
 				t->data_dir);
-- 
2.16.3

