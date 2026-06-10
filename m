Return-Path: <linux-scsi+bounces-24647-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zrZgI8BqKWoGWgMAu9opvQ
	(envelope-from <linux-scsi+bounces-24647-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 15:46:40 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1253D669E66
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 15:46:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=LlSRZUQ7;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24647-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24647-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30AFD3104C59
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EBD40B379;
	Wed, 10 Jun 2026 13:43:25 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DB3E314E
	for <linux-scsi@vger.kernel.org>; Wed, 10 Jun 2026 13:43:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099004; cv=none; b=oHBELzeuPo/zL8iwHBmavKzi3EUJ/AKMt+8QYnREcdrUUjLSPDWptgR8d4DHv77M7ReXr1gC07PvlHguray1h0tpG9XCTK9ZP5vLlIticiovo7o23QL3lyWjXR7eOMxB/LJGbsNDEjYc2Ze6TIUy4+29bFDujxuvo4bfE1zo43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099004; c=relaxed/simple;
	bh=tKPjeKXFqdUI1bUCwdrab6jQmOu3Im24bfVhatoQKPQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RxdNce4Ylt0JEr/Zru1w3T5mPh16UoJFhUbzImSO42Z50ZkDqEt4uNQ131EvyJ6pErUdbZxQdOZC46/NhHM/VcLwYHvrmVu4TOQdcZe6s2ZidSRQHJBC0/J+DbKTkpe6mu7EE5VfuXQ5LDrcEy8PC8erLl5DZk5bns5ovxJK9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LlSRZUQ7; arc=none smtp.client-ip=74.125.82.74
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13815cb1507so11435553c88.0
        for <linux-scsi@vger.kernel.org>; Wed, 10 Jun 2026 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781099001; x=1781703801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GrehnnAjFDeZRq62mB1caOgxAL52h6MoL3yIydBalJU=;
        b=LlSRZUQ770oKz/1D1vRHH8tqF0zQBKHXjd5FkiD/XVMCodRfaFtMdt3kFRUYoOoXyT
         6n3vhiUV5+fpJLsGn9DTUOFuqu/UBdxH9Pq3GXpIHdfo5brfo1vPGFQms8XRpj3xAKcN
         +LTsz/51umPinf3Bfysj8J2fPyXAUrko/IJATb2NIaaStuFYfWoTtccO2UG0rzHVNAzp
         tFrAv3zJEsrcz4j0HxFUCnXNcU1f0hXRgZORCIre+wivirQSliAX2FnIlObV1x3qnr9w
         aCRE4M+oSqSg2qi7nesU6W+ngggh5XYqdfEgG+6CmkAy207fkQMIgWiDmer7D/8zqgo7
         gFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099001; x=1781703801;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrehnnAjFDeZRq62mB1caOgxAL52h6MoL3yIydBalJU=;
        b=FfjIK89AmTlGzLCwXAOkTL34YjWIiMnCd4cBaLop9cKUYzRrNR8Wfi/XT24tBTJnLt
         7T6yvzMPaGdX3wRPC/IF7tuNuhb+EgTnoB7HAzQ5cCm9AFy+hlCwtA7RR5G2BIo+0L6a
         PU8PQmAQxF9zdfx26fGVEtScBSPAz6zbI//d6oOeEkOcGQcEABb4LVlKzgiMX6I0VR6P
         hTEQB+n5bdSpypHkSyzE7zD3G4hcw5j4XyNFZsiNsC3a6Bq+mXxRN/aqIivSffq007B9
         4lQFD5Uf/H3g8LQTA3acMoTJiOhr1vIo8Lw5Cnh3x1F3nvGKEcbcQXeawH58uj/spyr/
         jxPw==
X-Forwarded-Encrypted: i=1; AFNElJ/U1ZiXAxYG5ImKqTG8aQ116Aq/e18fiNidfM6N9w4wH+slBgdRi28Ejb8QU/x3B9exbGpKE7fo3D5n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Q2uyBoXXkRhyDg2q7mOoqGD+cdqaXUu+jwyy3ZFggR3VWgpK
	G5EhGtHIQ7Xeh2Uoqea+aVzLC5wt62REzimxtNGPlB2pRw3U2tUmj3XDC8n3EpxYQ7+7FB/5fgl
	dE3NY4rM80w==
X-Received: from dld33.prod.google.com ([2002:a05:7022:321:b0:138:281:799f])
 (user=chullee job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2528:b0:137:fad9:397c
 with SMTP id a92af1059eb24-138066d7575mr16111510c88.12.1781099000383; Wed, 10
 Jun 2026 06:43:20 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:43:16 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610134316.990430-1-chullee@google.com>
Subject: [PATCH v2] ufs: sysfs: Add WB partial flush mode support
From: Daniel Lee <chullee@google.com>
To: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, 
	tanghuan@vivo.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chullee@google.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24647-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:bvanassche@acm.org,m:tanghuan@vivo.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chullee@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[chullee@google.com,linux-scsi@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chullee@google.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1253D669E66

Expose the following JEDEC UFS 4.1 Extended WriteBooster attributes and
flags to sysfs to support FIFO and Pinned partial flush modes:

  - wb_partial_flush_mode
  - wb_max_fifo_size
  - wb_cur_fifo_size
  - wb_pinned_cur_size
  - wb_pinned_avail_pct
  - wb_pinned_cumulative_write_size
  - wb_pinned_size
  - wb_non_pinned_min_size
  - wb_unpin_enable

Introduce UFS_ATTRIBUTE_RW and UFS_FLAG_RW to support writable attributes
and flags.
Document the new entries under Documentation/ABI/testing/sysfs-driver-ufs.

Assisted-by: Gemini:gemini-3.1
Signed-off-by: Daniel Lee <chullee@google.com>
---
v2:
- Change wb_partial_flush_mode attribute to accept and report strings instead of numbers for better usability.
- Order local variable declarations from longest to shortest in new functions.

 Documentation/ABI/testing/sysfs-driver-ufs |  85 ++++++
 drivers/ufs/core/ufs-sysfs.c               | 326 +++++++++++++++++----
 include/ufs/ufs.h                          |  18 ++
 3 files changed, 366 insertions(+), 63 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 3c422aac778b..32dd38ebaef7 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1791,3 +1791,88 @@ Description:
 		will be rejected.
 
 		The attribute is read/write.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_partial_flush_mode
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_partial_flush_mode
+Date:		June 2026
+Contact:	Daniel Lee <chullee@google.com>
+Description:	This entry controls Extended WriteBooster partial flush modes.
+
+		======== ==============================
+		"none"   No partial flush
+		"fifo"   FIFO mode
+		"pinned" Pinned mode
+		======== ==============================
+
+		The attribute is read-write.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_max_fifo_size
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_max_fifo_size
+Date:		June 2026
+Contact:	Daniel Lee <chullee@google.com>
+Description:	This entry configures the maximum size in Allocation Units reserved for the
+		WriteBooster FIFO Buffer size.
+		The attribute is read-write.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_cur_fifo_size
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_cur_fifo_size
+Date:		June 2026
+Contact:	Daniel Lee <chullee@google.com>
+Description:	This entry shows the current size in Allocation Units of the WriteBooster FIFO
+		Buffer size.
+		The attribute is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_pinned_size
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_pinned_size
+Date:		June 2026
+Contact:	Daniel Lee <chullee@google.com>
+Description:	This entry configures the allocated size in Allocation Units for the UFS
+		Pinned WriteBooster buffer.
+		The attribute is read-write.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_pinned_cur_size
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_pinned_cur_size
+Date:		June 2026
+Contact:	Daniel Lee <chullee@google.com>
+Description:	This entry shows the current allocated size in Allocation Units for the UFS
+		Pinned WriteBooster buffer.
+		The attribute is read-only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_pinned_avail_pct
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_pinned_avail_pct
+Date:		June 2026
+Contact:	Daniel Lee <chullee@google.com>
+Description:	This entry shows the percentage of available space remaining in the
+		Pinned WriteBooster buffer.
+		The attribute is read-only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_pinned_cumulative_write_size
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_pinned_cumulative_write_size
+Date:		June 2026
+Contact:	Daniel Lee <chullee@google.com>
+Description:	This entry shows the total cumulative size of data written to the
+		Pinned WriteBooster buffer.
+		The attribute is read-only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_non_pinned_min_size
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_non_pinned_min_size
+Date:		June 2026
+Contact:	Daniel Lee <chullee@google.com>
+Description:	This entry configures the minimum size in Allocation Units for the
+		Non-Pinned WriteBooster Buffer area when Pinned partial flush mode is active.
+		The attribute is read-write.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/flags/wb_unpin_enable
+What:		/sys/bus/platform/devices/*.ufs/flags/wb_unpin_enable
+Date:		June 2026
+Contact:	Daniel Lee <chullee@google.com>
+Description:	This entry controls the Pinned WriteBooster unpin enable flag (fUnpinEn).
+
+		======   ==============================================================
+		0        Unpin Disable: pinned data is not flushed by WriteBooster
+		         Buffer flush operation.
+		1        Unpin Enable: pinned data is flushed by WriteBooster
+		         Buffer flush operation.
+		======   ==============================================================
+
+		The attribute is read-write.
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index d9dc4cc3452e..5721b35b74fb 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -88,6 +88,21 @@ static const char *ufs_wb_resize_status_to_string(enum wb_resize_status status)
 	}
 }
 
+static const char * const wb_partial_flush_modes[] = {
+	[WB_PARTIAL_FLUSH_NONE]		= "none",
+	[WB_PARTIAL_FLUSH_FIFO]		= "fifo",
+	[WB_PARTIAL_FLUSH_PINNED]	= "pinned",
+};
+
+static const char *ufs_wb_pfm_to_string(u32 pfm)
+{
+	if (pfm < NUM_WB_PARTIAL_FLUSH_MODES)
+		return wb_partial_flush_modes[pfm];
+
+	return "unknown";
+}
+
+
 static const char * const ufs_hid_states[] = {
 	[HID_IDLE]		= "idle",
 	[ANALYSIS_IN_PROGRESS]	= "analysis_in_progress",
@@ -1527,41 +1542,98 @@ static const struct attribute_group ufs_sysfs_string_descriptors_group = {
 
 static inline bool ufshcd_is_wb_flags(enum flag_idn idn)
 {
-	return idn >= QUERY_FLAG_IDN_WB_EN &&
-		idn <= QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8;
+	return (idn >= QUERY_FLAG_IDN_WB_EN &&
+		idn <= QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8) ||
+	       idn == QUERY_FLAG_IDN_WB_UNPIN_EN;
+}
+
+static ssize_t ufs_sysfs_flag_show(struct device *dev,
+	struct device_attribute *attr, char *buf, enum flag_idn idn)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u8 index = 0;
+	bool flag;
+	int ret;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		up(&hba->host_sem);
+		return -EBUSY;
+	}
+	if (ufshcd_is_wb_flags(idn))
+		index = ufshcd_wb_get_query_index(hba);
+	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_READ_FLAG,
+		idn, index, &flag);
+	ufshcd_rpm_put_sync(hba);
+	if (ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = sysfs_emit(buf, "%s\n", str_true_false(flag));
+out:
+	up(&hba->host_sem);
+	return ret;
+}
+
+static ssize_t ufs_sysfs_flag_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count,
+	enum flag_idn idn)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u8 index = 0;
+	bool value;
+	int ret;
+
+	if (kstrtobool(buf, &value))
+		return -EINVAL;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		up(&hba->host_sem);
+		return -EBUSY;
+	}
+	if (ufshcd_is_wb_flags(idn))
+		index = ufshcd_wb_get_query_index(hba);
+	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_query_flag(hba,
+		value ? UPIU_QUERY_OPCODE_SET_FLAG : UPIU_QUERY_OPCODE_CLEAR_FLAG,
+		idn, index, NULL);
+	ufshcd_rpm_put_sync(hba);
+	if (ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+out:
+	up(&hba->host_sem);
+	return ret ? ret : count;
 }
 
 #define UFS_FLAG(_name, _uname)						\
 static ssize_t _name##_show(struct device *dev,				\
 	struct device_attribute *attr, char *buf)			\
 {									\
-	bool flag;							\
-	u8 index = 0;							\
-	int ret;							\
-	struct ufs_hba *hba = dev_get_drvdata(dev);			\
-									\
-	down(&hba->host_sem);						\
-	if (!ufshcd_is_user_access_allowed(hba)) {			\
-		up(&hba->host_sem);					\
-		return -EBUSY;						\
-	}								\
-	if (ufshcd_is_wb_flags(QUERY_FLAG_IDN##_uname))			\
-		index = ufshcd_wb_get_query_index(hba);			\
-	ufshcd_rpm_get_sync(hba);					\
-	ret = ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_READ_FLAG,	\
-		QUERY_FLAG_IDN##_uname, index, &flag);			\
-	ufshcd_rpm_put_sync(hba);					\
-	if (ret) {							\
-		ret = -EINVAL;						\
-		goto out;						\
-	}								\
-	ret = sysfs_emit(buf, "%s\n", str_true_false(flag));		\
-out:									\
-	up(&hba->host_sem);						\
-	return ret;							\
+	return ufs_sysfs_flag_show(dev, attr, buf,			\
+				   QUERY_FLAG_IDN##_uname);		\
 }									\
 static DEVICE_ATTR_RO(_name)
 
+#define UFS_FLAG_RW(_name, _uname)					\
+static ssize_t _name##_show(struct device *dev,				\
+	struct device_attribute *attr, char *buf)			\
+{									\
+	return ufs_sysfs_flag_show(dev, attr, buf,			\
+				   QUERY_FLAG_IDN##_uname);		\
+}									\
+static ssize_t _name##_store(struct device *dev,			\
+	struct device_attribute *attr, const char *buf, size_t count)	\
+{									\
+	return ufs_sysfs_flag_store(dev, attr, buf, count,		\
+				    QUERY_FLAG_IDN##_uname);		\
+}									\
+static DEVICE_ATTR_RW(_name)
+
+
 UFS_FLAG(device_init, _FDEVICEINIT);
 UFS_FLAG(permanent_wpe, _PERMANENT_WPE);
 UFS_FLAG(power_on_wpe, _PWR_ON_WPE);
@@ -1573,6 +1645,7 @@ UFS_FLAG(disable_fw_update, _PERMANENTLY_DISABLE_FW_UPDATE);
 UFS_FLAG(wb_enable, _WB_EN);
 UFS_FLAG(wb_flush_en, _WB_BUFF_FLUSH_EN);
 UFS_FLAG(wb_flush_during_h8, _WB_BUFF_FLUSH_DURING_HIBERN8);
+UFS_FLAG_RW(wb_unpin_enable, _WB_UNPIN_EN);
 
 static struct attribute *ufs_sysfs_device_flags[] = {
 	&dev_attr_device_init.attr,
@@ -1586,6 +1659,7 @@ static struct attribute *ufs_sysfs_device_flags[] = {
 	&dev_attr_wb_enable.attr,
 	&dev_attr_wb_flush_en.attr,
 	&dev_attr_wb_flush_during_h8.attr,
+	&dev_attr_wb_unpin_enable.attr,
 	NULL,
 };
 
@@ -1671,10 +1745,14 @@ static DEVICE_ATTR_RW(max_number_of_rtt);
 
 static inline bool ufshcd_is_wb_attrs(enum attr_idn idn)
 {
-	return idn >= QUERY_ATTR_IDN_WB_FLUSH_STATUS &&
-		idn <= QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE;
+	return (idn >= QUERY_ATTR_IDN_WB_FLUSH_STATUS &&
+		idn <= QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE) ||
+	       (idn >= QUERY_ATTR_IDN_WB_PFM &&
+		idn <= QUERY_ATTR_IDN_NON_PINNED_WB_MIN_SIZE);
 }
 
+
+
 static inline bool ufshcd_is_qword_attr(enum attr_idn idn)
 {
 	return idn == QUERY_ATTR_IDN_TIMESTAMP ||
@@ -1742,48 +1820,101 @@ static ssize_t wb_resize_status_show(struct device *dev,
 
 static DEVICE_ATTR_RO(wb_resize_status);
 
+static ssize_t ufs_sysfs_attr_show(struct device *dev,
+	struct device_attribute *attr, char *buf, enum attr_idn idn)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u64 qword_value;
+	u8 index = 0;
+	u32 value;
+	int ret;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		up(&hba->host_sem);
+		return -EBUSY;
+	}
+	if (ufshcd_is_wb_attrs(idn))
+		index = ufshcd_wb_get_query_index(hba);
+	ufshcd_rpm_get_sync(hba);
+	if (ufshcd_is_qword_attr(idn))
+		ret = ufshcd_query_attr_qword(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			idn, index, 0, &qword_value);
+	else
+		ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			idn, index, 0, &value);
+	ufshcd_rpm_put_sync(hba);
+	if (ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (ufshcd_is_qword_attr(idn))
+		ret = sysfs_emit(buf, "0x%016llX\n", qword_value);
+	else
+		ret = sysfs_emit(buf, "0x%08X\n", value);
+out:
+	up(&hba->host_sem);
+	return ret;
+}
+
+static ssize_t ufs_sysfs_attr_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count,
+	enum attr_idn idn)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u8 index = 0;
+	u32 value;
+	int ret;
+
+	if (kstrtou32(buf, 0, &value))
+		return -EINVAL;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		up(&hba->host_sem);
+		return -EBUSY;
+	}
+	if (ufshcd_is_wb_attrs(idn))
+		index = ufshcd_wb_get_query_index(hba);
+	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+		idn, index, 0, &value);
+	ufshcd_rpm_put_sync(hba);
+	if (ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+out:
+	up(&hba->host_sem);
+	return ret ? ret : count;
+}
+
 #define UFS_ATTRIBUTE(_name, _uname)					\
 static ssize_t _name##_show(struct device *dev,				\
 	struct device_attribute *attr, char *buf)			\
 {									\
-	struct ufs_hba *hba = dev_get_drvdata(dev);			\
-	u64 qword_value;						\
-	u32 value;							\
-	int ret;							\
-	u8 index = 0;							\
-									\
-	down(&hba->host_sem);						\
-	if (!ufshcd_is_user_access_allowed(hba)) {			\
-		up(&hba->host_sem);					\
-		return -EBUSY;						\
-	}								\
-	if (ufshcd_is_wb_attrs(QUERY_ATTR_IDN##_uname))			\
-		index = ufshcd_wb_get_query_index(hba);			\
-	ufshcd_rpm_get_sync(hba);					\
-	if (ufshcd_is_qword_attr(QUERY_ATTR_IDN##_uname))		\
-		ret = ufshcd_query_attr_qword(hba,			\
-			UPIU_QUERY_OPCODE_READ_ATTR,			\
-			QUERY_ATTR_IDN##_uname,				\
-			index, 0, &qword_value);			\
-	else								\
-		ret = ufshcd_query_attr(hba,				\
-			UPIU_QUERY_OPCODE_READ_ATTR,			\
-			QUERY_ATTR_IDN##_uname, index, 0, &value);	\
-	ufshcd_rpm_put_sync(hba);					\
-	if (ret) {							\
-		ret = -EINVAL;						\
-		goto out;						\
-	}								\
-	if (ufshcd_is_qword_attr(QUERY_ATTR_IDN##_uname))		\
-		ret = sysfs_emit(buf, "0x%016llX\n", qword_value);	\
-	else								\
-		ret = sysfs_emit(buf, "0x%08X\n", value);		\
-out:									\
-	up(&hba->host_sem);						\
-	return ret;							\
+	return ufs_sysfs_attr_show(dev, attr, buf,			\
+				   QUERY_ATTR_IDN##_uname);		\
 }									\
 static DEVICE_ATTR_RO(_name)
 
+#define UFS_ATTRIBUTE_RW(_name, _uname)					\
+static ssize_t _name##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	return ufs_sysfs_attr_show(dev, attr, buf,			\
+				   QUERY_ATTR_IDN##_uname);		\
+}									\
+static ssize_t _name##_store(struct device *dev,			\
+			     struct device_attribute *attr,		\
+			     const char *buf, size_t count)		\
+{									\
+	return ufs_sysfs_attr_store(dev, attr, buf, count,		\
+				    QUERY_ATTR_IDN##_uname);		\
+}									\
+static DEVICE_ATTR_RW(_name)
+
+
 UFS_ATTRIBUTE(boot_lun_enabled, _BOOT_LU_EN);
 UFS_ATTRIBUTE(current_power_mode, _POWER_MODE);
 UFS_ATTRIBUTE(active_icc_level, _ACTIVE_ICC_LVL);
@@ -1804,6 +1935,67 @@ UFS_ATTRIBUTE(wb_avail_buf, _AVAIL_WB_BUFF_SIZE);
 UFS_ATTRIBUTE(wb_life_time_est, _WB_BUFF_LIFE_TIME_EST);
 UFS_ATTRIBUTE(wb_cur_buf, _CURR_WB_BUFF_SIZE);
 
+static ssize_t wb_partial_flush_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u32 value;
+	int ret;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		up(&hba->host_sem);
+		return -EBUSY;
+	}
+	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+		QUERY_ATTR_IDN_WB_PFM, ufshcd_wb_get_query_index(hba), 0, &value);
+	ufshcd_rpm_put_sync(hba);
+	up(&hba->host_sem);
+	if (ret)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", ufs_wb_pfm_to_string(value));
+}
+
+static ssize_t wb_partial_flush_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u32 value;
+	int mode;
+	int ret;
+
+	mode = sysfs_match_string(wb_partial_flush_modes, buf);
+	if (mode < 0)
+		return -EINVAL;
+
+	value = mode;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		up(&hba->host_sem);
+		return -EBUSY;
+	}
+	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+		QUERY_ATTR_IDN_WB_PFM, ufshcd_wb_get_query_index(hba), 0, &value);
+	ufshcd_rpm_put_sync(hba);
+	up(&hba->host_sem);
+
+	return ret ? -EINVAL : count;
+}
+
+static DEVICE_ATTR_RW(wb_partial_flush_mode);
+UFS_ATTRIBUTE_RW(wb_max_fifo_size, _MAX_FIFO_SIZE_WB_PFM);
+UFS_ATTRIBUTE(wb_cur_fifo_size, _CURRENT_FIFO_SIZE_WB_PFM);
+UFS_ATTRIBUTE(wb_pinned_cur_size, _PINNED_WB_CURRENT_SIZE);
+UFS_ATTRIBUTE(wb_pinned_avail_pct, _PINNED_WB_AVAIL_PERC);
+UFS_ATTRIBUTE(wb_pinned_cumulative_write_size, _PINNED_WB_CUMMULATIVE_WS);
+UFS_ATTRIBUTE_RW(wb_pinned_size, _PINNED_WB_SIZE);
+UFS_ATTRIBUTE_RW(wb_non_pinned_min_size, _NON_PINNED_WB_MIN_SIZE);
+
 
 static struct attribute *ufs_sysfs_attributes[] = {
 	&dev_attr_boot_lun_enabled.attr,
@@ -1828,6 +2020,14 @@ static struct attribute *ufs_sysfs_attributes[] = {
 	&dev_attr_wb_cur_buf.attr,
 	&dev_attr_wb_resize_hint.attr,
 	&dev_attr_wb_resize_status.attr,
+	&dev_attr_wb_partial_flush_mode.attr,
+	&dev_attr_wb_max_fifo_size.attr,
+	&dev_attr_wb_cur_fifo_size.attr,
+	&dev_attr_wb_pinned_cur_size.attr,
+	&dev_attr_wb_pinned_avail_pct.attr,
+	&dev_attr_wb_pinned_cumulative_write_size.attr,
+	&dev_attr_wb_pinned_size.attr,
+	&dev_attr_wb_non_pinned_min_size.attr,
 	NULL,
 };
 
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 0d48e137d66d..b34ca7aadd69 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -146,6 +146,7 @@ enum flag_idn {
 	QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8     = 0x10,
 	QUERY_FLAG_IDN_HPB_RESET                        = 0x11,
 	QUERY_FLAG_IDN_HPB_EN				= 0x12,
+	QUERY_FLAG_IDN_WB_UNPIN_EN			= 0x13,
 };
 
 /* Attribute idn for Query requests */
@@ -191,6 +192,14 @@ enum attr_idn {
 	QUERY_ATTR_IDN_WB_BUF_RESIZE_HINT	= 0x3C,
 	QUERY_ATTR_IDN_WB_BUF_RESIZE_EN		= 0x3D,
 	QUERY_ATTR_IDN_WB_BUF_RESIZE_STATUS	= 0x3E,
+	QUERY_ATTR_IDN_WB_PFM			= 0x3F,
+	QUERY_ATTR_IDN_MAX_FIFO_SIZE_WB_PFM	= 0x40,
+	QUERY_ATTR_IDN_CURRENT_FIFO_SIZE_WB_PFM	= 0x41,
+	QUERY_ATTR_IDN_PINNED_WB_CURRENT_SIZE	= 0x42,
+	QUERY_ATTR_IDN_PINNED_WB_AVAIL_PERC	= 0x43,
+	QUERY_ATTR_IDN_PINNED_WB_CUMMULATIVE_WS	= 0x44,
+	QUERY_ATTR_IDN_PINNED_WB_SIZE		= 0x45,
+	QUERY_ATTR_IDN_NON_PINNED_WB_MIN_SIZE	= 0x46,
 	QUERY_ATTR_IDN_TX_EQ_GN_SETTINGS        = 0x47,
 	QUERY_ATTR_IDN_TX_EQ_GN_SETTINGS_EXT    = 0x48,
 };
@@ -401,6 +410,15 @@ enum {
 	UFS_DEV_WB_BUF_RESIZE	= BIT(0),
 };
 
+/* Possible values for bWriteBoosterBufferPartialFlushMode */
+enum wb_partial_flush_mode {
+	WB_PARTIAL_FLUSH_NONE		= 0,
+	WB_PARTIAL_FLUSH_FIFO		= 1,
+	WB_PARTIAL_FLUSH_PINNED		= 2,
+	NUM_WB_PARTIAL_FLUSH_MODES	= 3,
+};
+
+
 /* Possible values for dExtendedUFSFeaturesSupport */
 enum {
 	UFS_DEV_HIGH_TEMP_NOTIF		= BIT(4),
-- 
2.54.0.1099.g489fc7bff1-goog


