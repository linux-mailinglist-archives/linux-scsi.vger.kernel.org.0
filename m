Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D59D156ED
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 02:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEGA1l (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 May 2019 20:27:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47069 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEGA1k (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 6 May 2019 20:27:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi2so7185007plb.13
        for <linux-scsi@vger.kernel.org>; Mon, 06 May 2019 17:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ImOHu9nbCp452klM4H4ZTNSIFwphYjn2TohZD60ojf0=;
        b=oX9S+ceyrjRUxowAyAVxsKcL69LTl7+tiZeRWvZ3JC5m65RvviINTiLiZFDSpHYYoo
         SPMZ+OaH/cbvSuXb7x0fXo0sbmCZmpKScVRSUKABNLH6iUCQx7I/AbJRCmErP6aCIZSR
         nHe1G14tNJVQ0C9typtjKDfYBU+AXvBqP9RC42tOwzgaxtvyR1PKFqD6D6oCKwhBgpSH
         DiNIZxM6OKY/QS11bGJ/srGLA7gZZgyWC3IiXNmWF4FEkq3HziowaS1PSuXXy8mgTcWo
         FIzrIMs4M3s8U8h8larjfql5YaFp3l0+ZwXJqCSc3ffE/t4DlTex60n5cAvGK6JBrmvf
         BVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ImOHu9nbCp452klM4H4ZTNSIFwphYjn2TohZD60ojf0=;
        b=b3vsIMqRmhS3cBAKluIRLn2gOWkYJRnQsJRvasFwhdGGdPN3iwWJTlb9QvZZewvON+
         dGR8YjXwZHmmT9Vjv2jFrJlu1BAAreJueATaE5PoKffqkp3I593qoDmhgRTlbzRKGbnO
         ePpIQp5YVURsznt6GV8cdisTJ/jD0tf9f6CnifLoF78fIobVmWYlZsASTqetFqvGFqPm
         pr7fCMoAfzx8rHyEcABzJJKoW/BeIEVd0AfAJqd1FD5wdJo1oAYLaHG8Mw3TwSCdV97X
         b0dVG4xbnGhC4wwmyEhHbL7s2f0vgvC1lIlAfHCVxDSWzZfD0/eA8Aq3fgm6aD0CqkGo
         P6MA==
X-Gm-Message-State: APjAAAVhQZB9rkhsmAQwQNZNrRugmSiwb8RtReKtN0zZHp2SwdxF8Uv0
        iVKRQOycfkcZpkf9mRgdvfwX0aZN
X-Google-Smtp-Source: APXvYqwRF9jFK6SKb3+41VrwBA5bQgcd73AdAgmihMRNHvhU3E2SOh/sbkZ5aalyQpwp0VbOK/ZLLQ==
X-Received: by 2002:a17:902:7c93:: with SMTP id y19mr2650263pll.268.1557188859914;
        Mon, 06 May 2019 17:27:39 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id r8sm14756623pfn.11.2019.05.06.17.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 17:27:39 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH v2 2/4] lpfc: correct rcu unlock issue in lpfc_nvme_info_show
Date:   Mon,  6 May 2019 17:26:48 -0700
Message-Id: <20190507002650.23210-3-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190507002650.23210-1-jsmart2021@gmail.com>
References: <20190507002650.23210-1-jsmart2021@gmail.com>
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

