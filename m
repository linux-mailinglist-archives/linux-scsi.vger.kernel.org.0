Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A328936EC2
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfFFIee (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 04:34:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfFFIed (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Jun 2019 04:34:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D049300602A;
        Thu,  6 Jun 2019 08:34:33 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 709631B467;
        Thu,  6 Jun 2019 08:34:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH V3 2/3] scsi: core: don't pre-allocate small SGL in case of NO_SG_CHAIN
Date:   Thu,  6 Jun 2019 16:34:09 +0800
Message-Id: <20190606083410.32243-3-ming.lei@redhat.com>
In-Reply-To: <20190606083410.32243-1-ming.lei@redhat.com>
References: <20190606083410.32243-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 06 Jun 2019 08:34:33 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pre-allocated small SGL depends on SG_CHAIN, so if the ARCH doesn't
support SG_CHAIN, pre-allocation of small SGL can't work at all.

Fixes this issue by not using small pre-allocation in case of
NO_SG_CHAIN.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Fixes: c3288dd8c232 ("scsi: core: avoid pre-allocating big SGL for data")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6e81258471fa..29aba762a4f1 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -44,9 +44,13 @@
  * Size of integrity metadata is usually small, 1 inline sg should
  * cover normal cases.
  */
+#ifdef CONFIG_ARCH_NO_SG_CHAIN
+#define  SCSI_INLINE_PROT_SG_CNT  0
+#define  SCSI_INLINE_SG_CNT  0
+#else
 #define  SCSI_INLINE_PROT_SG_CNT  1
-
 #define  SCSI_INLINE_SG_CNT  2
+#endif
 
 static struct kmem_cache *scsi_sdb_cache;
 static struct kmem_cache *scsi_sense_cache;
-- 
2.20.1

