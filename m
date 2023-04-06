Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4EA6D95CC
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Apr 2023 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbjDFLhT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Apr 2023 07:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbjDFLgl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Apr 2023 07:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201A8B747;
        Thu,  6 Apr 2023 04:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0B2B645A3;
        Thu,  6 Apr 2023 11:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB69C4339E;
        Thu,  6 Apr 2023 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680780856;
        bh=ttxrWK0ds3BLQZme7B06MSYATP5g4gqhmeNnU6qH4I0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8PWhkXdW6/MNpjP3Mjj7Rjd/Y4dw71SmfZ6nkSS02tEmAeDuYvDgwyJzTUvLz9kv
         YbdDmNC2TYWqDB4bKjHImMxUckhCHQoMKxCjwUzX5KqpQ+gwusjRpnT/ZVsq/Sagwh
         aP+Q2uxOGbGhz6MtvlKSZz10hxS2i3eyJ4tSrca3zpzlhCvwlOSLzAwWWOi8AOz80P
         zQTEnRv3D0rplqKWn3MG/BeTtfMSxbm5u6j01XBbPNJEdAPnSZ+bfTksL2h8mpRCCK
         2OCXeuG7bE9SnDxHXS2QxzROMmM/4Y7gdoiLCqffKOeEiR1vDh7CXD+tJsCA/AP4N/
         Voj6a9fLjbpvQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/8] scsi: core: Improve scsi_vpd_inquiry() checks
Date:   Thu,  6 Apr 2023 07:33:57 -0400
Message-Id: <20230406113400.649038-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406113400.649038-1-sashal@kernel.org>
References: <20230406113400.649038-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

[ Upstream commit f0aa59a33d2ac2267d260fe21eaf92500df8e7b4 ]

Some USB-SATA adapters have broken behavior when an unsupported VPD page is
probed: Depending on the VPD page number, a 4-byte header with a valid VPD
page number but with a 0 length is returned. Currently, scsi_vpd_inquiry()
only checks that the page number is valid to determine if the page is
valid, which results in receiving only the 4-byte header for the
non-existent page. This error manifests itself very often with page 0xb9
for the Concurrent Positioning Ranges detection done by sd_read_cpr(),
resulting in the following error message:

sd 0:0:0:0: [sda] Invalid Concurrent Positioning Ranges VPD page

Prevent such misleading error message by adding a check in
scsi_vpd_inquiry() to verify that the page length is not 0.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Link: https://lore.kernel.org/r/20230322022211.116327-1-damien.lemoal@opensource.wdc.com
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index febe29a9b8b06..acd118da88bfb 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -351,11 +351,18 @@ static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
 	if (result)
 		return -EIO;
 
-	/* Sanity check that we got the page back that we asked for */
+	/*
+	 * Sanity check that we got the page back that we asked for and that
+	 * the page size is not 0.
+	 */
 	if (buffer[1] != page)
 		return -EIO;
 
-	return get_unaligned_be16(&buffer[2]) + 4;
+	result = get_unaligned_be16(&buffer[2]);
+	if (!result)
+		return -EIO;
+
+	return result + 4;
 }
 
 /**
-- 
2.39.2

