Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2030080676
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391112AbfHCOAh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44704 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391038AbfHCOAh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so37472442pgl.11
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWFNrMfs7MpoNynZtF5FK1CvE/E5FEYETo7HSNeuckw=;
        b=ElSkCQBmbDMrbJ8T4yXGieW0aZQw34Nt0xZDpD0j3AwYbx4E2w5rrPdDDy1XUTF5wR
         wKM5LYpYqpFUPzg9DkCQ36OgiM1tf7Yn6HGyNqsDDSiKLOmUO3Yk4XYHlRSravSaondO
         RKPU+4Gwu+uKzAfUVNg2VlBPJasYu4MRZE5XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWFNrMfs7MpoNynZtF5FK1CvE/E5FEYETo7HSNeuckw=;
        b=Yv/GN6gVpAdI5L7QtN2riK4IdFvHbm8RqJoDoPPQHyiUZtb0Ls9ROyKWxofISZgMQW
         17CSHRFy1nHRKcB/eOtwHR/bsJi3ZyLbRqOQcC7HphRgP2HP8yzwiWRbE/jsbhYGsyo0
         Mc91u9l7fQj6ZE0FAxv+MCYr1lohchGLSya0ugE2xqnU74nZMx5FzaigsZH4GNCGW/U5
         jpR5ZR/WyzuYBJQnUhKckJ1G94O/BXgNYUyqTQunYKHZ2BbwqSFD7WVdhtWKo5fuTSzm
         H2298wdKZgYVn/Ut6BKQeUYFgHUkj9vofmotVfDdY1pvrMmJ2CkKJEaMuk6gYXj+U7Me
         DEpw==
X-Gm-Message-State: APjAAAWuOMjZytrBwM0q3D6uNfjh/ld9CgwbbvXO4/vZVIbzWcLJuxwz
        Viam92dFo5hGg07ge3InXtfEu8ViY2Eu6YRVds0qC2fdFe4diYunI0XlxAiUtoGzCO7+OvKM3+y
        /CR5Gj7oaRsorc1NAwNaee9CsHhXcD37+VbtKd4JF6vsZZ6l3KwzOqmEO3zzWJ7YH42VtQwtWri
        md22D7s5kaQHsPeWR3GA==
X-Google-Smtp-Source: APXvYqz9qKhE+6zLtaXRULHBQkCH5HShjvOpW4BFeSZZqai1FO5EVBd7CWNqd6llnkd142bAca/P+g==
X-Received: by 2002:a65:500a:: with SMTP id f10mr98059201pgo.105.1564840836228;
        Sat, 03 Aug 2019 07:00:36 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:35 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 11/12] mpt3sas:Run SAS DEVICE STATUS CHANGE EVENT from  ISR
Date:   Sat,  3 Aug 2019 09:59:56 -0400
Message-Id: <1564840797-5876-12-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In some case like while performing extensive expander reset
or phy reset user may observe that drives are not visible in
OS and driver's firmware-worker thread got blocked for more
than 120 seconds call trace for below scenarios,

1. Received target add event for Device A and hence driver has
registered this device to SML by calling sas_rphy_add(). SML has
half added this device and returned the control to the driver by
quitting from sas_rphy_add() API, and started some background
scanning on this device A.

2. While background scanning is going on device A, driver has
received SAS DEVICE STATUS CHANGE EVENT with RC code
"Internal device reset" event and hence driver has set tm_busy
flag for this Device A from FW worker thread context. When tm_busy
flag is set then driver return scsi commands with device busy
status asking the kernel to retry the same command after some time.
So background scanning for device A will be waiting for this tm_busy
to be cleared.

3. Meanwhile driver has received a target add event for Device B
and hence driver called  sas_rphy_add() API to register this device
with SML. Bust since background scanning for Device A is still
pending and hence SML is not quitting  from this sas_rphy_add()
and hence driver’s firmware worker thread got blocked.

4. Now driver has received  SAS DEVICE STATUS CHANGE EVENT with RC code
"Internal device reset complete" event, But as driver’s firmware worker
thread got blocked in Step3, so it can’t process this event and it was
not clearing the tm_busy flag and deadlock has occurred.
(where SML was waiting for tm_busy flag to be cleared and our FW worker
thread is waiting for SML to quit from sas_device_rphy_add() API).

Same deadlock will be observed even if device B is getting removed in
step3. So to limit these types of deadlocks driver will process the
SAS DEVICE STATUS CHANGE EVENT events from ISR context instead of
processing this event from worker thread context.
This improvement avoids above deadlock.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 24b5f5f..09b3d3f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -6469,24 +6469,17 @@ _scsih_sas_device_status_change_event_debug(struct MPT3SAS_ADAPTER *ioc,
 /**
  * _scsih_sas_device_status_change_event - handle device status change
  * @ioc: per adapter object
- * @fw_event: The fw_event_work object
+ * @event_data: The fw event
  * Context: user.
  */
 static void
 _scsih_sas_device_status_change_event(struct MPT3SAS_ADAPTER *ioc,
-	struct fw_event_work *fw_event)
+	Mpi2EventDataSasDeviceStatusChange_t *event_data)
 {
 	struct MPT3SAS_TARGET *target_priv_data;
 	struct _sas_device *sas_device;
 	u64 sas_address;
 	unsigned long flags;
-	Mpi2EventDataSasDeviceStatusChange_t *event_data =
-		(Mpi2EventDataSasDeviceStatusChange_t *)
-		fw_event->event_data;
-
-	if (ioc->logging_level & MPT_DEBUG_EVENT_WORK_TASK)
-		_scsih_sas_device_status_change_event_debug(ioc,
-		     event_data);
 
 	/* In MPI Revision K (0xC), the internal device reset complete was
 	 * implemented, so avoid setting tm_busy flag for older firmware.
@@ -6518,6 +6511,12 @@ _scsih_sas_device_status_change_event(struct MPT3SAS_ADAPTER *ioc,
 	else
 		target_priv_data->tm_busy = 0;
 
+	if (ioc->logging_level & MPT_DEBUG_EVENT_WORK_TASK)
+		ioc_info(ioc,
+		    "%s tm_busy flag for handle(0x%04x)\n",
+		    (target_priv_data->tm_busy == 1) ? "Enable" : "Disable",
+		    target_priv_data->handle);
+
 out:
 	if (sas_device)
 		sas_device_put(sas_device);
@@ -9346,7 +9345,10 @@ _mpt3sas_fw_work(struct MPT3SAS_ADAPTER *ioc, struct fw_event_work *fw_event)
 		_scsih_sas_topology_change_event(ioc, fw_event);
 		break;
 	case MPI2_EVENT_SAS_DEVICE_STATUS_CHANGE:
-		_scsih_sas_device_status_change_event(ioc, fw_event);
+		if (ioc->logging_level & MPT_DEBUG_EVENT_WORK_TASK)
+			_scsih_sas_device_status_change_event_debug(ioc,
+			    (Mpi2EventDataSasDeviceStatusChange_t *)
+			    fw_event->event_data);
 		break;
 	case MPI2_EVENT_SAS_DISCOVERY:
 		_scsih_sas_discovery_event(ioc, fw_event);
@@ -9519,6 +9521,10 @@ mpt3sas_scsih_event_callback(struct MPT3SAS_ADAPTER *ioc, u8 msix_index,
 		break;
 	}
 	case MPI2_EVENT_SAS_DEVICE_STATUS_CHANGE:
+		_scsih_sas_device_status_change_event(ioc,
+		    (Mpi2EventDataSasDeviceStatusChange_t *)
+		    mpi_reply->EventData);
+		break;
 	case MPI2_EVENT_IR_OPERATION_STATUS:
 	case MPI2_EVENT_SAS_DISCOVERY:
 	case MPI2_EVENT_SAS_DEVICE_DISCOVERY_ERROR:
-- 
1.8.3.1

