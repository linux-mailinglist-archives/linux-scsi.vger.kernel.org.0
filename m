Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35941D2125
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2020 23:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgEMVgc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 May 2020 17:36:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31905 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729359AbgEMVg3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 May 2020 17:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589405788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2q8wNP5BfDbkqdgV480g/4dZ2snqC8+5OQT7xuYCGC8=;
        b=TGsSCWtfG95WuwofCyjKbUYvEapAEMA6EPc7vin31RzwfNFr+VWPMD4GCmEB1ord0y+4vO
        oAmvAUCQNMGPhjlcNgcSDVmPFQEPsLTWBuejgf0DLCGxRkr1TUYnjkbJd9x8GA5atRk/1Z
        m1Kb6ltAsXv/NTeCwS4GHBB2xxWkjKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-ApFMHm3KOWuAOSRNWDobEg-1; Wed, 13 May 2020 17:36:26 -0400
X-MC-Unique: ApFMHm3KOWuAOSRNWDobEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C1DB107ACF4;
        Wed, 13 May 2020 21:36:25 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8F6A5D9E5;
        Wed, 13 May 2020 21:36:24 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH v2 2/7] create_syslog_header: Add durable name
Date:   Wed, 13 May 2020 16:36:16 -0500
Message-Id: <20200513213621.470411-3-tasleson@redhat.com>
In-Reply-To: <20200513213621.470411-1-tasleson@redhat.com>
References: <20200513213621.470411-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This gets us a persistent durable name for code that logs messages in the
block layer that have the appropriate callbacks setup for durable name.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 drivers/base/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 86ea3acb1e1f..8c89b711d91d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3577,6 +3577,7 @@ create_syslog_header(const struct device *dev, char *hdr, size_t hdrlen)
 {
 	const char *subsys;
 	size_t pos = 0;
+	int dlen;
 
 	if (dev->class)
 		subsys = dev->class->name;
@@ -3619,6 +3620,10 @@ create_syslog_header(const struct device *dev, char *hdr, size_t hdrlen)
 				"DEVICE=+%s:%s", subsys, dev_name(dev));
 	}
 
+	dlen = dev_durable_name(dev, hdr + (pos + 1), hdrlen - (pos + 1));
+	if (dlen)
+		pos += dlen + 1;
+
 	if (pos >= hdrlen)
 		goto overflow;
 
-- 
2.25.4

