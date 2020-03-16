Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA1B1865C5
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2020 08:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgCPHkD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Mar 2020 03:40:03 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:3416 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbgCPHkC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 16 Mar 2020 03:40:02 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  viswas.g@microsemi.com designates 208.19.100.22 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.22;
  receiver=esa3.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="viswas.g@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa3.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=viswas.g@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dkim=none (message not signed) header.i=none; dmarc=fail (p=none dis=none) d=microchip.com
IronPort-SDR: 04MLXKwDD9/JV28rmcuOkTOPx1OirpOLkc1aiqVYCOWplYD4hZJiGLjZ1JlYav+5Txe+IZUoh+
 wvIq/twyRLosxJ5FrHsqAV1UonDm2YxPSoJaDhsFtqzIDIoaQqGwAIwYeWc0IHsMFOKdWAa8DQ
 tAPJYsrP3nJLCTax3Q0k52mYfsNcCGW9EYJrSha+hWgei7t4wjiiYiOAKRALoIc9dgcA18WEet
 uyVf1uRN8dpg0SVi0/35gykm9DbCtRJBo3FYd+MrBXvj/WfOpaHcrt26hNRN/SRni4dOqKXOhk
 prk=
X-IronPort-AV: E=Sophos;i="5.70,559,1574146800"; 
   d="scan'208";a="70072415"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2020 00:39:54 -0700
Received: from AVMBX1.microsemi.net (10.100.34.31) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 16 Mar
 2020 00:39:54 -0700
Received: from localhost (10.41.130.51) by avmbx1.microsemi.net (10.100.34.31)
 with Microsoft SMTP Server id 15.1.1847.3 via Frontend Transport; Mon, 16 Mar
 2020 00:39:53 -0700
From:   Deepak Ukey <deepak.ukey@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <deepak.ukey@microchip.com>,
        <jinpu.wang@profitbricks.com>, <martin.petersen@oracle.com>,
        <yuuzheng@google.com>, <auradkar@google.com>,
        <vishakhavc@google.com>, <bjashnani@google.com>,
        <radha@google.com>, <akshatzen@google.com>
Subject: [PATCH V3 1/6] pm80xx : Increase request sg length.
Date:   Mon, 16 Mar 2020 13:19:01 +0530
Message-ID: <20200316074906.9119-2-deepak.ukey@microchip.com>
X-Mailer: git-send-email 2.19.0-rc1
In-Reply-To: <20200316074906.9119-1-deepak.ukey@microchip.com>
References: <20200316074906.9119-1-deepak.ukey@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Peter Chang <dpf@google.com>

Increasing the per-request size maximum (max_sectors_kb) runs into
the per-device dma scatter gather list limit (max_segments) for
users of the io vector system calls (eg, readv and writev). This is
because the kernel combines io vectors into dma segments when
possible, but it doesn't work for our user because the vectors in the
buffer cache get scrambled.
This change bumps the advertised max scatter gather length to 528 to
cover 2M w/ x86's 4k pages and some extra for the user checksum.
It trims the size of some of the tables we don't care about and
exposes all of the command slots upstream to the scsi layer.
Also reduced the PM8001_MAX_CCB to 256 as pm8001 driver has memory
limit depend on machine capability. If we increase the sg length,
we need to trade-off it by decreasing PM8001_MAX_CCB.
PM8001_MAX_CCB = 256 does not have any influence on normal use

Signed-off-by: Peter Chang <dpf@google.com>
Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Signed-off-by: Radha Ramachandran <radha@google.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/scsi/pm8001/pm8001_defs.h | 5 +++--
 drivers/scsi/pm8001/pm8001_init.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_defs.h b/drivers/scsi/pm8001/pm8001_defs.h
index 48e0624ecc68..1c7f15fd69ce 100644
--- a/drivers/scsi/pm8001/pm8001_defs.h
+++ b/drivers/scsi/pm8001/pm8001_defs.h
@@ -75,7 +75,7 @@ enum port_type {
 };
 
 /* driver compile-time configuration */
-#define	PM8001_MAX_CCB		 512	/* max ccbs supported */
+#define	PM8001_MAX_CCB		 256	/* max ccbs supported */
 #define PM8001_MPI_QUEUE         1024   /* maximum mpi queue entries */
 #define	PM8001_MAX_INB_NUM	 1
 #define	PM8001_MAX_OUTB_NUM	 1
@@ -99,7 +99,8 @@ enum port_type {
 #define OB			(CI + PM8001_MAX_SPCV_INB_NUM)
 #define PI			(OB + PM8001_MAX_SPCV_OUTB_NUM)
 #define USI_MAX_MEMCNT		(PI + PM8001_MAX_SPCV_OUTB_NUM)
-#define PM8001_MAX_DMA_SG	SG_ALL
+#define	CONFIG_SCSI_PM8001_MAX_DMA_SG	528
+#define PM8001_MAX_DMA_SG	CONFIG_SCSI_PM8001_MAX_DMA_SG
 enum memory_region_num {
 	AAP1 = 0x0, /* application acceleration processor */
 	IOP,	    /* IO processor */
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index ff618ad80ebd..3f1e755c52c6 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -95,7 +95,7 @@ static struct scsi_host_template pm8001_sht = {
 	.bios_param		= sas_bios_param,
 	.can_queue		= 1,
 	.this_id		= -1,
-	.sg_tablesize		= SG_ALL,
+	.sg_tablesize		= PM8001_MAX_DMA_SG,
 	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
 	.eh_device_reset_handler = sas_eh_device_reset_handler,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
-- 
2.16.3

