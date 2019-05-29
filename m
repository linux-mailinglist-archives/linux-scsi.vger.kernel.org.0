Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665432E656
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfE2Uka (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:40:30 -0400
Received: from www17.your-server.de ([213.133.104.17]:60010 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfE2Uka (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:40:30 -0400
X-Greylist: delayed 1130 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 16:40:29 EDT
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW54w-0005yN-A2; Wed, 29 May 2019 22:21:42 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=maria.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW54v-0006Vr-20; Wed, 29 May 2019 22:21:42 +0200
Received: by maria.localdomain (sSMTP sendmail emulation); Wed, 29 May 2019 22:21:40 +0200
From:   "Thomas Meyer" <thomas@m3y3r.de>
Date:   Wed, 29 May 2019 22:21:40 +0200
Subject: [PATCH] scsi: pmcraid: Use *_pool_zalloc rather than *_pool_alloc
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1559161113902-328168114-2-diffsplit-thomas@m3y3r.de>
References: <1559161113889-196429735-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1559161113889-196429735-0-diffsplit-thomas@m3y3r.de>
X-Serial-No: 2
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25464/Wed May 29 09:59:09 2019)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use *_pool_zalloc rather than *_pool_alloc followed by memset with 0.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4668,18 +4668,14 @@ static int pmcraid_allocate_control_bloc
 		return -ENOMEM;
 
 	for (i = 0; i < PMCRAID_MAX_CMD; i++) {
-		pinstance->cmd_list[i]->ioa_cb =
-			dma_pool_alloc(
-				pinstance->control_pool,
-				GFP_KERNEL,
-				&(pinstance->cmd_list[i]->ioa_cb_bus_addr));
+		pinstance->cmd_list[i]->ioa_cb = dma_pool_zalloc(pinstance->control_pool,
+								 GFP_KERNEL,
+								 &(pinstance->cmd_list[i]->ioa_cb_bus_addr));
 
 		if (!pinstance->cmd_list[i]->ioa_cb) {
 			pmcraid_release_control_blocks(pinstance, i);
 			return -ENOMEM;
 		}
-		memset(pinstance->cmd_list[i]->ioa_cb, 0,
-			sizeof(struct pmcraid_control_block));
 	}
 	return 0;
 }
