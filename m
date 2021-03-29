Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC24934D767
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Mar 2021 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhC2Shl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Mar 2021 14:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhC2ShO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Mar 2021 14:37:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AB0C061574
        for <linux-scsi@vger.kernel.org>; Mon, 29 Mar 2021 11:37:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y13so10547095ybk.20
        for <linux-scsi@vger.kernel.org>; Mon, 29 Mar 2021 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qAlrygfCbzF3KE5N88YqkSjT4Xlc7QpVIO8AbWVJ3g4=;
        b=t+RiCRfyyE+2Egl32t9CUIKDgWxffsRpzeLb4VyDOamLdxvmyAIXKTIku2IzQkCtmM
         sfMnrQM0eM3F9byo0eObXPCYXhq31N0urjFXubb8j4sVz/gHcAJgwn31YPfb+aDsdVze
         po/LFOeXbRrkXh1X+mIr/Zc9fPXipFh9cV7ytCdoXoyQ+5hgMmZ5oh5uLST6Xczd82pL
         1imBSgp2Vfhu9D1vtzPWcTshuSuJXANhIv0p+UhMRWMjaj5/s0I7rI9Y5V0NGYYdWHGO
         3aAgkxWcqh81Yoxnyg3Hs6WELnyFq8nzdV2QeOA9qbBXVk0GDzfZOcFNgrGvBDjOUF1k
         N4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qAlrygfCbzF3KE5N88YqkSjT4Xlc7QpVIO8AbWVJ3g4=;
        b=QcO9o/PXEkiU00M6Llol9VF0k+BVjX70tAmBWhQcDPqr5yk7HDGoTVNksS7+2UHFiF
         9rEwe1PdiqqhnlfhYREhAvv9Ngpu34rNNocatWCuBgCkfZ2+ymqwzvBEB0BG/RLJVLup
         qjFdhcC3ndeOaxZTaBcQF6Up4ff5U3UhDhUKxuVqpd69Ry0d4MQ+ObiqUzBDcixxj/F/
         YasATABzlX35FX5H8LjuM3vHl0H3cIGmmA6NsEG0GpdRFWnIGd4O9/DPgoyXrY0jVgmW
         ne5NDNBacGI9AMPHhHX7RviiFo6BnkZd5x0VB0zIa9lHAJDLkHnzSzI27vHW7vmDb1Zn
         SsuA==
X-Gm-Message-State: AOAM533JqAp3K0CdMYaY4/pCob8f9iHd7BEWgf18cx0VzyihBGLYWl7n
        Y7qYXazB6lGcT/jVwn+yWcLw5yiZEFAxGw==
X-Google-Smtp-Source: ABdhPJxP7war2zoTJaFnwD5cwYT3+XdULfUKuA1NeQDLZAfNxEwGEAzCGYuJLLYIMrkCcmzCvsq6L2Vs6UEsOQ==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:11:31d5:9537:66db:f466])
 (user=ipylypiv job=sendgmr) by 2002:a5b:40d:: with SMTP id
 m13mr38404138ybp.516.1617043033463; Mon, 29 Mar 2021 11:37:13 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:36:38 -0700
In-Reply-To: <20210329183639.1674307-1-ipylypiv@google.com>
Message-Id: <20210329183639.1674307-2-ipylypiv@google.com>
Mime-Version: 1.0
References: <20210329183639.1674307-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 1/2] scsi: pm80xx: Increase timeout for pm80xx mpi_uninit_check()
From:   Igor Pylypiv <ipylypiv@google.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Vishakha Channapattan <vishakhavc@google.com>,
        Akshat Jain <akshatzen@google.com>,
        Jolly Shah <jollys@google.com>, Yu Zheng <yuuzheng@google.com>,
        linux-scsi@vger.kernel.org, Viswas G <Viswas.G@microchip.com>,
        Deepak Ukey <deepak.ukey@microchip.com>,
        Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The mpi_uninit_check() takes longer for inbound doorbell register to be
cleared. Increased the timeout substantially so that the driver does not
fail to load.

Previously, the inbound doorbell wait time was mistakenly increased in
the mpi_init_check() instead of the mpi_uninit_check(). It is okay to
leave the mpi_init_check() wait time as is as these are timeout values
and if there is a failure, waiting longer is not an issue.

Fixes: e90e236250e9 ("scsi: pm80xx: Increase timeout for pm80xx
mpi_uninit_check")
Reviewed-by: Vishakha Channapattan <vishakhavc@google.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 84315560e8e1..a6f65666c98e 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1502,9 +1502,9 @@ static int mpi_uninit_check(struct pm8001_hba_info *pm8001_ha)
 
 	/* wait until Inbound DoorBell Clear Register toggled */
 	if (IS_SPCV_12G(pm8001_ha->pdev)) {
-		max_wait_count = 4 * 1000 * 1000;/* 4 sec */
+		max_wait_count = (30 * 1000 * 1000) /* 30 sec */
 	} else {
-		max_wait_count = 2 * 1000 * 1000;/* 2 sec */
+		max_wait_count = (15 * 1000 * 1000) /* 15 sec */
 	}
 	do {
 		udelay(1);
-- 
2.31.0.291.g576ba9dcdaf-goog

