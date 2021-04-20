Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B0C365FB9
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhDTStS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Apr 2021 14:49:18 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:19130 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhDTStR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 20 Apr 2021 14:49:17 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d34 with ME
        id v6oi2401121Fzsu036oiDl; Tue, 20 Apr 2021 20:48:44 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Apr 2021 20:48:44 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: bfa: Remove some unused variables
Date:   Tue, 20 Apr 2021 20:48:41 +0200
Message-Id: <d10ccee35e35bf33d651f2e0163034d7c451520b.1618944442.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

'lp' is unused. It is just declared and memset'ed.
It can be removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/bfa/bfa_svc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_svc.c b/drivers/scsi/bfa/bfa_svc.c
index 11c0c3e6f014..5387883d6604 100644
--- a/drivers/scsi/bfa/bfa_svc.c
+++ b/drivers/scsi/bfa/bfa_svc.c
@@ -369,13 +369,10 @@ bfa_plog_fchdr(struct bfa_plog_s *plog, enum bfa_plog_mid mid,
 			enum bfa_plog_eid event,
 			u16 misc, struct fchs_s *fchdr)
 {
-	struct bfa_plog_rec_s  lp;
 	u32	*tmp_int = (u32 *) fchdr;
 	u32	ints[BFA_PL_INT_LOG_SZ];
 
 	if (plog->plog_enabled) {
-		memset(&lp, 0, sizeof(struct bfa_plog_rec_s));
-
 		ints[0] = tmp_int[0];
 		ints[1] = tmp_int[1];
 		ints[2] = tmp_int[4];
@@ -389,13 +386,10 @@ bfa_plog_fchdr_and_pl(struct bfa_plog_s *plog, enum bfa_plog_mid mid,
 		      enum bfa_plog_eid event, u16 misc, struct fchs_s *fchdr,
 		      u32 pld_w0)
 {
-	struct bfa_plog_rec_s  lp;
 	u32	*tmp_int = (u32 *) fchdr;
 	u32	ints[BFA_PL_INT_LOG_SZ];
 
 	if (plog->plog_enabled) {
-		memset(&lp, 0, sizeof(struct bfa_plog_rec_s));
-
 		ints[0] = tmp_int[0];
 		ints[1] = tmp_int[1];
 		ints[2] = tmp_int[4];
-- 
2.27.0

