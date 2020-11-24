Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345F02C1C47
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Nov 2020 04:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgKXDw3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Nov 2020 22:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgKXDw3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 23 Nov 2020 22:52:29 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1722AC0613CF
        for <linux-scsi@vger.kernel.org>; Mon, 23 Nov 2020 19:52:29 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 34so16247015pgp.10
        for <linux-scsi@vger.kernel.org>; Mon, 23 Nov 2020 19:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=RfKzpWg95fRhVnkBUQzbGkzIpR9Y6UF9xdACzKQ45ZE=;
        b=BzvFLz/8dhPzdYk6DOItIhkAGpgZHMBrPmZdYgKZEGYGlfXAID+2pqUn6M4p9EPYVY
         Mk0S9Hn/WzRti3r6r+xdG5w3Qww/EZvNt/PI3hKRqWpyQMz39KRlrZ6DE6anAuGBz9Ih
         zYbQiXIVaCD1CHoY1UUh7CcVvlLinSnRoizwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=RfKzpWg95fRhVnkBUQzbGkzIpR9Y6UF9xdACzKQ45ZE=;
        b=tgmYONAoln+YlfXY8oQKaNkMXVZ0LBvq4QY+4tfdqu+A7R+cWGOAAp7K7nOlXe7RW0
         4yfC+nhXZhWD2eOjcLqNBCmoxMWnZnHpjw55NbDH+qmN6R9ZX6ei3Alg3SGEbcWWvKFd
         z9QjtHkm7U4mnLmkSMv/UARtHJD6kTWOrkvdNIeEFDUu+7ZWkY8qDXGNHZWpOup+ZcZz
         /Cw9uYhDBwKHI4u9YgoIqJzxGEPFz3J1Po/0Z6iQd/nBZpT3YNknYZwrvZH0QZbzZ9Gz
         uV7IB7pqTVga35rAY2ebD7Ed4ffDxKQdpfq+zfj7ISbIL+yqhn7FUdPL76t8WSx22vXE
         yBPw==
X-Gm-Message-State: AOAM532LmGPHnTGLYZPyrwywlkufB52pALhAcBHRpUXlOg1e10eLcG1Z
        YyjK8OtgLD+3+brhxbw1GngvFMqMHndyD9hD+XH7gW1Ayevxi1ClTwzpd5Yo/rD2BS8hDcdFHSo
        LSrFAe6g9MyO2ZYghOZm9kHbjNsamsOKRyPBE/DH9GrZg0auKd69WZDIlLdbX3DsMc+C/ITOZKH
        r6XnsCnrKJarm50yzKkBuFc/g=
X-Google-Smtp-Source: ABdhPJwroxf2Be5wvV/u/i0rkpkL1tDbNhpKK5Zhvfs9DNPA6cPuXJrdVCcDQuRvXaM0YQ+QulipRQ==
X-Received: by 2002:a17:90a:c17:: with SMTP id 23mr2544998pjs.199.1606189947942;
        Mon, 23 Nov 2020 19:52:27 -0800 (PST)
Received: from dhcp-10-123-20-14.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x8sm851093pjr.52.2020.11.23.19.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 19:52:27 -0800 (PST)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 1/8] mpt3sas: Sync time stamp periodically between Driver and FW
Date:   Tue, 24 Nov 2020 09:20:12 +0530
Message-Id: <20201124035019.27975-2-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201124035019.27975-1-suganath-prabu.subramani@broadcom.com>
References: <20201124035019.27975-1-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000052004505b4d23d7f"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--00000000000052004505b4d23d7f
Content-Transfer-Encoding: 8bit

Issue Description:
In current Driver/FW, the controller timestamp gets updated
with host time during driver load time or when a controller
reset is issued. i.e. when host issues the IOCInit request
message to the HBA FW. This IOCInit message has a field named
'TimeStamp' using which the host updates the controller
timestamp. Over a period, sometimes we may observe controller
time drifting away from host and it is difficult to co-relate
host logs with controller logs with respect to time.
And every time driver cannot issue the IOCInit request message
just for updating the controller timestamp.

Implementation:
Instead of IOCInit, driver sends IO_UNIT_CONTROL Request to
sync time stamp periodically with controller. Timestamp
synchronization interval is specified in 'TimeSyncInterval'
field of Manufacturing Page11 by controller.
TimeSyncInterval - 8 bits
        bits  0-6: Time stamp Synchronization interval value
        bit     7: Time stamp Synchronization interval unit,
                (if this bit is one then Timestamp Synchronization
                interval value is specified in terms of hours else
                Timestamp Synchronization interval value is
                specified in terms of minutes).

Driver sends this IO_UNIT_CONTROL Request message from
watchdog thread (which gets invoked every one second).
Driver keeps tracks of timer using ioc's timestamp_update_count
field. This field value gets incremented whenever the watchdog
thread gets invoked. And whenever this field value is greater
than or equals to the Time stamp Synchronization interval value
then driver sends the IO_UNIT_CONTROL Request message to
controller to update the time stamp and then it resets the
timestamp_update_count field to zero.

Syncing Driver and FW timestamp periodically makes
correlating the FW logs and OS events easier.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 93 ++++++++++++++++++++++++++++-
 drivers/scsi/mpt3sas/mpt3sas_base.h | 14 ++++-
 2 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 93230cd..18d5c3c 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -596,6 +596,71 @@ static int mpt3sas_remove_dead_ioc_func(void *arg)
 	return 0;
 }
 
+/**
+ * _base_sync_drv_fw_timestamp - Sync Drive-Fw TimeStamp.
+ * @ioc: Per Adapter Object
+ *
+ * Return nothing.
+ */
+static void _base_sync_drv_fw_timestamp(struct MPT3SAS_ADAPTER *ioc)
+{
+	Mpi26IoUnitControlRequest_t *mpi_request;
+	Mpi26IoUnitControlReply_t *mpi_reply;
+	u16 smid;
+	ktime_t current_time;
+	u64 TimeStamp = 0;
+	u8 issue_reset = 0;
+
+	mutex_lock(&ioc->scsih_cmds.mutex);
+	if (ioc->scsih_cmds.status != MPT3_CMD_NOT_USED) {
+		ioc_err(ioc, "scsih_cmd in use %s\n", __func__);
+		goto out;
+	}
+	ioc->scsih_cmds.status = MPT3_CMD_PENDING;
+	smid = mpt3sas_base_get_smid(ioc, ioc->scsih_cb_idx);
+	if (!smid) {
+		ioc_err(ioc, "Failed obtaining a smid %s\n", __func__);
+		ioc->scsih_cmds.status = MPT3_CMD_NOT_USED;
+		goto out;
+	}
+	mpi_request = mpt3sas_base_get_msg_frame(ioc, smid);
+	ioc->scsih_cmds.smid = smid;
+	memset(mpi_request, 0, sizeof(Mpi26IoUnitControlRequest_t));
+	mpi_request->Function = MPI2_FUNCTION_IO_UNIT_CONTROL;
+	mpi_request->Operation = MPI26_CTRL_OP_SET_IOC_PARAMETER;
+	mpi_request->IOCParameter = MPI26_SET_IOC_PARAMETER_SYNC_TIMESTAMP;
+	current_time = ktime_get_real();
+	TimeStamp = cpu_to_le64(ktime_to_ms(current_time));
+	mpi_request->Reserved7 = (u32) (TimeStamp & 0xFFFFFFFF);
+	mpi_request->IOCParameterValue = (u32) (TimeStamp >> 32);
+	init_completion(&ioc->scsih_cmds.done);
+	ioc->put_smid_default(ioc, smid);
+	dinitprintk(ioc, ioc_info(ioc,
+	    "Io Unit Control Sync TimeStamp (sending), @time %lld ms\n",
+	    TimeStamp));
+	wait_for_completion_timeout(&ioc->scsih_cmds.done,
+		MPT3SAS_TIMESYNC_TIMEOUT_SECONDS*HZ);
+	if (!(ioc->scsih_cmds.status & MPT3_CMD_COMPLETE)) {
+		mpt3sas_check_cmd_timeout(ioc,
+		    ioc->scsih_cmds.status, mpi_request,
+		    sizeof(Mpi2SasIoUnitControlRequest_t)/4, issue_reset);
+		goto issue_host_reset;
+	}
+	if (ioc->scsih_cmds.status & MPT3_CMD_REPLY_VALID) {
+		mpi_reply = ioc->scsih_cmds.reply;
+		dinitprintk(ioc, ioc_info(ioc,
+		    "Io Unit Control sync timestamp (complete): ioc_status(0x%04x), loginfo(0x%08x)\n",
+		    le16_to_cpu(mpi_reply->IOCStatus),
+		    le32_to_cpu(mpi_reply->IOCLogInfo)));
+	}
+issue_host_reset:
+	if (issue_reset)
+		mpt3sas_base_hard_reset_handler(ioc, FORCE_BIG_HAMMER);
+	ioc->scsih_cmds.status = MPT3_CMD_NOT_USED;
+out:
+	mutex_unlock(&ioc->scsih_cmds.mutex);
+}
+
 /**
  * _base_fault_reset_work - workq handling ioc fault conditions
  * @work: input argument, used to derive ioc
@@ -720,7 +785,11 @@ _base_fault_reset_work(struct work_struct *work)
 			return; /* don't rearm timer */
 	}
 	ioc->ioc_coredump_loop = 0;
-
+	if (ioc->time_sync_interval &&
+	    ++ioc->timestamp_update_count >= ioc->time_sync_interval) {
+		ioc->timestamp_update_count = 0;
+		_base_sync_drv_fw_timestamp(ioc);
+	}
 	spin_lock_irqsave(&ioc->ioc_reset_in_progress_lock, flags);
  rearm_timer:
 	if (ioc->fault_reset_work_q)
@@ -744,6 +813,7 @@ mpt3sas_base_start_watchdog(struct MPT3SAS_ADAPTER *ioc)
 	if (ioc->fault_reset_work_q)
 		return;
 
+	ioc->timestamp_update_count = 0;
 	/* initialize fault polling */
 
 	INIT_DELAYED_WORK(&ioc->fault_reset_work, _base_fault_reset_work);
@@ -4754,7 +4824,24 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 		else
 			ioc->nvme_abort_timeout = ioc->manu_pg11.NVMeAbortTO;
 	}
-
+	ioc->time_sync_interval =
+	    ioc->manu_pg11.TimeSyncInterval & MPT3SAS_TIMESYNC_MASK;
+	if (ioc->time_sync_interval) {
+		if (ioc->manu_pg11.TimeSyncInterval & MPT3SAS_TIMESYNC_UNIT_MASK)
+			ioc->time_sync_interval =
+			    ioc->time_sync_interval * SECONDS_PER_HOUR;
+		else
+			ioc->time_sync_interval =
+			    ioc->time_sync_interval * SECONDS_PER_MIN;
+		dinitprintk(ioc, ioc_info(ioc,
+		    "Driver-FW TimeSync interval is %d seconds. ManuPg11 TimeSync Unit is in %s\n",
+		    ioc->time_sync_interval, (ioc->manu_pg11.TimeSyncInterval &
+		    MPT3SAS_TIMESYNC_UNIT_MASK) ? "Hour" : "Minute"));
+	} else {
+		if (ioc->is_gen35_ioc)
+			ioc_warn(ioc,
+			    "TimeSync Interval in Manuf page-11 is not enabled. Periodic Time-Sync will be disabled\n");
+	}
 	mpt3sas_config_get_bios_pg2(ioc, &mpi_reply, &ioc->bios_pg2);
 	mpt3sas_config_get_bios_pg3(ioc, &mpi_reply, &ioc->bios_pg3);
 	mpt3sas_config_get_ioc_pg8(ioc, &mpi_reply, &ioc->ioc_pg8);
@@ -6466,6 +6553,8 @@ _base_send_ioc_init(struct MPT3SAS_ADAPTER *ioc)
 		r = -EIO;
 	}
 
+	/* Reset TimeSync Counter*/
+	ioc->timestamp_update_count = 0;
 	return r;
 }
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 7dab579..cc4815c 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -93,6 +93,14 @@
 /* CoreDump: Default timeout */
 #define MPT3SAS_DEFAULT_COREDUMP_TIMEOUT_SECONDS	(15) /*15 seconds*/
 #define MPT3SAS_COREDUMP_LOOP_DONE                     (0xFF)
+#define MPT3SAS_TIMESYNC_TIMEOUT_SECONDS		(10) /* 10 seconds */
+#define MPT3SAS_TIMESYNC_UPDATE_INTERVAL		(900) /* 15 minutes */
+#define MPT3SAS_TIMESYNC_UNIT_MASK			(0x80) /* bit 7 */
+#define MPT3SAS_TIMESYNC_MASK				(0x7F) /* 0 - 6 bits */
+#define SECONDS_PER_MIN					(60)
+#define SECONDS_PER_HOUR				(3600)
+#define MPT3SAS_COREDUMP_LOOP_DONE			(0xFF)
+#define MPI26_SET_IOC_PARAMETER_SYNC_TIMESTAMP		(0x81)
 
 /*
  * Set MPT3SAS_SG_DEPTH value based on user input.
@@ -405,7 +413,7 @@ struct Mpi2ManufacturingPage11_t {
 	u16	HostTraceBufferMaxSizeKB;	/* 50h */
 	u16	HostTraceBufferMinSizeKB;	/* 52h */
 	u8	CoreDumpTOSec;			/* 54h */
-	u8	Reserved8;			/* 55h */
+	u8	TimeSyncInterval;		/* 55h */
 	u16	Reserved9;			/* 56h */
 	__le32	Reserved10;			/* 58h */
 };
@@ -1113,6 +1121,8 @@ typedef void (*MPT3SAS_FLUSH_RUNNING_CMDS)(struct MPT3SAS_ADAPTER *ioc);
  * @cpu_msix_table_sz: table size
  * @total_io_cnt: Gives total IO count, used to load balance the interrupts
  * @ioc_coredump_loop: will have non-zero value when FW is in CoreDump state
+ * @timestamp_update_count: Counter to fire timeSync command
+ * time_sync_interval: Time sync interval read from man page 11
  * @high_iops_outstanding: used to load balance the interrupts
  *				within high iops reply queues
  * @msix_load_balance: Enables load balancing of interrupts across
@@ -1308,6 +1318,8 @@ struct MPT3SAS_ADAPTER {
 	MPT3SAS_FLUSH_RUNNING_CMDS schedule_dead_ioc_flush_running_cmds;
 	u32             non_operational_loop;
 	u8              ioc_coredump_loop;
+	u32		timestamp_update_count;
+	u32		time_sync_interval;
 	atomic64_t      total_io_cnt;
 	atomic64_t	high_iops_outstanding;
 	bool            msix_load_balance;
-- 
2.18.4


--00000000000052004505b4d23d7f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
iUkiVw86iw1/yBRkUHjZV+F5nigRTD1p16yuvarGtyB6rg4jKzna5QV4nk8+hvH80mioAJQGVzts
8xzpVqdUE0XKNyTxbKeog4Szn+7BAgMBAAGjggHcMIIB2DAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsG
AQUFBwEBBIGRMIGOME0GCCsGAQUFBzAChkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2Nh
Y2VydC9nc3BlcnNvbmFsc2lnbjJzaGEyZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29j
c3AyLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisG
AQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wCQYDVR0TBAIwADBEBgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24u
Y29tL2dzcGVyc29uYWxzaWduMnNoYTJnMy5jcmwwMAYDVR0RBCkwJ4Elc3VnYW5hdGgtcHJhYnUu
c3VicmFtYW5pQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRp
coJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQU/c23ZwEKsymUWmWA1y8P9Rg3/S4wDQYJKoZI
hvcNAQELBQADggEBALOKJyKtCFXYqEKp/a6z7VfKi9uLkcftrcrYXqV3K6PB8j7qnYb37eV1DCBs
+gdZLkbSE0oBBzV/dqmsngPjBwkLSigxsRg1K44sgdBpolmGw/gESFR8P2tXB0l+UEEq4kzhz6sM
bCYKYpNz68rpFqaHpBXisSwGMZwPHsfyh2Stv/1cNBG6dGpoUgZcoFjXT7Akx1Tz11FUkRjNsUAc
DAYA3uHCdaZTnVbSESs1pk+HAhlZhqrDYXWCG6ya+SIG51Q4PHS6jfst/6xnaSFPhWhIv2hSB2NA
vWzrcXMq9IfE5HFZXqzOWMP/gUOKk155U6EuRQzVcCpabG8ROpPND3sxggJvMIICawIBATBtMF0x
CzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxT
aWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDE84Ya9bsUMoMZ6qKjANBglghkgB
ZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgl/qcW7NZ7MeHWVi+Z2sgHT1lveJ3JuTeNR2WaQ8b
oo4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAxMTI0MDM1MjI4
WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAEC
MAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqG
SIb3DQEBAQUABIIBAIDxEt4XOxkpX1Obu7j2kOtZuEGC5RrNA/UIIngz4+ciieJu2Hax7Qr5UpjU
/tlTBq4lnPaw0BA/u/0Osp4cqZL1WcVM1KJoRkdnSKqkAvwI6whN3rGgkQbMhB9MzVoRc7dyvUn4
E0xPwxoqq2WQqNum4RbZPsIrFe2kdFP9n5heNe0ziAuUXd4OG7OBpZzPo6HbRqNc9w/rU42WTp8X
YQPzk+ObPQnYfD6i0Hsh7LCvA3L3C7lWxgwbYLT8DuEGUiIHwULUDyGj+vx4J4UcLykU06u1EKPr
hKCi8rKCsg497fd2L2FZfQpcC7k2i1+G7AEnS4GhrAj+oPnP6qL6/O4=
--00000000000052004505b4d23d7f--
