Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C273B2FAC9A
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Jan 2021 22:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394607AbhARV0y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Jan 2021 16:26:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389173AbhARKLJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 18 Jan 2021 05:11:09 -0500
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zi87JU1wtYK7u/9EdBeQmfwuSvWpL6Dl6md8k/4q3TA=;
        b=vmmHzRErECNDY4i8p0Uw2lqTGSxAzYWkTqg8U/HTNsEkGRDsPM6ORRmQBUBt4rbPg0b9ap
        hrKvpr6n9ciCKpwZ/SmSorh76TqxmXnRS3wS/8adasC5vQzs5RgZeQg6IiwyOHKD3Pz8LO
        aREoYZ1hFodaFCqtaGd5nJxOxzeyhf0MbaAAOUDlcX+vQf6jzDU4wwg89S0o7eQ6j9Ft8h
        xkvz8Bt66ymeTys7kkVIceza7e2/HSDKAuZDW5gLEAUSvwh4KkPVvekGEYqi1S8B+wbijB
        bqxBBOMBcSNsdBvHagkrit8fs4L0meLz+w2BqRbzZ/sBHkVLMPeVmMgBr4zMwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zi87JU1wtYK7u/9EdBeQmfwuSvWpL6Dl6md8k/4q3TA=;
        b=TqGab2doXTK6ZVTCop+70ObWN/mZW7jLhxlq0+eklJvJ5OUHqE+rRZPJU78FC9ZtHZMOOP
        N/OEVOE5UgcpEgAQ==
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        John Garry <john.garry@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Daniel Wagner <dwagner@suse.de>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v3 01/19] Documentation: scsi: libsas: Remove notify_ha_event()
Date:   Mon, 18 Jan 2021 11:09:37 +0100
Message-Id: <20210118100955.1761652-2-a.darwish@linutronix.de>
In-Reply-To: <20210118100955.1761652-1-a.darwish@linutronix.de>
References: <20210118100955.1761652-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The ->notify_ha_event() hook has long been removed from the libsas event
interface.

Remove it from documentation.

Fixes: 042ebd293b86 ("scsi: libsas: kill useless ha_event and do some cleanup")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Reviewed-by: John Garry <john.garry@huawei.com>
Cc: stable@vger.kernel.org
---
 Documentation/scsi/libsas.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/scsi/libsas.rst b/Documentation/scsi/libsas.rst
index 7216b5d25800..f9b77c7879db 100644
--- a/Documentation/scsi/libsas.rst
+++ b/Documentation/scsi/libsas.rst
@@ -189,7 +189,6 @@ num_phys
 The event interface::
 
 	/* LLDD calls these to notify the class of an event. */
-	void (*notify_ha_event)(struct sas_ha_struct *, enum ha_event);
 	void (*notify_port_event)(struct sas_phy *, enum port_event);
 	void (*notify_phy_event)(struct sas_phy *, enum phy_event);
 
-- 
2.30.0

