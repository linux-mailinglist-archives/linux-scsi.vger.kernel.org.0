Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE5F8597ED
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Jun 2019 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfF1Jv1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jun 2019 05:51:27 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:42409 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF1Jv1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Jun 2019 05:51:27 -0400
Received: by mail-pl1-f181.google.com with SMTP id ay6so2935507plb.9
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jun 2019 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T/mZXL8M+UQCk9oP+hzmcx6Ryi1tWi6WEqvKWBJb9TQ=;
        b=ecp+RSC2BEW7epG+um3Ks/X0QAp/1nBfRX7tf7zDbLkJ3faxxYhAUxlBNEDCLxsedd
         G1l0AKOf1jCAfqrBFcSEfpID/ped8KPDXw/EBomWVY2YRyg3Fkn9gDam3IUoZOuUTN3E
         DY1Xjzo/J/7lrdB0eknyxapnpORQuGQibAyqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T/mZXL8M+UQCk9oP+hzmcx6Ryi1tWi6WEqvKWBJb9TQ=;
        b=hLvSQeW2gjiQdvng5aOX/XJq4/w85m564pF/nqqigOTnlUY4+rxyJpjWvZX4qi26fM
         n9q/gdCNYd7HjQfNqvbUbfmqxceOsCuM0SwM6nk63dH4YGzogSC/k5xh91PoIR6i0y7s
         gFONB4bxKolHlQvIbfV6eX2vn9bTcrMrEf23oY9FO4tHAv6Dddm/800e+uvcYSy6pLE0
         A7UCsAq4+SivLD9D4E8y1QVrvVwR8kBsvYkLNjgn4gHKaXaTlBDF/l2xkXzhOfmukiwH
         Wmg5kvcXxy4xcV9GQUSWyhu1QcKhafxe4amq72dMvvWckCEX8yobDBCA1OvClhJLTSm0
         8jew==
X-Gm-Message-State: APjAAAVHNM3gDSm0nkSD99MkwnOqtkwXV3Az9tza0qORws0Gx5AAFl1R
        P2KHqkvl09yRrtX7ZAyc7dk7iQrFa9Lx8qxeV1LiLzLiFL2jbtrcZ4taJb5QsOMlmolZEvrGnw5
        sD8Q9SE79OcOGNDQUcb7+jFn7+E3IYSOVyXKTR2TncRPSPzPJx+guxtPjsqoOveA7HmdU4AaLQ6
        iQIItw0GCCxRSPyuoQTueRo0o=
X-Google-Smtp-Source: APXvYqy13i6zSOjSEhqXY2qBuZTHa3hTIyoeiEvNVtOts9Lr3exJYsx/LV1GTsTN/V5XohYTIXUC0Q==
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr10557171plv.282.1561715486209;
        Fri, 28 Jun 2019 02:51:26 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q19sm2096975pfc.62.2019.06.28.02.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:51:25 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, chandrakanth.patil@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 3/4] megaraid_sas: Add module parameter for FW Async event logging
Date:   Fri, 28 Jun 2019 02:50:40 -0700
Message-Id: <1561715441-1428-4-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1561715441-1428-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1561715441-1428-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add module parameter to control logging levels of async event notifications
from firmware that get logged to system log.
Also, allow changing the value from sysfs after driver load.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 96b6510..4b3f2f80 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -117,6 +117,10 @@ MODULE_PARM_DESC(perf_mode, "Performance mode (only for Aero adapters), options:
 		"default mode is 'balanced'"
 		);
 
+int event_log_level = MFI_EVT_CLASS_CRITICAL;
+module_param(event_log_level, int, 0644);
+MODULE_PARM_DESC(event_log_level, "Asynchronous event logging level- range is: -2(CLASS_DEBUG) to 4(CLASS_DEAD), Default: 2(CLASS_CRITICAL)");
+
 MODULE_LICENSE("GPL");
 MODULE_VERSION(MEGASAS_VERSION);
 MODULE_AUTHOR("megaraidlinux.pdl@broadcom.com");
@@ -416,7 +420,13 @@ megasas_decode_evt(struct megasas_instance *instance)
 	union megasas_evt_class_locale class_locale;
 	class_locale.word = le32_to_cpu(evt_detail->cl.word);
 
-	if (class_locale.members.class >= MFI_EVT_CLASS_CRITICAL)
+	if ((event_log_level < MFI_EVT_CLASS_DEBUG) ||
+	    (event_log_level > MFI_EVT_CLASS_DEAD)) {
+		printk(KERN_WARNING "megaraid_sas: provided event log level is out of range, setting it to default 2(CLASS_CRITICAL), permissible range is: -2 to 4\n");
+		event_log_level = MFI_EVT_CLASS_CRITICAL;
+	}
+
+	if (class_locale.members.class >= event_log_level)
 		dev_info(&instance->pdev->dev, "%d (%s/0x%04x/%s) - %s\n",
 			le32_to_cpu(evt_detail->seq_num),
 			format_timestamp(le32_to_cpu(evt_detail->time_stamp)),
@@ -8762,6 +8772,12 @@ static int __init megasas_init(void)
 		goto err_pcidrv;
 	}
 
+	if ((event_log_level < MFI_EVT_CLASS_DEBUG) ||
+	    (event_log_level > MFI_EVT_CLASS_DEAD)) {
+		printk(KERN_WARNING "megarid_sas: provided event log level is out of range, setting it to default 2(CLASS_CRITICAL), permissible range is: -2 to 4\n");
+		event_log_level = MFI_EVT_CLASS_CRITICAL;
+	}
+
 	rval = driver_create_file(&megasas_pci_driver.driver,
 				  &driver_attr_version);
 	if (rval)
-- 
2.9.5

