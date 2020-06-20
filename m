Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B7202227
	for <lists+linux-scsi@lfdr.de>; Sat, 20 Jun 2020 09:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFTHNJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 20 Jun 2020 03:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFTHNI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 20 Jun 2020 03:13:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97501C06174E;
        Sat, 20 Jun 2020 00:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CfONlCRjhO73FEJM/WnVlbCNj8YwlebODnTmK/qAM28=; b=e2Swv7dLWvXRlk0EHxa64o2Kkh
        S5v14RCvcHEGoijs4S7d1FiFLlHWjBoA0VAsRZk6o38HrJ8wZFJVaU/+87DUn991u7oeE+4jb2t/n
        1n1HQ1wbnikuSLUCYyFnB+JV6dpxlB7TBafk/lDUe3jDAoVsZu8E0W49zE19JY94vz6HhzycFe5x4
        /09sWovtueZ5QR1EeYishahcwXFLChbcfUH1ZInPsGyO+SjCWns4gXIU+g8l6F2HLW5MvyrVZeY+E
        /DKoWOs6X+DBjuTtlJ2K/BtMvo8chqnKUGR9554u6DIxWDtVHRK/hFy9CGTs7TtQpQMwcZIzJRRNH
        g8f8FPiA==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXgZ-000196-Vm; Sat, 20 Jun 2020 07:13:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH] libata: fix the ata_scsi_dma_need_drain stub
Date:   Sat, 20 Jun 2020 09:13:02 +0200
Message-Id: <20200620071302.462974-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620071302.462974-1-hch@lst.de>
References: <20200620071302.462974-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We don't only need the stub when libata is disable, but also if it
is modular and there are built-in SAS drivers (which can happen when
SCSI_SAS_ATA is disabled).

Fixes: b8f1d1e05817 ("scsi: Wire up ata_scsi_dma_need_drain for SAS HBA drivers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/libata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 042e584daca73e..c57bf674968114 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1092,7 +1092,7 @@ extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
 #define ATA_SCSI_COMPAT_IOCTL /* empty */
 #endif
 extern int ata_scsi_queuecmd(struct Scsi_Host *h, struct scsi_cmnd *cmd);
-#if IS_ENABLED(CONFIG_ATA)
+#if IS_REACHABLE(CONFIG_ATA)
 bool ata_scsi_dma_need_drain(struct request *rq);
 #else
 #define ata_scsi_dma_need_drain NULL
-- 
2.26.2

