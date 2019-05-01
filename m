Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E726C10C84
	for <lists+linux-scsi@lfdr.de>; Wed,  1 May 2019 19:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfEAR7l (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 13:59:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41672 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEAR7l (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 May 2019 13:59:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so8505061pls.8
        for <linux-scsi@vger.kernel.org>; Wed, 01 May 2019 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ImOHu9nbCp452klM4H4ZTNSIFwphYjn2TohZD60ojf0=;
        b=M9BKZz2tyzrlv6HJ476k7/2YIBvTwD1NA9wP31T0QPBGccSdvUzsTT2h3mtwu3dvfa
         Q4zY+tCi2ZxmUoW+RnIcQbTzoyiq75EMDVEwtM8yqjrRERcC87sRDzPWGqR5qAn1e2JI
         LUhPqY1yrhEhCixe9dN1BNy/x7vbBjksXSYww0BVZWOjuNHSTdMO3zOxiFtHBXJC+dcN
         dPc7tXkkpEgXPTuCUzyf3ptHdwCLXBJYD542d9cGbbuicidiYSSkMM7u4PCqg5b/JzkK
         lBXWFcPqt+RIIrUynzVBogubFwht5Ij+qAxdICx45bUG+e7yELuMI5n4sC4JX20eGAgx
         1Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ImOHu9nbCp452klM4H4ZTNSIFwphYjn2TohZD60ojf0=;
        b=I6JX5fwp2sDGQ5oUeLEpWnIn4p3hVJSimKTCqgRHE9IOuTmU7Ub1GHB1PbclhxpnJv
         GD6F0CevVHGVyOzIFPcnH/K94WaCBi3vFb21hfx3tCrF4O6y15dfca4HBARsF06vCHFC
         DXUpoD9v7kg40/o0pS4i6GYQQU0O2R3Wyvof6bgYeRJrD6+DjP8k7K/KrIlb4Di6kNqa
         xgNqBdlELxi1kPyICpyeHGzMzlxh0JmVJKsJQXy5VGWmIPTM/RI984hK3Umd9h1WLx3g
         OpZPSerRFymNO7ZvmN4g3/CJRf0uIeG30KIgfHNMpR8Krh/rzBL0NYFBGdoCLzdJZkT9
         D+lw==
X-Gm-Message-State: APjAAAU54nYX7VoHECOhEZl4npiyfBknkjqO9P3rcEAkj5w7MU4R/KN4
        w72/vcXz5Y1sMGb43+OX9A/pK4ZL
X-Google-Smtp-Source: APXvYqyb0TA/twTgKmRn4F9Uraf0BF0BsU+xpMB9+/b0/VJOALgE8OtOs9mFZzbO7QVaWe5XQcr6KQ==
X-Received: by 2002:a17:902:4383:: with SMTP id j3mr7646860pld.320.1556733580679;
        Wed, 01 May 2019 10:59:40 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z7sm72906679pgh.81.2019.05.01.10.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 10:59:40 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 2/4] lpfc: correct rcu unlock issue in lpfc_nvme_info_show
Date:   Wed,  1 May 2019 10:59:24 -0700
Message-Id: <20190501175926.4551-3-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190501175926.4551-1-jsmart2021@gmail.com>
References: <20190501175926.4551-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Many of the exit cases were not releasing the rcu read lock.
Corrected the exit paths.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 31b963ae7289..d4c65e2109e2 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -355,7 +355,7 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 		  phba->sli4_hba.io_xri_max,
 		  lpfc_sli4_get_els_iocb_cnt(phba));
 	if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
-		goto buffer_done;
+		goto rcu_unlock_buf_done;
 
 	/* Port state is only one of two values for now. */
 	if (localport->port_id)
@@ -371,7 +371,7 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 		  wwn_to_u64(vport->fc_nodename.u.wwn),
 		  localport->port_id, statep);
 	if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
-		goto buffer_done;
+		goto rcu_unlock_buf_done;
 
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
 		nrport = NULL;
@@ -398,39 +398,39 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 
 		/* Tab in to show lport ownership. */
 		if (strlcat(buf, "NVME RPORT       ", PAGE_SIZE) >= PAGE_SIZE)
-			goto buffer_done;
+			goto rcu_unlock_buf_done;
 		if (phba->brd_no >= 10) {
 			if (strlcat(buf, " ", PAGE_SIZE) >= PAGE_SIZE)
-				goto buffer_done;
+				goto rcu_unlock_buf_done;
 		}
 
 		scnprintf(tmp, sizeof(tmp), "WWPN x%llx ",
 			  nrport->port_name);
 		if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
-			goto buffer_done;
+			goto rcu_unlock_buf_done;
 
 		scnprintf(tmp, sizeof(tmp), "WWNN x%llx ",
 			  nrport->node_name);
 		if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
-			goto buffer_done;
+			goto rcu_unlock_buf_done;
 
 		scnprintf(tmp, sizeof(tmp), "DID x%06x ",
 			  nrport->port_id);
 		if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
-			goto buffer_done;
+			goto rcu_unlock_buf_done;
 
 		/* An NVME rport can have multiple roles. */
 		if (nrport->port_role & FC_PORT_ROLE_NVME_INITIATOR) {
 			if (strlcat(buf, "INITIATOR ", PAGE_SIZE) >= PAGE_SIZE)
-				goto buffer_done;
+				goto rcu_unlock_buf_done;
 		}
 		if (nrport->port_role & FC_PORT_ROLE_NVME_TARGET) {
 			if (strlcat(buf, "TARGET ", PAGE_SIZE) >= PAGE_SIZE)
-				goto buffer_done;
+				goto rcu_unlock_buf_done;
 		}
 		if (nrport->port_role & FC_PORT_ROLE_NVME_DISCOVERY) {
 			if (strlcat(buf, "DISCSRVC ", PAGE_SIZE) >= PAGE_SIZE)
-				goto buffer_done;
+				goto rcu_unlock_buf_done;
 		}
 		if (nrport->port_role & ~(FC_PORT_ROLE_NVME_INITIATOR |
 					  FC_PORT_ROLE_NVME_TARGET |
@@ -438,12 +438,12 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 			scnprintf(tmp, sizeof(tmp), "UNKNOWN ROLE x%x",
 				  nrport->port_role);
 			if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
-				goto buffer_done;
+				goto rcu_unlock_buf_done;
 		}
 
 		scnprintf(tmp, sizeof(tmp), "%s\n", statep);
 		if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
-			goto buffer_done;
+			goto rcu_unlock_buf_done;
 	}
 	rcu_read_unlock();
 
@@ -505,7 +505,13 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 		  atomic_read(&lport->cmpl_fcp_err));
 	strlcat(buf, tmp, PAGE_SIZE);
 
-buffer_done:
+	/* RCU is already unlocked. */
+	goto buffer_done;
+
+ rcu_unlock_buf_done:
+	rcu_read_unlock();
+
+ buffer_done:
 	len = strnlen(buf, PAGE_SIZE);
 
 	if (unlikely(len >= (PAGE_SIZE - 1))) {
-- 
2.13.7

