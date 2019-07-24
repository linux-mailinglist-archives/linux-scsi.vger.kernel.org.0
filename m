Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F3372AF4
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jul 2019 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfGXJBO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Jul 2019 05:01:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:55386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726759AbfGXJBO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 24 Jul 2019 05:01:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E8FDB031;
        Wed, 24 Jul 2019 09:01:12 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/3] libfc: Whitespqce cleanup in libfc.h
Date:   Wed, 24 Jul 2019 11:00:54 +0200
Message-Id: <20190724090056.7506-2-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190724090056.7506-1-hare@suse.de>
References: <20190724090056.7506-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

No functional change.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/scsi/libfc.h | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/scsi/libfc.h b/include/scsi/libfc.h
index 76cb9192319a..aab23934f662 100644
--- a/include/scsi/libfc.h
+++ b/include/scsi/libfc.h
@@ -115,7 +115,7 @@ struct fc_disc_port {
 	struct fc_lport    *lp;
 	struct list_head   peers;
 	struct work_struct rport_work;
-	u32                port_id;
+	u32		   port_id;
 };
 
 /**
@@ -155,14 +155,14 @@ struct fc_rport_operations {
  */
 struct fc_rport_libfc_priv {
 	struct fc_lport		   *local_port;
-	enum fc_rport_state        rp_state;
+	enum fc_rport_state	   rp_state;
 	u16			   flags;
 	#define FC_RP_FLAGS_REC_SUPPORTED	(1 << 0)
 	#define FC_RP_FLAGS_RETRY		(1 << 1)
 	#define FC_RP_STARTED			(1 << 2)
 	#define FC_RP_FLAGS_CONF_REQ		(1 << 3)
-	unsigned int	           e_d_tov;
-	unsigned int	           r_a_tov;
+	unsigned int		   e_d_tov;
+	unsigned int		   r_a_tov;
 };
 
 /**
@@ -191,24 +191,24 @@ struct fc_rport_priv {
 	struct fc_lport		    *local_port;
 	struct fc_rport		    *rport;
 	struct kref		    kref;
-	enum fc_rport_state         rp_state;
+	enum fc_rport_state	    rp_state;
 	struct fc_rport_identifiers ids;
 	u16			    flags;
-	u16		            max_seq;
+	u16			    max_seq;
 	u16			    disc_id;
 	u16			    maxframe_size;
-	unsigned int	            retries;
-	unsigned int	            major_retries;
-	unsigned int	            e_d_tov;
-	unsigned int	            r_a_tov;
-	struct mutex                rp_mutex;
+	unsigned int		    retries;
+	unsigned int		    major_retries;
+	unsigned int		    e_d_tov;
+	unsigned int		    r_a_tov;
+	struct mutex		    rp_mutex;
 	struct delayed_work	    retry_work;
-	enum fc_rport_event         event;
+	enum fc_rport_event	    event;
 	struct fc_rport_operations  *ops;
-	struct list_head            peers;
-	struct work_struct          event_work;
+	struct list_head	    peers;
+	struct work_struct	    event_work;
 	u32			    supported_classes;
-	u16                         prli_count;
+	u16			    prli_count;
 	struct rcu_head		    rcu;
 	u16			    sp_features;
 	u8			    spp_type;
@@ -618,12 +618,12 @@ struct libfc_function_template {
  * @disc_callback: Callback routine called when discovery completes
  */
 struct fc_disc {
-	unsigned char         retry_count;
-	unsigned char         pending;
-	unsigned char         requested;
-	unsigned short        seq_count;
-	unsigned char         buf_len;
-	u16                   disc_id;
+	unsigned char	      retry_count;
+	unsigned char	      pending;
+	unsigned char	      requested;
+	unsigned short	      seq_count;
+	unsigned char	      buf_len;
+	u16		      disc_id;
 
 	struct list_head      rports;
 	void		      *priv;
@@ -697,7 +697,7 @@ struct fc_lport {
 	struct fc_rport_priv	       *ms_rdata;
 	struct fc_rport_priv	       *ptp_rdata;
 	void			       *scsi_priv;
-	struct fc_disc                 disc;
+	struct fc_disc		       disc;
 
 	/* Virtual port information */
 	struct list_head	       vports;
@@ -715,7 +715,7 @@ struct fc_lport {
 	u8			       retry_count;
 
 	/* Fabric information */
-	u32                            port_id;
+	u32			       port_id;
 	u64			       wwpn;
 	u64			       wwnn;
 	unsigned int		       service_params;
@@ -743,11 +743,11 @@ struct fc_lport {
 	struct fc_ns_fts	       fcts;
 
 	/* Miscellaneous */
-	struct mutex                   lp_mutex;
-	struct list_head               list;
+	struct mutex		       lp_mutex;
+	struct list_head	       list;
 	struct delayed_work	       retry_work;
 	void			       *prov[FC_FC4_PROV_SIZE];
-	struct list_head               lport_list;
+	struct list_head	       lport_list;
 };
 
 /**
-- 
2.16.4

