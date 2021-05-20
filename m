Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2987B389CC7
	for <lists+linux-scsi@lfdr.de>; Thu, 20 May 2021 06:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhETEpv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 May 2021 00:45:51 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:34196 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETEpv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 May 2021 00:45:51 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d84 with ME
        id 6skT2500521Fzsu03skTup; Thu, 20 May 2021 06:44:29 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 20 May 2021 06:44:29 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        James.Bottomley@SteelEye.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: sni_53c710: Fix a resource leak in an error handling path
Date:   Thu, 20 May 2021 06:44:25 +0200
Message-Id: <5a97774020847f6b63e161197254d15ef1d786ea.1621485792.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

After a successful 'NCR_700_detect()' call, 'NCR_700_release()' must be
called to release some DMA related resources, as already done in the
remove function.

Fixes: c27d85f3f3c5 ("[SCSI] SNI RM 53c710 driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/sni_53c710.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sni_53c710.c b/drivers/scsi/sni_53c710.c
index 678651b9b4dd..f6d60d542207 100644
--- a/drivers/scsi/sni_53c710.c
+++ b/drivers/scsi/sni_53c710.c
@@ -98,6 +98,7 @@ static int snirm710_probe(struct platform_device *dev)
 
  out_put_host:
 	scsi_host_put(host);
+	NCR_700_release(host);
  out_kfree:
 	iounmap(hostdata->base);
 	kfree(hostdata);
-- 
2.30.2

