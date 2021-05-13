Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8981337F42B
	for <lists+linux-scsi@lfdr.de>; Thu, 13 May 2021 10:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhEMIf1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 May 2021 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhEMIe7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 13 May 2021 04:34:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E41C06138C
        for <linux-scsi@vger.kernel.org>; Thu, 13 May 2021 01:33:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 10so21195444pfl.1
        for <linux-scsi@vger.kernel.org>; Thu, 13 May 2021 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0nXP7UQbagatx6nK2wQt6aH25tuCzRoI5v1TJaotLy0=;
        b=G4MuynAcF+XKY5xJIZYdploiZPaqICHoSHuRcr3B1KXzgTbgHQRNSYo2xH9JIHpt0Z
         frAtnwF5Z0IZY/b2kWHTkMve95mcudth3AuqZEOjo0lMswY3qt0vuUwLbnVT4r7jRAs0
         lSDFBWwaX6reRZiXM1MLo2IZpaJ8HKHpUbKSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0nXP7UQbagatx6nK2wQt6aH25tuCzRoI5v1TJaotLy0=;
        b=ds5FLb9CEiwdoR2b+/QNCznVCdB2qTCA1tDk7GezCn8+BaGgRK+hRGDrflbUnShmRb
         p/1fLXTZpBC1I2796nMCg2uz2RRmmEAWaeL5LG4MxGKLeK3LHRt2PeYAT5MYcXn1dd5y
         b1Pi3jEHYml7mFhOPtcoDhrXk6Bc+rAJq+rfwo11XFtLV32XVSmMlIR4BacCUjowxZTq
         22kEBdc/XKiHx0HkdTKiQ+5KWayO9Lh3JBH2Dz+MrrDgeZLbpLE92w2JWklJ8J1dx6NO
         bgjE2dsnZaLDDJ6XZIjYBxO+gNlVhfzKDmB67dFjJONv91+hhgsRToJ8U2S1qekx4364
         Iueg==
X-Gm-Message-State: AOAM532PU2BbOcePrtdbPZTpsCRpV97zwFpfMTceAmfLYciCSDmMVr/z
        3L2656unW9SCSBWlBYk5UTm8WFc1mXyy8lluTYA7Yd9KebNRK7f1ugVtR2bbdZ4MAeshF3B6gzh
        1YnkYBIdyUalIvRWRBuy5HpRKB/nB/J7l0XAzR1d3tB2iFF9oFIGO7iUIHM+pGoa5Pr8Oa0RsVT
        bvdNbbSg==
X-Google-Smtp-Source: ABdhPJxCJiZCmlQfofXRWu2jCttj0a66DfvoQ5n9z3UGPyQ2g2vLk6lKzLUPqddZgiT09SzmIppMIw==
X-Received: by 2002:a62:6481:0:b029:249:ecee:a05d with SMTP id y123-20020a6264810000b0290249eceea05dmr39669257pfb.9.1620894818537;
        Thu, 13 May 2021 01:33:38 -0700 (PDT)
Received: from drv-bst-rhel8.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i123sm1632468pfc.53.2021.05.13.01.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 01:33:37 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        sathya.prakash@broadcom.com
Subject: [PATCH v5 19/24] mpi3mr: print pending host ios for debug
Date:   Thu, 13 May 2021 14:06:03 +0530
Message-Id: <20210513083608.2243297-20-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210513083608.2243297-1-kashyap.desai@broadcom.com>
References: <20210513083608.2243297-1-kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e91f5205c231fbf7"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000e91f5205c231fbf7

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Tomas Henzl <thenzl@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Cc: sathya.prakash@broadcom.com
---
 drivers/scsi/mpi3mr/mpi3mr_os.c | 69 +++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index ad3390e02034..cca9c4e9149c 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -333,6 +333,37 @@ void mpi3mr_invalidate_devhandles(struct mpi3mr_ioc *mrioc)
 	}
 }
 
+/**
+ * mpi3mr_print_scmd - print individual SCSI command
+ * @rq: Block request
+ * @data: Adapter instance reference
+ * @reserved: N/A. Currently not used
+ *
+ * Print the SCSI command details if it is in LLD scope.
+ *
+ * Return: true always.
+ */
+static bool mpi3mr_print_scmd(struct request *rq,
+	void *data, bool reserved)
+{
+	struct mpi3mr_ioc *mrioc = (struct mpi3mr_ioc *)data;
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
+	struct scmd_priv *priv = NULL;
+
+	if (scmd) {
+		priv = scsi_cmd_priv(scmd);
+		if (!priv->in_lld_scope)
+			goto out;
+
+		ioc_info(mrioc, "%s :Host Tag = %d, qid = %d\n",
+		    __func__, priv->host_tag, priv->req_q_idx + 1);
+		scsi_print_command(scmd);
+	}
+
+out:
+	return(true);
+}
+
 /**
  * mpi3mr_flush_scmd - Flush individual SCSI command
  * @rq: Block request
@@ -2350,6 +2381,43 @@ static int mpi3mr_map_queues(struct Scsi_Host *shost)
 	    mrioc->pdev, mrioc->op_reply_q_offset);
 }
 
+/**
+ * mpi3mr_get_fw_pending_ios - Calculate pending I/O count
+ * @mrioc: Adapter instance reference
+ *
+ * Calculate the pending I/Os for the controller and return.
+ *
+ * Return: Number of pending I/Os
+ */
+static inline int mpi3mr_get_fw_pending_ios(struct mpi3mr_ioc *mrioc)
+{
+	u16 i;
+	uint pend_ios = 0;
+
+	for (i = 0; i < mrioc->num_op_reply_q; i++)
+		pend_ios += atomic_read(&mrioc->op_reply_qinfo[i].pend_ios);
+	return pend_ios;
+}
+
+/**
+ * mpi3mr_print_pending_host_io - print pending I/Os
+ * @mrioc: Adapter instance reference
+ *
+ * Print number of pending I/Os and each I/O details prior to
+ * reset for debug purpose.
+ *
+ * Return: Nothing
+ */
+static void mpi3mr_print_pending_host_io(struct mpi3mr_ioc *mrioc)
+{
+	struct Scsi_Host *shost = mrioc->shost;
+
+	ioc_info(mrioc, "%s :Pending commands prior to reset: %d\n",
+	    __func__, mpi3mr_get_fw_pending_ios(mrioc));
+	blk_mq_tagset_busy_iter(&shost->tag_set,
+	    mpi3mr_print_scmd, (void *)mrioc);
+}
+
 /**
  * mpi3mr_eh_host_reset - Host reset error handling callback
  * @scmd: SCSI command reference
@@ -2366,6 +2434,7 @@ static int mpi3mr_eh_host_reset(struct scsi_cmnd *scmd)
 	struct mpi3mr_ioc *mrioc = shost_priv(scmd->device->host);
 	int retval = FAILED, ret;
 
+	mpi3mr_print_pending_host_io(mrioc);
 	ret = mpi3mr_soft_reset_handler(mrioc,
 	    MPI3MR_RESET_FROM_EH_HOS, 1);
 	if (ret)
-- 
2.18.1


--000000000000e91f5205c231fbf7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIK5sN5ax/TKVmfpZL/z9PepeXv9b
iCAUeJpoLyV1zLRlMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUxMzA4MzMzOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBtjmDppLoCNyRRFrwz43WU0pd1p5/TJ3FP1+aUS4V5rqxo
FhJ9H6mQ4ZGb9lrKHgBEypuOmJg1QN7ZvpSv6yzS9MHFqaXqfSlTo3QHvzIdWL2C+1/GjVQiJdhm
IDuKbIAer5QuOGkbpvrUjjjp5KklnRXM44zBipvCIxjm01RgLKhIh4VBawZGQ4GGZrNJznjXFKhN
1r2ix04HbecsD17D/8UdykLHGDfmUOXA5jbBIKkvSPPNRZkk59be8wuXoSPzHPV8v4EdO5gZ6BVo
QAgxqkWe4JqhkpT0Z8BQ91zhajJ6lSbwR8dm4yFNFfRfOqQcaQHHtNzeYZc5KDzt1X2h
--000000000000e91f5205c231fbf7--
