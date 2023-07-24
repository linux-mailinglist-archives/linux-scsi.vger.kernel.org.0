Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F4D75F82E
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jul 2023 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjGXNYl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jul 2023 09:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjGXNY2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jul 2023 09:24:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026010D5
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jul 2023 06:24:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9cd6a0051so26400475ad.1
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jul 2023 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690205053; x=1690809853;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=loAu1oUSxRsYjDsAF8fTxxkOKFpbgXtx4mIX46LDkb4=;
        b=YWvjXqD5SgdEvHo9KiJ6FK4B1olwLTwB9w6DZomvW4iIs/67yrg6Pz9C5AdIAP44h/
         AKQugAHVXtkSBsZIXN9uRRhx69USX5627QYr5XdwRs4FtCz42ftzTrN31V8aBx9hXcOR
         2LGAbRphNpztxBY9G+zEW160zf10SwwyhZszw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690205053; x=1690809853;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loAu1oUSxRsYjDsAF8fTxxkOKFpbgXtx4mIX46LDkb4=;
        b=Q305iigL2EqoRmjREjrJ9aZr0rVzYPEVY/mE7tdjttGBVE0jUzfbNz+Swiy+9yVuVI
         8O+8cvbw8c/666lUg3LNNVH0Tb7+CMRUM3RZaUsT2wmntkZTE25ITQcFvcb3yOFvIauq
         t+TVeWqmEFZnvE2SHd5+ZbFYMrAUOjspq2DfNAzyAD/gkE280Syy4XJa7Q1PhID1BmtV
         Y3IeCnx6QfQSxmIDvo2uzP9ceMjq1hS8YDgcGn3yE+sc+M8tXsWfKHRNGLaTbfJKokg5
         cwz0f6OOQ0mOnpdBv5iEAoLS3d5V01plUvfAbTcf+9j85oCnBOo9QVQbCRvPuH1G1ywH
         Qq5w==
X-Gm-Message-State: ABy/qLaFME120mOICj2Yimsqx2tqMWYehNLMJoy5AELEchOua6TTXzMW
        KDKbSsonoHhEKdGZV46GvcA1fCu0Y4uRnQYcxdKfXg3nzP7SWrSvc0ieYojTiN+iQkK8UXxyhnw
        6x4V1PWLcSc8JZT1mhQ8e/EuFz3gn0B1YsW0bNJSeZwTJU+LehXRDNQgm908N6bZIArCDRoSJdu
        AX5NXBSfUODQ==
X-Google-Smtp-Source: APBJJlHnHjhYTwzPvGiXZ0Mfd7RNnIqjCY5hB6Wb6PYDNrGkfxDDE5d9gIHZ1dZrD8M97RTXpf9Yew==
X-Received: by 2002:a17:902:b698:b0:1b8:8262:7333 with SMTP id c24-20020a170902b69800b001b882627333mr8657173pls.51.1690205053300;
        Mon, 24 Jul 2023 06:24:13 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001b9e0918b0asm8917887plg.169.2023.07.24.06.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:24:12 -0700 (PDT)
From:   Ranjan Kumar <ranjan.kumar@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     rajsekhar.chundru@broadcom.com, sathya.prakash@broadcom.com,
        sumit.saxena@broadcom.com, chandrakanth.patil@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Ranjan Kumar <ranjan.kumar@broadcom.com>
Subject: [PATCH v1 4/6] mpi3mr: WriteSame implementation
Date:   Mon, 24 Jul 2023 18:53:01 +0530
Message-Id: <20230724132303.19470-5-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230724132303.19470-1-ranjan.kumar@broadcom.com>
References: <20230724132303.19470-1-ranjan.kumar@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d31ad706013b87ec"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000d31ad706013b87ec
Content-Transfer-Encoding: 8bit

The driver is enhanced to divert the writesame commands that
are issued with unmap=1 and NDOB=1 and with the transfer length
greater than the max writesame length specified by the firmware
for the particular drive to the firmware.

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi3mr.h    |  11 +++
 drivers/scsi/mpi3mr/mpi3mr_os.c | 118 +++++++++++++++++++++++++-------
 2 files changed, 105 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index fd3619775739..8b009ba26d88 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -207,6 +207,9 @@ extern atomic64_t event_counter;
  */
 #define MPI3MR_MAX_APP_XFER_SECTORS	(2048 + 512)
 
+#define MPI3MR_WRITE_SAME_MAX_LEN_256_BLKS 256
+#define MPI3MR_WRITE_SAME_MAX_LEN_2048_BLKS 2048
+
 /**
  * struct mpi3mr_nvme_pt_sge -  Structure to store SGEs for NVMe
  * Encapsulated commands.
@@ -678,6 +681,7 @@ enum mpi3mr_dev_state {
  * @io_unit_port: IO Unit port ID
  * @non_stl: Is this device not to be attached with SAS TL
  * @io_throttle_enabled: I/O throttling needed or not
+ * @wslen: Write same max length
  * @q_depth: Device specific Queue Depth
  * @wwid: World wide ID
  * @enclosure_logical_id: Enclosure logical identifier
@@ -700,6 +704,7 @@ struct mpi3mr_tgt_dev {
 	u8 io_unit_port;
 	u8 non_stl;
 	u8 io_throttle_enabled;
+	u16 wslen;
 	u16 q_depth;
 	u64 wwid;
 	u64 enclosure_logical_id;
@@ -753,6 +758,8 @@ static inline void mpi3mr_tgtdev_put(struct mpi3mr_tgt_dev *s)
  * @dev_removed: Device removed in the Firmware
  * @dev_removedelay: Device is waiting to be removed in FW
  * @dev_type: Device type
+ * @dev_nvme_dif: Device is NVMe DIF enabled
+ * @wslen: Write same max length
  * @io_throttle_enabled: I/O throttling needed or not
  * @io_divert: Flag indicates io divert is on or off for the dev
  * @throttle_group: Pointer to throttle group info
@@ -769,6 +776,8 @@ struct mpi3mr_stgt_priv_data {
 	u8 dev_removed;
 	u8 dev_removedelay;
 	u8 dev_type;
+	u8 dev_nvme_dif;
+	u16 wslen;
 	u8 io_throttle_enabled;
 	u8 io_divert;
 	struct mpi3mr_throttle_group_info *throttle_group;
@@ -784,12 +793,14 @@ struct mpi3mr_stgt_priv_data {
  * @ncq_prio_enable: NCQ priority enable for SATA device
  * @pend_count: Counter to track pending I/Os during error
  *		handling
+ * @wslen: Write same max length
  */
 struct mpi3mr_sdev_priv_data {
 	struct mpi3mr_stgt_priv_data *tgt_priv_data;
 	u32 lun_id;
 	u8 ncq_prio_enable;
 	u32 pend_count;
+	u16 wslen;
 };
 
 /**
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index b19b624d0e97..080c1a958905 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -430,6 +430,7 @@ void mpi3mr_invalidate_devhandles(struct mpi3mr_ioc *mrioc)
 			tgt_priv->io_throttle_enabled = 0;
 			tgt_priv->io_divert = 0;
 			tgt_priv->throttle_group = NULL;
+			tgt_priv->wslen = 0;
 			if (tgtdev->host_exposed)
 				atomic_set(&tgt_priv->block_io, 1);
 		}
@@ -1108,6 +1109,18 @@ static void mpi3mr_update_tgtdev(struct mpi3mr_ioc *mrioc,
 		tgtdev->io_throttle_enabled =
 		    (flags & MPI3_DEVICE0_FLAGS_IO_THROTTLING_REQUIRED) ? 1 : 0;
 
+	switch (flags & MPI3_DEVICE0_FLAGS_MAX_WRITE_SAME_MASK) {
+	case MPI3_DEVICE0_FLAGS_MAX_WRITE_SAME_256_LB:
+		tgtdev->wslen = MPI3MR_WRITE_SAME_MAX_LEN_256_BLKS;
+		break;
+	case MPI3_DEVICE0_FLAGS_MAX_WRITE_SAME_2048_LB:
+		tgtdev->wslen = MPI3MR_WRITE_SAME_MAX_LEN_2048_BLKS;
+		break;
+	case MPI3_DEVICE0_FLAGS_MAX_WRITE_SAME_NO_LIMIT:
+	default:
+		tgtdev->wslen = 0;
+		break;
+	}
 
 	if (tgtdev->starget && tgtdev->starget->hostdata) {
 		scsi_tgt_priv_data = (struct mpi3mr_stgt_priv_data *)
@@ -1119,6 +1132,7 @@ static void mpi3mr_update_tgtdev(struct mpi3mr_ioc *mrioc,
 		    tgtdev->io_throttle_enabled;
 		if (is_added == true)
 			atomic_set(&scsi_tgt_priv_data->block_io, 0);
+		scsi_tgt_priv_data->wslen = tgtdev->wslen;
 	}
 
 	switch (dev_pg0->access_status) {
@@ -3939,6 +3953,48 @@ void mpi3mr_wait_for_host_io(struct mpi3mr_ioc *mrioc, u32 timeout)
 	    mpi3mr_get_fw_pending_ios(mrioc));
 }
 
+/**
+ * mpi3mr_setup_divert_ws - Setup Divert IO flag for write same
+ * @mrioc: Adapter instance reference
+ * @scmd: SCSI command reference
+ * @scsiio_req: MPI3 SCSI IO request
+ * @scsiio_flags: Pointer to MPI3 SCSI IO Flags
+ * @wslen: write same max length
+ *
+ * Gets values of unmap, ndob and number of blocks from write
+ * same scsi io and based on these values it sets divert IO flag
+ * and reason for diverting IO to firmware.
+ *
+ * Return: Nothing
+ */
+static inline void mpi3mr_setup_divert_ws(struct mpi3mr_ioc *mrioc,
+	struct scsi_cmnd *scmd, struct mpi3_scsi_io_request *scsiio_req,
+	u32 *scsiio_flags, u16 wslen)
+{
+	u8 unmap = 0, ndob = 0;
+	u8 opcode = scmd->cmnd[0];
+	u32 num_blocks = 0;
+	u16 sa = (scmd->cmnd[8] << 8) | (scmd->cmnd[9]);
+
+	if (opcode == WRITE_SAME_16) {
+		unmap = scmd->cmnd[1] & 0x08;
+		ndob = scmd->cmnd[1] & 0x01;
+		num_blocks = get_unaligned_be32(scmd->cmnd + 10);
+	} else if ((opcode == VARIABLE_LENGTH_CMD) && (sa == WRITE_SAME_32)) {
+		unmap = scmd->cmnd[10] & 0x08;
+		ndob = scmd->cmnd[10] & 0x01;
+		num_blocks = get_unaligned_be32(scmd->cmnd + 28);
+	} else
+		return;
+
+	if ((unmap) && (ndob) && (num_blocks > wslen)) {
+		scsiio_req->msg_flags |=
+		    MPI3_SCSIIO_MSGFLAGS_DIVERT_TO_FIRMWARE;
+		*scsiio_flags |=
+			MPI3_SCSIIO_FLAGS_DIVERT_REASON_WRITE_SAME_TOO_LARGE;
+	}
+}
+
 /**
  * mpi3mr_eh_host_reset - Host reset error handling callback
  * @scmd: SCSI command reference
@@ -4436,7 +4492,6 @@ static int mpi3mr_target_alloc(struct scsi_target *starget)
 	unsigned long flags;
 	int retval = 0;
 	struct sas_rphy *rphy = NULL;
-	bool update_stgt_priv_data = false;
 
 	scsi_tgt_priv_data = kzalloc(sizeof(*scsi_tgt_priv_data), GFP_KERNEL);
 	if (!scsi_tgt_priv_data)
@@ -4445,39 +4500,50 @@ static int mpi3mr_target_alloc(struct scsi_target *starget)
 	starget->hostdata = scsi_tgt_priv_data;
 
 	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
-
 	if (starget->channel == mrioc->scsi_device_channel) {
 		tgt_dev = __mpi3mr_get_tgtdev_by_perst_id(mrioc, starget->id);
-		if (tgt_dev && !tgt_dev->is_hidden)
-			update_stgt_priv_data = true;
-		else
+		if (tgt_dev && !tgt_dev->is_hidden) {
+			scsi_tgt_priv_data->starget = starget;
+			scsi_tgt_priv_data->dev_handle = tgt_dev->dev_handle;
+			scsi_tgt_priv_data->perst_id = tgt_dev->perst_id;
+			scsi_tgt_priv_data->dev_type = tgt_dev->dev_type;
+			scsi_tgt_priv_data->tgt_dev = tgt_dev;
+			tgt_dev->starget = starget;
+			atomic_set(&scsi_tgt_priv_data->block_io, 0);
+			retval = 0;
+		if ((tgt_dev->dev_type == MPI3_DEVICE_DEVFORM_PCIE) &&
+		    ((tgt_dev->dev_spec.pcie_inf.dev_info &
+		    MPI3_DEVICE0_PCIE_DEVICE_INFO_TYPE_MASK) ==
+		    MPI3_DEVICE0_PCIE_DEVICE_INFO_TYPE_NVME_DEVICE) &&
+		    ((tgt_dev->dev_spec.pcie_inf.dev_info &
+		    MPI3_DEVICE0_PCIE_DEVICE_INFO_PITYPE_MASK) !=
+		    MPI3_DEVICE0_PCIE_DEVICE_INFO_PITYPE_0))
+			scsi_tgt_priv_data->dev_nvme_dif = 1;
+		scsi_tgt_priv_data->io_throttle_enabled = tgt_dev->io_throttle_enabled;
+		scsi_tgt_priv_data->wslen = tgt_dev->wslen;
+		if (tgt_dev->dev_type == MPI3_DEVICE_DEVFORM_VD)
+			scsi_tgt_priv_data->throttle_group = tgt_dev->dev_spec.vd_inf.tg;
+		} else
 			retval = -ENXIO;
 	} else if (mrioc->sas_transport_enabled && !starget->channel) {
 		rphy = dev_to_rphy(starget->dev.parent);
 		tgt_dev = __mpi3mr_get_tgtdev_by_addr_and_rphy(mrioc,
 		    rphy->identify.sas_address, rphy);
 		if (tgt_dev && !tgt_dev->is_hidden && !tgt_dev->non_stl &&
-		    (tgt_dev->dev_type == MPI3_DEVICE_DEVFORM_SAS_SATA))
-			update_stgt_priv_data = true;
-		else
+		    (tgt_dev->dev_type == MPI3_DEVICE_DEVFORM_SAS_SATA)) {
+			scsi_tgt_priv_data->starget = starget;
+			scsi_tgt_priv_data->dev_handle = tgt_dev->dev_handle;
+			scsi_tgt_priv_data->perst_id = tgt_dev->perst_id;
+			scsi_tgt_priv_data->dev_type = tgt_dev->dev_type;
+			scsi_tgt_priv_data->tgt_dev = tgt_dev;
+			scsi_tgt_priv_data->io_throttle_enabled = tgt_dev->io_throttle_enabled;
+			scsi_tgt_priv_data->wslen = tgt_dev->wslen;
+			tgt_dev->starget = starget;
+			atomic_set(&scsi_tgt_priv_data->block_io, 0);
+			retval = 0;
+		} else
 			retval = -ENXIO;
 	}
-
-	if (update_stgt_priv_data) {
-		scsi_tgt_priv_data->starget = starget;
-		scsi_tgt_priv_data->dev_handle = tgt_dev->dev_handle;
-		scsi_tgt_priv_data->perst_id = tgt_dev->perst_id;
-		scsi_tgt_priv_data->dev_type = tgt_dev->dev_type;
-		scsi_tgt_priv_data->tgt_dev = tgt_dev;
-		tgt_dev->starget = starget;
-		atomic_set(&scsi_tgt_priv_data->block_io, 0);
-		retval = 0;
-		scsi_tgt_priv_data->io_throttle_enabled =
-		    tgt_dev->io_throttle_enabled;
-		if (tgt_dev->dev_type == MPI3_DEVICE_DEVFORM_VD)
-			scsi_tgt_priv_data->throttle_group =
-			    tgt_dev->dev_spec.vd_inf.tg;
-	}
 	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
 
 	return retval;
@@ -4738,6 +4804,10 @@ static int mpi3mr_qcmd(struct Scsi_Host *shost,
 
 	mpi3mr_setup_eedp(mrioc, scmd, scsiio_req);
 
+	if (stgt_priv_data->wslen)
+		mpi3mr_setup_divert_ws(mrioc, scmd, scsiio_req, &scsiio_flags,
+		    stgt_priv_data->wslen);
+
 	memcpy(scsiio_req->cdb.cdb32, scmd->cmnd, scmd->cmd_len);
 	scsiio_req->data_length = cpu_to_le32(scsi_bufflen(scmd));
 	scsiio_req->dev_handle = cpu_to_le16(dev_handle);
-- 
2.31.1


--000000000000d31ad706013b87ec
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
GK2Ee6ez7fr/FL1RWbOPVHJR+deNIorOjW7U5HVwnRYhM1OR4mAkrkqcN+3kwae0KmVO3SDKFd7h
Ok4L2e1ixyaRTo379Ur3iVTnagglDOliayMGRITBPe0CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcmFuamFuLmt1bWFyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU8WuEiYXvpeCaubgLCCFoyRBc
8QwwDQYJKoZIhvcNAQELBQADggEBAA5th3yz1fvJCBmK21x68IdDNFC0gmynT76I3fOgslLHc7ey
lC9VXLb+vJ863blS/WxEOwf0fvc0ks7qYWl8xisInHu5AX9glaooGhLImlzE0l9rDf0tcq2kkgc4
CXL9UGDEoqdxfRj3j9xn9fm9gpTBWSck6ufc/8RV1TLVjcZvrYkMqQwoVulGkr+HCnzaEFxBRmO/
nWsVitGa1sKS9usFXoW1bQXgJ9TtRdy8gka8b9SaKnh4TaiEKpdl8ztXhugWp7RpFGVu/ZZ8narx
0H1L9W/UIr3J/uYokdFr+hIrXOfOwJLB18bWOTCVWxTEo4zYC8qZ/h7UcS5aispm/rkxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxMV+PqteWF5WGw7jsw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPvzKNf19ti8KDKrWN28KabBC7btq5wq
NLGhE0h+Ng4PMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDcy
NDEzMjQxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQDPo7LyKnPX3DWzdxgmZB5WsRSujw1/VDrLH3isGD22EzXYg8QE
BB7d/ZT08mBXZdbSTZNqLAM1+WF6UdENKmllcA1l6/qKSnEm9smumeh4pqzQv8B/0kSTSpN1jIh1
2S8oJ6RnAJcNKZGlo1vE2sB4JVtd/hZ7Dv/a4KcgTA+96Gn4kGlIhuTf+gulx9rlu7XpTQsibX1K
Cn132Sh/k5TykqUd7DrlJl4b7JtxtPzOLB03BMrDabeT1bIRa1DF+ubTM5tTfgpA/Iae3q1JDDzb
hnH5wGI3ThwI12Ku2zQFU0dwRCSS43F7sRnKde+OznyQGs021FL+CbJkhc8Dg1ts
--000000000000d31ad706013b87ec--
