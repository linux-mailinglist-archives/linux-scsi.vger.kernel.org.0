Return-Path: <linux-scsi+bounces-11676-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6775FA1941D
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Jan 2025 15:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D5B3A1D64
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Jan 2025 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9633214214;
	Wed, 22 Jan 2025 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ftNktYOq"
X-Original-To: linux-scsi@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925091F94A;
	Wed, 22 Jan 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556737; cv=none; b=TimbdI69k+cMejLxdNvLffebnuuKHt87I/zlgAGr7l4fkEcX3kLpaIPYxN0dgaRjogFm4QQM19EXLnN4fhkc5PnbDDk4gFBigzxUrvHYmi9CWcrkq3nbYVulbyJ3j3mWlee+W3N+77s7hYzqXrt8n/gqPeknvZijZZ13lqWVEXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556737; c=relaxed/simple;
	bh=JIXXb4VR7cSSmfX8H0HaQkKqzEbRkLvxUDpomKCNzFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CVK0Y/64Ch9XF+mHHxkrSFOuzizcyUcN/Pi4twM5XTAAhl2R8zCTHUpH034nfRi3HDMp67JZW/s0EpF32wtLWBjA11z2V3g96lHq2AXgJYMNwFkHhqZ9F9u6X8JeWEmQ8Yv68kPKdgTVhgTIiZHkH9naqCcHf41Oele16V7230A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ftNktYOq; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737556736; x=1769092736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JIXXb4VR7cSSmfX8H0HaQkKqzEbRkLvxUDpomKCNzFw=;
  b=ftNktYOquHzXgN4v2wmuKWBVHyvUIc8LnyYkIi9OE3zCqerlDVq72lK7
   Y4RmtBYmtEWN9T02nOA/XvmvaornZgXbHG2ucsj9zbCyAtwmTRhCTmKSP
   b/4HKsKLS9IL246ozX+94OZ4oI4N0b0CZWtzgtGmOZlFwRm5Lonfh0o3h
   fyucv6a+B5rbsOvg6RAwZQpztBxpWFDqFjoX7xL9X7CRqBVOXLAjx8lpt
   sMIHtTiGEvN6d6zHb8/sRs+OlMrGyS0W/kuSepTsq3KiCZ4bh7fLsmCXv
   awfnI7cdeuDCkjj1arT+mXEx2/Mb5XGYwNUjyFJjawZarY8xsQSIhNrvF
   Q==;
X-CSE-ConnectionGUID: PR25BGZAR42lNzEMS/1yYg==
X-CSE-MsgGUID: ugiq2wA9SkOiKPA7UiiaPw==
X-IronPort-AV: E=Sophos;i="6.13,225,1732550400"; 
   d="scan'208";a="36527780"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2025 22:38:50 +0800
IronPort-SDR: 6790f561_JyCXd7wBUr3317NJ0/22SXZfsXFJk5Y8W4uZWRN2FhpjPYO
 L5LeNLNMAdw2Aqb/oekg5co/i8RsMdYeqko5EAA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2025 05:40:49 -0800
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2025 06:38:47 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manisadhasivam.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Can Guo <cang@qti.qualcomm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] scsi: ufs: Move clock gating sysfs entries to ufs-sysfs.c
Date: Wed, 22 Jan 2025 16:36:05 +0200
Message-Id: <20250122143605.3804506-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit moves the clock gating sysfs entries from `ufshcd.c` to
`ufs-sysfs.c` where it belongs. This change improves the organization of
the code by consolidating all sysfs-related code into a single file.

The `clkgate_enable` and `clkgate_delay_ms` attributes are now defined
and managed in `ufs-sysfs.c`, and the corresponding initialization and
removal functions in `ufshcd.c` are removed.

No functional change.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufs-sysfs.c | 62 ++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c    | 85 ------------------------------------
 2 files changed, 62 insertions(+), 85 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 796e37a1d859..dd0db44b18a6 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -458,6 +458,64 @@ static ssize_t pm_qos_enable_store(struct device *dev,
 	return count;
 }
 
+static ssize_t
+clkgate_enable_show(struct device *dev, struct device_attribute *attr,
+		    char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->clk_gating.is_enabled);
+}
+
+static ssize_t
+clkgate_enable_store(struct device *dev, struct device_attribute *attr,
+		     const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u32 value;
+
+	if (kstrtou32(buf, 0, &value))
+		return -EINVAL;
+
+	value = !!value;
+
+	guard(spinlock_irqsave)(&hba->clk_gating.lock);
+
+	if (value == hba->clk_gating.is_enabled)
+		return count;
+
+	if (value)
+		ufshcd_release(hba);
+	else
+		hba->clk_gating.active_reqs++;
+
+	hba->clk_gating.is_enabled = value;
+
+	return count;
+}
+
+static ssize_t
+clkgate_delay_ms_show(struct device *dev, struct device_attribute *attr,
+		      char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", hba->clk_gating.delay_ms);
+}
+
+static ssize_t
+clkgate_delay_ms_store(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
+{
+	unsigned long value;
+
+	if (kstrtoul(buf, 0, &value))
+		return -EINVAL;
+
+	ufshcd_clkgate_delay_set(dev, value);
+	return count;
+}
+
 static DEVICE_ATTR_RW(rpm_lvl);
 static DEVICE_ATTR_RO(rpm_target_dev_state);
 static DEVICE_ATTR_RO(rpm_target_link_state);
@@ -470,6 +528,8 @@ static DEVICE_ATTR_RW(enable_wb_buf_flush);
 static DEVICE_ATTR_RW(wb_flush_threshold);
 static DEVICE_ATTR_RW(rtc_update_ms);
 static DEVICE_ATTR_RW(pm_qos_enable);
+static DEVICE_ATTR_RW(clkgate_delay_ms);
+static DEVICE_ATTR_RW(clkgate_enable);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -484,6 +544,8 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_wb_flush_threshold.attr,
 	&dev_attr_rtc_update_ms.attr,
 	&dev_attr_pm_qos_enable.attr,
+	&dev_attr_clkgate_delay_ms.attr,
+	&dev_attr_clkgate_enable.attr,
 	NULL
 };
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f6c38cf10382..901aef52a452 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2019,14 +2019,6 @@ void ufshcd_release(struct ufs_hba *hba)
 }
 EXPORT_SYMBOL_GPL(ufshcd_release);
 
-static ssize_t ufshcd_clkgate_delay_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct ufs_hba *hba = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%lu\n", hba->clk_gating.delay_ms);
-}
-
 void ufshcd_clkgate_delay_set(struct device *dev, unsigned long value)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
@@ -2036,79 +2028,6 @@ void ufshcd_clkgate_delay_set(struct device *dev, unsigned long value)
 }
 EXPORT_SYMBOL_GPL(ufshcd_clkgate_delay_set);
 
-static ssize_t ufshcd_clkgate_delay_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	unsigned long value;
-
-	if (kstrtoul(buf, 0, &value))
-		return -EINVAL;
-
-	ufshcd_clkgate_delay_set(dev, value);
-	return count;
-}
-
-static ssize_t ufshcd_clkgate_enable_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct ufs_hba *hba = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%d\n", hba->clk_gating.is_enabled);
-}
-
-static ssize_t ufshcd_clkgate_enable_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct ufs_hba *hba = dev_get_drvdata(dev);
-	u32 value;
-
-	if (kstrtou32(buf, 0, &value))
-		return -EINVAL;
-
-	value = !!value;
-
-	guard(spinlock_irqsave)(&hba->clk_gating.lock);
-
-	if (value == hba->clk_gating.is_enabled)
-		return count;
-
-	if (value)
-		__ufshcd_release(hba);
-	else
-		hba->clk_gating.active_reqs++;
-
-	hba->clk_gating.is_enabled = value;
-
-	return count;
-}
-
-static void ufshcd_init_clk_gating_sysfs(struct ufs_hba *hba)
-{
-	hba->clk_gating.delay_attr.show = ufshcd_clkgate_delay_show;
-	hba->clk_gating.delay_attr.store = ufshcd_clkgate_delay_store;
-	sysfs_attr_init(&hba->clk_gating.delay_attr.attr);
-	hba->clk_gating.delay_attr.attr.name = "clkgate_delay_ms";
-	hba->clk_gating.delay_attr.attr.mode = 0644;
-	if (device_create_file(hba->dev, &hba->clk_gating.delay_attr))
-		dev_err(hba->dev, "Failed to create sysfs for clkgate_delay\n");
-
-	hba->clk_gating.enable_attr.show = ufshcd_clkgate_enable_show;
-	hba->clk_gating.enable_attr.store = ufshcd_clkgate_enable_store;
-	sysfs_attr_init(&hba->clk_gating.enable_attr.attr);
-	hba->clk_gating.enable_attr.attr.name = "clkgate_enable";
-	hba->clk_gating.enable_attr.attr.mode = 0644;
-	if (device_create_file(hba->dev, &hba->clk_gating.enable_attr))
-		dev_err(hba->dev, "Failed to create sysfs for clkgate_enable\n");
-}
-
-static void ufshcd_remove_clk_gating_sysfs(struct ufs_hba *hba)
-{
-	if (hba->clk_gating.delay_attr.attr.name)
-		device_remove_file(hba->dev, &hba->clk_gating.delay_attr);
-	if (hba->clk_gating.enable_attr.attr.name)
-		device_remove_file(hba->dev, &hba->clk_gating.enable_attr);
-}
-
 static void ufshcd_init_clk_gating(struct ufs_hba *hba)
 {
 	if (!ufshcd_is_clkgating_allowed(hba))
@@ -2126,8 +2045,6 @@ static void ufshcd_init_clk_gating(struct ufs_hba *hba)
 		"ufs_clk_gating_%d", WQ_MEM_RECLAIM | WQ_HIGHPRI,
 		hba->host->host_no);
 
-	ufshcd_init_clk_gating_sysfs(hba);
-
 	hba->clk_gating.is_enabled = true;
 	hba->clk_gating.is_initialized = true;
 }
@@ -2137,8 +2054,6 @@ static void ufshcd_exit_clk_gating(struct ufs_hba *hba)
 	if (!hba->clk_gating.is_initialized)
 		return;
 
-	ufshcd_remove_clk_gating_sysfs(hba);
-
 	/* Ungate the clock if necessary. */
 	ufshcd_hold(hba);
 	hba->clk_gating.is_initialized = false;
-- 
2.25.1


