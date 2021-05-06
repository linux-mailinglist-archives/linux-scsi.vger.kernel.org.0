Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF535375A3E
	for <lists+linux-scsi@lfdr.de>; Thu,  6 May 2021 20:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhEFSjj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 May 2021 14:39:39 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:48462 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbhEFSji (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 May 2021 14:39:38 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d05 with ME
        id 1WeN2500821Fzsu03WeNP0; Thu, 06 May 2021 20:38:38 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 May 2021 20:38:38 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, JBottomley@Odin.com, hare@suse.de,
        nmusini@cisco.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: snic: Fix an error message
Date:   Thu,  6 May 2021 20:38:20 +0200
Message-Id: <3b9d5d767e09d03a07bede293a6ba32e3735cd1a.1620326191.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

'ret' is known to be 0 here.
No error code is available, so just remove it from the error message.

While at it, change the word "Queuing" into "Init" which looks more
appropriate.

Fixes: c8806b6c9e82 ("snic: driver for Cisco SCSI HBA")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/snic/snic_ctl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/snic/snic_ctl.c b/drivers/scsi/snic/snic_ctl.c
index 4cd86115cfb2..703f229862fc 100644
--- a/drivers/scsi/snic/snic_ctl.c
+++ b/drivers/scsi/snic/snic_ctl.c
@@ -114,10 +114,7 @@ snic_queue_exch_ver_req(struct snic *snic)
 
 	rqi = snic_req_init(snic, 0);
 	if (!rqi) {
-		SNIC_HOST_ERR(snic->shost,
-			      "Queuing Exch Ver Req failed, err = %d\n",
-			      ret);
-
+		SNIC_HOST_ERR(snic->shost, "Init Exch Ver Req failed\n");
 		ret = -ENOMEM;
 		goto error;
 	}
-- 
2.30.2

