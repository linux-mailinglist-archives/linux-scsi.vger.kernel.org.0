Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A4138B30F
	for <lists+linux-scsi@lfdr.de>; Thu, 20 May 2021 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhETPYL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 May 2021 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhETPXi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 May 2021 11:23:38 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD90CC06175F
        for <linux-scsi@vger.kernel.org>; Thu, 20 May 2021 08:22:16 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e17so2001649pfl.5
        for <linux-scsi@vger.kernel.org>; Thu, 20 May 2021 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PWo2feLGLRylj/1ifnAwt+FY8f0+492j6yLH3dQi3to=;
        b=JZMp+VhIYYiyDDWvwnAHFks0U9uEtKE81ybQ+t4t4p3ZSgs4UoJO45VGMNAO2IqYX9
         uVzkZYTqFb0mf7SxeVceixzp3sGs4UhiGFGfckYh5GXkjgj14OMqddD+xlNtSml/rP4C
         ZLxrjnz4UMG+Kytvg8BG1TcVIcy2uqYqG0cq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PWo2feLGLRylj/1ifnAwt+FY8f0+492j6yLH3dQi3to=;
        b=DwBgMct5PWr5dZ7lxKyq/UqdC7oTHjCMeUYnkaGmtl6HekGz/DApMdNIENBofrDvF/
         Xp5X+ZFSTo7ftSLfOV5uPlJcotzBryBZtV4U4TLRqWTcsRUQzVu+k5qgYPpba6rhp1Zm
         8wEH2XPO3zguMya+dt1UbYV0PXT3/ZgqbzsFsmaBBG2d5yx7l0gotafOEdOVolYg9N/T
         Q8zLlwDiGu82V9wHypdSPirv/EiA0oXD4WHj/nyWCCgDGCD+0qkCCwG33Q2T3XYwUjUS
         JY7EaASwi00XICA9q8oJr4w29RibX1cbfhslYUbCpgvdKnL/PVaivqViE4n0I1dNEIcX
         JEKg==
X-Gm-Message-State: AOAM531Xq+NXzjh1Wd/xdnJyecJBO/L+epomUqV/veyCcMpDSAPv+e1A
        PQD1FP0Q3uLWegUzFzrPF2hx+RKA2kGgpwPmdGFleaFeLY3BsE+lZZftpJFni2SHy4R0ook8eLi
        eF48H7jGTlOfIWJAUJi4EJBCO1eJBKYt7jK0imi5QmxOKsf9kKoKHluKXwrj2HlaOsLf2oDP+9y
        ZAptlDBg==
X-Google-Smtp-Source: ABdhPJy3xohbSRL3rFYDVONEKkNZ9S5uXiW4bWtzMigrz1OzXv6LOkJi1N4n97QY/naAAawHm2Y2WA==
X-Received: by 2002:a62:1d90:0:b029:2db:649d:7e6e with SMTP id d138-20020a621d900000b02902db649d7e6emr4945504pfd.75.1621524135463;
        Thu, 20 May 2021 08:22:15 -0700 (PDT)
Received: from drv-bst-rhel8.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s8sm2250557pfe.112.2021.05.20.08.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:22:15 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        sathya.prakash@broadcom.com
Subject: [PATCH v6 18/24] mpi3mr: add complete support of soft reset
Date:   Thu, 20 May 2021 20:55:39 +0530
Message-Id: <20210520152545.2710479-19-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210520152545.2710479-1-kashyap.desai@broadcom.com>
References: <20210520152545.2710479-1-kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000020963205c2c482fd"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--00000000000020963205c2c482fd

Unlock the host diagnostic registers and write the specific
reset type to that, wait for reset acknowledgment from the
controller, if the reset is not successful retry for the
predefined number of times

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Tomas Henzl <thenzl@redhat.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

Cc: sathya.prakash@broadcom.com
---
 drivers/scsi/mpi3mr/mpi3mr.h    |   3 +
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 246 +++++++++++++++++++++++++++++++-
 2 files changed, 247 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 2d760ee..5a3a137 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -194,6 +194,9 @@ enum mpi3mr_reset_reason {
 	MPI3MR_RESET_FROM_EVTACK_TIMEOUT = 19,
 	MPI3MR_RESET_FROM_CIACTVRST_TIMER = 20,
 	MPI3MR_RESET_FROM_GETPKGVER_TIMEOUT = 21,
+	MPI3MR_RESET_FROM_PELABORT_TIMEOUT = 22,
+	MPI3MR_RESET_FROM_SYSFS = 23,
+	MPI3MR_RESET_FROM_SYSFS_TIMEOUT = 24
 };
 
 /**
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 6a7891d..605015e 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -639,6 +639,101 @@ static const char *mpi3mr_iocstate_name(enum mpi3mr_iocstate mrioc_state)
 	return name;
 }
 
+/* Reset reason to name mapper structure*/
+static const struct {
+	enum mpi3mr_reset_reason value;
+	char *name;
+} mpi3mr_reset_reason_codes[] = {
+	{ MPI3MR_RESET_FROM_BRINGUP, "timeout in bringup" },
+	{ MPI3MR_RESET_FROM_FAULT_WATCH, "fault" },
+	{ MPI3MR_RESET_FROM_IOCTL, "application invocation" },
+	{ MPI3MR_RESET_FROM_EH_HOS, "error handling" },
+	{ MPI3MR_RESET_FROM_TM_TIMEOUT, "TM timeout" },
+	{ MPI3MR_RESET_FROM_IOCTL_TIMEOUT, "IOCTL timeout" },
+	{ MPI3MR_RESET_FROM_MUR_FAILURE, "MUR failure" },
+	{ MPI3MR_RESET_FROM_CTLR_CLEANUP, "timeout in controller cleanup" },
+	{ MPI3MR_RESET_FROM_CIACTIV_FAULT, "component image activation fault" },
+	{ MPI3MR_RESET_FROM_PE_TIMEOUT, "port enable timeout" },
+	{ MPI3MR_RESET_FROM_TSU_TIMEOUT, "time stamp update timeout" },
+	{ MPI3MR_RESET_FROM_DELREQQ_TIMEOUT, "delete request queue timeout" },
+	{ MPI3MR_RESET_FROM_DELREPQ_TIMEOUT, "delete reply queue timeout" },
+	{
+		MPI3MR_RESET_FROM_CREATEREPQ_TIMEOUT,
+		"create request queue timeout"
+	},
+	{
+		MPI3MR_RESET_FROM_CREATEREQQ_TIMEOUT,
+		"create reply queue timeout"
+	},
+	{ MPI3MR_RESET_FROM_IOCFACTS_TIMEOUT, "IOC facts timeout" },
+	{ MPI3MR_RESET_FROM_IOCINIT_TIMEOUT, "IOC init timeout" },
+	{ MPI3MR_RESET_FROM_EVTNOTIFY_TIMEOUT, "event notify timeout" },
+	{ MPI3MR_RESET_FROM_EVTACK_TIMEOUT, "event acknowledgment timeout" },
+	{
+		MPI3MR_RESET_FROM_CIACTVRST_TIMER,
+		"component image activation timeout"
+	},
+	{
+		MPI3MR_RESET_FROM_GETPKGVER_TIMEOUT,
+		"get package version timeout"
+	},
+	{ MPI3MR_RESET_FROM_SYSFS, "sysfs invocation" },
+	{ MPI3MR_RESET_FROM_SYSFS_TIMEOUT, "sysfs TM timeout" },
+};
+
+/**
+ * mpi3mr_reset_rc_name - get reset reason code name
+ * @reason_code: reset reason code value
+ *
+ * Map reset reason to an NULL terminated ASCII string
+ *
+ * Return: name corresponding to reset reason value or NULL.
+ */
+static const char *mpi3mr_reset_rc_name(enum mpi3mr_reset_reason reason_code)
+{
+	int i;
+	char *name = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(mpi3mr_reset_reason_codes); i++) {
+		if (mpi3mr_reset_reason_codes[i].value == reason_code) {
+			name = mpi3mr_reset_reason_codes[i].name;
+			break;
+		}
+	}
+	return name;
+}
+
+/* Reset type to name mapper structure*/
+static const struct {
+	u16 reset_type;
+	char *name;
+} mpi3mr_reset_types[] = {
+	{ MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET, "soft" },
+	{ MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT, "diag fault" },
+};
+
+/**
+ * mpi3mr_reset_type_name - get reset type name
+ * @reset_type: reset type value
+ *
+ * Map reset type to an NULL terminated ASCII string
+ *
+ * Return: name corresponding to reset type value or NULL.
+ */
+static const char *mpi3mr_reset_type_name(u16 reset_type)
+{
+	int i;
+	char *name = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(mpi3mr_reset_types); i++) {
+		if (mpi3mr_reset_types[i].reset_type == reset_type) {
+			name = mpi3mr_reset_types[i].name;
+			break;
+		}
+	}
+	return name;
+}
+
 /**
  * mpi3mr_print_fault_info - Display fault information
  * @mrioc: Adapter instance reference
@@ -800,6 +895,48 @@ static int mpi3mr_bring_ioc_ready(struct mpi3mr_ioc *mrioc)
 	return -1;
 }
 
+/**
+ * mpi3mr_soft_reset_success - Check softreset is success or not
+ * @ioc_status: IOC status register value
+ * @ioc_config: IOC config register value
+ *
+ * Check whether the soft reset is successful or not based on
+ * IOC status and IOC config register values.
+ *
+ * Return: True when the soft reset is success, false otherwise.
+ */
+static inline bool
+mpi3mr_soft_reset_success(u32 ioc_status, u32 ioc_config)
+{
+	if (!((ioc_status & MPI3_SYSIF_IOC_STATUS_READY) ||
+	    (ioc_status & MPI3_SYSIF_IOC_STATUS_FAULT) ||
+	    (ioc_config & MPI3_SYSIF_IOC_CONFIG_ENABLE_IOC)))
+		return true;
+	return false;
+}
+
+/**
+ * mpi3mr_diagfault_success - Check diag fault is success or not
+ * @mrioc: Adapter reference
+ * @ioc_status: IOC status register value
+ *
+ * Check whether the controller hit diag reset fault code.
+ *
+ * Return: True when there is diag fault, false otherwise.
+ */
+static inline bool mpi3mr_diagfault_success(struct mpi3mr_ioc *mrioc,
+	u32 ioc_status)
+{
+	u32 fault;
+
+	if (!(ioc_status & MPI3_SYSIF_IOC_STATUS_FAULT))
+		return false;
+	fault = readl(&mrioc->sysif_regs->fault) & MPI3_SYSIF_FAULT_CODE_MASK;
+	if (fault == MPI3_SYSIF_FAULT_CODE_DIAG_FAULT_RESET)
+		return true;
+	return false;
+}
+
 /**
  * mpi3mr_set_diagsave - Set diag save bit for snapdump
  * @mrioc: Adapter reference
@@ -824,14 +961,117 @@ static inline void mpi3mr_set_diagsave(struct mpi3mr_ioc *mrioc)
  * @reset_type: Reset type
  * @reset_reason: Reset reason code
  *
- * TBD
+ * Unlock the host diagnostic registers and write the specific
+ * reset type to that, wait for reset acknowledgment from the
+ * controller, if the reset is not successful retry for the
+ * predefined number of times.
  *
  * Return: 0 on success, non-zero on failure.
  */
 static int mpi3mr_issue_reset(struct mpi3mr_ioc *mrioc, u16 reset_type,
 	u32 reset_reason)
 {
-	return 0;
+	int retval = -1;
+	u8 unlock_retry_count, reset_retry_count = 0;
+	u32 host_diagnostic, timeout, ioc_status, ioc_config;
+
+	pci_cfg_access_lock(mrioc->pdev);
+	if ((reset_type != MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET) &&
+	    (reset_type != MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT))
+		goto out;
+	if (mrioc->unrecoverable)
+		goto out;
+retry_reset:
+	unlock_retry_count = 0;
+	mpi3mr_clear_reset_history(mrioc);
+	do {
+		ioc_info(mrioc,
+		    "Write magic sequence to unlock host diag register (retry=%d)\n",
+		    ++unlock_retry_count);
+		if (unlock_retry_count >= MPI3MR_HOSTDIAG_UNLOCK_RETRY_COUNT) {
+			writel(reset_reason, &mrioc->sysif_regs->scratchpad[0]);
+			mrioc->unrecoverable = 1;
+			goto out;
+		}
+
+		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_FLUSH,
+		    &mrioc->sysif_regs->write_sequence);
+		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_1ST,
+		    &mrioc->sysif_regs->write_sequence);
+		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_2ND,
+		    &mrioc->sysif_regs->write_sequence);
+		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_3RD,
+		    &mrioc->sysif_regs->write_sequence);
+		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_4TH,
+		    &mrioc->sysif_regs->write_sequence);
+		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_5TH,
+		    &mrioc->sysif_regs->write_sequence);
+		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_6TH,
+		    &mrioc->sysif_regs->write_sequence);
+		usleep_range(1000, 1100);
+		host_diagnostic = readl(&mrioc->sysif_regs->host_diagnostic);
+		ioc_info(mrioc,
+		    "wrote magic sequence: retry_count(%d), host_diagnostic(0x%08x)\n",
+		    unlock_retry_count, host_diagnostic);
+	} while (!(host_diagnostic & MPI3_SYSIF_HOST_DIAG_DIAG_WRITE_ENABLE));
+
+	writel(reset_reason, &mrioc->sysif_regs->scratchpad[0]);
+	ioc_info(mrioc, "%s reset due to %s(0x%x)\n",
+	    mpi3mr_reset_type_name(reset_type),
+	    mpi3mr_reset_rc_name(reset_reason), reset_reason);
+	writel(host_diagnostic | reset_type,
+	    &mrioc->sysif_regs->host_diagnostic);
+	timeout = mrioc->ready_timeout * 10;
+	if (reset_type == MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET) {
+		do {
+			ioc_status = readl(&mrioc->sysif_regs->ioc_status);
+			if (ioc_status &
+			    MPI3_SYSIF_IOC_STATUS_RESET_HISTORY) {
+				mpi3mr_clear_reset_history(mrioc);
+				ioc_config =
+				    readl(&mrioc->sysif_regs->ioc_configuration);
+				if (mpi3mr_soft_reset_success(ioc_status,
+				    ioc_config)) {
+					retval = 0;
+					break;
+				}
+			}
+			msleep(100);
+		} while (--timeout);
+		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_2ND,
+		    &mrioc->sysif_regs->write_sequence);
+	} else if (reset_type == MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT) {
+		do {
+			ioc_status = readl(&mrioc->sysif_regs->ioc_status);
+			if (mpi3mr_diagfault_success(mrioc, ioc_status)) {
+				retval = 0;
+				break;
+			}
+			msleep(100);
+		} while (--timeout);
+		mpi3mr_clear_reset_history(mrioc);
+		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_2ND,
+		    &mrioc->sysif_regs->write_sequence);
+	}
+	if (retval && ((++reset_retry_count) < MPI3MR_MAX_RESET_RETRY_COUNT)) {
+		ioc_status = readl(&mrioc->sysif_regs->ioc_status);
+		ioc_config = readl(&mrioc->sysif_regs->ioc_configuration);
+		ioc_info(mrioc,
+		    "Base IOC Sts/Config after reset try %d is (0x%x)/(0x%x)\n",
+		    reset_retry_count, ioc_status, ioc_config);
+		goto retry_reset;
+	}
+
+out:
+	pci_cfg_access_unlock(mrioc->pdev);
+	ioc_status = readl(&mrioc->sysif_regs->ioc_status);
+	ioc_config = readl(&mrioc->sysif_regs->ioc_configuration);
+
+	ioc_info(mrioc,
+	    "Base IOC Sts/Config after %s reset is (0x%x)/(0x%x)\n",
+	    (!retval) ? "successful" : "failed", ioc_status,
+	    ioc_config);
+	return retval;
 }
 
 /**
@@ -3448,6 +3688,8 @@ int mpi3mr_diagfault_reset_handler(struct mpi3mr_ioc *mrioc,
 {
 	int retval = 0;
 
+	ioc_info(mrioc, "Entry: reason code: %s\n",
+	    mpi3mr_reset_rc_name(reset_reason));
 	mrioc->reset_in_progress = 1;
 
 	mpi3mr_ioc_disable_intr(mrioc);
-- 
2.18.1


--00000000000020963205c2c482fd
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
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHlp03mDRcbD5L2qqANgYVkEr2Ed
fM4r/NWLmN+5gw7dMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUyMDE1MjIxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBeIIWkaZ21/NkpxIJUkFcpRRkQPiO2onQOwag+fGKDhaWY
6fAoQz4nqUS2VIfZWM79vGKWef8qVdpNEipFGu0NxtSneejrODodehzM2MW6iLwPulTxjX7aQVk0
SQRHZ968RQ0oOMH6KiUHSFC6fSe+H7G2kSEGh7ZHeQSpXCBglHnFaVbS6OCcFib3CPq/22Rd6s4L
RUcStjPzfPPdspz7WCy7EFjTbxlqDWoEJ0ypD3Pk6RRXhTP41Qwg0rSDZ9xU2wvUqTCj+2UNg4Ez
0U6HoM3jqLgr8hT5WstDdW0ByjRMoocuzAKgC/8OlXwkDXOVbHpgKyE0FKYzUibjcD3M
--00000000000020963205c2c482fd--
