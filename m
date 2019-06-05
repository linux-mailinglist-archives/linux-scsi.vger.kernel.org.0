Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A9B357F8
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFEHjw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 03:39:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:43034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbfFEHjw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 5 Jun 2019 03:39:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F32C0B006;
        Wed,  5 Jun 2019 07:39:50 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/4] libfc: kill lld_event_callback
Date:   Wed,  5 Jun 2019 09:39:39 +0200
Message-Id: <20190605073942.125577-2-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190605073942.125577-1-hare@suse.de>
References: <20190605073942.125577-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

It will only ever be set so another callback, and the pointer to
this callback is available on all locations. So kill it.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/libfc/fc_rport.c | 13 ++++++-------
 include/scsi/libfc.h          |  3 ---
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index 0da34c7a6866..255e6568be66 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -155,10 +155,9 @@ struct fc_rport_priv *fc_rport_create(struct fc_lport *lport, u32 port_id)
 	rdata->maxframe_size = FC_MIN_MAX_PAYLOAD;
 	INIT_DELAYED_WORK(&rdata->retry_work, fc_rport_timeout);
 	INIT_WORK(&rdata->event_work, fc_rport_work);
-	if (port_id != FC_FID_DIR_SERV) {
-		rdata->lld_event_callback = lport->tt.rport_event_callback;
+	if (port_id != FC_FID_DIR_SERV)
 		list_add_rcu(&rdata->peers, &lport->disc.rports);
-	}
+
 	return rdata;
 }
 EXPORT_SYMBOL(fc_rport_create);
@@ -308,9 +307,9 @@ static void fc_rport_work(struct work_struct *work)
 			FC_RPORT_DBG(rdata, "callback ev %d\n", event);
 			rport_ops->event_callback(lport, rdata, event);
 		}
-		if (rdata->lld_event_callback) {
+		if (lport->tt.rport_event_callback) {
 			FC_RPORT_DBG(rdata, "lld callback ev %d\n", event);
-			rdata->lld_event_callback(lport, rdata, event);
+			lport->tt.rport_event_callback(lport, rdata, event);
 		}
 		kref_put(&rdata->kref, fc_rport_destroy);
 		break;
@@ -334,9 +333,9 @@ static void fc_rport_work(struct work_struct *work)
 			FC_RPORT_DBG(rdata, "callback ev %d\n", event);
 			rport_ops->event_callback(lport, rdata, event);
 		}
-		if (rdata->lld_event_callback) {
+		if (lport->tt.rport_event_callback) {
 			FC_RPORT_DBG(rdata, "lld callback ev %d\n", event);
-			rdata->lld_event_callback(lport, rdata, event);
+			lport->tt.rport_event_callback(lport, rdata, event);
 		}
 		if (cancel_delayed_work_sync(&rdata->retry_work))
 			kref_put(&rdata->kref, fc_rport_destroy);
diff --git a/include/scsi/libfc.h b/include/scsi/libfc.h
index 76cb9192319a..2c3c5b9e7cc6 100644
--- a/include/scsi/libfc.h
+++ b/include/scsi/libfc.h
@@ -212,9 +212,6 @@ struct fc_rport_priv {
 	struct rcu_head		    rcu;
 	u16			    sp_features;
 	u8			    spp_type;
-	void			    (*lld_event_callback)(struct fc_lport *,
-						      struct fc_rport_priv *,
-						      enum fc_rport_event);
 };
 
 /**
-- 
2.16.4

