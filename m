Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F92D40614C
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Sep 2021 02:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240313AbhIJAmZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Sep 2021 20:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhIJASW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 Sep 2021 20:18:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D5A46120D;
        Fri, 10 Sep 2021 00:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631233018;
        bh=cTpJbF4vmEZ/c4wqkTsrEgA22dQeKqu195wkjgnhdhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpEaxf0LP7UQK6wTVuNQzA9nFo13UcYOl7KJ/yTvZJ3SGh3zVecVVJQRSeMbD7+ck
         zdEKTcoZVuH020K9v/BZKPu8RlLr2yW+HXck9sgbnDl0k4WIsu0Vbk/9343G779L2H
         uziAvlccQqYAOchBnkySWaPUA13KM8G6OhbYtSz2U7QmQjr+wDed4N7Tnr3L5utnLs
         tPowJLUcicBcGvOyI85UtA7pEeDS3166xgB4OnkWvjeuLONxsWB7quh2VdMmv5yZaS
         Myf3Y9r2SI3lqaJOxLWFZeh5pAZtFNlANhKLPIOK+NH+8oMyYqLE3nXtjm5swqpe3v
         Kh4HGEEMHGgyA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 43/99] scsi: qla2xxx: Fix port type info
Date:   Thu,  9 Sep 2021 20:15:02 -0400
Message-Id: <20210910001558.173296-43-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910001558.173296-1-sashal@kernel.org>
References: <20210910001558.173296-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit 01c97f2dd8fb4d2188c779a975031c0fe1ec061d ]

Over time, fcport->port_type became a flag field. The flags within this
field were not defined properly. This caused external tools to read wrong
info.

Link: https://lore.kernel.org/r/20210810043720.1137-8-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 2f67ec1df3e6..2da1d4eccbaa 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2377,11 +2377,9 @@ struct mbx_24xx_entry {
  */
 typedef enum {
 	FCT_UNKNOWN,
-	FCT_RSCN,
-	FCT_SWITCH,
-	FCT_BROADCAST,
-	FCT_INITIATOR,
-	FCT_TARGET,
+	FCT_BROADCAST = 0x01,
+	FCT_INITIATOR = 0x02,
+	FCT_TARGET    = 0x04,
 	FCT_NVME_INITIATOR = 0x10,
 	FCT_NVME_TARGET = 0x20,
 	FCT_NVME_DISCOVERY = 0x40,
-- 
2.30.2

