Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0717CC026
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Oct 2023 12:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjJQKHr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Oct 2023 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbjJQKHo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Oct 2023 06:07:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B9DA2
        for <linux-scsi@vger.kernel.org>; Tue, 17 Oct 2023 03:07:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 12E0321CE3;
        Tue, 17 Oct 2023 10:07:40 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id CE0652C657;
        Tue, 17 Oct 2023 10:07:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id F295851EBE84; Tue, 17 Oct 2023 12:07:39 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 01/16] zfcp: do not wait for rports to become unblocked after host reset
Date:   Tue, 17 Oct 2023 12:07:14 +0200
Message-Id: <20231017100729.123506-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231017100729.123506-1-hare@suse.de>
References: <20231017100729.123506-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.49 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.20)[suse.de];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[6];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2]
X-Spam-Score: 5.49
X-Rspamd-Queue-Id: 12E0321CE3
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

zfcp_scsi_eh_host_reset_handler() would call fc_block_rport() to
wait for all rports to become unblocked after host reset.
But after host reset it might happen that the port is gone, hence
fc_block_rport() might fail due to a missing port.
But that's a perfectly legal operation; on FC remote ports might
come and go.
So this patch removes the call to fc_block_rport() after host
reset. But with that rports may still be in blocked state after
host reset, so we need to return FAST_IO_FAIL from host reset
to avoid SCSI EH to fail commands prematurely if the rports
are still blocked.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Cc: Steffen Maier <maier@linux.ibm.com
Cc: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_scsi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index b2a8cd792266..b1df853e6f66 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -375,7 +375,7 @@ static int zfcp_scsi_eh_host_reset_handler(struct scsi_cmnd *scpnt)
 {
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(scpnt->device);
 	struct zfcp_adapter *adapter = zfcp_sdev->port->adapter;
-	int ret = SUCCESS, fc_ret;
+	int ret = FAST_IO_FAIL;
 
 	if (!(adapter->connection_features & FSF_FEATURE_NPIV_MODE)) {
 		zfcp_erp_port_forced_reopen_all(adapter, 0, "schrh_p");
@@ -383,10 +383,6 @@ static int zfcp_scsi_eh_host_reset_handler(struct scsi_cmnd *scpnt)
 	}
 	zfcp_erp_adapter_reopen(adapter, 0, "schrh_1");
 	zfcp_erp_wait(adapter);
-	fc_ret = fc_block_scsi_eh(scpnt);
-	if (fc_ret)
-		ret = fc_ret;
-
 	zfcp_dbf_scsi_eh("schrh_r", adapter, ~0, ret);
 	return ret;
 }
-- 
2.35.3

