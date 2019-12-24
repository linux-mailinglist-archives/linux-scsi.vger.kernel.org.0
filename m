Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1935012A43F
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Dec 2019 23:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLXWC6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 24 Dec 2019 17:02:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44495 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfLXWC6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 24 Dec 2019 17:02:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id az3so8866657plb.11
        for <linux-scsi@vger.kernel.org>; Tue, 24 Dec 2019 14:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9G4xjKAJmt/5rVJ99tyhVqNPLQtajCh5LMYoRNXIvY=;
        b=RDeGu2VrA5ztno5+Q52hI85zVlN/1hr4UBdLRz5IpmVFjZ4AZk5MmgOy3wPv8dvJtp
         TvnW4B456bPrrw7JxFp9GvkVUtvJFRRYu0XtXsCNVr9JDhXtomfYYuGLqWX94X94+G+r
         65eSHr78q5yobzSjqa+gv3r4fZOnWAGuA1j1+e3wb2vGN/JcLTeVVxHXyOQOK6NGWjJ8
         Dczhxlv7Ukc2aWKeYR15fDrxh1IEcZqth4I9jwMg3iCS+2M6g4pFrE0H7YmoCPTwSUWS
         t8Z2lKSu/XJ/Xvs82FHdBoHJeVr39OWXQUnCt7a4hrmM6hCs6ZHBVP5s6LG5xq93BDXk
         OPPw==
X-Gm-Message-State: APjAAAXzEpZ7VEzDsU0Slovd4IZhBvW5BcydZKFoLXtRRjaXbmCWLzf8
        TOXfbWWxuYMitK/dRfwUxy8=
X-Google-Smtp-Source: APXvYqzZe+TdlH/R22gMBMI3fMvcvGD5c1DG5S+Xc48cJWMeYEr1RhDcwGFLV82qR/9feDkCe+R/Gg==
X-Received: by 2002:a17:90a:8c8c:: with SMTP id b12mr8522082pjo.119.1577224977425;
        Tue, 24 Dec 2019 14:02:57 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:1206:80fd:a97:a7d:f0c8])
        by smtp.gmail.com with ESMTPSA id m15sm26839779pgi.91.2019.12.24.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 14:02:56 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 1/6] ufs: Fix indentation in ufshcd_query_attr_retry()
Date:   Tue, 24 Dec 2019 14:02:43 -0800
Message-Id: <20191224220248.30138-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191224220248.30138-1-bvanassche@acm.org>
References: <20191224220248.30138-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove a space that occurs after a tab.

Cc: Bean Huo <beanhuo@micron.com>
Cc: Can Guo <cang@codeaurora.org>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Stanley Chu <stanley.chu@mediatek.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d6d0f83c9044..48f2f94d51bc 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2869,7 +2869,7 @@ static int ufshcd_query_attr_retry(struct ufs_hba *hba,
 	int ret = 0;
 	u32 retries;
 
-	 for (retries = QUERY_REQ_RETRIES; retries > 0; retries--) {
+	for (retries = QUERY_REQ_RETRIES; retries > 0; retries--) {
 		ret = ufshcd_query_attr(hba, opcode, idn, index,
 						selector, attr_val);
 		if (ret)
