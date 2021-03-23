Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF65F3464F2
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Mar 2021 17:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhCWQWg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 Mar 2021 12:22:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233173AbhCWQWc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 23 Mar 2021 12:22:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616516551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2rbPaXRKb7h4KyZ87XmNO0rXGf+RsMQ+Dah0PlV+ljQ=;
        b=hfynwLKlRO3z12u9rEPiNwPQLyRgGghUs1h8V85F2solE8+kt2XhtHJ5RtkD3lCLJUoQa4
        f0brXZ4CqFpV45AwLYH3x/xlM/iHFz/m23fusnGf5WJaCho3zqycDImcU9X+FfJXbBcskB
        o6tYh7oqpa8q7cMqeppXILJPfk9VsO0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5192CADF1;
        Tue, 23 Mar 2021 16:22:31 +0000 (UTC)
From:   mwilck@suse.com
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        David Disseldorp <ddiss@suse.com>,
        =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>,
        Martin Wilck <mwilck@suse.com>
Subject: [PATCH] target: pscsi: avoid OOM in pscsi_map_sg()
Date:   Tue, 23 Mar 2021 17:22:03 +0100
Message-Id: <20210323162203.30942-1-mwilck@suse.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

pscsi_map_sg() uses the variable nr_pages as a hint for bio_kmalloc()
how many vector elements to allocate. If nr_pages is < BIO_MAX_PAGES,
it will be reset to 0 after successful allocation of the bio.

If bio_add_pc_page() fails later for whatever reason, pscsi_map_sg()
tries to allocate another bio, passing nr_vecs=0. This causes
bio_add_pc_page() to fail immediately in the next call. pci_map_sg()
continues to allocate zero-length bios until memory is exhausted and
the kernel crashes with OOM. This can be easily observed by exporting
a SATA DVD drive via pscsi. The target crashes as soon as the client
tries to access the DVD LUN. In the case I analyzed, bio_add_pc_page()
would fail because the DVD device's max_sectors_kb (128) was
exceeded.

Avoid this by simply not resetting nr_pages to 0 after allocating the
bio. This way, the client receives an IO error when it tries to send
requests exceeding the devices max_sectors_kb, and eventually gets
it right. The client must still limit max_sectors_kb e.g. by an udev
rule if (like in my case) the driver doesn't report valid block
limits, otherwise it encounters I/O errors.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/target/target_core_pscsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 7b1035e..977362d 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -881,7 +881,6 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 			if (!bio) {
 new_bio:
 				nr_vecs = bio_max_segs(nr_pages);
-				nr_pages -= nr_vecs;
 				/*
 				 * Calls bio_kmalloc() and sets bio->bi_end_io()
 				 */
-- 
2.26.2

