Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6F615F248
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Feb 2020 19:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbgBNPyU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Feb 2020 10:54:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731481AbgBNPyU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Feb 2020 10:54:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0571222C4;
        Fri, 14 Feb 2020 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695659;
        bh=6z/t0VhggveAqMfKd+GXVB1VM3eyWMPeYQwd11GIHLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tipDIYy4SgWUegpqyztsE6mgVw34EL3VowG3rtsKoiQ6cUdvgTQGMsIOIFiDvR2cw
         F5Cqw0kYOPgUJEsmbRE3CCfzjibyxC5AP5ExBsdglm76kKKRdFdoiCHh9eIuTRH4SO
         FE6+wIuaTDoYwAgv6055TnbCDURKpLUAzzWSiuHw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 250/542] scsi: lpfc: Fix: Rework setting of fdmi symbolic node name registration
Date:   Fri, 14 Feb 2020 10:44:02 -0500
Message-Id: <20200214154854.6746-250-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit df9166bfa7750bade5737ffc91fbd432e0354442 ]

This patch reworks the fdmi symbolic node name data for the following two
issues:

 - Correcting extraneous periods following the DV and HN fdmi data fields.

 - Avoiding buffer overflow issues when formatting the data.

The fix to the fist issue is to just remove the characters.

The fix to the second issue has all data being staged in temporary storage
before being moved to the real buffer.

Link: https://lore.kernel.org/r/20191218235808.31922-3-jsmart2021@gmail.com
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_ct.c | 42 +++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 99c9bb249758c..1b4dbb28fb419 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -1493,33 +1493,35 @@ int
 lpfc_vport_symbolic_node_name(struct lpfc_vport *vport, char *symbol,
 	size_t size)
 {
-	char fwrev[FW_REV_STR_SIZE];
-	int n;
+	char fwrev[FW_REV_STR_SIZE] = {0};
+	char tmp[MAXHOSTNAMELEN] = {0};
 
-	lpfc_decode_firmware_rev(vport->phba, fwrev, 0);
+	memset(symbol, 0, size);
 
-	n = scnprintf(symbol, size, "Emulex %s", vport->phba->ModelName);
-	if (size < n)
-		return n;
+	scnprintf(tmp, sizeof(tmp), "Emulex %s", vport->phba->ModelName);
+	if (strlcat(symbol, tmp, size) >= size)
+		goto buffer_done;
 
-	n += scnprintf(symbol + n, size - n, " FV%s", fwrev);
-	if (size < n)
-		return n;
+	lpfc_decode_firmware_rev(vport->phba, fwrev, 0);
+	scnprintf(tmp, sizeof(tmp), " FV%s", fwrev);
+	if (strlcat(symbol, tmp, size) >= size)
+		goto buffer_done;
 
-	n += scnprintf(symbol + n, size - n, " DV%s.",
-		      lpfc_release_version);
-	if (size < n)
-		return n;
+	scnprintf(tmp, sizeof(tmp), " DV%s", lpfc_release_version);
+	if (strlcat(symbol, tmp, size) >= size)
+		goto buffer_done;
 
-	n += scnprintf(symbol + n, size - n, " HN:%s.",
-		      init_utsname()->nodename);
-	if (size < n)
-		return n;
+	scnprintf(tmp, sizeof(tmp), " HN:%s", init_utsname()->nodename);
+	if (strlcat(symbol, tmp, size) >= size)
+		goto buffer_done;
 
 	/* Note :- OS name is "Linux" */
-	n += scnprintf(symbol + n, size - n, " OS:%s",
-		      init_utsname()->sysname);
-	return n;
+	scnprintf(tmp, sizeof(tmp), " OS:%s", init_utsname()->sysname);
+	strlcat(symbol, tmp, size);
+
+buffer_done:
+	return strnlen(symbol, size);
+
 }
 
 static uint32_t
-- 
2.20.1

