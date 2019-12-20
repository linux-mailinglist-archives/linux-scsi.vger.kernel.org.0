Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF6512796B
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Dec 2019 11:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfLTKcg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Dec 2019 05:32:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36438 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfLTKcg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 20 Dec 2019 05:32:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so4740257pgc.3
        for <linux-scsi@vger.kernel.org>; Fri, 20 Dec 2019 02:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K8aMOOzkB4ZENXSc5mKaFOkWvqexGaJc2uVk27zYfGY=;
        b=AdCQ6HAPmRAjRwYlgo0iXNL3mZJI9ymHeIt7RHnXlDerG+s3lEGk+Ck7AfwWi2MWU3
         hitY4eN7Kl/66ogCJk+F168h76BW5F+KpOQd0JUhD48ddCkrIZjsrLXR6gOCiK96hVda
         u7ePybHLH/OHf1UF0VDwavzFU1c0RW0t1pJpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K8aMOOzkB4ZENXSc5mKaFOkWvqexGaJc2uVk27zYfGY=;
        b=jUAkscnu/TsG31hAKSqOKbYcnyVlHDjrSv72OQUplcaqzKtH9bpGRvsA+jbWsS6b7Y
         d1k6Yd2YmTYTJczCzV1ZAGlbMzYQByU9bSX/3Upv9HfnabooDZFsiPhWfdS+1nrcSHgb
         VMiAb64wPDgcVqP5WqKTfSJZz2aKF/wYHA3p2GALUms7QmP/LM+WzAabkzfVLoBWZUoj
         Arn5VE7tbNoIEv5MfbRtGTPxJXzxq/pPYf5D3VL+YCe/act5DBJZ8GjAZ5R9tguTY737
         Stp4I515nDGVlhNlgbDlps27No1oGJRp8eb7K6WZaGdNdcsyMBZ0Pckq5+xdjBVMvJOo
         XtrA==
X-Gm-Message-State: APjAAAWt+ujtprRYPF14MCsfwKuqqD+roA/j/HPYqNsABYQ3qGx6Dr9E
        jETfbymsQooJCxJCSDGj/rH9NQ65SxcUmj8ndwJRcnf6lAQbzK11ir2rD8UvCJPzj/6ZuBYGJwe
        AOIyvE2JO8bgXx7lPvY9cHAam1BNX0QqoIo/h7HunrsSdsGt0yP2FFVHSvYBzAXhbat/119WYzt
        PATZ1UimfvthlB70KGmA==
X-Google-Smtp-Source: APXvYqyxdJwjXgpBrn6PwOlcmGsrtxUHNApfMw+pLSHjfXHkKB3rxrj5hrG0nUDNLjXd7w9DTVZy9w==
X-Received: by 2002:a62:3141:: with SMTP id x62mr15423614pfx.214.1576837955011;
        Fri, 20 Dec 2019 02:32:35 -0800 (PST)
Received: from dhcp-10-123-20-125.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 200sm12185364pfz.121.2019.12.20.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 02:32:34 -0800 (PST)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     sreekanth.reddy@broadcom.com, sathya.prakash@broadcom.com,
        kashyap.desai@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 04/10] mpt3sas: Add support IOCs new state named COREDUMP
Date:   Fri, 20 Dec 2019 05:32:04 -0500
Message-Id: <20191220103210.43631-5-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20191220103210.43631-1-suganath-prabu.subramani@broadcom.com>
References: <20191220103210.43631-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

New feature is added in HBA firmware where it copies
the collected firmware logs in flash region named 'CoreDump'
whenever HBA firmware faults occurs.

For copying the logs to CoreDump flash region firmware
needs some time and hence it has introduced a new IOC state
named "CoreDump" State.

Whenever driver detects the CoreDump state then it means that
some firmware fault has occurred and firmware is copying the
logs to the coredump flash region. During this time driver
should not perform any operation with the HBA, driver
should wait for HBA firmware to move the IOC state from
'CoreDump' state to 'Fault' state once it's done with copying
the logs to coredump region. Once driver detects the
Fault state then it will issue the diag reset/host reset
operation to move the IOC state from Fault to Operational state.

Here the valid IOC state transactions w.r.t to this
CoreDump state feature,

Operational -> Fault:
The IOC transitions to the Fault state when an operational
error occurs AND CoreDump is not supported (or disabled)
by the firmware(FW).

Operational -> CoreDump:
The IOC transitions to the CoreDump state when an operational
error occurs AND CoreDump is supported & enabled by the FW.

CoreDump -> Fault:
A transition from CoreDump state to Fault state happens
when the FW completes the CoreDump collection.

CoreDump -> Reset:
A transition out of the CoreDump state happens when the
host sets the Reset Adapter bit in the System Diagnostic
Register (Hard Reset). This reset action indicates
that CoreDump took longer than the host time out.

Firmware informs the driver about the maximum time that driver
has to wait for firmware to transition the IOC state from
'CoreDump' to 'FAULT' state through 'CoreDumpTOSec' field of
ManufacturingPage11 page. if this 'CoreDumpTOSec' field value
is zero then driver will wait for max 15 seconds.

Driver informs the HBA firmware that it supports this new
IOC state named 'CoreDump' state by enabling COREDUMP_ENABLE
flag in ConfigurationFlags field of ioc init request message.

Current patch handles the CoreDump state only during HBA
initialization and release scenarios where watchdog thread
(which polls the IOC state in every one second) is disabled.
Next subsequent patch handle the CoreDump state when
watchdog thread is enabled.

During HBA initialization or release execution time if driver
detects the CoreDump state then driver will wait for maximum
CoreDumpTOSec value seconds for FW to copy the logs. After
that it will issue the diag reset operation to move the IOC
state to Operational state.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 111 +++++++++++++++++++++++++++-
 drivers/scsi/mpt3sas/mpt3sas_base.h |  11 ++-
 2 files changed, 118 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 589b41d..2e4be9a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -123,6 +123,9 @@ enum mpt3sas_perf_mode {
 	MPT_PERF_MODE_LATENCY	= 2,
 };
 
+static int
+_base_wait_on_iocstate(struct MPT3SAS_ADAPTER *ioc,
+		u32 ioc_state, int timeout);
 static int
 _base_get_ioc_facts(struct MPT3SAS_ADAPTER *ioc);
 
@@ -748,6 +751,49 @@ mpt3sas_base_fault_info(struct MPT3SAS_ADAPTER *ioc , u16 fault_code)
 	ioc_err(ioc, "fault_state(0x%04x)!\n", fault_code);
 }
 
+/**
+ * mpt3sas_base_coredump_info - verbose translation of firmware CoreDump state
+ * @ioc: per adapter object
+ * @fault_code: fault code
+ *
+ * Return nothing.
+ */
+void
+mpt3sas_base_coredump_info(struct MPT3SAS_ADAPTER *ioc, u16 fault_code)
+{
+	ioc_err(ioc, "coredump_state(0x%04x)!\n", fault_code);
+}
+
+/**
+ * mpt3sas_base_wait_for_coredump_completion - Wait until coredump
+ * completes or times out
+ * @ioc: per adapter object
+ *
+ * Returns 0 for success, non-zero for failure.
+ */
+int
+mpt3sas_base_wait_for_coredump_completion(struct MPT3SAS_ADAPTER *ioc,
+		const char *caller)
+{
+	u8 timeout = (ioc->manu_pg11.CoreDumpTOSec) ?
+			ioc->manu_pg11.CoreDumpTOSec :
+			MPT3SAS_DEFAULT_COREDUMP_TIMEOUT_SECONDS;
+
+	int ioc_state = _base_wait_on_iocstate(ioc, MPI2_IOC_STATE_FAULT,
+					timeout);
+
+	if (ioc_state)
+		ioc_err(ioc,
+		    "%s: CoreDump timed out. (ioc_state=0x%x)\n",
+		    caller, ioc_state);
+	else
+		ioc_info(ioc,
+		    "%s: CoreDump completed. (ioc_state=0x%x)\n",
+		    caller, ioc_state);
+
+	return ioc_state;
+}
+
 /**
  * mpt3sas_halt_firmware - halt's mpt controller firmware
  * @ioc: per adapter object
@@ -768,9 +814,14 @@ mpt3sas_halt_firmware(struct MPT3SAS_ADAPTER *ioc)
 	dump_stack();
 
 	doorbell = ioc->base_readl(&ioc->chip->Doorbell);
-	if ((doorbell & MPI2_IOC_STATE_MASK) == MPI2_IOC_STATE_FAULT)
-		mpt3sas_base_fault_info(ioc , doorbell);
-	else {
+	if ((doorbell & MPI2_IOC_STATE_MASK) == MPI2_IOC_STATE_FAULT) {
+		mpt3sas_base_fault_info(ioc, doorbell &
+		    MPI2_DOORBELL_DATA_MASK);
+	} else if ((doorbell & MPI2_IOC_STATE_MASK) ==
+	    MPI2_IOC_STATE_COREDUMP) {
+		mpt3sas_base_coredump_info(ioc, doorbell &
+		    MPI2_DOORBELL_DATA_MASK);
+	} else {
 		writel(0xC0FFEE00, &ioc->chip->Doorbell);
 		ioc_err(ioc, "Firmware is halted due to command timeout\n");
 	}
@@ -3209,6 +3260,12 @@ _base_check_for_fault_and_issue_reset(struct MPT3SAS_ADAPTER *ioc)
 		mpt3sas_base_fault_info(ioc, ioc_state &
 		    MPI2_DOORBELL_DATA_MASK);
 		rc = _base_diag_reset(ioc);
+	} else if ((ioc_state & MPI2_IOC_STATE_MASK) ==
+	    MPI2_IOC_STATE_COREDUMP) {
+		mpt3sas_base_coredump_info(ioc, ioc_state &
+		     MPI2_DOORBELL_DATA_MASK);
+		mpt3sas_base_wait_for_coredump_completion(ioc, __func__);
+		rc = _base_diag_reset(ioc);
 	}
 
 	return rc;
@@ -5447,6 +5504,8 @@ _base_wait_on_iocstate(struct MPT3SAS_ADAPTER *ioc, u32 ioc_state, int timeout)
 			return 0;
 		if (count && current_state == MPI2_IOC_STATE_FAULT)
 			break;
+		if (count && current_state == MPI2_IOC_STATE_COREDUMP)
+			break;
 
 		usleep_range(1000, 1500);
 		count++;
@@ -5551,6 +5610,11 @@ _base_wait_for_doorbell_ack(struct MPT3SAS_ADAPTER *ioc, int timeout)
 				mpt3sas_base_fault_info(ioc , doorbell);
 				return -EFAULT;
 			}
+			if ((doorbell & MPI2_IOC_STATE_MASK) ==
+			    MPI2_IOC_STATE_COREDUMP) {
+				mpt3sas_base_coredump_info(ioc, doorbell);
+				return -EFAULT;
+			}
 		} else if (int_status == 0xFFFFFFFF)
 			goto out;
 
@@ -5610,6 +5674,7 @@ _base_send_ioc_reset(struct MPT3SAS_ADAPTER *ioc, u8 reset_type, int timeout)
 {
 	u32 ioc_state;
 	int r = 0;
+	unsigned long flags;
 
 	if (reset_type != MPI2_FUNCTION_IOC_MESSAGE_UNIT_RESET) {
 		ioc_err(ioc, "%s: unknown reset_type\n", __func__);
@@ -5628,6 +5693,7 @@ _base_send_ioc_reset(struct MPT3SAS_ADAPTER *ioc, u8 reset_type, int timeout)
 		r = -EFAULT;
 		goto out;
 	}
+
 	ioc_state = _base_wait_on_iocstate(ioc, MPI2_IOC_STATE_READY, timeout);
 	if (ioc_state) {
 		ioc_err(ioc, "%s: failed going to ready state (ioc_state=0x%x)\n",
@@ -5636,6 +5702,26 @@ _base_send_ioc_reset(struct MPT3SAS_ADAPTER *ioc, u8 reset_type, int timeout)
 		goto out;
 	}
  out:
+	if (r != 0) {
+		ioc_state = mpt3sas_base_get_iocstate(ioc, 0);
+		spin_lock_irqsave(&ioc->ioc_reset_in_progress_lock, flags);
+		/*
+		 * Wait for IOC state CoreDump to clear only during
+		 * HBA initialization & release time.
+		 */
+		if ((ioc_state & MPI2_IOC_STATE_MASK) ==
+		    MPI2_IOC_STATE_COREDUMP && (ioc->is_driver_loading == 1 ||
+		    ioc->fault_reset_work_q == NULL)) {
+			spin_unlock_irqrestore(
+			    &ioc->ioc_reset_in_progress_lock, flags);
+			mpt3sas_base_coredump_info(ioc, ioc_state);
+			mpt3sas_base_wait_for_coredump_completion(ioc,
+			    __func__);
+			spin_lock_irqsave(
+			    &ioc->ioc_reset_in_progress_lock, flags);
+		}
+		spin_unlock_irqrestore(&ioc->ioc_reset_in_progress_lock, flags);
+	}
 	ioc_info(ioc, "message unit reset: %s\n",
 		 r == 0 ? "SUCCESS" : "FAILED");
 	return r;
@@ -6032,6 +6118,12 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
 		mpt3sas_base_fault_info(ioc, ioc_state &
 		    MPI2_DOORBELL_DATA_MASK);
 		goto issue_diag_reset;
+	} else if ((ioc_state & MPI2_IOC_STATE_MASK) ==
+	    MPI2_IOC_STATE_COREDUMP) {
+		ioc_info(ioc,
+		    "%s: Skipping the diag reset here. (ioc_state=0x%x)\n",
+		    __func__, ioc_state);
+		return -EFAULT;
 	}
 
 	ioc_state = _base_wait_on_iocstate(ioc, MPI2_IOC_STATE_READY, timeout);
@@ -6210,6 +6302,12 @@ _base_send_ioc_init(struct MPT3SAS_ADAPTER *ioc)
 		    cpu_to_le64((u64)ioc->reply_post[0].reply_post_free_dma);
 	}
 
+	/*
+	 * Set the flag to enable CoreDump state feature in IOC firmware.
+	 */
+	mpi_request.ConfigurationFlags |=
+	    cpu_to_le16(MPI26_IOCINIT_CFGFLAGS_COREDUMP_ENABLE);
+
 	/* This time stamp specifies number of milliseconds
 	 * since epoch ~ midnight January 1, 1970.
 	 */
@@ -6716,6 +6814,13 @@ _base_make_ioc_ready(struct MPT3SAS_ADAPTER *ioc, enum reset_type type)
 		goto issue_diag_reset;
 	}
 
+	if ((ioc_state & MPI2_IOC_STATE_MASK) == MPI2_IOC_STATE_COREDUMP) {
+		mpt3sas_base_coredump_info(ioc, ioc_state &
+		    MPI2_DOORBELL_DATA_MASK);
+		mpt3sas_base_wait_for_coredump_completion(ioc, __func__);
+		goto issue_diag_reset;
+	}
+
 	if (type == FORCE_BIG_HAMMER)
 		goto issue_diag_reset;
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 70f3a76..d29753f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -90,6 +90,9 @@
 #define MPT2SAS_BUILD_VERSION		0
 #define MPT2SAS_RELEASE_VERSION	00
 
+/* CoreDump: Default timeout */
+#define MPT3SAS_DEFAULT_COREDUMP_TIMEOUT_SECONDS	(15) /*15 seconds*/
+
 /*
  * Set MPT3SAS_SG_DEPTH value based on user input.
  */
@@ -399,7 +402,10 @@ struct Mpi2ManufacturingPage11_t {
 	u8	HostTraceBufferFlags;		/* 4Fh */
 	u16	HostTraceBufferMaxSizeKB;	/* 50h */
 	u16	HostTraceBufferMinSizeKB;	/* 52h */
-	__le32	Reserved10[2];			/* 54h - 5Bh */
+	u8	CoreDumpTOSec;			/* 54h */
+	u8	Reserved8;			/* 55h */
+	u16	Reserved9;			/* 56h */
+	__le32	Reserved10;			/* 58h */
 };
 
 /**
@@ -1538,6 +1544,9 @@ void *mpt3sas_base_get_reply_virt_addr(struct MPT3SAS_ADAPTER *ioc,
 u32 mpt3sas_base_get_iocstate(struct MPT3SAS_ADAPTER *ioc, int cooked);
 
 void mpt3sas_base_fault_info(struct MPT3SAS_ADAPTER *ioc , u16 fault_code);
+void mpt3sas_base_coredump_info(struct MPT3SAS_ADAPTER *ioc, u16 fault_code);
+int mpt3sas_base_wait_for_coredump_completion(struct MPT3SAS_ADAPTER *ioc,
+		const char *caller);
 int mpt3sas_base_sas_iounit_control(struct MPT3SAS_ADAPTER *ioc,
 	Mpi2SasIoUnitControlReply_t *mpi_reply,
 	Mpi2SasIoUnitControlRequest_t *mpi_request);
-- 
2.18.1

