Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8536F8066E
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391024AbfHCOAS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36286 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbfHCOAS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so37466310pgm.3
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y151potURalM4a9rPPaFD6S1UTRiyK+Hq+doF1sRmSw=;
        b=N6/XU2OiBRLFZHtNTVhxIjZunFmCPbG654dCbU7u+bNJlA0SjN0+xH1cxtJk1XkOHX
         RoDvh9VansiBo/l0GndtdSp1fxVtk26RxraiRO8M5scDQ7RWrkzKg8Sp7GOZ7Hl39/Ny
         onbLBUs3vEfcBt562Q289Y5/eFMWoOAU+VFg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y151potURalM4a9rPPaFD6S1UTRiyK+Hq+doF1sRmSw=;
        b=CM+0d/tOawRPvRunYnWdQQOHary/hYpefmb6T/dPuEwl5+b7xTk58s+sLspRwv86q1
         Gk+Xj6lPRIh4uuQx684E7xYGyPUqB5C7xhZIv0vBCpGvWShVT7bv3Hv2ApDBLyqzMpJ9
         zzWGxjHfvH4o1UGvrRhIbAeMANVNKN2WeqYz5YFZsMulhgLjAwop/TALqoiU8CpEHHBN
         lBxC/NiKu45IKqJWsVxL7rH1GQfoh62q7mNW/77U038vQWiZqf0r/LVtUl/W7sZU8nRj
         9NOjMQZjSgX3bnmdrPvlvbJIoJw3FVlTEec0QVvXTG6i+GZgOeGKyxFlQoq6w33TPg4o
         kQDw==
X-Gm-Message-State: APjAAAU6yxRVvoJnzM76G6DZ0A7Wh6qGQMNUY3EGSMyGGw2ZCtB7jCwp
        B6HExzVYcFR/RsrpiyJgG+/DDzqr/5NYUswXBPsXQvscsCR7BjsRmb+Zi+NwgvDxVS61HLYN7YR
        s77bSlJP1DZuqNKawK7QDDvGALjE92XkaZl7dKmh+jbOBm/3ReUiTTpxgDV7Hi5o9zxxLJ3ItNP
        nxp/6fnmnqs7QN8HPPEg==
X-Google-Smtp-Source: APXvYqzsPOPnEKpAJVHLpAs0EA1D48WwNm2mCSID3y1eSrlCZfIi9BcO8B34DOzU6BmwQZdjYLkb5Q==
X-Received: by 2002:a63:cb4b:: with SMTP id m11mr55412663pgi.49.1564840816647;
        Sat, 03 Aug 2019 07:00:16 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:16 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 03/12] mpt3sas: Gracefully handle online firmware update
Date:   Sat,  3 Aug 2019 09:59:48 -0400
Message-Id: <1564840797-5876-4-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Issue:
During online Firmware upgrade operations, It is possible
that, MaxDevHandles filed in IOCFacts may change with new FW.
With this we may observe kernel panics when driver try to access
the pd_handles or blocking_handles buffers at offset greater than the
old firmware's MaxDevHandle value.

Fix:
_base_check_ioc_facts_changes() looks for increase/decrease in IOCFacts
attributes during online firmware upgrade and increases the pd_handles,
blocking_handles, etc buffer sizes to new firmware's MaxDevHandle value
if this new firmware's MaxDevHandle value is greater than the
old firmware's MaxDevHandle value.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 93 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/mpt3sas/mpt3sas_base.h |  2 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index ba83f59..a2a70a5 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7120,6 +7120,13 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 	if (r)
 		goto out_free_resources;
 
+	/*
+	 * Copy current copy of IOCFacts in prev_fw_facts
+	 * and it will be used during online firmware upgrade.
+	 */
+	memcpy(&ioc->prev_fw_facts, &ioc->facts,
+	    sizeof(struct mpt3sas_facts));
+
 	ioc->non_operational_loop = 0;
 	ioc->got_task_abort_from_ioctl = 0;
 	return 0;
@@ -7282,6 +7289,85 @@ mpt3sas_wait_for_commands_to_complete(struct MPT3SAS_ADAPTER *ioc)
 }
 
 /**
+ * _base_check_ioc_facts_changes - Look for increase/decrease of IOCFacts
+ *     attributes during online firmware upgrade and update the corresponding
+ *     IOC variables accordingly.
+ *
+ * @ioc: Pointer to MPT_ADAPTER structure
+ */
+static int
+_base_check_ioc_facts_changes(struct MPT3SAS_ADAPTER *ioc)
+{
+	u16 pd_handles_sz;
+	void *pd_handles = NULL, *blocking_handles = NULL;
+	void *pend_os_device_add = NULL, *device_remove_in_progress = NULL;
+	struct mpt3sas_facts *old_facts = &ioc->prev_fw_facts;
+
+	if (ioc->facts.MaxDevHandle > old_facts->MaxDevHandle) {
+		pd_handles_sz = (ioc->facts.MaxDevHandle / 8);
+		if (ioc->facts.MaxDevHandle % 8)
+			pd_handles_sz++;
+
+		pd_handles = krealloc(ioc->pd_handles, pd_handles_sz,
+		    GFP_KERNEL);
+		if (!pd_handles) {
+			ioc_info(ioc,
+			    "Unable to allocate the memory for pd_handles of sz: %d\n",
+			    pd_handles_sz);
+			return -ENOMEM;
+		}
+		memset(pd_handles + ioc->pd_handles_sz, 0,
+		    (pd_handles_sz - ioc->pd_handles_sz));
+		ioc->pd_handles = pd_handles;
+
+		blocking_handles = krealloc(ioc->blocking_handles,
+		    pd_handles_sz, GFP_KERNEL);
+		if (!blocking_handles) {
+			ioc_info(ioc,
+			    "Unable to allocate the memory for "
+			    "blocking_handles of sz: %d\n",
+			    pd_handles_sz);
+			return -ENOMEM;
+		}
+		memset(blocking_handles + ioc->pd_handles_sz, 0,
+		    (pd_handles_sz - ioc->pd_handles_sz));
+		ioc->blocking_handles = blocking_handles;
+		ioc->pd_handles_sz = pd_handles_sz;
+
+		pend_os_device_add = krealloc(ioc->pend_os_device_add,
+		    pd_handles_sz, GFP_KERNEL);
+		if (!pend_os_device_add) {
+			ioc_info(ioc,
+			    "Unable to allocate the memory for pend_os_device_add of sz: %d\n",
+			    pd_handles_sz);
+			return -ENOMEM;
+		}
+		memset(pend_os_device_add + ioc->pend_os_device_add_sz, 0,
+		    (pd_handles_sz - ioc->pend_os_device_add_sz));
+		ioc->pend_os_device_add = pend_os_device_add;
+		ioc->pend_os_device_add_sz = pd_handles_sz;
+
+		device_remove_in_progress = krealloc(
+		    ioc->device_remove_in_progress, pd_handles_sz, GFP_KERNEL);
+		if (!device_remove_in_progress) {
+			ioc_info(ioc,
+			    "Unable to allocate the memory for "
+			    "device_remove_in_progress of sz: %d\n "
+			    , pd_handles_sz);
+			return -ENOMEM;
+		}
+		memset(device_remove_in_progress +
+		    ioc->device_remove_in_progress_sz, 0,
+		    (pd_handles_sz - ioc->device_remove_in_progress_sz));
+		ioc->device_remove_in_progress = device_remove_in_progress;
+		ioc->device_remove_in_progress_sz = pd_handles_sz;
+	}
+
+	memcpy(&ioc->prev_fw_facts, &ioc->facts, sizeof(struct mpt3sas_facts));
+	return 0;
+}
+
+/**
  * mpt3sas_base_hard_reset_handler - reset controller
  * @ioc: Pointer to MPT_ADAPTER structure
  * @type: FORCE_BIG_HAMMER or SOFT_RESET
@@ -7344,6 +7430,13 @@ mpt3sas_base_hard_reset_handler(struct MPT3SAS_ADAPTER *ioc,
 	if (r)
 		goto out;
 
+	r = _base_check_ioc_facts_changes(ioc);
+	if (r) {
+		ioc_info(ioc,
+		    "Some of the parameters got changed in this new firmware"
+		    " image and it requires system reboot\n");
+		goto out;
+	}
 	if (ioc->rdpq_array_enable && !ioc->rdpq_array_capable)
 		panic("%s: Issue occurred with flashing controller firmware."
 		      "Please reboot the system and ensure that the correct"
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 6afbdb0..5cd6148 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1066,6 +1066,7 @@ typedef void (*MPT3SAS_FLUSH_RUNNING_CMDS)(struct MPT3SAS_ADAPTER *ioc);
  * @event_log: event log pointer
  * @event_masks: events that are masked
  * @facts: static facts data
+ * @prev_fw_facts: previous fw facts data
  * @pfacts: static port facts data
  * @manu_pg0: static manufacturing page 0
  * @manu_pg10: static manufacturing page 10
@@ -1276,6 +1277,7 @@ struct MPT3SAS_ADAPTER {
 
 	/* static config pages */
 	struct mpt3sas_facts facts;
+	struct mpt3sas_facts prev_fw_facts;
 	struct mpt3sas_port_facts *pfacts;
 	Mpi2ManufacturingPage0_t manu_pg0;
 	struct Mpi2ManufacturingPage10_t manu_pg10;
-- 
1.8.3.1

