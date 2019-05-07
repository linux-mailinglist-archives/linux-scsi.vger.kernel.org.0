Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3C16A35
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 20:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEGSca (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 14:32:30 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24158 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfEGSca (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 14:32:30 -0400
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=don.brace@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  don.brace@microsemi.com designates 208.19.100.22 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.22;
  receiver=esa5.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="don.brace@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa5.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.60,443,1549954800"; 
   d="scan'208";a="30471252"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 May 2019 11:32:30 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 11:32:28 -0700
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 11:32:27 -0700
Received: from [127.0.1.1] (10.238.32.34) by avmbx2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 May 2019 11:32:27 -0700
Subject: [PATCH 5/7] hpsa: do-not-complete-cmds-for-deleted-devices
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Tue, 7 May 2019 13:32:26 -0500
Message-ID: <155725394682.27200.4066909118536633097.stgit@brunhilda>
In-Reply-To: <155725372104.27200.12250663760304977059.stgit@brunhilda>
References: <155725372104.27200.12250663760304977059.stgit@brunhilda>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

- close up a rare multipath issue.
  . close up small hole where a command completes after a device
    has been removed from SML and before the device is re-added.
    . mark device as removed in slave_destroy.
    . do not complete commands for deleted devices.

Reviewed-by: Justin Lindley <justin.lindley@microsemi.com>
Reviewed-by: David Carroll <david.carroll@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
---
 drivers/scsi/hpsa.c |   14 +++++++++++++-
 drivers/scsi/hpsa.h |    1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 5c02163c7cea..0480e3c34217 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -2141,6 +2141,7 @@ static int hpsa_slave_configure(struct scsi_device *sdev)
 	sdev->no_uld_attach = !sd || !sd->expose_device;
 
 	if (sd) {
+		sd->was_removed = 0;
 		if (sd->external) {
 			queue_depth = EXTERNAL_QD;
 			sdev->eh_timeout = HPSA_EH_PTRAID_TIMEOUT;
@@ -2160,7 +2161,12 @@ static int hpsa_slave_configure(struct scsi_device *sdev)
 
 static void hpsa_slave_destroy(struct scsi_device *sdev)
 {
-	/* nothing to do. */
+	struct hpsa_scsi_dev_t *hdev = NULL;
+
+	hdev = sdev->hostdata;
+
+	if (hdev)
+		hdev->was_removed = 1;
 }
 
 static void hpsa_free_ioaccel2_sg_chain_blocks(struct ctlr_info *h)
@@ -2588,6 +2594,12 @@ static void complete_scsi_command(struct CommandList *cp)
 	cmd->result = (DID_OK << 16); 		/* host byte */
 	cmd->result |= (COMMAND_COMPLETE << 8);	/* msg byte */
 
+	/* SCSI command has already been cleaned up in SML */
+	if (dev->was_removed) {
+		hpsa_cmd_resolve_and_free(h, cp);
+		return;
+	}
+
 	if (cp->cmd_type == CMD_IOACCEL2 || cp->cmd_type == CMD_IOACCEL1) {
 		if (dev->physical_device && dev->expose_device &&
 			dev->removed) {
diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
index 75210de71917..a013c16af5f1 100644
--- a/drivers/scsi/hpsa.h
+++ b/drivers/scsi/hpsa.h
@@ -65,6 +65,7 @@ struct hpsa_scsi_dev_t {
 	u8 physical_device : 1;
 	u8 expose_device;
 	u8 removed : 1;			/* device is marked for death */
+	u8 was_removed : 1;		/* device actually removed */
 #define RAID_CTLR_LUNID "\0\0\0\0\0\0\0\0"
 	unsigned char device_id[16];    /* from inquiry pg. 0x83 */
 	u64 sas_address;

