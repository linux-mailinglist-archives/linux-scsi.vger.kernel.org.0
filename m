Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0CA913FBDB
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jan 2020 22:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389025AbgAPV7k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Jan 2020 16:59:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39931 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbgAPV7k (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 16 Jan 2020 16:59:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so5429657wmj.4;
        Thu, 16 Jan 2020 13:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KBosvAPP0dc526ycXRN2g+Rfl+cHTJgFFbNFy4NrI8A=;
        b=viJNfGYwFB32ZRt0l4pEQ2Fyp+biAk29ltieVXdLrTDc2jBp+49xtqBh8AK7djE86/
         Kj+1cHMlskFP5ET5gyUjXhQuarMx4+LzauUCJujdpZfEyPPKXZe6DKwju9geXB/ifPOo
         0lu6tclQ0z31A7xL03pNBRe3XD+kg/k1imHelvSrBFNvWrvXcfJ7QDUwhPCpXvsBkwu/
         EkV63JoO7A1GhJrDwSGELnFs/hSxUW7fjrxhznfbF+6HtSCWLwKkvYWHs5kX2dp8pvjY
         kFm5OaiPscsISNxq+6AflSc+g6lpiWvKZVUP4VhI8UL9iuaqD6TVAn2rDVS6UUIq1IUf
         tHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KBosvAPP0dc526ycXRN2g+Rfl+cHTJgFFbNFy4NrI8A=;
        b=pQJRLWHuGy8hbhzCH4tiWsOqo7OpILnxAef3z9/A40GnOXr717ZAWO0PvJErW7yzlp
         L/yQy3kFGZsrmszBnntXLWC+0Kr1JzQn/lbuYei8GhRCmpHESNESvG8X1ThtySLYSRJP
         c6A6aEKjE7LAtUYZf9mWWamRwKpErHJADFPqmoGQgOY0LvV5j+RCj3UkWBl+8TV23Nkj
         qeig9/7jyF3QEj6OB/wYALICbvf6AVNC3nXoX/130VoreBQEP/sW0UEnBSR2L/CDUGbD
         qmuX8AcLsWKtCp+HWjeZ5gwf5uroue4sVYVVzO9gB9XQDGrOpyw/scjAvQOJkXRtRuRm
         2GOQ==
X-Gm-Message-State: APjAAAVa9kJJbysqPdfn0Pc17Lu9T9VGLz/wIWqGg2GMasMhH0/SIn5m
        E/t3SNrmfMhODkGlRNGJ1nk=
X-Google-Smtp-Source: APXvYqwUVXPPwu6xRjCfdWdgR3BQl4fcvW0MM0FMUhh2YikI0+UXDAO3x6lPSa5BHGgNuYT+wMNz8g==
X-Received: by 2002:a1c:ded6:: with SMTP id v205mr1175994wmg.86.1579211978883;
        Thu, 16 Jan 2020 13:59:38 -0800 (PST)
Received: from localhost.localdomain (ip5f5bee3c.dynamic.kabel-deutschland.de. [95.91.238.60])
        by smtp.gmail.com with ESMTPSA id a14sm32418131wrx.81.2020.01.16.13.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 13:59:38 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] scsi: ufs: goto with returned value while failed to add WL
Date:   Thu, 16 Jan 2020 22:59:06 +0100
Message-Id: <20200116215914.16015-2-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116215914.16015-1-huobean@gmail.com>
References: <20200116215914.16015-1-huobean@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

This patch is to make goto statement with failure result in case of
failure of adding well known LUs.

Fixes: 2a8fa600445c ("ufs: manually add well known logical units")
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index bea036ab189a..9a9085a7bcc5 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7032,7 +7032,8 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 			ufshcd_init_icc_levels(hba);
 
 		/* Add required well known logical units to scsi mid layer */
-		if (ufshcd_scsi_add_wlus(hba))
+		ret = ufshcd_scsi_add_wlus(hba);
+		if (ret)
 			goto out;
 
 		/* Initialize devfreq after UFS device is detected */
-- 
2.17.1

