Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDF96AEBFB
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Mar 2023 18:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjCGRus (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Mar 2023 12:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjCGRuY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 Mar 2023 12:50:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31808A0296;
        Tue,  7 Mar 2023 09:45:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2FC5614E8;
        Tue,  7 Mar 2023 17:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75CEC433EF;
        Tue,  7 Mar 2023 17:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678211123;
        bh=eZhh6BSFQ1k6BW1csQ0X36HHVeHgWxg0M5U+VtotJqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1RXqCRggUynjMgz4L0pMspKQhydFmiEEDLdbxFZYVX+ACrpts+KdfanYIp4ZNDbW
         QSWuoGibFBKLsS/A1r28uTbJlGkELrXpTa8Y7Ov+HjSxvL7vG+cSQ5Qh6OZCUgly25
         X5MWPiSPs5TGjkS7iKwwRh3PIVCG14yDaD4hA7Ts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 0729/1001] scsi: snic: Fix memory leak with using debugfs_lookup()
Date:   Tue,  7 Mar 2023 17:58:21 +0100
Message-Id: <20230307170053.340405583@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307170022.094103862@linuxfoundation.org>
References: <20230307170022.094103862@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit ad0e4e2fab928477f74d742e6e77d79245d3d3e7 ]

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic at
once.

Link: https://lore.kernel.org/r/20230202141009.2290380-1-gregkh@linuxfoundation.org
Cc: Karan Tilak Kumar <kartilak@cisco.com>
Cc: Sesidhar Baddela <sebaddel@cisco.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/snic/snic_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 57bdc3ba49d9c..9dd975b36b5bd 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -437,6 +437,6 @@ void snic_trc_debugfs_init(void)
 void
 snic_trc_debugfs_term(void)
 {
-	debugfs_remove(debugfs_lookup(TRC_FILE, snic_glob->trc_root));
-	debugfs_remove(debugfs_lookup(TRC_ENABLE_FILE, snic_glob->trc_root));
+	debugfs_lookup_and_remove(TRC_FILE, snic_glob->trc_root);
+	debugfs_lookup_and_remove(TRC_ENABLE_FILE, snic_glob->trc_root);
 }
-- 
2.39.2



