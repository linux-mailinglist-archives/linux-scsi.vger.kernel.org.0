Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1BEE50472
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfFXIWV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 04:22:21 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6316 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfFXIWV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 04:22:21 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  viswas.g@microsemi.com designates 208.19.99.222 as permitted
  sender) identity=mailfrom; client-ip=208.19.99.222;
  receiver=esa2.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="viswas.g@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.99.222; receiver=esa2.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=viswas.g@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,411,1557212400"; 
   d="scan'208";a="38607862"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.99.222])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jun 2019 01:22:15 -0700
Received: from AUSMBX1.microsemi.net (10.201.34.31) by AUSMBX2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Jun
 2019 03:22:14 -0500
Received: from localhost (10.41.130.49) by ausmbx1.microsemi.net
 (10.201.34.31) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 24 Jun 2019 03:22:13 -0500
From:   Deepak Ukey <deepak.ukey@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microcchip.com>, <deepak.ukey@microchip.com>,
        <jinpu.wang@profitbricks.com>, <martin.petersen@oracle.com>
Subject: [PATCH 2/3] pm80xx : Event log size through sysfs.
Date:   Mon, 24 Jun 2019 13:52:27 +0530
Message-ID: <20190624082228.27433-3-deepak.ukey@microchip.com>
X-Mailer: git-send-email 2.19.0-rc1
In-Reply-To: <20190624082228.27433-1-deepak.ukey@microchip.com>
References: <20190624082228.27433-1-deepak.ukey@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Added support to read event log size from MPI configuration table
and export through sysfs.

Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index d193961..c7e0a42c 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -462,6 +462,24 @@ static ssize_t pm8001_ctl_bios_version_show(struct device *cdev,
 }
 static DEVICE_ATTR(bios_version, S_IRUGO, pm8001_ctl_bios_version_show, NULL);
 /**
+ * event_log_size_show - event log size
+ * @cdev: pointer to embedded class device
+ * @buf: the buffer returned
+ *
+ * A sysfs read  shost attribute.
+ */
+static ssize_t event_log_size_show(struct device *cdev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(cdev);
+	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
+	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+		pm8001_ha->main_cfg_tbl.pm80xx_tbl.event_log_size);
+}
+static DEVICE_ATTR_RO(event_log_size);
+/**
  * pm8001_ctl_aap_log_show - IOP event log
  * @cdev: pointer to embedded class device
  * @buf: the buffer returned
@@ -796,6 +814,7 @@ struct device_attribute *pm8001_host_attrs[] = {
 	&dev_attr_max_sg_list,
 	&dev_attr_sas_spec_support,
 	&dev_attr_logging_level,
+	&dev_attr_event_log_size,
 	&dev_attr_host_sas_address,
 	&dev_attr_bios_version,
 	&dev_attr_ib_log,
-- 
1.8.5.6

