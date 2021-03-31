Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C994E347E46
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Mar 2021 17:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhCXQye (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Mar 2021 12:54:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17488 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbhCXQyW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 24 Mar 2021 12:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616604862; x=1648140862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yAWd8gmP5eMRM29p10AtrxYxyb6TUyucLv05sC/FTi0=;
  b=1nAhlimff5w58G/cSiE3I4sc/hW5scuo5cxvwJGL5vp3E6Ta08DfIJUS
   OABVdo5AgkMYD19heoN7gyK24umptAyG29F3sBGx5WihmOUD6FV8sg0Ra
   qF7SoiD2dzWBV6YJCfsQToJUEk1eq9laa3ygMlAjsIX6KUPsvJ/56ZrvD
   lVqws+xsCXcKUiUyE5NLoLMr1IVp36yEghn7Ebm030sj3snTAAEIwsX9c
   AfdRYMmNqW1JmAkBy3xT0c3DW24V4PlEtjqhwsnLpdw7DdXoauF9LJltc
   tQkD6rFLaw48HTGHjsraJ7EQ63Ie5RAu721MaQZutK4aGhcKW7m5PrN6p
   w==;
IronPort-SDR: APJAmuf71tz6KYpIBI2LiPgqxk9wjfZMkt0D0MI12SJFqMHkQuXFmXJPOOYRbBM4OXUGgfdSKz
 JTNnGcey7iOUSVU+xJ5z4PafRsuAd6o8nnqehItlasQCaedI92qKKArojLGh7yIAqv2EXdDuyK
 ZZ2pg0PSQG0IsRn2T4Tten31g/BgsWq/aC9ldmdwVxqjHGfrpfq5c2QRkp2cmDIS/IMbHa2pbr
 MVV5D8Q2BaTD2RJ1Ca8XqDgOPcuhO24kJwu760FBMEqUPR5JEjKS8mW6lcdlBr1KA5HwNVqTfn
 104=
X-IronPort-AV: E=Sophos;i="5.81,275,1610434800"; 
   d="scan'208";a="111203603"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2021 09:54:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 09:54:21 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 24 Mar 2021 09:54:21 -0700
From:   Viswas G <Viswas.G@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <Ruksar.devadi@microchip.com>,
        <vishakhavc@google.com>, <radha@google.com>,
        <jinpu.wang@cloud.ionos.com>,
        Ashokkumar N <Ashokkumar.N@microchip.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 2/7] pm80xx: Add sysfs attribute to track RAAE count
Date:   Wed, 24 Mar 2021 22:33:52 +0530
Message-ID: <20210324170357.9765-3-Viswas.G@microchip.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20210324170357.9765-1-Viswas.G@microchip.com>
References: <20210324170357.9765-1-Viswas.G@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Vishakha Channapattan <vishakhavc@google.com>

A new sysfs variable 'ctl_raae_count' is being introduced that tells if
the controller is alive by indicating controller ticks. If on subsequent
run we see the ticks changing in RAAE count that indicates that
controller is not dead.

Tested: Using 'ctl_raae_count' sysfs variable we can see ticks
incrementing
mvae14:~# cat  /sys/class/scsi_host/host*/ctl_raae_count
0x00002245
0x00002253
0x0000225e

Signed-off-by: Vishakha Channapattan <vishakhavc@google.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Signed-off-by: Ruksar Devadi <Ruksar.devadi@microchip.com>
Signed-off-by: Ashokkumar N <Ashokkumar.N@microchip.com>
Signed-off-by: Radha Ramachandran <radha@google.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index ce4846b1377c..98e5b47b9bb7 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -918,6 +918,29 @@ static ssize_t ctl_mpi_state_show(struct device *cdev,
 }
 static DEVICE_ATTR_RO(ctl_mpi_state);
 
+/**
+ * ctl_raae_count_show - controller raae count check
+ * @cdev: pointer to embedded class device
+ * @buf: the buffer returned
+ *
+ * A sysfs 'read-only' shost attribute.
+ */
+
+static ssize_t ctl_raae_count_show(struct device *cdev,
+		struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(cdev);
+	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
+	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
+	unsigned int raaecnt;
+	int c;
+
+	raaecnt = pm8001_mr32(pm8001_ha->general_stat_tbl_addr, 12);
+	c = sysfs_emit(buf, "0x%08x\n", raaecnt);
+	return c;
+}
+static DEVICE_ATTR_RO(ctl_raae_count);
+
 struct device_attribute *pm8001_host_attrs[] = {
 	&dev_attr_interface_rev,
 	&dev_attr_controller_fatal_error,
@@ -942,6 +965,7 @@ struct device_attribute *pm8001_host_attrs[] = {
 	&dev_attr_ila_version,
 	&dev_attr_inc_fw_ver,
 	&dev_attr_ctl_mpi_state,
+	&dev_attr_ctl_raae_count,
 	NULL,
 };
 
-- 
2.16.3

