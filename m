Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DC030BB8D
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Feb 2021 10:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhBBJ4s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Feb 2021 04:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhBBJ4V (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 2 Feb 2021 04:56:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C7C061573
        for <linux-scsi@vger.kernel.org>; Tue,  2 Feb 2021 01:55:40 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d13so12186811plg.0
        for <linux-scsi@vger.kernel.org>; Tue, 02 Feb 2021 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=m+bW6ZuLGDn/1O3vGW596NeSMdSo322VT2idbSe8z14=;
        b=CXqe1zDP/ok9Xowd1U50rGgOR9taEUWRo9lAwJrIaLDwQU1kZn0ylUSlyTccoNmmo9
         ZmJ9SzU/uYqBCzlrrmkJyRBpsZp6UzYMMtaRrTJfzMNlpRoW4V4FJRS8RFhQ8sCNKx6y
         jhHmgRoikUYeKrA/8m8nQliRrrdOJ+JUJNO+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=m+bW6ZuLGDn/1O3vGW596NeSMdSo322VT2idbSe8z14=;
        b=O8rK6bx4/2G2gdrdxy8vNfTolU1nyolBwpabIzWeB7+mQ/FC8Xoeg3tzaJRBlu/IXU
         7/2PlPY8ZPFv6n3caqERucO2wDWj5v2cZJIoEPvSs7F3Xlq3yz0KNxTeMb7Jib0EziQd
         9oEvWbKsgnhEnFW6o/Qhb2kMb6FJQxc9E6LD52Ypabsttdg92U50RIwAxOYWDtdcaJBy
         eYxBuJfZhgFq1RhHrnnowBzz2xZPqhizQSZZebJ9Xe/AEwmS8RYBK8KeV68MeNr+bY3U
         ifVNcAb3mmnNmjqHxhHshdyw5OM6WjqE5rRosUXnwdv9E30JRMgYEBZY/snOEU4qIf5w
         c8Xw==
X-Gm-Message-State: AOAM531NDyaRieWLDJ80vfhB8dzMgZInc3X8ZxjLE8DzdwH5yjMQDeJb
        edKlZ1Uo59it9IbeArQz3b/Lbz8ePMSf1Tte
X-Google-Smtp-Source: ABdhPJwbHjnnGtvdfKcuWk0W1ispjV9kocfoDQ+3kBXxc0hwdn0fy4xPGXTlJ8EY4XQrpkryciCr3A==
X-Received: by 2002:a17:90a:5317:: with SMTP id x23mr3496549pjh.154.1612259739944;
        Tue, 02 Feb 2021 01:55:39 -0800 (PST)
Received: from dhcp-10-123-20-36.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id m1sm2335583pjz.16.2021.02.02.01.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:55:38 -0800 (PST)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, sathya.prakash@broadcom.com,
        suganath-prabu.subramani@broadcom.com, kashyap.desai@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] mpt3sas: Added support for shared host tagset for cpuhotplug
Date:   Tue,  2 Feb 2021 15:28:32 +0530
Message-Id: <20210202095832.23072-1-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001d9cb305ba577931"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000001d9cb305ba577931
Content-Transfer-Encoding: 8bit

MPT Fusion adapters can steer completions to individual queues, and
we now have support for shared host-wide tags.
So we can enable multiqueue support for MPT fusion adapters.

Once driver enable shared host-wide tags, cpu hotplug feature is also
supported as it was enabled using below patchsets -
commit bf0beec060 ("blk-mq: drain I/O when all CPUs in a hctx are
offline")

Currently the driver has provision to disable host-wide tags using
"host_tagset_enable" module parameter.

Once we do not have any major performance regression using host-wide
tags, we will drop the hand-crafted interrupt affinity settings.

Performance is also meeting the expectation - (used both none and
mq-deadline scheduler)
24 Drive SSD on Aero with/without this patch can get 3.1M IOPs"

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---

v2:
   Fix the error reported by kernel test robot

 drivers/scsi/mpt3sas/mpt3sas_base.c  | 50 ++++++++++++++++++----------
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  1 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 42 ++++++++++++++++++++++-
 3 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index f5582c8..84663d1 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3648,25 +3648,16 @@ _base_get_msix_index(struct MPT3SAS_ADAPTER *ioc,
 		    base_mod64(atomic64_add_return(1,
 		    &ioc->total_io_cnt), ioc->reply_queue_count) : 0;
 
-	return ioc->cpu_msix_table[raw_smp_processor_id()];
-}
+	if (scmd && ioc->shost->nr_hw_queues > 1) {
+		u32 tag = blk_mq_unique_tag(scmd->request);
 
-/**
- * _base_sdev_nr_inflight_request -get number of inflight requests
- *				   of a request queue.
- * @q: request_queue object
- *
- * returns number of inflight request of a request queue.
- */
-inline unsigned long
-_base_sdev_nr_inflight_request(struct request_queue *q)
-{
-	struct blk_mq_hw_ctx *hctx = q->queue_hw_ctx[0];
+		return blk_mq_unique_tag_to_hwq(tag) +
+			ioc->high_iops_queues;
+	}
 
-	return atomic_read(&hctx->nr_active);
+	return ioc->cpu_msix_table[raw_smp_processor_id()];
 }
 
-
 /**
  * _base_get_high_iops_msix_index - get the msix index of
  *				high iops queues
@@ -3686,7 +3677,8 @@ _base_get_high_iops_msix_index(struct MPT3SAS_ADAPTER *ioc,
 	 * reply queues in terms of batch count 16 when outstanding
 	 * IOs on the target device is >=8.
 	 */
-	if (_base_sdev_nr_inflight_request(scmd->device->request_queue) >
+
+	if (atomic_read(&scmd->device->device_busy) >
 	    MPT3SAS_DEVICE_HIGH_IOPS_DEPTH)
 		return base_mod64((
 		    atomic64_add_return(1, &ioc->high_iops_outstanding) /
@@ -3739,8 +3731,23 @@ mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
 	struct scsi_cmnd *scmd)
 {
 	struct scsiio_tracker *request = scsi_cmd_priv(scmd);
-	unsigned int tag = scmd->request->tag;
 	u16 smid;
+	u32 tag, unique_tag;
+
+	unique_tag = blk_mq_unique_tag(scmd->request);
+	tag = blk_mq_unique_tag_to_tag(unique_tag);
+
+	/*
+	 * store hw queue number corresponding to the tag,
+	 * this hw queue number is used later to determine
+	 * the unqiue_tag using below logic. This unique_tag
+	 * is used to retrieve the scmd pointer corresponding
+	 * to tag using scsi_host_find_tag() API,
+	 *
+	 * tag = smid - 1;
+	 * unique_tag = ioc->io_queue_num[tag] << BLK_MQ_UNIQUE_TAG_BITS | tag;
+	 */
+	ioc->io_queue_num[tag] = blk_mq_unique_tag_to_hwq(unique_tag);
 
 	smid = tag + 1;
 	request->cb_idx = cb_idx;
@@ -3831,6 +3838,7 @@ mpt3sas_base_free_smid(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 
 		mpt3sas_base_clear_st(ioc, st);
 		_base_recovery_check(ioc);
+		ioc->io_queue_num[smid - 1] = 0;
 		return;
 	}
 
@@ -5362,6 +5370,9 @@ _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 		kfree(ioc->chain_lookup);
 		ioc->chain_lookup = NULL;
 	}
+
+	kfree(ioc->io_queue_num);
+	ioc->io_queue_num = NULL;
 }
 
 /**
@@ -5772,6 +5783,11 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 		    ioc_info(ioc, "internal(0x%p): depth(%d), start smid(%d)\n",
 			     ioc->internal,
 			     ioc->internal_depth, ioc->internal_smid));
+
+	ioc->io_queue_num = kcalloc(ioc->scsiio_depth,
+	    sizeof(u16), GFP_KERNEL);
+	if (!ioc->io_queue_num)
+		goto out;
 	/*
 	 * The number of NVMe page sized blocks needed is:
 	 *     (((sg_tablesize * 8) - 1) / (page_size - 8)) + 1
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 2def7a3..2eb94e4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1439,6 +1439,7 @@ struct MPT3SAS_ADAPTER {
 	spinlock_t	scsi_lookup_lock;
 	int		pending_io_count;
 	wait_queue_head_t reset_wq;
+	u16		*io_queue_num;
 
 	/* PCIe SGL */
 	struct dma_pool *pcie_sgl_dma_pool;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index c8b09a8..6973041 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -54,6 +54,7 @@
 #include <linux/interrupt.h>
 #include <linux/aer.h>
 #include <linux/raid_class.h>
+#include <linux/blk-mq-pci.h>
 #include <asm/unaligned.h>
 
 #include "mpt3sas_base.h"
@@ -168,6 +169,11 @@ MODULE_PARM_DESC(multipath_on_hba,
 	"\t SAS 2.0 & SAS 3.0 HBA - This will be disabled,\n\t\t"
 	"\t SAS 3.5 HBA - This will be enabled)");
 
+static int host_tagset_enable = 1;
+module_param(host_tagset_enable, int, 0444);
+MODULE_PARM_DESC(host_tagset_enable,
+	"Shared host tagset enable/disable Default: enable(1)");
+
 /* raid transport support */
 static struct raid_template *mpt3sas_raid_template;
 static struct raid_template *mpt2sas_raid_template;
@@ -1743,10 +1749,12 @@ mpt3sas_scsih_scsi_lookup_get(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 	struct scsi_cmnd *scmd = NULL;
 	struct scsiio_tracker *st;
 	Mpi25SCSIIORequest_t *mpi_request;
+	u16 tag = smid - 1;
 
 	if (smid > 0  &&
 	    smid <= ioc->scsiio_depth - INTERNAL_SCSIIO_CMDS_COUNT) {
-		u32 unique_tag = smid - 1;
+		u32 unique_tag =
+		    ioc->io_queue_num[tag] << BLK_MQ_UNIQUE_TAG_BITS | tag;
 
 		mpi_request = mpt3sas_base_get_msg_frame(ioc, smid);
 
@@ -11599,6 +11607,22 @@ scsih_scan_finished(struct Scsi_Host *shost, unsigned long time)
 	return 1;
 }
 
+/**
+ * scsih_map_queues - map reply queues with request queues
+ * @shost: SCSI host pointer
+ */
+static int scsih_map_queues(struct Scsi_Host *shost)
+{
+	struct MPT3SAS_ADAPTER *ioc =
+	    (struct MPT3SAS_ADAPTER *)shost->hostdata;
+
+	if (ioc->shost->nr_hw_queues == 1)
+		return 0;
+
+	return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+	    ioc->pdev, ioc->high_iops_queues);
+}
+
 /* shost template for SAS 2.0 HBA devices */
 static struct scsi_host_template mpt2sas_driver_template = {
 	.module				= THIS_MODULE,
@@ -11666,6 +11690,7 @@ static struct scsi_host_template mpt3sas_driver_template = {
 	.sdev_attrs			= mpt3sas_dev_attrs,
 	.track_queue_depth		= 1,
 	.cmd_size			= sizeof(struct scsiio_tracker),
+	.map_queues			= scsih_map_queues,
 };
 
 /* raid transport support for SAS 3.0 HBA devices */
@@ -12028,6 +12053,21 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	} else
 		ioc->hide_drives = 0;
 
+	shost->host_tagset = 0;
+	shost->nr_hw_queues = 1;
+
+	if (ioc->is_gen35_ioc && ioc->reply_queue_count > 1 &&
+	    host_tagset_enable && ioc->smp_affinity_enable) {
+
+		shost->host_tagset = 1;
+		shost->nr_hw_queues =
+		    ioc->reply_queue_count - ioc->high_iops_queues;
+
+		dev_info(&ioc->pdev->dev,
+		    "Max SCSIIO MPT commands: %d shared with nr_hw_queues = %d\n",
+		    shost->can_queue, shost->nr_hw_queues);
+	}
+
 	rv = scsi_add_host(shost, &pdev->dev);
 	if (rv) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
-- 
2.27.0


--0000000000001d9cb305ba577931
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Rag/s/0IKyxAQsoBcla5ZufuDE5ir/mlnYktkPJdg+kns/OPDsINSyWqNYE9PKy9+3cp/fItNFtH
krg1AgMBAAGjggHTMIIBzzAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsG
AQUFBzAChkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2ln
bjJzaGEyZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29t
L2dzcGVyc29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEF
BQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBE
BgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWdu
MnNoYTJnMy5jcmwwJwYDVR0RBCAwHoEcc3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbTATBgNV
HSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4E
FgQU1CyhXqcQo40SZ7kFS/AiOnRW6lMwDQYJKoZIhvcNAQELBQADggEBAFeMmmz112eNFAV8Ense
5WremClV5F3Md1xS0yXKqxlgakUJaOI/Fai7OLQaQqsEoxW6/QqWEi1wbZOccbdritOkL5b7sVUp
SU9OfuIlV8c3XMLaWSIluy+0ImtRJ49jDCI4KtQESHrqfQRZcc1C/avZvNED3U4b10U6N3SY+59b
fm2Vlwacwp+8ESTp49DsLcJqc4U/0rUZxLWtgPokzS+ovX+JAu8zx1SmOzUC4hj4Bp6Vnfd5KWUK
JJQBmQHXii+acSeTgHmPWUYs3tYQ0uIX0Yy8LUWPdGbEq+KWepzY2otC+iVWdngCCv8Nf1Xo1jki
AGJ6hrlWFE0qJVWv25sxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hB
MjU2IC0gRzMCDBmG1a14/wFg8qBhUjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg
ZM9Vw+AsRvAJTArd3C3vtkBARxZCTZwh0w/aa0Nrvm8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjEwMjAyMDk1NTQwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABefc7k0WRPWQ9vjWcLC
JldM4As+W3a9G9AkcT3BTc6HlSRwT8X8lyTCOZ+SShvXGph3WQJqNvyTlOHHq9jOMn4AafTE6YoP
HJDGoZcoiRCdb0f0/xGFNJa2w+RZdIzHRKU7lSUwOAdqUfkqNdYxUXFc1NiGuDvHHT7rC7wiI+I1
8lJew3RsCF9npuTP/p8sRkpC/ari5Hn/mkLQA3pFEEvKnM5mNQACaFzwrReEif8oQV5Ems2BRoXb
ZCK6mgmDIzm42POTMZYCLMCkoIn6ips1vkNnuUV2qJh+lmgBkg7M8oztDcLeYC3MG8c2iCXmV/4y
NefW83Ku7W8NeULihn4=
--0000000000001d9cb305ba577931--
