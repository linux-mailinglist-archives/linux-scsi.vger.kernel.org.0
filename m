Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3616710B0E
	for <lists+linux-scsi@lfdr.de>; Wed,  1 May 2019 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfEAQPY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 12:15:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfEAQPY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 May 2019 12:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LhiiGsQtqWts5dxpsG+adD5T1bQE0OqxeRu+AIjcIuE=; b=sJ8rQYiup1oaHc3HsgC1aHJJ1g
        ADrlShKY3aATYhrTpYHmIbGWouSW5H8ujFf8TslqEHR7/tr4WuFuPxWWfgpVnmo86k/ZUPVW/Jogf
        PnmVMZePYi6a1Na+6ZBBn8+1oaeIoDLDUURjpgfSGAw6GEaUGXFU9WQ2r+AWq3IiKV+StYN8zmaZy
        q+csIVcx4mhgjZJT4PBYkKLpkzi8IABz+Q73If7V8kQaSLsDB3F7uBoI9+DtALjnpPi+7jvhQt3pw
        ZuV7AjqIL6KHXJEIcYPigIoRwHC/AfVt96Zpvm2pbJz/qcYmPsVSGi7OGLKrdAqe7n3lFqfoQaVL5
        kh8TTejA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrt8-0005ew-Sq; Wed, 01 May 2019 16:15:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>, Willem Riede <osst@riede.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 15/24] libsas: add a SPDX tag to sas_task.c
Date:   Wed,  1 May 2019 12:14:08 -0400
Message-Id: <20190501161417.32592-16-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501161417.32592-1-hch@lst.de>
References: <20190501161417.32592-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

sas_task.c is the only libsas file missing licensing information.  Add a
GPLv2 tag for the default kernel license.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/libsas/sas_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_task.c b/drivers/scsi/libsas/sas_task.c
index c3b9befad4e6..a46e8e4c0684 100644
--- a/drivers/scsi/libsas/sas_task.c
+++ b/drivers/scsi/libsas/sas_task.c
@@ -1,4 +1,4 @@
-
+// SPDX-License-Identifier: GPL-2.0
 #include "sas_internal.h"
 
 #include <linux/kernel.h>
-- 
2.20.1

