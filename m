Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45B491768
	for <lists+linux-scsi@lfdr.de>; Sun, 18 Aug 2019 16:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfHROon (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 18 Aug 2019 10:44:43 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:18806 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfHROom (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 18 Aug 2019 10:44:42 -0400
Received: from localhost.localdomain ([92.140.207.10])
        by mwinf5d11 with ME
        id qekc2000W0Dzhgk03ekd4e; Sun, 18 Aug 2019 16:44:39 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Aug 2019 16:44:39 +0200
X-ME-IP: 92.140.207.10
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     QLogic-Storage-Upstream@qlogic.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: qla4xxx: Avoid usage of duplicated Header Guard
Date:   Sun, 18 Aug 2019 16:44:35 +0200
Message-Id: <20190818144435.2883-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

__QLA_NX_H is already used in 'drivers/scsi/qla2xxx/qla_nx.h', so use a
better name for the include headrr guard of 'ql4_nx.h'.
Use __QL4_NX_H

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/qla4xxx/ql4_nx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_nx.h b/drivers/scsi/qla4xxx/ql4_nx.h
index 98fe78613eb7..2b94b39ee95f 100644
--- a/drivers/scsi/qla4xxx/ql4_nx.h
+++ b/drivers/scsi/qla4xxx/ql4_nx.h
@@ -4,8 +4,8 @@
  *
  * See LICENSE.qla4xxx for copyright and licensing details.
  */
-#ifndef __QLA_NX_H
-#define __QLA_NX_H
+#ifndef __QL4_NX_H
+#define __QL4_NX_H
 
 /*
  * Following are the states of the Phantom. Phantom will set them and
-- 
2.20.1

