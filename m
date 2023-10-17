Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3E57CC032
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Oct 2023 12:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbjJQKIS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Oct 2023 06:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbjJQKHr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Oct 2023 06:07:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE41F9
        for <linux-scsi@vger.kernel.org>; Tue, 17 Oct 2023 03:07:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9753921D13;
        Tue, 17 Oct 2023 10:07:40 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 25FDD2D3F8;
        Tue, 17 Oct 2023 10:07:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 5276951EBE9C; Tue, 17 Oct 2023 12:07:40 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 14/16] fnic: use fc_block_rport() correctly
Date:   Tue, 17 Oct 2023 12:07:27 +0200
Message-Id: <20231017100729.123506-15-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231017100729.123506-1-hare@suse.de>
References: <20231017100729.123506-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [3.83 / 50.00];
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
         RCVD_COUNT_TWO(0.00)[2];
         BAYES_HAM(-1.66)[92.86%]
X-Spam-Score: 3.83
X-Rspamd-Queue-Id: 9753921D13
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use fc_block_rport() instead of fc_block_scsi_eh() and evaluate
the return value to avoid issuing TMF commands when the port
is still blocked.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/scsi/fnic/fnic_scsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 7a8b6285a096..90f30944eab3 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1719,9 +1719,6 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	unsigned long abt_issued_time;
 	DECLARE_COMPLETION_ONSTACK(tm_done);
 
-	/* Wait for rport to unblock */
-	fc_block_scsi_eh(sc);
-
 	/* Get local-port, check ready and link up */
 	lp = shost_priv(sc->device->host);
 
@@ -1731,6 +1728,10 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	term_stats = &fnic->fnic_stats.term_stats;
 
 	rport = starget_to_rport(scsi_target(sc->device));
+	ret = fc_block_rport(rport);
+	if (ret)
+		return ret;
+
 	FNIC_SCSI_DBG(KERN_DEBUG,
 		fnic->lport->host,
 		"Abort Cmd called FCID 0x%x, LUN 0x%llx TAG %x flags %x\n",
-- 
2.35.3

