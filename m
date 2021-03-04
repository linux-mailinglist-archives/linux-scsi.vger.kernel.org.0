Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1432D2E7
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Mar 2021 13:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbhCDM2f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Mar 2021 07:28:35 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30]:40466 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240502AbhCDM2D (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Mar 2021 07:28:03 -0500
Received: from localhost.localdomain (unknown [10.157.2.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 0A90822590;
        Thu,  4 Mar 2021 04:19:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0A90822590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1614860398;
        bh=iNcyFJyTKjzxYkDx4WW/6UuGlOCZHy6l9mGwuCR9nUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpbdIXgTeWb9aAkAQz6jGO2urf0vsUzz6HpYvUSqwORVSi8ytIpvFFBzyVq4vcSOf
         IixLzu5bF3TS00fTW9ub7/PzIewzo6tPX8ufGIEWqhpdSO+nDDiYGaVu/bDHyFk+zR
         OwOeBrO904hozhiwhALqtdzgyvBMNqLU/hu6yOYQ=
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org, hare@suse.de
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v8 06/16] lpfc: vmid: Forward declarations for APIs
Date:   Thu,  4 Mar 2021 10:57:16 +0530
Message-Id: <1614835646-16217-7-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch contains the forward declarations of commonly used APIs which
are used outside the scope of the file.

Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v8:
modify function declaration

v7:
No change

v6:
No change

v5:
No change

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_crtn.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index a0aad4896a45..6a73819d9b6b 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -608,3 +608,14 @@ extern unsigned long lpfc_no_hba_reset[];
 extern union lpfc_wqe128 lpfc_iread_cmd_template;
 extern union lpfc_wqe128 lpfc_iwrite_cmd_template;
 extern union lpfc_wqe128 lpfc_icmnd_cmd_template;
+
+/* vmid interface */
+int lpfc_vmid_uvem(struct lpfc_vport *vport, struct lpfc_vmid *vmid, bool ins);
+uint32_t lpfc_vmid_get_cs_ctl(struct lpfc_vport *vport);
+int lpfc_vmid_cmd(struct lpfc_vport *vport,
+		  int cmdcode, struct lpfc_vmid *vmid);
+int lpfc_vmid_hash_fn(const char *vmid, int len);
+struct lpfc_vmid *lpfc_get_vmid_from_hastable(struct lpfc_vport *vport,
+					      uint32_t hash, uint8_t *buf);
+void lpfc_vmid_vport_cleanup(struct lpfc_vport *vport);
+int lpfc_issue_els_qfpa(struct lpfc_vport *vport);
-- 
2.26.2

