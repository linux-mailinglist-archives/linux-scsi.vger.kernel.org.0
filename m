Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A981121A3DC
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2020 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGIPhf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Jul 2020 11:37:35 -0400
Received: from m15112.mail.126.com ([220.181.15.112]:51555 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgGIPhe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 9 Jul 2020 11:37:34 -0400
X-Greylist: delayed 1828 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2020 11:37:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=nlTBb/0mf2htxgi1qK
        4HyVVy5Vg0edIYoQo4K6WIOA0=; b=bVs7SqtviqcojpZxxESbFENwtF0N5+Ab2a
        f7UmuS5NAj3foCnQHW+TZOQdgsPte6WhxvgmQXzD4jh90M1nOZ8tX2L3v+VQJKjS
        qsFvGYISU9nz65sEO9rGenPiNzwFqISZz/lIVc7MGfw9/P6aJ6oTJNvZGVBcjIWE
        I59Y9gkLo=
Received: from 192.168.137.252 (unknown [112.10.74.133])
        by smtp2 (Coremail) with SMTP id DMmowABX1SFfMgdfeNahFA--.52098S3;
        Thu, 09 Jul 2020 23:06:09 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: virtio_scsi: remove unnecessary condition check
Date:   Thu,  9 Jul 2020 11:06:07 -0400
Message-Id: <1594307167-8807-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DMmowABX1SFfMgdfeNahFA--.52098S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw47tryktw1xZr18WrW8Xrb_yoWDWFc_XF
        40qrsrGr15KFn2krWIkrWfArZ09anrZa1j9ryFgFWfCr1Yq3909r4jqryrZF1fWw1jk3W7
        Cw40yryS9r13CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8Tv3UUUUUU==
X-Originating-IP: [112.10.74.133]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi5gtcpFpD+5LX2gABsp
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

kmem_cache_destroy and mempool_destroy can correctly handle
null pointer parameter, so there is no need to check if the
parameter is null before calling kmem_cache_destroy and
mempool_destroy.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 drivers/scsi/virtio_scsi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index bfec84a..54ac83e 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -1003,14 +1003,10 @@ static int __init init(void)
 	return 0;
 
 error:
-	if (virtscsi_cmd_pool) {
-		mempool_destroy(virtscsi_cmd_pool);
-		virtscsi_cmd_pool = NULL;
-	}
-	if (virtscsi_cmd_cache) {
-		kmem_cache_destroy(virtscsi_cmd_cache);
-		virtscsi_cmd_cache = NULL;
-	}
+	mempool_destroy(virtscsi_cmd_pool);
+	virtscsi_cmd_pool = NULL;
+	kmem_cache_destroy(virtscsi_cmd_cache);
+	virtscsi_cmd_cache = NULL;
 	return ret;
 }
 
-- 
1.8.3.1

