Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C741D2130
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2020 23:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgEMVgf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 May 2020 17:36:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45279 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729413AbgEMVge (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 May 2020 17:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589405793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jDh1PWkPuH4E+iC0pkUXTKMHgEo2Mi/ejIMG+oNRyqY=;
        b=X+QuiBnzeXJmgnGcCvmJFi7Oy+MRJAGNo6/rCfglSqTpj+5pbsixzcjYqM8Af3pqxCOuPK
        GIOxGDejlu5KyiMxXUpa6OjdIQGOWWMSAAARVUJthmdG8ta3Teezbn/1o2qAmO0wbuC9Ob
        9cIm4tyn29DqvGYpTVQfhhohbaWCqIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-EGvR7dZSNqWpmCmV0mSeFQ-1; Wed, 13 May 2020 17:36:31 -0400
X-MC-Unique: EGvR7dZSNqWpmCmV0mSeFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97A7E460;
        Wed, 13 May 2020 21:36:30 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEAC35D9E5;
        Wed, 13 May 2020 21:36:29 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH v2 7/7] nvme: Add durable name for dev_printk
Date:   Wed, 13 May 2020 16:36:21 -0500
Message-Id: <20200513213621.470411-8-tasleson@redhat.com>
In-Reply-To: <20200513213621.470411-1-tasleson@redhat.com>
References: <20200513213621.470411-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 drivers/nvme/host/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a4d8c90ee7cc..7479c7e82200 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2614,6 +2614,22 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 	return true;
 }
 
+static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
+			char *buf);
+
+static int dev_to_nvme_durable_name(const struct device *dev, char *buf, size_t len)
+{
+	char serial[128];
+	ssize_t serial_len = wwid_show((struct device *)dev, NULL, serial);
+
+	if (serial_len > 0 && serial_len < len) {
+		serial_len -= 1;  // Remove the '\n' from the string
+		strncpy(buf, serial, serial_len);
+		return serial_len;
+	}
+	return 0;
+}
+
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	struct nvme_subsystem *subsys, *found;
@@ -3541,6 +3557,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	disk->queue = ns->queue;
 	disk->flags = flags;
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
+	disk_to_dev(disk)->durable_name = dev_to_nvme_durable_name;
+
 	ns->disk = disk;
 
 	__nvme_revalidate_disk(disk, id);
-- 
2.25.4

