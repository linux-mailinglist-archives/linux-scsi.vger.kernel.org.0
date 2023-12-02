Return-Path: <linux-scsi+bounces-451-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449C801DC1
	for <lists+linux-scsi@lfdr.de>; Sat,  2 Dec 2023 17:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D17281434
	for <lists+linux-scsi@lfdr.de>; Sat,  2 Dec 2023 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B27321115
	for <lists+linux-scsi@lfdr.de>; Sat,  2 Dec 2023 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="G9eqaHEL";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="oxdDHlly"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAAD18A;
	Sat,  2 Dec 2023 08:02:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701532958; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z6tfNtR1LqgQUhGZUAjAL/47yg9nw/IFkjS+g62yD7tvoka1fiav/7P4nMevwV0pv7
    IlJbqG/L9P0HhqbZB7MoBwrKal/83jmebrD13fUZ3+9C+lExdB0Ju36ofnG2qhuEIypR
    I/gCMq7r+ptaPbPbq+0m782/Jtnea/AhysuZBr7UUgUdhNgRlmvYmRrBK3wFDs0PbtRS
    zlhcxASKYrPlvxSGEKEdqzImUJG5D8XwJbWVTJ2aKfe2p7pfvqzjh2d29gmPRw9UIfhV
    l83f1j6NcCuCkKlwrPGqJlPE7ykNYW7TgzY5ao4qvf/k0GRF3jMF1iLMRepq8lkS0U+t
    EUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701532958;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=oxMNWR/TdQAOnRsDvUNaC3OMvStYq+qqiw9ndKWZvb8=;
    b=atzxk6CSr/hz2VfiRhzmLXsg+OSPUhZ4/AfxDPX3NPCYE/0Uor7N/ek2Zr8uTP2avI
    PRUZxigY51f3B9OBlbhaNNX8rnP4MoF/tt25oyilUA1aRA7mPEaeSt9iVz+pjhGuJasK
    o+2auw4JiSkgJ6khCZ8ZtRLz3fSz1DcZ/l0oHLKY74qDCrhHWNl+h5IKY4U42Zi7gybV
    EtrdNkU/abVeEil4Nnc1trQEE0ldQWU5wALMBDuGAGJR7pawt6neg67vQoUvinofZGaC
    DwqzJsAmrFji+6AnPwDvEFQz2WGnAkI5+XcJ0sA0UdvFm1EAGtlm+anUqicSxbawmycQ
    LI2Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701532958;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=oxMNWR/TdQAOnRsDvUNaC3OMvStYq+qqiw9ndKWZvb8=;
    b=G9eqaHELdc+mxqstTAlRYIbnrhMVcaE2jSyHbtMd/oVdvxErxDUNxcZFOQOT/Lz9/l
    wba6/Sw64vo6Yvs/RNthQK0Kzg081wdnrGOpXIXqlRZqdDxyrhi12k1FQTPERinks/ul
    e4TiaXBoAPENv4YyL3kGdwj7HIMXcXtrrF9ug0kIaihv8bwkpCVSjXWdzG6H7ReWtPm6
    8o6czr0F6yM4L1Yb8jA7Om1XTRrNptfWVh6K2nrXaqzghS83Sv8q8IMehbGIA1PCli5o
    qQznfrrkEgY4gWvvkAET6aiuEjwpgUBPyK7cQkWfiVIhOONQ1TNXDvaBBzxWmadXqSba
    sbog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701532958;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=oxMNWR/TdQAOnRsDvUNaC3OMvStYq+qqiw9ndKWZvb8=;
    b=oxdDHllyCAGyLruYARpcyri7Vd9/zdW/5oTl1KjvoTlE/d4zDn9p+07d51ag36EBKQ
    HhAoao4dCg2g7KhefbDg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U0BfWsYLe+bQusZClHgu6POSIuOZDSGI3MA01fA=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 49.9.7 AUTH)
    with ESMTPSA id z8d451zB2G2b5CL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 2 Dec 2023 17:02:37 +0100 (CET)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	bvanassche@acm.org,
	alim.akhtar@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	mani@kernel.org,
	quic_cang@quicinc.com,
	quic_asutoshd@quicinc.com,
	beanhuo@micron.com,
	thomas@t-8ch.de
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mikebi@micron.com,
	lporzio@micron.com
Subject: [PATCH v3 3/3] scsi: ufs: core: Add sysfs node for UFS RTC update
Date: Sat,  2 Dec 2023 17:02:27 +0100
Message-Id: <20231202160227.766529-4-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202160227.766529-1-beanhuo@iokpp.de>
References: <20231202160227.766529-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Introduce a sysfs node named 'rtc_update_ms' within the kernel, enabling
user to adjust the RTC periodic update frequency to suit the specific
requirements of the system and UFS. Also, this patch allows the user to
disable/enable periodic update RTC in the UFS idle time.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs |  7 +++++
 drivers/ufs/core/ufs-sysfs.c               | 31 ++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c                  | 11 ++++++--
 include/ufs/ufs.h                          |  1 +
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 0c7efaf62de0..ef1e27584fff 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1474,3 +1474,10 @@ Description:	Indicates status of Write Booster.
 
 		The file is read only.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/rtc_update_ms
+What:		/sys/bus/platform/devices/*.ufs/rtc_update_ms
+Date:		November 2023
+Contact:	Bean Huo <beanhuo@micron.com>
+Description:
+		rtc_update_ms indicates how often the host should synchronize or update the
+		UFS RTC. If set to 0, this will disable UFS RTC periodic update.
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index c95906443d5f..bb6b540ccd8e 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -255,6 +255,35 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 	return res < 0 ? res : count;
 }
 
+static ssize_t rtc_update_ms_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->dev_info.rtc_update_period);
+}
+
+static ssize_t rtc_update_ms_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	unsigned int ms;
+	bool resume_period_update = false;
+
+	if (kstrtouint(buf, 0, &ms))
+		return -EINVAL;
+
+	if (!hba->dev_info.rtc_update_period && ms > 0)
+		resume_period_update =  true;
+	/* Minimum and maximum update frequency should be synchronized with all UFS vendors */
+	hba->dev_info.rtc_update_period = ms;
+
+	if (resume_period_update)
+		schedule_delayed_work(&hba->ufs_rtc_update_work,
+						msecs_to_jiffies(hba->dev_info.rtc_update_period));
+	return count;
+}
+
 static ssize_t enable_wb_buf_flush_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -339,6 +368,7 @@ static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
 static DEVICE_ATTR_RW(enable_wb_buf_flush);
 static DEVICE_ATTR_RW(wb_flush_threshold);
+static DEVICE_ATTR_RW(rtc_update_ms);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -351,6 +381,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_wb_on.attr,
 	&dev_attr_enable_wb_buf_flush.attr,
 	&dev_attr_wb_flush_threshold.attr,
+	&dev_attr_rtc_update_ms.attr,
 	NULL
 };
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index dfc660de656f..4864d213d5d9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8231,9 +8231,9 @@ static void ufshcd_rtc_work(struct work_struct *work)
 	if (!is_busy)
 		ufshcd_update_rtc(hba);
 
-	if (ufshcd_is_ufs_dev_active(hba))
+	if (ufshcd_is_ufs_dev_active(hba) && hba->dev_info.rtc_update_period)
 		schedule_delayed_work(&hba->ufs_rtc_update_work,
-			msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
+			msecs_to_jiffies(hba->dev_info.rtc_update_period));
 }
 
 static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
@@ -8255,6 +8255,13 @@ static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
 		dev_info->rtc_time_baseline = 0;
 	}
 
+	/*
+	 * We ignore TIME_PERIOD defined in wPeriodicRTCUpdate because Spec does not clearly state
+	 * how to calculate the specific update period for each time unit. Here we disable periodic
+	 * update work, and let user configure by sysfs node according to specific circumstance.
+	 */
+	hba->dev_info.rtc_update_period = 0;
+
 	INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
 }
 
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 8022d267fe8a..288724d3be90 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -592,6 +592,7 @@ struct ufs_dev_info {
 	/* UFS RTC */
 	enum ufs_rtc_time rtc_type;
 	time64_t rtc_time_baseline;
+	u32 rtc_update_period;
 };
 
 /*
-- 
2.34.1


