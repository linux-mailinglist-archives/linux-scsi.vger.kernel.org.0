Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6DC34330
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfFDJan (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 05:30:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:35736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbfFDJan (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 05:30:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88CDBAE51;
        Tue,  4 Jun 2019 09:30:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] fcoe: avoid memset across pointer boundaries
Date:   Tue,  4 Jun 2019 11:30:28 +0200
Message-Id: <20190604093028.79673-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Gcc-9 complains for a memset across pointer boundaries, which happens
as the code tries to allocate a flexible array on the stack.
Turns out we cannot do this without relying on gcc-isms, so
this patch converts the stack allocation in proper kzalloc() calls.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 50 +++++++++++++++++++++++++------------------
 include/scsi/libfc.h          |  1 +
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 0d7770d07405..3b9db5093c3e 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -2005,7 +2005,7 @@ EXPORT_SYMBOL_GPL(fcoe_wwn_from_mac);
  */
 static inline struct fcoe_rport *fcoe_ctlr_rport(struct fc_rport_priv *rdata)
 {
-	return (struct fcoe_rport *)(rdata + 1);
+	return (struct fcoe_rport *)(&rdata->rpriv);
 }
 
 /**
@@ -2284,7 +2284,6 @@ static int fcoe_ctlr_vn_parse(struct fcoe_ctlr *fip,
 	u32 dtype;
 	u8 sub;
 
-	memset(rdata, 0, sizeof(*rdata) + sizeof(*frport));
 	frport = fcoe_ctlr_rport(rdata);
 
 	fiph = (struct fip_header *)skb->data;
@@ -2738,10 +2737,7 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 {
 	struct fip_header *fiph;
 	enum fip_vn2vn_subcode sub;
-	struct {
-		struct fc_rport_priv rdata;
-		struct fcoe_rport frport;
-	} buf;
+	struct fc_rport_priv *rdata;
 	int rc, vlan_id = 0;
 
 	fiph = (struct fip_header *)skb->data;
@@ -2757,28 +2753,35 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 		goto drop;
 	}
 
-	rc = fcoe_ctlr_vn_parse(fip, skb, &buf.rdata);
+	rdata = kzalloc(sizeof(*rdata) + sizeof(struct fcoe_rport), GFP_KERNEL);
+	if (!rdata) {
+		LIBFCOE_FIP_DBG(fip, "vn_recv rdata alloc error\n");
+		rc = -EAGAIN;
+		goto drop;
+	}
+
+	rc = fcoe_ctlr_vn_parse(fip, skb, rdata);
 	if (rc) {
 		LIBFCOE_FIP_DBG(fip, "vn_recv vn_parse error %d\n", rc);
-		goto drop;
+		goto free;
 	}
 
 	mutex_lock(&fip->ctlr_mutex);
 	switch (sub) {
 	case FIP_SC_VN_PROBE_REQ:
-		fcoe_ctlr_vn_probe_req(fip, &buf.rdata);
+		fcoe_ctlr_vn_probe_req(fip, rdata);
 		break;
 	case FIP_SC_VN_PROBE_REP:
-		fcoe_ctlr_vn_probe_reply(fip, &buf.rdata);
+		fcoe_ctlr_vn_probe_reply(fip, rdata);
 		break;
 	case FIP_SC_VN_CLAIM_NOTIFY:
-		fcoe_ctlr_vn_claim_notify(fip, &buf.rdata);
+		fcoe_ctlr_vn_claim_notify(fip, rdata);
 		break;
 	case FIP_SC_VN_CLAIM_REP:
-		fcoe_ctlr_vn_claim_resp(fip, &buf.rdata);
+		fcoe_ctlr_vn_claim_resp(fip, rdata);
 		break;
 	case FIP_SC_VN_BEACON:
-		fcoe_ctlr_vn_beacon(fip, &buf.rdata);
+		fcoe_ctlr_vn_beacon(fip, rdata);
 		break;
 	default:
 		LIBFCOE_FIP_DBG(fip, "vn_recv unknown subcode %d\n", sub);
@@ -2786,6 +2789,8 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 		break;
 	}
 	mutex_unlock(&fip->ctlr_mutex);
+free:
+	kfree(rdata);
 drop:
 	kfree_skb(skb);
 	return rc;
@@ -2982,24 +2987,27 @@ static int fcoe_ctlr_vlan_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 {
 	struct fip_header *fiph;
 	enum fip_vlan_subcode sub;
-	struct {
-		struct fc_rport_priv rdata;
-		struct fcoe_rport frport;
-	} buf;
+	struct fc_rport_priv *rdata;
 	int rc;
 
+	rdata = kzalloc(sizeof(*rdata) + sizeof(struct fcoe_rport), GFP_KERNEL);
+	if (!rdata) {
+		LIBFCOE_FIP_DBG(fip, "vlan_recv rdata alloc error\n");
+		goto drop;
+	}
 	fiph = (struct fip_header *)skb->data;
 	sub = fiph->fip_subcode;
-	rc = fcoe_ctlr_vlan_parse(fip, skb, &buf.rdata);
+	rc = fcoe_ctlr_vlan_parse(fip, skb, rdata);
 	if (rc) {
 		LIBFCOE_FIP_DBG(fip, "vlan_recv vlan_parse error %d\n", rc);
-		goto drop;
+		goto free;
 	}
 	mutex_lock(&fip->ctlr_mutex);
 	if (sub == FIP_SC_VL_REQ)
-		fcoe_ctlr_vlan_disc_reply(fip, &buf.rdata);
+		fcoe_ctlr_vlan_disc_reply(fip, rdata);
 	mutex_unlock(&fip->ctlr_mutex);
-
+free:
+	kfree(rdata);
 drop:
 	kfree_skb(skb);
 	return rc;
diff --git a/include/scsi/libfc.h b/include/scsi/libfc.h
index 13dd2eebc20e..8c9db4f531ce 100644
--- a/include/scsi/libfc.h
+++ b/include/scsi/libfc.h
@@ -212,6 +212,7 @@ struct fc_rport_priv {
 	struct rcu_head		    rcu;
 	u16			    sp_features;
 	u8			    spp_type;
+	char			    rpriv[];
 };
 
 /**
-- 
2.16.4

