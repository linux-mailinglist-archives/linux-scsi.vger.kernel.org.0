Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC2D589C0C
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Aug 2022 15:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiHDNAz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Aug 2022 09:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbiHDNAr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Aug 2022 09:00:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B052BED
        for <linux-scsi@vger.kernel.org>; Thu,  4 Aug 2022 06:00:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so5748455pjh.0
        for <linux-scsi@vger.kernel.org>; Thu, 04 Aug 2022 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc;
        bh=zFbA7GGrj3pHQqpLBfCg3+6B3k/axPdKI5x4ZzUhJp4=;
        b=huEyviqItbnVA9+VkbpWQajbAEiOleO06iWch9QND4H/c1dnQ86h6TWZr8t8IJ409t
         OmnNbVqTjPkuyYfnN241Z8j3hKp+TwCPhmfdcxta8SkKsuNqUQ8o3/Ol6b235gv8sGly
         6p6Bi0LcIWvAjPXC9IlX24Pn7Y3n+y/3AjupU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=zFbA7GGrj3pHQqpLBfCg3+6B3k/axPdKI5x4ZzUhJp4=;
        b=otN6pS/qr+jyJ2l16mkBaySVXyPbVOnZSm25armd1NOhnFvj3/eajDbVQ8FkTNQFxI
         ISsfY89eP582fOV8n71yrmIcC9o4byW5GVzd7AClekf7mXPISlIIJ/2A0oD935+MC8ub
         JPBoSs56BxNCltL0uSfTa7jnariAllDKXopNMtbqRwLe+4Ia5WxHKKzckffxlIceB4fk
         8I66g16riourYB8yGEg6b+ICX3fuwCQdGK5B7gi+iBOta4qB0MWhhf8WWqlZOwzkeIjY
         SdiWPP2HfqxTigTX8Xc9pxj2EVfQLnVwq1oXY7J7Ot+Gp55mnpA2YGm8nugkklkwm3Cz
         LBKg==
X-Gm-Message-State: ACgBeo13rPEkeuWV0ynBhcjg5XzGrI6ZqRTaTLkzbr5F562EyMFhF2+o
        q4WDENJsjZre0nyeK/8wSZFAT9ePRusDW+Rv1nSRT28eNW/9XI3NtjRl4kg2eIUlSF/rZe5lyHF
        z+tmEa2sM+twqxFTWVCXezYOLFIwT8nL7FSNJxSUXgX6tFi/GRhPV+ofew1SQsHouUZ3J2E0QLr
        /DUDqUy6ue
X-Google-Smtp-Source: AA6agR7H13vEwsLls3HyReXsNiD1lZ0UyD6VF7SzskNEbqUzEObt3d1Y/ZOuPNAWpmEQva5FJR2Xag==
X-Received: by 2002:a17:903:2601:b0:16d:b055:2985 with SMTP id jd1-20020a170903260100b0016db0552985mr1809137plb.161.1659618028161;
        Thu, 04 Aug 2022 06:00:28 -0700 (PDT)
Received: from dhcp-10-123-20-36.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w15-20020aa7954f000000b0052e2a1edab8sm934645pfq.24.2022.08.04.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 06:00:27 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v2 04/15] mpi3mr: Enable Enclosure device add event
Date:   Thu,  4 Aug 2022 18:42:15 +0530
Message-Id: <20220804131226.16653-5-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220804131226.16653-1-sreekanth.reddy@broadcom.com>
References: <20220804131226.16653-1-sreekanth.reddy@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000d0b1a05e569f029"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000000d0b1a05e569f029
Content-Transfer-Encoding: 8bit

Enable and process the Enclosure device add event.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi3mr.h    |  19 +++++
 drivers/scsi/mpi3mr/mpi3mr_fw.c |   4 +
 drivers/scsi/mpi3mr/mpi3mr_os.c | 133 +++++++++++++++++++++++++++++++-
 3 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 8af94d3..542b462 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -461,6 +461,16 @@ struct mpi3mr_throttle_group_info {
 	atomic_t pend_large_data_sz;
 };
 
+/**
+ * struct mpi3mr_enclosure_node - enclosure information
+ * @list: List of enclosures
+ * @pg0: Enclosure page 0;
+ */
+struct mpi3mr_enclosure_node {
+	struct list_head list;
+	struct mpi3_enclosure_page0 pg0;
+};
+
 /**
  * struct tgt_dev_sas_sata - SAS/SATA device specific
  * information cached from firmware given data
@@ -535,12 +545,14 @@ union _form_spec_inf {
  * @slot: Slot number
  * @encl_handle: FW enclosure handle
  * @perst_id: FW assigned Persistent ID
+ * @devpg0_flag: Device Page0 flag
  * @dev_type: SAS/SATA/PCIE device type
  * @is_hidden: Should be exposed to upper layers or not
  * @host_exposed: Already exposed to host or not
  * @io_throttle_enabled: I/O throttling needed or not
  * @q_depth: Device specific Queue Depth
  * @wwid: World wide ID
+ * @enclosure_logical_id: Enclosure logical identifier
  * @dev_spec: Device type specific information
  * @ref_count: Reference count
  */
@@ -552,12 +564,14 @@ struct mpi3mr_tgt_dev {
 	u16 slot;
 	u16 encl_handle;
 	u16 perst_id;
+	u16 devpg0_flag;
 	u8 dev_type;
 	u8 is_hidden;
 	u8 host_exposed;
 	u8 io_throttle_enabled;
 	u16 q_depth;
 	u64 wwid;
+	u64 enclosure_logical_id;
 	union _form_spec_inf dev_spec;
 	struct kref ref_count;
 };
@@ -877,6 +891,7 @@ struct scmd_priv {
  * @cfg_page: Default memory for configuration pages
  * @cfg_page_dma: Configuration page DMA address
  * @cfg_page_sz: Default configuration page memory size
+ * @enclosure_list: List of Enclosure objects
  */
 struct mpi3mr_ioc {
 	struct list_head list;
@@ -1053,6 +1068,8 @@ struct mpi3mr_ioc {
 	void *cfg_page;
 	dma_addr_t cfg_page_dma;
 	u16 cfg_page_sz;
+
+	struct list_head enclosure_list;
 };
 
 /**
@@ -1177,6 +1194,8 @@ int mpi3mr_pel_get_seqnum_post(struct mpi3mr_ioc *mrioc,
 	struct mpi3mr_drv_cmd *drv_cmd);
 void mpi3mr_app_save_logdata(struct mpi3mr_ioc *mrioc, char *event_data,
 	u16 event_data_size);
+struct mpi3mr_enclosure_node *mpi3mr_enclosure_find_by_handle(
+	struct mpi3mr_ioc *mrioc, u16 handle);
 extern const struct attribute_group *mpi3mr_host_groups[];
 extern const struct attribute_group *mpi3mr_dev_groups[];
 
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index bfc4244..c732586 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -244,6 +244,9 @@ static void mpi3mr_print_event_data(struct mpi3mr_ioc *mrioc,
 	case MPI3_EVENT_ENCL_DEVICE_STATUS_CHANGE:
 		desc = "Enclosure Device Status Change";
 		break;
+	case MPI3_EVENT_ENCL_DEVICE_ADDED:
+		desc = "Enclosure Added";
+		break;
 	case MPI3_EVENT_HARD_RESET_RECEIVED:
 		desc = "Hard Reset Received";
 		break;
@@ -3660,6 +3663,7 @@ static int mpi3mr_enable_events(struct mpi3mr_ioc *mrioc)
 	mpi3mr_unmask_events(mrioc, MPI3_EVENT_DEVICE_INFO_CHANGED);
 	mpi3mr_unmask_events(mrioc, MPI3_EVENT_DEVICE_STATUS_CHANGE);
 	mpi3mr_unmask_events(mrioc, MPI3_EVENT_ENCL_DEVICE_STATUS_CHANGE);
+	mpi3mr_unmask_events(mrioc, MPI3_EVENT_ENCL_DEVICE_ADDED);
 	mpi3mr_unmask_events(mrioc, MPI3_EVENT_SAS_TOPOLOGY_CHANGE_LIST);
 	mpi3mr_unmask_events(mrioc, MPI3_EVENT_SAS_DISCOVERY);
 	mpi3mr_unmask_events(mrioc, MPI3_EVENT_SAS_DEVICE_DISCOVERY_ERROR);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 40bed22..ca718cb 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -1026,6 +1026,7 @@ static void mpi3mr_update_tgtdev(struct mpi3mr_ioc *mrioc,
 {
 	u16 flags = 0;
 	struct mpi3mr_stgt_priv_data *scsi_tgt_priv_data = NULL;
+	struct mpi3mr_enclosure_node *enclosure_dev = NULL;
 	u8 prot_mask = 0;
 
 	tgtdev->perst_id = le16_to_cpu(dev_pg0->persistent_id);
@@ -1036,8 +1037,17 @@ static void mpi3mr_update_tgtdev(struct mpi3mr_ioc *mrioc,
 	tgtdev->slot = le16_to_cpu(dev_pg0->slot);
 	tgtdev->q_depth = le16_to_cpu(dev_pg0->queue_depth);
 	tgtdev->wwid = le64_to_cpu(dev_pg0->wwid);
+	tgtdev->devpg0_flag = le16_to_cpu(dev_pg0->flags);
+
+	if (tgtdev->encl_handle)
+		enclosure_dev = mpi3mr_enclosure_find_by_handle(mrioc,
+		    tgtdev->encl_handle);
+	if (enclosure_dev)
+		tgtdev->enclosure_logical_id = le64_to_cpu(
+		    enclosure_dev->pg0.enclosure_logical_id);
+
+	flags = tgtdev->devpg0_flag;
 
-	flags = le16_to_cpu(dev_pg0->flags);
 	tgtdev->is_hidden = (flags & MPI3_DEVICE0_FLAGS_HIDDEN);
 
 	if (is_added == true)
@@ -1265,6 +1275,116 @@ out:
 		mpi3mr_tgtdev_put(tgtdev);
 }
 
+/**
+ * mpi3mr_enclosure_find_by_handle - enclosure search by handle
+ * @mrioc: Adapter instance reference
+ * @handle: Firmware device handle of the enclosure
+ *
+ * This searches for enclosure device based on handle, then returns the
+ * enclosure object.
+ *
+ * Return: Enclosure object reference or NULL
+ */
+struct mpi3mr_enclosure_node *mpi3mr_enclosure_find_by_handle(
+	struct mpi3mr_ioc *mrioc, u16 handle)
+{
+	struct mpi3mr_enclosure_node *enclosure_dev, *r = NULL;
+
+	list_for_each_entry(enclosure_dev, &mrioc->enclosure_list, list) {
+		if (le16_to_cpu(enclosure_dev->pg0.enclosure_handle) != handle)
+			continue;
+		r = enclosure_dev;
+		goto out;
+	}
+out:
+	return r;
+}
+
+/**
+ * mpi3mr_encldev_add_chg_evt_debug - debug for enclosure event
+ * @mrioc: Adapter instance reference
+ * @encl_pg0: Enclosure page 0.
+ * @is_added: Added event or not
+ *
+ * Return nothing.
+ */
+static void mpi3mr_encldev_add_chg_evt_debug(struct mpi3mr_ioc *mrioc,
+	struct mpi3_enclosure_page0 *encl_pg0, u8 is_added)
+{
+	char *reason_str = NULL;
+
+	if (!(mrioc->logging_level & MPI3_DEBUG_EVENT_WORK_TASK))
+		return;
+
+	if (is_added)
+		reason_str = "enclosure added";
+	else
+		reason_str = "enclosure dev status changed";
+
+	ioc_info(mrioc,
+	    "%s: handle(0x%04x), enclosure logical id(0x%016llx)\n",
+	    reason_str, le16_to_cpu(encl_pg0->enclosure_handle),
+	    (unsigned long long)le64_to_cpu(encl_pg0->enclosure_logical_id));
+	ioc_info(mrioc,
+	    "number of slots(%d), port(%d), flags(0x%04x), present(%d)\n",
+	    le16_to_cpu(encl_pg0->num_slots), encl_pg0->io_unit_port,
+	    le16_to_cpu(encl_pg0->flags),
+	    ((le16_to_cpu(encl_pg0->flags) &
+	      MPI3_ENCLS0_FLAGS_ENCL_DEV_PRESENT_MASK) >> 4));
+}
+
+/**
+ * mpi3mr_encldev_add_chg_evt_bh - Enclosure evt bottomhalf
+ * @mrioc: Adapter instance reference
+ * @fwevt: Firmware event reference
+ *
+ * Prints information about the Enclosure device status or
+ * Enclosure add events if logging is enabled and add or remove
+ * the enclosure from the controller's internal list of
+ * enclosures.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_encldev_add_chg_evt_bh(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_fwevt *fwevt)
+{
+	struct mpi3mr_enclosure_node *enclosure_dev = NULL;
+	struct mpi3_enclosure_page0 *encl_pg0;
+	u16 encl_handle;
+	u8 added, present;
+
+	encl_pg0 = (struct mpi3_enclosure_page0 *) fwevt->event_data;
+	added = (fwevt->event_id == MPI3_EVENT_ENCL_DEVICE_ADDED) ? 1 : 0;
+	mpi3mr_encldev_add_chg_evt_debug(mrioc, encl_pg0, added);
+
+
+	encl_handle = le16_to_cpu(encl_pg0->enclosure_handle);
+	present = ((le16_to_cpu(encl_pg0->flags) &
+	      MPI3_ENCLS0_FLAGS_ENCL_DEV_PRESENT_MASK) >> 4);
+
+	if (encl_handle)
+		enclosure_dev = mpi3mr_enclosure_find_by_handle(mrioc,
+		    encl_handle);
+	if (!enclosure_dev && present) {
+		enclosure_dev =
+			kzalloc(sizeof(struct mpi3mr_enclosure_node),
+			    GFP_KERNEL);
+		if (!enclosure_dev)
+			return;
+		list_add_tail(&enclosure_dev->list,
+		    &mrioc->enclosure_list);
+	}
+	if (enclosure_dev) {
+		if (!present) {
+			list_del(&enclosure_dev->list);
+			kfree(enclosure_dev);
+		} else
+			memcpy(&enclosure_dev->pg0, encl_pg0,
+			    sizeof(enclosure_dev->pg0));
+
+	}
+}
+
 /**
  * mpi3mr_sastopochg_evt_debug - SASTopoChange details
  * @mrioc: Adapter instance reference
@@ -1641,6 +1761,13 @@ static void mpi3mr_fwevt_bh(struct mpi3mr_ioc *mrioc,
 		mpi3mr_devstatuschg_evt_bh(mrioc, fwevt);
 		break;
 	}
+	case MPI3_EVENT_ENCL_DEVICE_ADDED:
+	case MPI3_EVENT_ENCL_DEVICE_STATUS_CHANGE:
+	{
+		mpi3mr_encldev_add_chg_evt_bh(mrioc, fwevt);
+		break;
+	}
+
 	case MPI3_EVENT_SAS_TOPOLOGY_CHANGE_LIST:
 	{
 		mpi3mr_sastopochg_evt_bh(mrioc, fwevt);
@@ -2502,6 +2629,8 @@ void mpi3mr_os_handle_events(struct mpi3mr_ioc *mrioc,
 	}
 	case MPI3_EVENT_DEVICE_INFO_CHANGED:
 	case MPI3_EVENT_LOG_DATA:
+	case MPI3_EVENT_ENCL_DEVICE_STATUS_CHANGE:
+	case MPI3_EVENT_ENCL_DEVICE_ADDED:
 	{
 		process_evt_bh = 1;
 		break;
@@ -2516,7 +2645,6 @@ void mpi3mr_os_handle_events(struct mpi3mr_ioc *mrioc,
 		mpi3mr_cablemgmt_evt_th(mrioc, event_reply);
 		break;
 	}
-	case MPI3_EVENT_ENCL_DEVICE_STATUS_CHANGE:
 	case MPI3_EVENT_SAS_DISCOVERY:
 	case MPI3_EVENT_SAS_DEVICE_DISCOVERY_ERROR:
 	case MPI3_EVENT_SAS_BROADCAST_PRIMITIVE:
@@ -4569,6 +4697,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_LIST_HEAD(&mrioc->tgtdev_list);
 	INIT_LIST_HEAD(&mrioc->delayed_rmhs_list);
 	INIT_LIST_HEAD(&mrioc->delayed_evtack_cmds_list);
+	INIT_LIST_HEAD(&mrioc->enclosure_list);
 
 	mutex_init(&mrioc->reset_mutex);
 	mpi3mr_init_drv_cmd(&mrioc->init_cmds, MPI3MR_HOSTTAG_INITCMDS);
-- 
2.27.0


--0000000000000d0b1a05e569f029
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
5AGo2E3pe+2yEgkxKvM2fnniZHUiSjbrfKk6nl9RIXPOKUP5HntZFdA5XuNYXWM+HPs3O0AJwBm/
VCZsZtkjVjxeBmTXiXDnxytdsHdGrHGymPfjJYatDu6d1KRVDlMCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcc3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUClVHbAvhzGT8
s2/6xOf58NkGMQ8wDQYJKoZIhvcNAQELBQADggEBAENRsP1H3calKC2Sstg/8li8byKiqljCFkfi
IhcJsjPOOR9UZnMFxAoH/s2AlM7mQDR7rZ2MxRuUnIa6Cp5W5w1lUJHktjCUHnQq5nIAZ9GH5SDY
pgzbFsoYX8U2QCmkAC023FF++ZDJuc9aj0R/nhABxmUYErIze2jV/VO8Pj7TnCrBONZ/Qvf8G5CQ
X1hfOcCDBgT7eSvf9YRLaV935mB9/V+KYX8lT4E0lB4wQ0OLV8qUS9UuNoG2lCJ5UQTMrBgeUFFY
eKKhn+R91COmRlKGlaCdTtzKG5atS6dPnGEYUHjcpUvzejmJ5ghBk6P01HqSACsszDOzmBvdiOs+
Ux0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxyeqr1
0keLkvPdYw4wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIF4g+7PAu40P7npsHed9
CKoTMA/j1+WSot67N8D7oDCkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIyMDgwNDEzMDA0NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB2AqPB8g4vk3yZreg6HsePTSiWLSn9NeSjKE3L
52ZOTFGJD/s4IEJU86MmQurGagRxK50TCLbd58dJ4VH0Ed1kqPVGcVZ4hB7emdOF9K7bskcRPgOK
lCKSokYQclcx2VgH5iEp/JBUIEsJik/hmaUzZsRbj3sEQ81P0Kgmsgh+GRs0+zfo4vtNqLM4ys3g
mvmmf7Kn+dd+/R6xpuQruoLnSkRXkRH95bPOG16v6kHUgD6Ef5qHTFczYMjtFUK/yE6O/BXZnoIi
vQQJoj2gUxhDpEUxKCLNU14LpAR33TILu+DjPwn8sX5wKQq49gTQCVT29PpDrSIX2Z1fwZvzXLrn
--0000000000000d0b1a05e569f029--
