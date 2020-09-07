Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF71625FD71
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Sep 2020 17:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgIGPsA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Sep 2020 11:48:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48490 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730107AbgIGPrw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 7 Sep 2020 11:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599493669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j5sybpypzHTEbaKxUL08ltwwNgxe7hLOJsUxK8gZhcA=;
        b=MFbJaNqj2hzGp20sjfAn6nzKv9Xiu1vRMuIUT+M2YugcAleylIrJghMj5VFQtvPcKu5/ks
        ilLzDXnpYqWvh0NI394XtFO1G/lJh2nuY7ru9jzhHxhFRzb0U0g6CND1myipZDMhCvt2Jd
        Bm7/eGxx9oFsS4IXQ//SAvuLSr5gqjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-qPhm_QpDOl2zvuoLxkU0CQ-1; Mon, 07 Sep 2020 11:47:47 -0400
X-MC-Unique: qPhm_QpDOl2zvuoLxkU0CQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9B5C801ADF
        for <linux-scsi@vger.kernel.org>; Mon,  7 Sep 2020 15:47:46 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6ADD45D9D2
        for <linux-scsi@vger.kernel.org>; Mon,  7 Sep 2020 15:47:46 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: take module reference during async scan
Date:   Mon,  7 Sep 2020 17:47:45 +0200
Message-Id: <20200907154745.20145-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

During an async scan the driver shost->hostt structures are used,
that may cause issues when the driver is removed at that time.
As protection take the module reference.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
 drivers/scsi/scsi_scan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index f2437a757..c9cc0862c 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1825,6 +1825,8 @@ static void do_scan_async(void *_data, async_cookie_t c)
 
 	do_scsi_scan_host(shost);
 	scsi_finish_async_scan(data);
+
+	module_put(shost->hostt->module);
 }
 
 /**
@@ -1848,6 +1850,12 @@ void scsi_scan_host(struct Scsi_Host *shost)
 		return;
 	}
 
+	/* protection against surprise driver removal
+	 * module_put is called from do_scan_async
+	 */
+	if (!try_module_get(shost->hostt->module))
+		return;
+
 	/* register with the async subsystem so wait_for_device_probe()
 	 * will flush this work
 	 */
-- 
2.25.4

