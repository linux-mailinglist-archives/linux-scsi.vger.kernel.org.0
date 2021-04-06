Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0413563A3
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Apr 2021 07:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbhDGF7l (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Apr 2021 01:59:41 -0400
Received: from saphodev.broadcom.com ([192.19.232.172]:39390 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345353AbhDGF7i (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 7 Apr 2021 01:59:38 -0400
Received: from localhost.localdomain (unknown [10.157.2.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id F28882433B;
        Tue,  6 Apr 2021 22:59:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F28882433B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1617775169;
        bh=X9vCVzGkXkP4A2eFeaHZWC4N0/75YPQ95C7bRlGTs5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KnfDQc8NFRzRU83xT4KDuNwfulLMMVbQjaQRNompecxEZSZ3Lyd3sApfvyPfRWV14
         18kOjqEQqb/7C3ec9fSK4ULi8EFLitxQhooifjiTjsfG835nI9d5ULx82hM2rAibBe
         jJFMKPHNwsfNpU9PH0Ihg/tQSCLhzBSwjswIqDio=
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org, hare@suse.de
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v9 12/13] lpfc: vmid: Adding qfpa and vmid timeout check in worker thread
Date:   Wed,  7 Apr 2021 04:36:36 +0530
Message-Id: <1617750397-26466-13-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch add the periodic check for issuing of qfpa command and vmid
timeout in the worker thread. The inactivity timeout check is added via
the timer function.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v9:
No change

v8:
checked the function return value

v7:
No change

v6:
Added Forward declarations and removed unused variable

v5:
No change

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 4cf1bc418bea..53712e30754a 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -73,6 +73,7 @@ static void lpfc_unregister_fcfi_cmpl(struct lpfc_hba *, LPFC_MBOXQ_t *);
 static int lpfc_fcf_inuse(struct lpfc_hba *);
 static void lpfc_mbx_cmpl_read_sparam(struct lpfc_hba *, LPFC_MBOXQ_t *);
 static void lpfc_check_inactive_vmid(struct lpfc_hba *phba);
+static void lpfc_check_vmid_qfpa_issue(struct lpfc_hba *phba);
 
 static int
 lpfc_valid_xpt_node(struct lpfc_nodelist *ndlp)
@@ -433,6 +434,32 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 	return fcf_inuse;
 }
 
+static void lpfc_check_vmid_qfpa_issue(struct lpfc_hba *phba)
+{
+	struct lpfc_vport *vport;
+	struct lpfc_vport **vports;
+	int i;
+
+	vports = lpfc_create_vport_work_array(phba);
+	if (!vports)
+		return;
+
+	for (i = 0; i <= phba->max_vports; i++) {
+		if ((!vports[i]) && (i == 0))
+			vport = phba->pport;
+		else
+			vport = vports[i];
+		if (!vport)
+			break;
+
+		if (vport->vmid_flag & LPFC_VMID_ISSUE_QFPA) {
+			if (!lpfc_issue_els_qfpa(vport))
+				vport->vmid_flag &= ~LPFC_VMID_ISSUE_QFPA;
+		}
+	}
+	lpfc_destroy_vport_work_array(phba, vports);
+}
+
 /**
  * lpfc_sli4_post_dev_loss_tmo_handler - SLI4 post devloss timeout handler
  * @phba: Pointer to hba context object.
@@ -753,6 +780,22 @@ lpfc_work_done(struct lpfc_hba *phba)
 	if (ha_copy & HA_LATT)
 		lpfc_handle_latt(phba);
 
+	/* Handle VMID Events */
+	if (lpfc_is_vmid_enabled(phba)) {
+		if (phba->pport->work_port_events &
+		    WORKER_CHECK_VMID_ISSUE_QFPA) {
+			lpfc_check_vmid_qfpa_issue(phba);
+			phba->pport->work_port_events &=
+				~WORKER_CHECK_VMID_ISSUE_QFPA;
+		}
+		if (phba->pport->work_port_events &
+		    WORKER_CHECK_INACTIVE_VMID) {
+			lpfc_check_inactive_vmid(phba);
+			phba->pport->work_port_events &=
+			    ~WORKER_CHECK_INACTIVE_VMID;
+		}
+	}
+
 	/* Process SLI4 events */
 	if (phba->pci_dev_grp == LPFC_PCI_DEV_OC) {
 		if (phba->hba_flag & HBA_RRQ_ACTIVE)
-- 
2.26.2

