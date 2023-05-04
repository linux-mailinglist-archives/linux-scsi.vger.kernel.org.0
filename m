Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D934D6F74A4
	for <lists+linux-scsi@lfdr.de>; Thu,  4 May 2023 21:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjEDTwP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 May 2023 15:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjEDTue (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 May 2023 15:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5138150DF;
        Thu,  4 May 2023 12:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29DF26375D;
        Thu,  4 May 2023 19:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD50C433D2;
        Thu,  4 May 2023 19:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229605;
        bh=f84D5WyFdSwh29Ao5yQKxvAWap/3U4GPVj/72rrimQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RLgqIUtezNt/nnKpC1vqyNv8+pyGm0bHwgzhzCBiMDBIvr3ptLcLBjuQkHFH6QMMN
         hiIv3bkgFNUQ4jpuJEk4cTbia3Ro765ymc+sw7toCxRpjw9IL0LdkytYtoX7g18kYy
         INwxgRd/h3jEREYpVdNUKrHnVlh+iQdQr1p5+SQxV7ho92Yw9fAzfRqP/uyxtGPy6g
         RWshAUsyC4GRBPI3yvWZxPIthWNPJSrJDzYHyXgYIrNsQTI8805zkF3ciRGVlh/gGw
         WpgvkrN1CjMBafFqNBPX4F8ypVWKXiahr+SYAhEeoyIiskteUKuRhXvqkq8QpegJG+
         ZhOTfNgdlNRXQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Justin Tee <justin.tee@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/49] scsi: lpfc: Prevent lpfc_debugfs_lockstat_write() buffer overflow
Date:   Thu,  4 May 2023 15:45:44 -0400
Message-Id: <20230504194626.3807438-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit c6087b82a9146826564a55c5ca0164cac40348f5 ]

A static code analysis tool flagged the possibility of buffer overflow when
using copy_from_user() for a debugfs entry.

Currently, it is possible that copy_from_user() copies more bytes than what
would fit in the mybuf char array.  Add a min() restriction check between
sizeof(mybuf) - 1 and nbytes passed from the userspace buffer to protect
against buffer overflow.

Link: https://lore.kernel.org/r/20230301231626.9621-2-justintee8345@gmail.com
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index f5252e45a48a2..3e365e5e194a2 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2157,10 +2157,13 @@ lpfc_debugfs_lockstat_write(struct file *file, const char __user *buf,
 	char mybuf[64];
 	char *pbuf;
 	int i;
+	size_t bsize;
 
 	memset(mybuf, 0, sizeof(mybuf));
 
-	if (copy_from_user(mybuf, buf, nbytes))
+	bsize = min(nbytes, (sizeof(mybuf) - 1));
+
+	if (copy_from_user(mybuf, buf, bsize))
 		return -EFAULT;
 	pbuf = &mybuf[0];
 
@@ -2181,7 +2184,7 @@ lpfc_debugfs_lockstat_write(struct file *file, const char __user *buf,
 			qp->lock_conflict.wq_access = 0;
 		}
 	}
-	return nbytes;
+	return bsize;
 }
 #endif
 
-- 
2.39.2

