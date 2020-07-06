Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0519C215807
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2020 15:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgGFNIY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 Jul 2020 09:08:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55582 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgGFNIY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 6 Jul 2020 09:08:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jsQr6-0006d5-KC; Mon, 06 Jul 2020 13:08:20 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: lpfc: fix less than zero comparison on unsigned int computation
Date:   Mon,  6 Jul 2020 14:08:20 +0100
Message-Id: <20200706130820.487271-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The expressions start_idx - dbg_cnt is evaluated using unsigned int
arthithmetic (since these variables are unsigned ints) and hence can
never be less than zero, so the less than comparison is never true.
Re-write the expression to check for start_idx being less than dbg_cnt.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 372c187b8a70 ("scsi: lpfc: Add an internal trace log buffer")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 7285b0114837..ce5afe7b11d0 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -14152,7 +14152,7 @@ void lpfc_dmp_dbg(struct lpfc_hba *phba)
 		if ((start_idx + dbg_cnt) > (DBG_LOG_SZ - 1)) {
 			temp_idx = (start_idx + dbg_cnt) % DBG_LOG_SZ;
 		} else {
-			if ((start_idx - dbg_cnt) < 0) {
+			if (start_idx < dbg_cnt) {
 				start_idx = DBG_LOG_SZ - (dbg_cnt - start_idx);
 				temp_idx = 0;
 			} else {
-- 
2.27.0

